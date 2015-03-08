From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 08 Mar 2015 23:52:50 +0100
Subject: [RFC PATCH 00/18] ARM: msm multiplatform support
In-Reply-To: <CAPDyKFpuQ50qgUxh7fXrt-2AoqgnQQ5q0heCgzKchKvDQazNag@mail.gmail.com>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
 <CAPDyKFpuQ50qgUxh7fXrt-2AoqgnQQ5q0heCgzKchKvDQazNag@mail.gmail.com>
Message-ID: <7616599.hAEbVQmATE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 March 2015 17:40:18 Ulf Hansson wrote:
> The goal from my side is to entirely remove this mmc driver and
> instead convert to use the mmci host driver.
> 
> If I understand correctly, the current big blocker to reach that goal
> is the DMA driver, since it's not converted to the DMA engine API? Do
> you know if that's a correct statement?

Yes, I think that is correct. As I wrote in the patch description,
after we remove the serial-hs driver, msm_sdcc is the only user of the
private MSM DMA API.

I wasn't aware that this device is compatible with mmci, but that
certainly simplifies things.

> Anyway, I suppose this patchset can be considered as step in the right
> direction, even if I don't like to take patches for the msm_sdcc.c.

Ok.

	Arnd
