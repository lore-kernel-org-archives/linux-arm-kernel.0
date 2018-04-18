From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Wed, 18 Apr 2018 11:18:30 +0200
Subject: [PATCH v6 28/30] drm/rockchip: Disable PSR from reboot notifier
In-Reply-To: <CAAFQd5C_RhqSCfEXNPQ0zH-O1PGk6xGEdvzsSxnfz9kJ5G4Ceg@mail.gmail.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
 <CGME20180405095117epcas2p2093448b49aab2abd6684bf689f8888d5@epcas2p2.samsung.com>
 <20180405095000.9756-29-enric.balletbo@collabora.com>
 <a9e436f8-34ec-123a-9c69-efabb4576bea@samsung.com>
 <CAAFQd5C_RhqSCfEXNPQ0zH-O1PGk6xGEdvzsSxnfz9kJ5G4Ceg@mail.gmail.com>
Message-ID: <CAFqH_51tQ66=oKb0ZhiicRicMd4_zN415tzhHc7X6SUTgg9mFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej, Tomasz

2018-04-16 15:12 GMT+02:00 Tomasz Figa <tfiga@chromium.org>:
> Hi Andrzej,
>
> On Mon, Apr 16, 2018 at 6:57 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>> On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
>> > From: Tomasz Figa <tfiga@chromium.org>
>> >
>> > It looks like the driver subsystem detaches devices from power domains
>> > at shutdown without consent of the drivers.
>
>> It looks bit strange. Could you elaborate more on it. Could you show the
>> code performing the detach?
>
> It not only looks strange, but it is strange. The code was present in 4.4:
>
> https://elixir.bootlin.com/linux/v4.4.128/source/drivers/base/platform.c#L553
>
> but was apparently removed in 4.5:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/base/platform.c?h=next-20180416&id=2d30bb0b3889adf09b342722b2ce596c0763bc93
>
> So we might not need this patch anymore.
>

Right, seems that we don't need this patch anymore, I'll do more few
tests and likely remove this patch from this series. Thanks for
catching this.

Best regards,
  Enric

> Best regards,
> Tomasz
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
