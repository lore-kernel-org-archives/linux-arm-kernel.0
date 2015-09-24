From: arend@broadcom.com (Arend van Spriel)
Date: Thu, 24 Sep 2015 13:18:00 +0200
Subject: [PATCH 0/3] mmc: Wait for card_busy before starting sdio requests
In-Reply-To: <5603C020.80603@redhat.com>
References: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
 <CAPDyKFqvnVTL0pDLc8S1Ssqmy5WXR9+=uCWq8ONmgrYU=Zzoow@mail.gmail.com>
 <5603C020.80603@redhat.com>
Message-ID: <5603DBE8.4000902@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2015 11:19 AM, Hans de Goede wrote:
> Hi,
>
> On 23-09-15 23:43, Ulf Hansson wrote:
>> On 22 September 2015 at 17:30, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi Ulf,
>>>
>>> Here is a non RFC version of my patch-set to wait for card_busy before
>>> starting sdio requests. It is the same as the RFC version of the set,
>>> but this time it has been tested no hardware which actually needs this
>>> and I can confirm now that this fixes wifi on that hardware.
>>
>> Great! Thanks, applied for next!
>
> Great, thanks, I guess it is too late for this to go as a fix into
> 4.3-rcX (no worries if it is) ?
>
>>> This patch-set should also allow removing this dw_mmc specific fix:
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc.c?id=0bdbd0e88cf6b603a2196418672715b0890fb040
>>>
>>>
>>> As this patch-set fixes this problem in a generic manner.
>>
>> Care to send a patch to remove the above hack/fix?
>
> I do not have any hardware to test this.
>
> I've added Doug the original author of that patch to the Cc.
>
> Dough, can you test if with the patch set from this mail thread
> (merged into mmc/next) this patch:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc.c?id=0bdbd0e88cf6b603a2196418672715b0890fb040
>
>
> Is still necessary ? Since this patch-set fixes the same issue
> in the mmc core I believe that this commit can be reverted now.

I have a chromebook which has this hack/patch (more or less) in 
chromeos. I can try and backport your patches and see how it goes.

Regards,
Arend

> Thanks & Regards,
>
> Hans
