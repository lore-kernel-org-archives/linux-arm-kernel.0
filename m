From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 00:29:25 -0700
Subject: [PATCH] ARM: allow DEBUG_UNCOMPRESS for omap2plus
In-Reply-To: <51F94200.2060202@wwwdotorg.org>
References: <1375224558-8170-1-git-send-email-swarren@wwwdotorg.org>
 <20130730225233.GF21614@n2100.arm.linux.org.uk>
 <51F845C7.8020106@wwwdotorg.org>
 <20130731064634.GR7656@atomide.com>
 <51F94200.2060202@wwwdotorg.org>
Message-ID: <20130802072925.GX7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130731 10:04]:
> On 07/31/2013 12:46 AM, Tony Lindgren wrote:
> > 
> > I think we're best off removing the remaining uncompress code
> > configured port detection features as the port properties are now
> > defined in kconfig anyways. That simplifies the code quite a bit.
> 
> If you want to do that with OMAP, I'm happy to drop this patch.

Yes on my list of things to do..
 
> For Tegra, automatic determination of the DEBUG_LL UART is rather
> useful, so I'm not going to give that up:-)

For omaps there's just too many options to try to detect anything.

It seems the best strategy seems to be to just init things later on
so DEBUG_LL is only needed when booting breaks really early on
during the boot process.

Regards,

Tony
