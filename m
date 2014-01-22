From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 22 Jan 2014 10:32:54 +0000
Subject: Question: about wm8904's regulator consumer nodes
In-Reply-To: <20140121181032.GI17314@sirena.org.uk>
References: <B256D81BAE5131468A838E5D7A24364172F64369@penmbx01>
 <20140121181032.GI17314@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A24364172F669CB@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Mark Brown
> Sent: Wednesday, January 22, 2014 2:11 AM
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: Question: about wm8904's regulator consumer nodes
> 
> On Tue, Jan 21, 2014 at 07:10:24AM +0000, Yang, Wenyou wrote:
> 
> >                                          DCVDD-supply = <&vcc_1v8_reg>;
> >                                          DBVDD-supply = <&vddana_reg>;
> >                                          AVDD-supply = <&vcc_1v8_reg>;
> >                                          CPVDD-supply = <&vcc_1v8_reg>;
> >                                          MICVDD-supply =
> > <&vddana_reg>;
> 
> > 	But the power of DCVDD, DBVDD, AVDD, CPVDD and MICVDD is not
> supplied by any regulators, not the above regulator nodes.
> 
> > 	How do I deal with this case? Could you give me some advice?
> 
> You should set up the supplies to point to whatever regulator is
> supplying the power.  If there are supplies on the board which are
> generated using fixed voltage regulators then you should register those
> using the fixed regulator driver.  Recent kernels are more tolerant of
> missing supplies but it's still better to be explicit if you can be.
Thank a lot for your answer.

Best Regards,
Wenyou Yang
