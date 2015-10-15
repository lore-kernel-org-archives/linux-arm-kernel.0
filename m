From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 15 Oct 2015 16:42:27 +0200
Subject: [RFT PATCH 3/3] ARM: dts: Mark SDIO as non-removable in
 exynos5250-snow-common
In-Reply-To: <CAAObsKC4QSGaqwh_4Gy3C+9ty=k=LixV8oZB1-5ZreLOxqc=aQ@mail.gmail.com>
References: <1444906530-25048-1-git-send-email-javier@osg.samsung.com>
 <1444906530-25048-4-git-send-email-javier@osg.samsung.com>
 <CAAObsKC4QSGaqwh_4Gy3C+9ty=k=LixV8oZB1-5ZreLOxqc=aQ@mail.gmail.com>
Message-ID: <561FBB53.8060302@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomeu,

On 10/15/2015 02:30 PM, Tomeu Vizoso wrote:
> On 15 October 2015 at 12:55, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> The Exynos5250 Snow Chromebooks have a Marvell WiFi SDIO chip which
>> can't neither be removed nor be detected. But the node isn't marked
>> as non-removable and instead has the broken-cd DT property.
>>
>> This causes the device to be removed when the system enters into a
>> suspend state and the following warnings is shown after a resume:
>>
>> [  181.944636] mmc2: error -2 during resume (card was removed?)
> 
> Hi Javier,
> 
> isn't wifi on snow on mmc_3?
>

Sigh, you are correct. It seems I have a really bad day and missed.

I got confused though because the node for mmc_0 (eMMC) in Snow
also has a broken-cd property instead of non-removable. I'll add
another patch to the series changing that.

I also noticed that the mmc_0 (eMMC) node in Peach boards have both
non-removable and broken-cd which doesn't make sense and the MMC
DT binding is clear that the options are mutually exclusive.

Seems to be copy & paste error from the vendor tree since the
downstream DTS also have both properties in the nodes. So I'll also
add patches to remove the broken-cd from these nodes.

> With your patch, I don't see any change, but if I do it on mmc_3
> instead, the machine fails to resume. Will try to get more info.
>

Yes, I wouldn't expect any changes since the patch is marking the
eMMC as non-removable but I wonder why is causing a fail to resume.
Are you sure the system is resuming without $SUBJECT? You mentioned
in IRC that S2R was broken for Snow in linux-next.

> Regards,
> 
> Tomeu
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
