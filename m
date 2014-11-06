From: voytikd@gmail.com (Dmitry Voytik)
Date: Thu, 6 Nov 2014 22:36:39 +0400
Subject: [PATCH] ARM: imx: refactor mxc_iomux_mode()
In-Reply-To: <54dc2a9edf554125b2158a1f9edd8adb@BN1PR0301MB0772.namprd03.prod.outlook.com>
References: <1413902151-20255-1-git-send-email-voytikd@gmail.com>
 <20141027142054.GB14033@voytthpd>
 <54dc2a9edf554125b2158a1f9edd8adb@BN1PR0301MB0772.namprd03.prod.outlook.com>
Message-ID: <20141106183639.GA17308@ubuntuvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Nov 04, 2014 at 12:21:55PM +0000, Peter Chen wrote:

> > > -int mxc_iomux_mode(unsigned int pin_mode)
> > > +void mxc_iomux_mode(unsigned int pin_mode)
> > >  {
> > > -	u32 field, l, mode, ret = 0;
> > > +	u32 field;
> > > +	u32 l;
> > > +	u32 mode;
> > >  	void __iomem *reg;
> > >
> 
> Why you use three lines to define it, it makes the function longer.

You're right but there is a recommendation in coding style to declare
variables on separate lines (see Documentation/CodingStyle,
line 469), which improves readability, imho. By the way I saw many
times, that maintainers asked to declare variables separately.

> Besides, Shawn's email changes to : <shawn.guo@linaro.org>

Oops, didn't see that. Thanks!

WBR.
