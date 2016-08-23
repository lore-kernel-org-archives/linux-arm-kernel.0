From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 23 Aug 2016 15:36:05 -0500
Subject: [PATCH] arm64: defconfig: Enable QDF2432 config options
In-Reply-To: <57768804.6050006@codeaurora.org>
References: <1467382327-9726-1-git-send-email-cov@codeaurora.org>
 <57767AC1.3070209@codeaurora.org> <577686FB.5040709@codeaurora.org>
 <57768804.6050006@codeaurora.org>
Message-ID: <20160823203605.GF30923@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 10:11:00AM -0500, Timur Tabi wrote:
> Christopher Covington wrote:
> >Due to distribution differences [1][2], I see =y built-in as the default
> >on mobile platforms and =m modular as the default on server platforms.
> 
> I don't think we should mix "server" defconfing entries with "mobile"
> defconfig entries.  It's a arm64 defconfig, neither server nor mobile. The
> other entries are =y, so these should be =y
> 
> No one uses this defconfig as-is for any platform.
> 
> >But thinking about it, we could get a poweroff, reset, over-temperature,
> >or other interrupt before we get to the initramfs. So the pin controller
> >driver should be =y built-in.
> >
> >One might make rootfs media =y built-in to make testing easier, but I
> >prefer to put my rootfs on SATA, as SD/MMC is much slower and smaller by
> >comparison.
> 
> Let's not overthink things, and just make *everything* =y by default.

Do you guys want me to fix this up so it can hit this window?  I can just change
the m to y before I send it off.


Andy
