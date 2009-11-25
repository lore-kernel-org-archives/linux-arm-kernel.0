From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 16:50:31 +0100
Subject: [PATCH 05/17] ARM: pxa/raumfeld: add rotary encoder support
In-Reply-To: <4B0D4CAE.50709@compulab.co.il>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-6-git-send-email-daniel@caiaq.de>
	<4B0D4CAE.50709@compulab.co.il>
Message-ID: <20091125155031.GQ29442@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 05:26:38PM +0200, Mike Rapoport wrote:
> Daniel Mack wrote:
> >  static void __init raumfeld_common_init(void)
> >  {
> >  	enable_irq_wake(IRQ_WAKEUP0);
> > @@ -174,6 +197,12 @@ static void __init raumfeld_common_init(void)
> >  
> >  static void __init raumfeld_controller_init(void)
> >  {
> > +	struct platform_device *raumfeld_controller_devices[] = {
> > +		&rotary_encoder_device,
> > +	};
> 
> Any reason to keep the devices array inside the function? I think it makes the
> code less readable.

Ok - changed for the next round.

Thanks,
Daniel
