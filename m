From: david@lechnology.com (David Lechner)
Date: Tue, 25 Sep 2018 10:23:40 -0500
Subject: [PATCH] ARM: dts: da850-lego-ev3: slow down A/DC as much as
 possible
In-Reply-To: <a6e9c7ce-8fc8-0ee2-2d3a-24c33b67bdcc@ti.com>
References: <20180924013146.18121-1-david@lechnology.com>
 <a6e9c7ce-8fc8-0ee2-2d3a-24c33b67bdcc@ti.com>
Message-ID: <fda2606b-3c7b-539a-ae07-4d9b57c34335@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/25/18 1:04 AM, Sekhar Nori wrote:
> Hi David,
> 
> On Monday 24 September 2018 07:01 AM, David Lechner wrote:
>> Due to the electrical design of the A/DC circuits on LEGO MINDSTORMS EV3,
>> if we are reading analog values as fast as possible (i.e. using DMA to
>> service the SPI) the A/DC chip will read incorrect values - as much as
>> 0.1V off when the SPI is running at 10MHz. (This has to do with the
>> capacitor charge time when channels are muxed in the A/DC.)
> 
> So you believe this is an issue with the board design rather than the
> limitation of the ADC chip itself? Because if its the later, the fix
> should be in the driver instead.

It is the board design. There are external 4.7k series resistors that 
make the RC charge time so long.

> 
>>
>> Both of these patches mentioned have been picked up in the respective
>> subsystems.
> 
> Is this needed for the -rc cycle or can wait for v4.20?

v4.20
