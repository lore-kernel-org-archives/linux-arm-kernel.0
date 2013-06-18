From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Jun 2013 12:47:53 -0600
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation
 to the DT binding
In-Reply-To: <51C0AA8E.9080807@gmail.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618174622.GD2204@obsidianresearch.com>
 <51C0A5F8.8030300@gmail.com> <201306182039.50736.arnd@arndb.de>
 <51C0AA8E.9080807@gmail.com>
Message-ID: <20130618184753.GA6090@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 08:44:30PM +0200, Sebastian Hesselbarth wrote:
> On 06/18/2013 08:39 PM, Arnd Bergmann wrote:
> >On Tuesday 18 June 2013, Sebastian Hesselbarth wrote:
> >>Also allows you to have up to 40b offset, which might be important
> >>with LPAE enabled.
> >
> >Not with the current generation I think, since the mbus windows are
> >32 bit only, but it would avoid having to come up with a new format
> >for a potential future-generation mbus that has wider address.
> 
> Yeah, I also recall Thomas or Gregory mention a 32b limitation in
> remap windows. But we don't need to waste addresses here
> 
> And even if SIAA0000 is a concern because there may be target id >15
> someday, we can still have IIAASS00 instead of IIAA00SS. I guess
> LPAE will not rise above 40b quickly ;)

S = 0 means 4 bit I, 8 bit A
S = F means special
S = 1 could mean 16 bit I, etc , etc

Yes, we could define things as 'SIAAoooo oooooooo'

But remember 'o' is the offset within the window, it is not related to
LPAE.

To need > 32 bits 'o' you need to have windows > 4G in size. The only
thing that could possibly do that is PCI-E, and it is all special
anyhow..

The mbus top level ranges remap already supports >4G locations for
the windows, even though current hardware cannot do that.

Jason
