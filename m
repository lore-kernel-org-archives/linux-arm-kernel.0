From: tthayer@opensource.altera.com (Thor Thayer)
Date: Fri, 15 May 2015 16:01:39 -0500
Subject: [PATCH 4/4] dts, altera: Arria10 SDRAM EDAC DTS additions.
In-Reply-To: <5383549.sAl5szqT14@wuerfel>
References: <1431553787-27741-1-git-send-email-tthayer@opensource.altera.com>
 <1431553787-27741-5-git-send-email-tthayer@opensource.altera.com>
 <5383549.sAl5szqT14@wuerfel>
Message-ID: <55565EB3.7040102@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 05/15/2015 05:55 AM, Arnd Bergmann wrote:
> On Wednesday 13 May 2015 16:49:47 tthayer at opensource.altera.com wrote:
>> +               sdr: sdr at ffc25000 {
>> +                       compatible = "syscon";
>> +                       reg = <0xffcfb100 0x80>;
>> +               };
>> +
>>
>
> A syscon node with just 128 bytes seems very odd. Can you check the
> hardware manual to see if this is part of some bigger unit?
>
> 	Arnd
>

This is an unfortunate legacy of our previous SDRAM controller (in the 
CycloneV) which had ECC registers interspersed with registers other 
drivers needed - thus the use of syscon.

In the Arria10 chip, the ECC registers are in their own partitioned 
group but I kept the syscon to remain consistent with the Device Tree 
bindings from the CycloneV family.

I've implemented your other suggestions. Thank you for reviewing!

Thor
