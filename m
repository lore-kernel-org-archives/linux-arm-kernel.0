From: svenkatr@ti.com (S, Venkatraman)
Date: Thu, 25 Aug 2011 20:25:13 +0530
Subject: [PATCH 0/2] OMAP: Update nr_irqs field in machine descriptors
In-Reply-To: <4E5636CD.4080302@ti.com>
References: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
	<4E5636CD.4080302@ti.com>
Message-ID: <CANfBPZ-AAZx9TxO88EgxCtOUsWrsYzbK+M2d6cVSS7Kf-LwS3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 5:19 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Venkat,
>
> On 8/24/2011 9:46 PM, S, Venkatraman wrote:
>>
>> As part of an effort to get single ARM kernel binary [1],
>> multiple ?definitions of NR_IRQS under various platforms
>> have to be reconciled and abstracted away from common code.
>>
>> This patch series takes the small step of populating the
>> machine descriptors with the pre-existing nr_irqs field.
>> Eventually, the common irq handler code will only look at this
>> field and not the compile time constant.
>
> Not related to this patch, but still on that topic. The current NR_IRQS
> depends as well on board stuff, like for example : the Phoenix
> IRQs:TWL6030_IRQ_BASE, TWL6040_CODEC_IRQ_BASE.
> Is there a plan to get rid of this static defines?
>

Currently, the goal is to get rid of the singleton nature
of NR_IRQS. Then it just becomes a property of the
platform, and the arm common code should not see this define.
This cleanup has to be done across multiple SoCs, not just OMAP.

After I get to complete some meaningful cleanup of NR_IRQS,
I can look into the static defines that you mention.

Best regards,
Venkat.
