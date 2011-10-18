From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 18 Oct 2011 19:58:37 +0800
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <4E9BAC4D.3010402@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111016145536.GA29885@S2100-06.ap.freescale.net>
	<4E9BAC4D.3010402@ti.com>
Message-ID: <20111018115836.GC30703@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 09:47:17AM +0530, Rajendra Nayak wrote:
> 
> >I do not see that of_get_regulation_constraints() covers the following
> >fields.  We do not support them for DT probe?
> 
> I left these out as I wasn't sure how such (if at all) Linux
> specific params should be passed through dt, and I am still not
> quite sure :(
> 
I'm seeing some linux specific parameters encoded in the device tree
below.

  Documentation/devicetree/bindings/gpio/gpio_keys.txt
  Documentation/devicetree/bindings/gpio/led.txt

Mark,

I understand that ideally device tree is supposed to describe pure
hardware configurations.  But practically, when migrating a driver
to device tree probe, we are trying to move the configurations
described by platform_data into device tree to save the use of
platform_data for device tree probe.  Then some of the configuration
may not be so purely hardware related.  But I do not see this is a
critical problem.

What do you think?  Is it what you want that we classify the
configurations clearly and put only strict hardware configurations
into device tree and keep others still in platform_data?

-- 
Regards,
Shawn
