From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 19 Mar 2013 14:50:38 -0700
Subject: [PATCH v6 00/16] clk: exynos4/5: migrate to common clock framework
In-Reply-To: <201303192212.16877.heiko@sntech.de>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
 <20130319184938.8663.18115@quantum> <201303192212.16877.heiko@sntech.de>
Message-ID: <20130319215038.8663.83548@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2013-03-19 14:12:16)
> Am Dienstag, 19. M?rz 2013, 19:49:38 schrieb Mike Turquette:
> > Quoting Thomas Abraham (2013-02-18 00:21:10)
> > 
> > > Changes since v5:
> > > - Squashed several Exynos4 fixes patch from Tomasz Figa
> > > - Included support for Exynos5250 and Exynos5440, thus converting all
> > > 
> > >   Exynos4 and Exynos5 platforms to common clock framework.
> > > 
> > > - Depends on the following patch series.
> > > 
> > >   -
> > >   http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg15849
> > >   .html -
> > >   http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg15852
> > >   .html
> > > 
> > > Changes since v4:
> > > - Rebased to linux-3.8-rc1.
> > > 
> > > Changes since v3:
> > > - Includes changes suggested by Tomasz Figa <tomasz.figa@gmail.com>
> > > 
> > > This patch series migrates the Samsung Exynos4/5 SoC clock code to adopt
> > > the common clock framework. The use of Samsung specific clock structures
> > > has been removed and all board support code has been updated. imx-style
> > > of clock registration and lookup has been adopted for device tree based
> > > exynos4/5 platforms.
> > 
> > Thomas,
> > 
> > Are you planning a V7 series which includes the clock alias bits from
> > patch #1?
> 
> Kukjin has already applied this series into the linux-samsung tree [0].
> 

That really is too much code to go into drivers/clk without my ACK.  I
have not made much noise about this in the past but there has been more
and more "bonus" code slipping into drivers/clk each merge window.
Let's not do that any more.

Regards,
Mike

> The alias changes are available in the series "clk: samsung: pm fixes
> and multiple aliases" from last wednesday to on top, which you should
> hopefully also have received.
> 
> This v2 series implements the changes discussed in the previous v1 
> "clk: samsung: small fixes and enhancements" from 2013-03-12, but didn't
> get any responses yet.
> 
> 
> Heiko
> 
> 
> [0] https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=next/clk-exynos
