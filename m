From: olof@lixom.net (Olof Johansson)
Date: Fri, 12 Jan 2018 10:18:38 -0800
Subject: [GIT PULL] ARM64: Xilinx ZynqMP SoC patches for v4.16
In-Reply-To: <CAK8P3a0JwAW2ZhQAQ6A3o9KC9sXe7qRJT7ZM+rZxGXX9dk0ADg@mail.gmail.com>
References: <84cfd3d5-f0e7-23dc-0e33-430a1f2dbdb0@monstr.eu>
 <20180112012847.iqol2xb2iro6wauk@localhost>
 <011f77e4-040b-a864-168f-bc198a523536@monstr.eu>
 <CAK8P3a0JwAW2ZhQAQ6A3o9KC9sXe7qRJT7ZM+rZxGXX9dk0ADg@mail.gmail.com>
Message-ID: <CAOesGMgGXbLCfrwqrY9=GoT4d1-UzX0svt-pYohXhJq7AdmODQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 12:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jan 12, 2018 at 7:44 AM, Michal Simek <monstr@monstr.eu> wrote:
>> On 12.1.2018 02:28, Olof Johansson wrote:
>>> On Mon, Jan 08, 2018 at 02:02:18PM +0100, Michal Simek wrote:
>
>>>> ----------------------------------------------------------------
>>>> Dhaval Shah (2):
>>>>       dt-bindings: soc: xilinx: Add DT bindings to xlnx_vcu driver
>>>>       soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver
>>>>
>>>> Michal Simek (1):
>>>>       soc: xilinx: Create folder structure for soc specific drivers
>>>>
>>>
>>> Merged, but you should probably add a platform config option for Xilinx
>>> and use that instead of obj-y to descend into the directory?
>
> I don't see it in arm-soc yet, did you forget to push the latest branches?

Hm, not sure what happened there. Fixing now.

>
>> Do you think change like this?
>>
>> -obj-y                          += xilinx/
>> +obj-$(CONFIG_ARCH_ZYNQMP)      += xilinx/
>>
>> Just a note. This folder is supposed to be used by arm64/arm32 and
>> microblaze that's why I didn't put there any single config because it
>> doesn't exist. If you suggest to introduce new config option to label
>> xilinx platforms we can talk about it.
>> Argument against it could be also using these drivers by openrisc or
>> mips (mipsfpga) which are also fpga based.
>> Anyway I am happy to hear what you suggest.
>>
>
> I think obj-y is fine in this case, the cost is minimal.

Yeah, if it's across platforms/architectures like this it's fine.


-Olof
