From: robherring2@gmail.com (Rob Herring)
Date: Tue, 21 Jun 2011 07:51:27 -0500
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <4E007CEB.6040104@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<201106171707.23989.arnd@arndb.de> <4DFB8E20.60802@gmail.com>
	<4E007CEB.6040104@arm.com>
Message-ID: <4E0093CF.6030804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On 06/21/2011 06:13 AM, Marc Zyngier wrote:
> On 17/06/11 18:25, Rob Herring wrote:
>> Also, device tree support for early platform devices would be useful for
>> this.
> 
> What about the attached patch? I've used it to boot a VExpress board
> with the following DT snippet (and the corresponding support in the
> amp_smp_twd driver):
> 
> 	localtimer at 2c000600 {
> 		device_type = "localtimer";

My understanding is device_type is only supposed to be used for devices
with real OpenFirmware. You could just add localtimer or timer as a 2nd
compatible string. I think localtimer is a bit of a Linux name, so just
timer may be better.

Rob

> 		compatible = "arm,smp-twd";
> 		reg = <0x2c000600 0x1000>;
> 		interrupts = <29>;
> 	};
> 
> Cheers,
> 
> 	M.
