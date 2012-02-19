From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 19 Feb 2012 08:07:38 +0100
Subject: [PATCH 16/18] Atmel: move console default platform_device to
 serial driver
In-Reply-To: <20120218091749.GA22669@samfundet.no>
References: <0d78171672a30e8ec8084f54a557e9948260356d.1329500622.git.nicolas.ferre@atmel.com>
 <81ce940f5ac09c5d50bfa712ab10a785f28df4ea.1329500622.git.nicolas.ferre@atmel.com>
 <20120218091749.GA22669@samfundet.no>
Message-ID: <20120219070738.GA491@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:17 Sat 18 Feb     , Hans-Christian Egtvedt wrote:
> Around Fri 17 Feb 2012 18:50:08 +0100 or thereabout, Nicolas Ferre wrote:
> > From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > 
> > This variable spread on every SoC that is using the atmel_serial.c
> > driver can be included directly into the latter.
> > 
> > This will allow to compile multiple soc in the same kernel.
> 
> Sounds like a good idea, but...
> 
> <snipp AT91 changes>
> 
> > diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
> > index 402a7bb..889c544 100644
> > --- a/arch/avr32/mach-at32ap/at32ap700x.c
> > +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> > @@ -1055,8 +1055,6 @@ struct platform_device *__init at32_add_device_usart(unsigned int id)
> >  	return at32_usarts[id];
> >  }
> >  
> > -struct platform_device *atmel_default_console_device;
> > -
> >  void __init at32_setup_serial_console(unsigned int usart_id)
> >  {
> >  	atmel_default_console_device = at32_usarts[usart_id];
> 
> I doubt this assignment will work if you remove the struct above. I did not
> look at how AT91 does this, will it be similar affected?
none the still exist in the kernel, its just moved

Best Regards,
J.
