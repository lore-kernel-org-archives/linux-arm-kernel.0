From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 8 Oct 2015 09:25:14 -0700
Subject: [GIT PULL 1/3] Keystone SOC driver updates for 4.4
In-Reply-To: <5870815.PiO7rCVXjJ@wuerfel>
References: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
 <5870815.PiO7rCVXjJ@wuerfel>
Message-ID: <561698EA.4030707@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/8/15 8:41 AM, Arnd Bergmann wrote:
> On Tuesday 06 October 2015 10:19:18 Santosh Shilimkar wrote:
>> Couple of patches for ARM Keystone SOC drivers
>>          - irq affinity bug fix
>>          - display the firmware name
>>
>> ----------------------------------------------------------------
>> Murali Karicheri (2):
>>        soc: ti: reset irq affinity before freeing irq
>>        soc: ti: display firmware file name as part of boot log
>>
>>   .../bindings/soc/ti/keystone-navigator-qmss.txt      | 20 +++++++++++++++++++-
>>   drivers/soc/ti/knav_qmss_acc.c                       |  4 ++++
>>   drivers/soc/ti/knav_qmss_queue.c                     |  3 +++
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>
> The new text you add to the binding document doesn't really seem to
> belong in there, so I'm not pulling this until we've discussed how
> this should be better handled.
>
OK. Can you please pick the affinity fix alone?

> Ideally, the firmware should just get merged into the linux-firmware.git
> tree.
>
IIRC, Murali got the firmware file merged to linux-firmware.git. Looping 
him to confirm that.

> Regarding the method of storing the firmware file name in DT, we
> recently had a longer discussion about that and basically concluded
> that this doesn't work for most devices, in particular when the
> communication between the driver and the firmware uses an interface
> that is not 100% stable and can change depending on the firmware
> blob.
>
Thanks for the info.

> Can you guarantee that there will never be changes to the interface?
> If not, we should try to come up with a better mechanism here, and
> only provide the current method for backwards compatibility.
>
I see your point and agree that its not future proof.

Regards,
Santosh

Regards,
Santosh
