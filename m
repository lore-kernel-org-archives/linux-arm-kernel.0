From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Wed, 14 Dec 2016 16:36:30 +0000
Subject: [PATCH 2/2] FPGA: Add TS-7300 FPGA manager
In-Reply-To: <alpine.DEB.2.10.1612120951520.3310@atull-730U3E-740U3E>
References: <20161211221750.27743-1-f.fainelli@gmail.com>
 <20161211221750.27743-3-f.fainelli@gmail.com>
 <alpine.DEB.2.10.1612120951520.3310@atull-730U3E-740U3E>
Message-ID: <SN1PR0101MB15658783ED2430979BC4978CD09A0@SN1PR0101MB1565.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 12, 2016 9:02 AM, Alan Tull wrote:
> On Sun, 11 Dec 2016, Florian Fainelli wrote:
>> Add support for loading bitstreams on the Altera Cyclone II FPGA
>> populated on the TS-7300 board. This is done through the configuration
>> and data registers offered through a memory interface between the EP93xx
>> SoC and the FPGA.
>> 
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>
> Hi Florain,
>
> Thanks for submitting!
>
> How specific is this to the tx7300 board?
>
> I'm unclear about the programming method here.  Are these registers
> exposed by the EP93xx?  Is it possible that another cpu could access
> these two registers to configure the cyclone ii?  Is this passive
> serial?

Alan,

>From the schematic, it appears that the Cyclone II FPGA is configured for
Fast AS programming. The glue chip (MAXII CLPD) on the board appears to
implement some kind of state machine to handle the FPGA programming
using two registers in the glue chip.

Hartley
