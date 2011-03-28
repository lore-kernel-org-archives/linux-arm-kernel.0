From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 27 Mar 2011 20:49:48 -0500
Subject: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
In-Reply-To: <4D8E5CD3.8010007@ru.mvista.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
	<4D8E5CD3.8010007@ru.mvista.com>
Message-ID: <AANLkTikcV_NSYz+zSRRMA=dQMxB7AS1tKsau95mxbCka@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 26, 2011 at 4:38 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 26-03-2011 3:29, Omar Ramirez Luna wrote:
>
>> If an error occurs in the L3 on any other initiator than MPU,
>> the interrupt goes unhandled given that the 'base' register
>> was calculated with the initialized err_base value (which
>> coincidentally points to MPU) and not with the actual source
>> of the error.
>
>> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
>> ---
>> ?arch/arm/mach-omap2/omap_l3_smx.c | ? ?5 +++--
>> ?1 files changed, 3 insertions(+), 2 deletions(-)
>
>> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c
>> b/arch/arm/mach-omap2/omap_l3_smx.c
>> index 5f2da75..da917c2 100644
>> --- a/arch/arm/mach-omap2/omap_l3_smx.c
>> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
>> @@ -196,11 +196,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, void
>> *_l3)
>> ? ? ? ? ? ? ? ?/* No timeout error for debug sources */
>> ? ? ? ?}
>>
>> - ? ? ? base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
>> -
>> ? ? ? ?/* identify the error source */
>> ? ? ? ?for (err_source = 0; !(status& ?(1<< ?err_source)); err_source++)
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?;
>> +
>> + ? ? ? base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
>> +
>
> ? What's the point of having () around rvalue? You could drop them, while at
> it...

You're right, will do.

Regards,

Omar
