From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 2 Apr 2013 16:10:06 +0530
Subject: [Query] PM runtime API
In-Reply-To: <CA+V-a8su4DDRudniqf8zAEb8Vmcbk4U6gtVLUOmOAm+n3t-PvQ@mail.gmail.com>
References: <CA+V-a8su4DDRudniqf8zAEb8Vmcbk4U6gtVLUOmOAm+n3t-PvQ@mail.gmail.com>
Message-ID: <515AB586.1090100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/2/2013 4:05 PM, Prabhakar Lad wrote:
> Hi Kevin/Sekhar,
> 
> I am porting the VPSS davinci driver to pm runtime API. This driver uses two
> clocks vpss_master and vpss_slave. The driver was initially using common clock
> framework, now when migrated i see only one clock enabled.
> 
> 1: Does pm runtime match only with the device id to enable the clock ?
> 
>  2:
>     	CLK("vpss", "master", &vpss_master_clk),
> 	CLK("vpss", "slave", &vpss_slave_clk),
>      If I provide above two clock lookups pm runtime doesnt enable
> them, but If I set
>      the connection id as NULL then only the master clock gets enabled.
> 
> My understanding is that pm runtime matches upon the device id for the
> first entry and only enables it.
> 
> Any inputs/suggestion how to handle it.

I think you need to tell pm_runtime about the con_ids. See the
initialization of pm_clk_notifier_block in
arch/arm/mach-davinci/pm_domain.c. There is a list of known con_ids that
need to passed.

Thanks,
Sekhar
