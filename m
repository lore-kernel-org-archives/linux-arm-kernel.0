From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 May 2015 09:36:38 +0200
Subject: [PATCH v2 2/2] ARM: vf610: Add SoC bus support for Vybrid
In-Reply-To: <9691074.oWRy1bscbz@wuerfel>
References: <cover.1432099651.git.maitysanchayan@gmail.com>
 <27733a88b73adb7000205e020bafdb6f7ebe1843.1432099651.git.maitysanchayan@gmail.com>
 <9691074.oWRy1bscbz@wuerfel>
Message-ID: <61cec15fe896133ee6e102b0242fb43d@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-20 09:12, Arnd Bergmann wrote:
> On Wednesday 20 May 2015 11:06:52 Sanchayan Maity wrote:
>> Implements SoC bus support to export SoC specific information. Read
>> the unique SoC ID from the Vybrid On Chip One Time Programmable
>> (OCOTP) controller, SoC specific information from the Miscellaneous
>> System Control Module (MSCM), revision from the ROM revision register
>> and expose it via the SoC bus infrastructure.
>>
>> Sample Output:
>>
>> root at vf:/sys/devices/soc0# cat soc_id
>> df63c12a2e2161d4
>> root at vf:/sys/devices/soc0# cat family
>> Freescale Vybrid VF500
>> root at vf:/sys/devices/soc0# cat revision
>> 00000013
>> root at vf:/sys/devices/soc0# cat machine
>> Freescale Vybrid
>>
> 
> I would prefer to see this as a driver in drivers/soc that registers
> to a platform device. Is there any DT node that would be a reasonable
> device to bind to?

Hm, what is a viable device? Probably the most SoC specific device in
the SoC? Currently, all three devices we read from do have a
vf610-something compatible string, hence would be SoC specific (ocotp,
ocrom and mscm-cpucfg). Probably the last is the most SoC specific...

But somehow bind to just a random device sounds wrong to me. Couldn't we
add a more specific compatible string to the soc node and bind to that?

--
Stefan
