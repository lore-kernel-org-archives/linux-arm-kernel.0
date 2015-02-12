From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Thu, 12 Feb 2015 15:12:52 +0530
Subject: [PATCH RFC v4 1/3] PM / Runtime: Add an API pm_runtime_set_slave
In-Reply-To: <Pine.LNX.4.44L0.1502091055460.20425-100000@netrider.rowland.org>
References: <1423479726-23140-2-git-send-email-amit.daniel@samsung.com>
 <Pine.LNX.4.44L0.1502091055460.20425-100000@netrider.rowland.org>
Message-ID: <CADGdYn6OwXgsGFspQva-q5WV5b_WB=G2PxZyhcETTgt8zY96ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Mon, Feb 9, 2015 at 9:28 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 9 Feb 2015, Amit Daniel Kachhap wrote:
>
>> This API creates a pm runtime slave type device which does not itself
>> participates in pm runtime but depends on the master devices to power
>> manage them.
>
> This makes no sense.  How can a master device manage a slave device?
> Devices are managed by drivers, not by other devices.
May be my commit is not explaining the requirements completely and the
API name may not reflect the relevance. But If you see the 3rd patch
it has one clock use-case where this new feature is used and the
current pm runtime feature is not sufficient enough to handle it. I
have one more IOMMU use case also which is not part of this patch
series.
I am not sure if this approach is final but I looked at runtime.c file
and it has couple of API's like pm_runtime_forbid/allow which
blocks/unblocks the runtime callbacks according to driver requirement.
In the similar line I added this new API.
>
>>  These devices should have pm runtime callbacks.
>>
>> These devices (like clock) may not implement complete pm_runtime calls
>> such as pm_runtime_get/pm_runtime_put due to subsystems interaction
>> behaviour or any other reason.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  drivers/base/power/runtime.c | 18 ++++++++++++++++++
>>  include/linux/pm.h           |  1 +
>>  include/linux/pm_runtime.h   |  2 ++
>>  3 files changed, 21 insertions(+)
>
> This patch is unacceptable because it does not update the runtime PM
> documentation file.
my fault. Will update in next version.
>
> Besides, doesn't the no_callbacks flag already do more or less what you
> want?
yes to some extent. But I thought its purpose is different so I added 1 more.

Regards,
Amit D
>
> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
