From: vm.rod25@gmail.com (Victor Rodriguez)
Date: Mon, 15 Nov 2010 08:31:21 -0600
Subject: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930234A2ACE1@dbde02.ent.ti.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
	<1289601535-6746-5-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ABE7@dbde02.ent.ti.com>
	<4CE124AE.4080301@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ACE1@dbde02.ent.ti.com>
Message-ID: <AANLkTin7+Rf+WG6MbYb+RnR=k+1f9hDipuZUc0iTX=sx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 7:07 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> Hi Sergei,
>
> On Mon, Nov 15, 2010 at 17:46:46, Sergei Shtylyov wrote:
>> On 15.11.2010 14:10, Nori, Sekhar wrote:
>>
>> >> This patch defines Pin Mux configuration for MacASP
>> >> used on the Hawkboard-L138 system in order to add Audio support
>>
>> >> Signed-off-by: Victor Rodriguez<victor.rodriguez@sasken.com>
>> >> Tested-by: Rene Gonzalez<renegs.2378@gmail.com>
>>
>> >> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> >> index 63916b9..f033a0a 100644
>> >> --- a/arch/arm/mach-davinci/da850.c
>> >> +++ b/arch/arm/mach-davinci/da850.c
>> >> @@ -591,7 +591,7 @@ const short da850_cpgmac_pins[] __initdata = {
>> >> ? const short da850_mcasp_pins[] __initdata = {
>> >> ? ? ? ?DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
>> >> ? ? ? ?DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
>> >> - ? ? DA850_AXR_11, DA850_AXR_12,
>> >> + ? ? DA850_AXR_11, DA850_AXR_12, DA850_AXR_13, DA850_AXR_14,
>>
>> > Looks like I missed pointing this out previously, but extending
>> > this list to take care of all boards will not be right since
>> > (for example) AXR13 and AXR14 pins could be used for different
>> > purpose on different boards.
>>
>> ? ? This is correct as the list in da850.c is a *generic* module's pin list.
>> If the board needs less pins (and the pins it does not use for McASP are used
>> differently), it should define its own pin list.
>>
>> > The right way would be to make this a per-board list. Since it
>> > is marked __initdata, that wouldn't lead to bloat.
>>
>> ? ? This patch is correct anyway. Unless DA850 EVM board can't use these pins
>> for McASP -- but in this case the corresponding board file needs the specific
>> pin list added.
>
> Okay. I guess you are saying we will keep adding pins to the generic list
> as long as *all* supported boards don't get a conflict and if we run into
> a conflict we will spawn separate list for the affected board.
>
> The only issue I see with this approach is it puts too much burden on the
> developer to verify that none of the supported boards break.
>
> Since it is highly unlikely that any board will need all the McASP pins,
> the generic list will likely remain unused. It might just be easier to
> start using board specific lists right away. This is especially true for
> McASP where usage of pins across boards will likely vary widely.
>
> Thanks,
> Sekhar
>
>
Hi All

Please confirme me if the path is rigth or if I should make a McASP
list for the board.

Regards

Victor Rodriguez
