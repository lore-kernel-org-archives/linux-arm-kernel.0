From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Jun 2011 12:13:47 +0100
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <4DFB8E20.60802@gmail.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<201106171707.23989.arnd@arndb.de> <4DFB8E20.60802@gmail.com>
Message-ID: <4E007CEB.6040104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/11 18:25, Rob Herring wrote:
> Also, device tree support for early platform devices would be useful for
> this.

What about the attached patch? I've used it to boot a VExpress board
with the following DT snippet (and the corresponding support in the
amp_smp_twd driver):

	localtimer at 2c000600 {
		device_type = "localtimer";
		compatible = "arm,smp-twd";
		reg = <0x2c000600 0x1000>;
		interrupts = <29>;
	};

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
