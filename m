From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 13 Jul 2018 10:50:21 +0100
Subject: [PATCH 1/3 v4] ARM: dts: Modernize the Vexpress PL111 integration
In-Reply-To: <b00c3b85-1368-f62b-efda-d23ce27e6f9c@arm.com>
References: <20180709075232.30678-1-linus.walleij@linaro.org>
 <b00c3b85-1368-f62b-efda-d23ce27e6f9c@arm.com>
Message-ID: <0bcade58-26d5-8c2f-bcba-765aebd343bb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/07/18 10:46, Sudeep Holla wrote:
>  
> On 09/07/18 08:52, Linus Walleij wrote:

[...]

> 
> Still get below warnings, not sure if I need to upgrade my DTC ?
> 
> vexpress-v2f-1xv7-ca53x2.dtb: Warning (graph_child_address):
> /smb at 8000000/motherboard/iofpga at 3,00000000/i2c at 160000/dvi-transmitter at 39/ports:
> graph node has single child node 'port at 0', #address-cells/#size-cells
> are not necessary
> rtsm_ve-aemv8a.dtb: Warning (graph_child_address):
> /smb at 8000000/motherboard/iofpga at 3,00000000/i2c at 160000/dvi-transmitter at 39/ports:
> graph node has single child node 'port at 0', #address-cells/#size-cells
> are not necessary
> 

Ignore this as it's hard to fix. If you fix this you will get 10 other
warnings elsewhere, not sure why.

[...]

>> - Fixed up the Real-Time Systems Models Virtual Executive
>>   RTSMv8 AEM VE:
>>   - Added the I2C interface (whether implemented in the
>>     emulator or not)
> 
> It doesn't work. This change is breaking the working CLCD on the models.
> I just tested and CLCD driver returns
> 

It even fails to initialize CLCD on my TC2.

clcd-pl11x 1c1f0000.clcd: PL111 designer 41 rev1 at 0x1c1f0000
clcd-pl11x: probe of 1c1f0000.clcd failed with error -2

-- 
Regards,
Sudeep
