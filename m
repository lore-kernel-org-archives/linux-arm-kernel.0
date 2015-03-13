From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 20:55:30 +0100
Subject: [PATCH 00/12] Remove mach-msm and associated code
In-Reply-To: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <3936339.LqGDoxnsbi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 11:09:33 Stephen Boyd wrote:
> The maintainers for mach-msm no longer have any plans to support
> or test the platforms supported by this architecture[1]. Most likely
> there aren't any active users of this code anyway, so let's
> delete it and the associated drivers/code. We should probably merge
> this as one big series through arm-soc. Although some patches
> should be fine to take through maintainers, some things like
> mmc and usb have header file dependencies for platform_data.
> 
> [1] http://lkml.kernel.org/r/20150307031212.GA8434 at fifo99.com
> 

As I wrote, I'd have a mild preference for doing the multiplatform
conversion first and then removing the support in the following merge
window, just in case someone wants that code back.

If everyone wants to see that code die rather sooner than later,
that's fine with me as well.

I think the MMC driver should also be removed when the platform
code is deleted, new code would use the mmci driver anyway.

	Arnd
