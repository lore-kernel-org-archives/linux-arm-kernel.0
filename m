From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 28 Jan 2010 20:54:38 +0100
Subject: [PATCH 06/13] ARM: LPC32XX: Core architecture files
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909020E9602@mi8nycmail19.Mi8.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-7-git-send-email-wellsk40@gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020E9602@mi8nycmail19.Mi8.com>
Message-ID: <083DF309106F364B939360100EC290F805C8A0A7F7@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	{
> > +		.inp_state	= (void __iomem *) GPIO_P3_INP_STATE(GPIOBASE),
> > +		.outp_set	= (void __iomem *) GPIO_P3_OUTP_SET(GPIOBASE),
> > +		.outp_clr	= (void __iomem *) GPIO_P3_OUTP_CLR(GPIOBASE),
> > +		.dir_set	= (void __iomem *) GPIO_P2_DIR_SET(GPIOBASE),
> > +		.dir_clr	= (void __iomem *) GPIO_P2_DIR_CLR(GPIOBASE),
> > +	},
> > +};
> 
> All this casting is pretty ugly.
> 
> It appears these GPIO_P* macros are only used here.  Can the macros
> be modified to create the (void __iomem *) directly?
> 
> BTW, you might need to add __force in order to keep sparse happy.
> 
> Also, a general comment on the global names in
> arch/arm/mach-lpc32xx/include/mach/platform.h.
> 
> You might consider adding something like LPC32XX_ to the front of
> all the defines. Names like GPIO_BASE or UART3_BASE could very well
> conflict with some other piece of code in the future.
> 

Thank you for helping review these. I'll look at the use of __force
and update the necessary arch files with your other review comments.
