From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 25 Oct 2013 10:00:10 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <1382616801.6040.26.camel@sakura.staff.proxad.net>
References: <20131020220839.GT2443@sirena.org.uk>	
 <5264576F.6050307@wwwdotorg.org>	
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>	
 <52658EBC.8020800@wwwdotorg.org>	
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>	
 <20131022093923.GC15640@ulmo.nvidia.com> <20131022150426.GF29341@beef>	
 <20131022171346.GE4061@obsidianresearch.com>	
 <20131023080630.GA14413@netboy>	
 <20131023172955.GA17145@obsidianresearch.com>	
 <20131023174458.GC5208@netboy>	
 <1382553982.31058.10.camel@sakura.staff.proxad.net>	
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>	
 <1382614439.6040.16.camel@sakura.staff.proxad.net>	
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <1382616801.6040.26.camel@sakura.staff.proxad.net>
Message-ID: <526A331A.3060200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2013 01:13 PM, Maxime Bizon wrote:
> 
> On Thu, 2013-10-24 at 12:47 +0100, David Woodhouse wrote:
> 
>> If you can automatically infer the correct clock/interrupt/etc in order
>> to do DMA correctly, despite the fact that it wasn't explicitly spelled
>> out in the old DT, then the property is *not* a "required" property.
>> It's optional, and you have a default behaviour for when it's not
>> present.
> 
> so inside the new version of driver-hwcrypto.c:
> 
> if (irq_of_parse_and_map(...) == NO_IRQ) {
> 	switch (get_soc_model()) {
> 		case SOC1:
> 			irq = 51;
> 			break;
> 
> 		case SOC2:
> 			irq = 62;
> 			break;
> 
> 		[...]
> 	}
> }

Uggh. Then you start embedding all the per-SoC or per-board description
in the drivers. It doesn't seem scalable for every driver to know about
every HW configuration. Adding extra IRQ/DMA/... properties to DT to
enable new features should be fine.
