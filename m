From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 09:11:24 -0800
Subject: [PATCH V2 1/6] pinctrl: pinctrl-single: use arch_initcall and
 module_exit
In-Reply-To: <20130201170906.GE22517@atomide.com>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
 <1359445134-13323-2-git-send-email-manishv.b@ti.com>
 <CACRpkdbf7TwrjfT2rhqQFGc3yh_Nt117RtzQO2y6g5Ddx5Ay_w@mail.gmail.com>
 <20130201170906.GE22517@atomide.com>
Message-ID: <20130201171124.GF22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130201 09:12]:
> * Linus Walleij <linus.walleij@linaro.org> [130129 03:03]:
> > On Tue, Jan 29, 2013 at 8:38 AM, Vishwanathrao Badarkhe, Manish
> > <manishv.b@ti.com> wrote:
> > 
> > > Currently, I2C driver gets probed before pinctrl driver.
> > > To achieve I2C pin muxing via pinctrl driver before I2C
> > > probe get called, register pinctrl driver in arch_initcall.
> > > Also, add module_exit to unregister pinctrl driver.
> > >
> > > Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
> > 
> > So your I2C driver is not returning -EPROBE_DEFER
> > if it cannot find its pins?
> > 
> > Hm, well I can live with this, if Tony ACKs it.
> 
> Hmm pinctrl is before i2c in drivers/Makefile.
> Making initcalls happen earlier and earlier is usually the
> wrong way to go. Sounds like there's some other issue here
> that needs to be fixed instead.

Let me guess: The i2c driver is wrongly set to run with
arch_initcall?
 
> Regards,
> 
> Tony
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
