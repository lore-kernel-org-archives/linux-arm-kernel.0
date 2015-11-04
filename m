From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Nov 2015 19:31:42 +0000
Subject: PSCI_CPU_ON flow
In-Reply-To: <20151104171048.GE23860@leverpostej>
References: <BY1PR0301MB1303B5D1A8CD0B7FA07AA40A822A0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <20151104171048.GE23860@leverpostej>
Message-ID: <20151104193142.GM8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 05:10:49PM +0000, Mark Rutland wrote:
> Yes, the CPU should start at __pa(secondary_entry) in head.S. From there
> it will branch to secondary_startup:
> 
> ENTRY(secondary_entry)
> 	bl      el2_setup                       // Drop to EL1
> 	bl      set_cpu_boot_mode_flag
> 	b       secondary_startup
> ENDPROC(secondary_entry)

We've been busy telling people to implement errata workarounds in firmware,
and we're also busy telling people that their secondary CPUs should start
in the kernel.  The two are incompatible with each other...

I think we need to come up with a clearer statement on both these subjects
which gives people a good idea about what's required, and doesn't send out
confusing messages.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
