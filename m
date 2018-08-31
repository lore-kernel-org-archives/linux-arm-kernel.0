From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 31 Aug 2018 05:06:57 +0200
Subject: [PATCH 0/2] ARM: dts: socfpga: Add support for PMU on
 Arria5/Cyclone5
In-Reply-To: <d723d5df-a700-3781-e8a5-4e57185585f8@kernel.org>
References: <1488297132-21553-1-git-send-email-florian.vaussard@heig-vd.ch>
 <d723d5df-a700-3781-e8a5-4e57185585f8@kernel.org>
Message-ID: <b575b848-ffaa-43cd-ee70-8538ede3eca8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2017 04:19 PM, Dinh Nguyen wrote:
> 
> 
> On 02/28/2017 09:52 AM, Florian Vaussard wrote:
>> Hi,
>>
>> These patches add suport for ARM Performance Monitor Units on Arria5 and
>> Cyclone5 SoCFPGA. This was tested on a Cyclone 5 SoC DK board.
>>
>> Side note: the same change can be probably applied to Arria10 as well,
>> but we do not have the hardware here to test.
>>
>> Regards,
>> Florian
>>
>> Florian Vaussard (2):
>>   ARM: dts: socfpga: Add labels for CPU nodes
>>   ARM: dts: socfpga: Add support for PMU
>>
>>  arch/arm/boot/dts/socfpga.dtsi | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
> 
> Applied!

I have to wonder how this was tested. I tried this on 4.14.y, but when I
do "perf record -e cycles", I get no samples. Moreover, when I check the
PMU interrupts, "grep pmu /proc/interrupts", it shows 0 interrupts from
the ARM PMU all the time.

Why am I not getting any PMU interrupts when using perf ?

-- 
Best regards,
Marek Vasut
