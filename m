From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 12 Feb 2015 19:00:29 +0100
Subject: [PATCHv6 4/5] USB: gadget: atmel_usba_udc: Prepare for IRQ
 single edge support
In-Reply-To: <20150208102439.5be43f78@bbrezillon>
References: <1421945805-31129-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421945805-31129-5-git-send-email-sylvain.rochet@finsecur.com>
 <20150122181422.1ba305f1@bbrezillon> <54D3A63B.6040209@atmel.com>
 <20150207193723.GA32213@gradator.net>
 <20150208102439.5be43f78@bbrezillon>
Message-ID: <20150212180029.GA8756@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Boris,

On Sun, Feb 08, 2015 at 10:24:39AM +0100, Boris Brezillon wrote:
> On Sat, 7 Feb 2015 20:37:23 +0100
> Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> 
> > If not, is udc->caps->irq_single_edge_support boolean acceptable ?
> 
> Do you mean keeping the current approach ?

Yes!


> If you do, then maybe you can rework a bit the way you detect the GPIO
> controller you depends on: instead of linking this information to the
> usba compatible string you could link it to the gpio controller
> compatible string.
> 
> You can find the gpio controller node thanks to your "vbus-gpio"
> property: use the phandle defined in this property to find the gpio
> controller node, and once you have the device_node referencing the gpio
> controller you can match it with your internal device_id table
> (containing 2 entries: one for the at91rm9200 IP and the other for the
> at91sam9x5 IP).

I have a working PoC for that if this is the chosen solution.


> Another solution would be to add an irq_try_set_irq_type function that
> would not complain when it fails to set the requested trigger.
> 
> Thomas, I know you did not follow the whole thread, but would you mind
> adding this irq_try_set_irq_type function (here is a reference
> implementation [1]), to prevent this error trace from happening when
> we're just trying a configuration ?

This would be great :-)


> > If not, I am ok to drop the feature, this is only a bonus.
> 
> That could be a short term solution, to get this series accepted. We
> could then find a proper way to support that optimization.

I agree, I have the feeling your proposed core change may takes a long 
time, I just sent a v7 without IRQ single edge support.


Sylvain
