From: Li.Xiubo@freescale.com (Li Xiubo)
Date: Tue, 3 Dec 2013 06:56:44 +0000
Subject: [PATCHv6 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM.
In-Reply-To: <20131128213159.GE14689@mithrandir>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-5-git-send-email-Li.Xiubo@freescale.com>
 <20131128213159.GE14689@mithrandir>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828E38BB@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +    "ftm0" (module clock),
> > +    "ftm0_counter" (counter clock),
> > +- clocks : Must contain a clock specifier for each entry in
> > +clock-names,
> > +  See clock/clock-bindings.txt for details of the property values.
> 
> Note that the order is significant here, at least from the way the driver
> currently implements this. You can probably make this more generic in the
> driver by using of_property_match_string() on the clock-names property to
> find the index of "ftm0_counter" and pass that index to the
> of_parse_phandle_with_args() function to cope with the situation where the
> device tree has the clocks in a different order.
> 

Yes, this's much better. As this is still under discussing, I will improve
about this after that.

And I will also revise other as you have piontet out.

--
Best Regards,
