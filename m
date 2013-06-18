From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 18 Jun 2013 20:44:30 +0200
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation
 to the DT binding
In-Reply-To: <201306182039.50736.arnd@arndb.de>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618174622.GD2204@obsidianresearch.com> <51C0A5F8.8030300@gmail.com>
 <201306182039.50736.arnd@arndb.de>
Message-ID: <51C0AA8E.9080807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2013 08:39 PM, Arnd Bergmann wrote:
> On Tuesday 18 June 2013, Sebastian Hesselbarth wrote:
>> Also allows you to have up to 40b offset, which might be important
>> with LPAE enabled.
>
> Not with the current generation I think, since the mbus windows are
> 32 bit only, but it would avoid having to come up with a new format
> for a potential future-generation mbus that has wider address.

Yeah, I also recall Thomas or Gregory mention a 32b limitation in
remap windows. But we don't need to waste addresses here

And even if SIAA0000 is a concern because there may be target id >15
someday, we can still have IIAASS00 instead of IIAA00SS. I guess
LPAE will not rise above 40b quickly ;)

Sebastian
