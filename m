From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Wed, 18 Apr 2018 07:46:43 +0200
Subject: [PATCH v6 09/11] ARM: sun8i: smp: Add support for A83T
In-Reply-To: <20180417112038.mw7bfhqw4xwvzxcw@flea>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-10-mylene.josserand@bootlin.com>
 <20180417112038.mw7bfhqw4xwvzxcw@flea>
Message-ID: <20180418074643.5bd68168@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

On Tue, 17 Apr 2018 13:20:38 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Mon, Apr 16, 2018 at 11:50:30PM +0200, Myl?ne Josserand wrote:
> > @@ -535,8 +599,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
> >  	return !ret;
> >  }
> >  
> > -static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
> > +static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
> >  {
> > +	/* CPU0 hotplug not handled for sun8i-a83t */
> > +	if (is_sun8i)
> > +		if (cpu == 0)
> > +			return false;
> >  	return true;  
> 
> I think Chen-Yu told you how to implement the hotplug in the previous
> iteration, did you have time to test it?

Not yet, I will have a look this evening.

Best regards,

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
