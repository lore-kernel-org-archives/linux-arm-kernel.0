From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 23 Dec 2013 22:19:45 +0100
Subject: [PATCH 4/7] iommu/omap: Allow enable/disable even without pdata
In-Reply-To: <52B88990.5020807@ti.com>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-5-git-send-email-florian.vaussard@epfl.ch>
 <52B88990.5020807@ti.com>
Message-ID: <52B8A8F1.4040906@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On 12/23/2013 08:05 PM, Anna, Suman wrote:
> Hi Florian,
> 
> On 12/17/2013 06:53 AM, Florian Vaussard wrote:
>> When booting with a devietree, no platform data is provided. Do not
>> prematurely
>> exit iommu_enable() and iommu_disable() in such a case.
> 
> Platform data may still be needed if we were to go with the pdata quirks
> approach for handling resets. You may need to revise the patch
> description then, but the change itself may be ok if supporting only DT
> devices.
> 

Indeed, this should be mentioned in the commit message. I would go for
a pdata-quirk until we have a proper reset-controller.

Regards,

Florian
