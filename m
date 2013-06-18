From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 18 Jun 2013 20:59:03 +0200
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation
 to the DT binding
In-Reply-To: <20130618184753.GA6090@obsidianresearch.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618174622.GD2204@obsidianresearch.com> <51C0A5F8.8030300@gmail.com>
 <201306182039.50736.arnd@arndb.de> <51C0AA8E.9080807@gmail.com>
 <20130618184753.GA6090@obsidianresearch.com>
Message-ID: <51C0ADF7.5050609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2013 08:47 PM, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2013 at 08:44:30PM +0200, Sebastian Hesselbarth wrote:
>> Yeah, I also recall Thomas or Gregory mention a 32b limitation in
>> remap windows. But we don't need to waste addresses here
>>
>> And even if SIAA0000 is a concern because there may be target id>15
>> someday, we can still have IIAASS00 instead of IIAA00SS. I guess
>> LPAE will not rise above 40b quickly ;)
>
> S = 0 means 4 bit I, 8 bit A
> S = F means special
> S = 1 could mean 16 bit I, etc , etc

S & 0x8 == 0x0 means 7b target
S & 0x8 == 0x8 means 7b special ?

> Yes, we could define things as 'SIAAoooo oooooooo'
>
> But remember 'o' is the offset within the window, it is not related to
> LPAE.
>
> To need>  32 bits 'o' you need to have windows>  4G in size. The only
> thing that could possibly do that is PCI-E, and it is all special
> anyhow..
>
> The mbus top level ranges remap already supports>4G locations for
> the windows, even though current hardware cannot do that.

True. But as Arnd also mentioned, I don't think it will ever be a
problem at all. Possibly there will never be any future SoC with mbus
that will either allow >32b remap base addresses nor >4G size.

But never the less, IIAA00SS (which is used in v3 of the patches) will
limit both to 32b/4G forever.

And we already have +3 for SIAAoooo ;)

Sebastian
