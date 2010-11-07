From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 7 Nov 2010 09:55:25 -0600
Subject: [PATCH 1/6] omap: iommu: remove redundant clock usage
In-Reply-To: <4CD5A846.4020607@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-2-git-send-email-omar.ramirez@ti.com>
	<4CD5A846.4020607@ti.com>
Message-ID: <AANLkTik3Qkf5cyYq-sP9gq0sG8fnYGHq7zvD7VuB-Vxy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 6, 2010 at 2:11 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>
>> iommu driver is meant to provide control of mmu hardware blocks
>
> A dot is missing here, and a capital letter should follow.

Actually it is a comma, it is meant to be part of the same paragraph.

>
>> its current users (MMUs) are part of larger subsystems and do not
>> have a dedicated clock as the one they use is shared with the
>> entire subsystem, it doesn't make sense to enable/disable on each
>> register read/write operation as the driver using its interface
>> should also be handling the same clock.
>>
>> iommu should only enable/disable the clock on mmu request/free from
>> the driver wanting to use it.
>
> Mmm, I'm not necessarily convinced by that explanation.
> If in a next revision, we change the clock partitioning and provide a
> dedicated clock for the mmu, it will not work anymore.
> I don't thing you should assume anything about the current partitioning.

HW wise, only one clock feeds the mmu, iva2_ck is used to generate
three clocks but this inside the IVA2 module. I'm assuming omap4 dsp
is the same.

ISP also depends on cam_ick (among others), and mmu is inside ISP module afaik.
