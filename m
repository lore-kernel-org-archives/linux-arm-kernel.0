From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Tue, 2 Apr 2013 16:05:16 +0530
Subject: [Query] PM runtime API
Message-ID: <CA+V-a8su4DDRudniqf8zAEb8Vmcbk4U6gtVLUOmOAm+n3t-PvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin/Sekhar,

I am porting the VPSS davinci driver to pm runtime API. This driver uses two
clocks vpss_master and vpss_slave. The driver was initially using common clock
framework, now when migrated i see only one clock enabled.

1: Does pm runtime match only with the device id to enable the clock ?

 2:
    	CLK("vpss", "master", &vpss_master_clk),
	CLK("vpss", "slave", &vpss_slave_clk),
     If I provide above two clock lookups pm runtime doesnt enable
them, but If I set
     the connection id as NULL then only the master clock gets enabled.

My understanding is that pm runtime matches upon the device id for the
first entry and only enables it.

Any inputs/suggestion how to handle it.

Regards,
--Prabhakar
