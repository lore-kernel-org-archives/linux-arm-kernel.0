From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 15 Nov 2010 15:16:46 +0300
Subject: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930234A2ABE7@dbde02.ent.ti.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
	<1289601535-6746-5-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ABE7@dbde02.ent.ti.com>
Message-ID: <4CE124AE.4080301@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.11.2010 14:10, Nori, Sekhar wrote:

>> This patch defines Pin Mux configuration for MacASP
>> used on the Hawkboard-L138 system in order to add Audio support

>> Signed-off-by: Victor Rodriguez<victor.rodriguez@sasken.com>
>> Tested-by: Rene Gonzalez<renegs.2378@gmail.com>

>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> index 63916b9..f033a0a 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
>> @@ -591,7 +591,7 @@ const short da850_cpgmac_pins[] __initdata = {
>>   const short da850_mcasp_pins[] __initdata = {
>>        DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
>>        DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
>> -     DA850_AXR_11, DA850_AXR_12,
>> +     DA850_AXR_11, DA850_AXR_12, DA850_AXR_13, DA850_AXR_14,

> Looks like I missed pointing this out previously, but extending
> this list to take care of all boards will not be right since
> (for example) AXR13 and AXR14 pins could be used for different
> purpose on different boards.

    This is correct as the list in da850.c is a *generic* module's pin list. 
If the board needs less pins (and the pins it does not use for McASP are used 
differently), it should define its own pin list.

> The right way would be to make this a per-board list. Since it
> is marked __initdata, that wouldn't lead to bloat.

    This patch is correct anyway. Unless DA850 EVM board can't use these pins 
for McASP -- but in this case the corresponding board file needs the specific 
pin list added.

> Thanks,
> Sekhar

WBR, Sergei
