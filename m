From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 20 Sep 2017 15:56:14 +0000
Subject: [RESEND PATCH 0/4] EDAC: support reduce bus width on 98dx3236
References: <20170807014641.4003-1-chris.packham@alliedtelesis.co.nz>
 <87a81pplm7.fsf@free-electrons.com>
Message-ID: <65e008eb149b4abd891f676770138fb8@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Thanks for following up.

On 21/09/17 01:04, Gregory CLEMENT wrote:
> Hi Chris,
>   
>   On lun., ao?t 07 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> 
>> (sorry I messed up sending this earlier, there is one additional patch and I'll
>> actually include the linux-arm and linux-edac mailing lists)
>>
>> This series applies on top of Jan Lubbe's "EDAC drivers for Armada XP L2 and
>> DDR" series[1]. 1/4, 2/4 and 3/4 don't strictly depend on Jan's work so they
>> could go in through the ARM tree if that is preferred.
>>
>> The 98dx3236 and similar switch chips with integrated CPUs have fewer pins
>> available for the SDRAM interface so the definition of "full" and "half" is
>> different to the Armada-XP SoC. In this series I introduce a
>> "marvell,reduced-width" device tree property and use this to identify such a
>> system.
>>
>> I chose to use a new property instead of a new compatible string because the IP
>> block really is the Armada-XP one (at least according to the Marvell FAE I
>> spoke to) and because the scenario of requiring a reduced pin-count when going
>> from an external SoC to an integrated one will be reasonably common as we see
>> more an more of these switches with integrated ARM cores.
> 
> If I understood well a version 2 is expected. If I missed it, please
> point me on it.

Yes I owe a v2. I was actually waiting to see Jan's series applied 
before sending my additions which build upon it. I'm traveling right now 
so it'll probably be at least a week before I'm able to send the next 
iteration.

> Once the binding will be acked I will be able to apply the dts
> patch. For the first patch unless I am wrong the the series "EDAC
> drivers for Armada XP L2 and DDR" was not applied or even formally
> acked.

Last I saw there was some comments from Boris on v2 of that series that 
needed addressing. Not sure if Jan has time to look at them. If not I 
can have a go when I get back.

> Also while you will be at sending a new version please add a
> commit log even a simple one.

Will do.
> For the 3rd patch, I also wait the new version of patch 2 with an
> ack.

Yes that's fine. I'm now doing some work on and Armada-38x platform and 
I realize that that also has the narrower DDR interface (as does the 375 
I believe). I was planning on using that as the compatible string since 
it's much better known than the integrated switch asic + CPU I've been 
working with.

> 
> Thanks,
> 
> Gregory
> 
> 
>>
>>
>> [1] - http://marc.info/?l=linux-edac&m=150167758312924
>>
>> Chris Packham (4):
>>    ARM: dts: enable L2 cache parity and ecc on db-xc3-24g4xg board
>>    dt-bindings: add "reduced-width" property for Armada XP SDRAM
>>      controller
>>    ARM: dts: mvebu: set reduced-width property for SDRAM on 98dx3236
>>    EDAC: add support for reduced-width Armada-XP SDRAM
>>
>>   .../bindings/memory-controllers/mvebu-sdram-controller.txt          | 6 ++++++
>>   arch/arm/boot/dts/armada-xp-98dx3236.dtsi                           | 1 +
>>   arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts                       | 5 +++++
>>   drivers/edac/armada_xp_edac.c                                       | 3 +++
>>   4 files changed, 15 insertions(+)
>>
>> -- 
>> 2.13.0
>>
> 
