From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 11 Sep 2013 16:14:28 +0400
Subject: [PATCH v2 4/4] ARM: shmobile: BOCK-W reference: add Ether PFC
 settings
In-Reply-To: <CANqRtoRKFoS9tehteDGaTUYJ8fSBqAYJJDiLxZmoNB9W0N+Mpg@mail.gmail.com>
References: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
 <201309070431.35908.sergei.shtylyov@cogentembedded.com>
 <CANqRtoRKFoS9tehteDGaTUYJ8fSBqAYJJDiLxZmoNB9W0N+Mpg@mail.gmail.com>
Message-ID: <52305EA4.1060902@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-09-2013 11:05, Magnus Damm wrote:

>> Add the Ether pin group to bockw_pinctrl_map[].

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>>   arch/arm/mach-shmobile/board-bockw-reference.c |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> Index: renesas/arch/arm/mach-shmobile/board-bockw-reference.c
>> ===================================================================
>> --- renesas.orig/arch/arm/mach-shmobile/board-bockw-reference.c
>> +++ renesas/arch/arm/mach-shmobile/board-bockw-reference.c
>> @@ -29,6 +29,9 @@
>>    */
>>
>>   static const struct pinctrl_map bockw_pinctrl_map[] = {
>> +       /* Ether */
>> +       PIN_MAP_MUX_GROUP_DEFAULT("fde00000.ethernet", "pfc-r8a7778",
>> +                                 "ether_rmii", "ether"),
>>          /* SCIF0 */
>>          PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
>>                                    "scif0_data_a", "scif0"),

> Hi Sergei,

> Thanks for your patches. In general I think your series looks fine. I
> have a single comment, and that's about the pinctrl-related hunk
> above. I can see that this patch is for DT reference for Bock-W, so I
> expect the code to be in DT. Do you have any plans to use DT to
> describe the pinmux bits? Perhaps you have some incremental patch
> planned?

    No, I just repeated what I saw mechanically. Now I'm seeing some evidence 
that PFC driver supports the device tree, so I probably need to redo the 
patchset... let me study this question better.

> Cheers,

> / magnus

WBR, Sergei
