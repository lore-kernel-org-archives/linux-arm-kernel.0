From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 25 Sep 2010 18:42:33 +0300
Subject: [PATCH 05/11] omap3: Remove non-existent config option
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
Message-ID: <AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 24, 2010 at 6:17 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> On Fri, Sep 24, 2010 at 4:50 AM, Tony Lindgren
>> <tony@atomide.com> wrote:
>> > From: Yogesh Marathe <yogesh_marathe@ti.com>
>> >
>> > The definition of "iva2" device in iommu_device
>> > is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
>> > this option is not defined in KConfig.
>> >
>> > This patch removes the wrapper and makes "iva2"
>> > available as another iommu_device.
>>
>> NAK.
>>
>> This would break tidspbridge's MMU. This was discussed before:
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/58302/focus=58305
>>
>> When tidspbridge has migrated to iommu, then it should define
>> CONFIG_MPU_BRIDGE_IOMMU.
>
> ?Can you go through earlier discussion on this patch
> ?http://marc.info/?l=linux-omap&m=127979007623260&w=2
>
> ?I believe these concerns were discussed. I am unable to
> ?open the gmane thread (getting 504) - so can't be sure
> ?if Hiroshi had referred to same discussion.

When you merge iommu support, then either you enable
CONFIG_MPU_BRIDGE_IOMMU unconditionally, or you apply this patch, but
this patch alone will only break things.

-- 
Felipe Contreras
