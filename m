From: yong.deng@magewell.com (Yong)
Date: Sun, 28 Jan 2018 10:19:03 +0800
Subject: [linux-sunxi] Re: [PATCH v6 2/2] media: V3s: Add support for
 Allwinner CSI.
In-Reply-To: <20180126081000.hy7g57zp5dv6ug2g@flea.lan>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <201801260759.RyNhDZz4%fengguang.wu@intel.com>
 <20180126094658.aa70ed3f890464f6051e21e4@magewell.com>
 <20180126110041.f89848325b9ecfb07df387ca@magewell.com>
 <20180126081000.hy7g57zp5dv6ug2g@flea.lan>
Message-ID: <20180128101903.fbaec083c787bda30aeb05ef@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, 26 Jan 2018 09:10:00 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Fri, Jan 26, 2018 at 11:00:41AM +0800, Yong wrote:
> > Hi Maxime,
> > 
> > On Fri, 26 Jan 2018 09:46:58 +0800
> > Yong <yong.deng@magewell.com> wrote:
> > 
> > > Hi Maxime,
> > > 
> > > Do you have any experience in solving this problem?
> > > It seems the PHYS_OFFSET maybe undeclared when the ARCH is not arm.
> > 
> > Got it.
> > Should I add 'depends on ARM' in Kconfig?
> 
> Yes, or even better a depends on MACH_SUNXI :)

Do you mean ARCH_SUNXI?

ARCH_SUNXI is alreay there. In the early version, my Kconfig is like this:

	depends on ARCH_SUNXI

But Hans suggest me to change this to:

	depends on ARCH_SUNXI || COMPILE_TEST

to allow this driver to be compiled on e.g. Intel for compile testing.

Should we get rid of COMPILE_TEST?

Yong
