From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 12 Jul 2012 19:04:43 +0800
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits
 for general purpose registers
In-Reply-To: <4FFE9D7E.1080302@gmail.com>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
 <4FFE9D7E.1080302@gmail.com>
Message-ID: <20120712110442.GE22640@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 05:48:46PM +0800, Hui Wang wrote:
...
> > +
> > +int imx_pinctrl_gpr_read(u8 gpr)
> > +{
> > +	if (!imx_pinctrl)
> > +		return -EPROBE_DEFER;
> > +
> > +	return readl(imx_pinctrl->base + gpr);
> >   
> Suppose the MSB of the register content is 1, how does the caller 
> distinguish if the function return an error or return a register content?
> 
Good catch, it's indeed an issue.
We need find a way to fix it, probably i would add a parameter for
read API to return a u32 value.

Thanks

Regards
Dong Aisheng
