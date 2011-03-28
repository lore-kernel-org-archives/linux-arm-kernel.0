From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 28 Mar 2011 10:15:52 -0500
Subject: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
In-Reply-To: <f12f050c3f7fe0b405fde475fcd62104@mail.gmail.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
	<f12f050c3f7fe0b405fde475fcd62104@mail.gmail.com>
Message-ID: <AANLkTimDCpHQ5yvYN+0mW7HyyovyXCdGOf8LPv5FapNh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 28, 2011 at 12:38 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> If an error occurs in the L3 on any other initiator than MPU,
>> the interrupt goes unhandled given that the 'base' register
>> was calculated with the initialized err_base value (which
>> coincidentally points to MPU) and not with the actual source
>> of the error.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>
> Patch looks good. Did you observe this with DSP initiator??

Yes, when loading a base image for the DSP, I got an: In-band Error
Error seen by IVA_SS  at address 0; after this fix.

I was planning to remove the duplicated "Error" print too.

> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks, I'll add it in my next version when I make the changes
affecting only these lines.

Regards,

Omar
