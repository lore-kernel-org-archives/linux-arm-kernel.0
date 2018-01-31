From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Jan 2018 08:42:12 +0100
Subject: [linux-sunxi] Re: [PATCH v6 2/2] media: V3s: Add support for
 Allwinner CSI.
In-Reply-To: <20180131030807.GA19945@bart.dudau.co.uk>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <201801260759.RyNhDZz4%fengguang.wu@intel.com>
 <20180126094658.aa70ed3f890464f6051e21e4@magewell.com>
 <20180126110041.f89848325b9ecfb07df387ca@magewell.com>
 <20180131030807.GA19945@bart.dudau.co.uk>
Message-ID: <20180131074212.7hvb3nqkt22h2chg@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On Wed, Jan 31, 2018 at 03:08:08AM +0000, Liviu Dudau wrote:
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
> No, I don't think you should do that, you should fix the code.
> 
> The dma_addr_t addr that you've got is ideally coming from dma_alloc_coherent(),
> in which case the addr is already "suitable" for use by the device (because the
> bus where the device is attached to does all the address translations).

Like we're discussing in that other part of the thread with Thierry
and Arnd, things are slightly more complicated than that :)

In our case, the bus where the device is attached will not do the
address translations, and shouldn't.

> If you apply PHYS_OFFSET forcefully to it you might get unexpected
> results.

Out of curiosity, what would be these unexpected results?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180131/7fd45ec6/attachment-0001.sig>
