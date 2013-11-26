From: lho@apm.com (Loc Ho)
Date: Tue, 26 Nov 2013 08:41:00 -0800
Subject: [PATCH v3 3/4] ata: Add APM X-Gene SoC SATA host controller driver
In-Reply-To: <529473DD.1090804@ti.com>
References: <1384465153-29902-1-git-send-email-lho@apm.com>
 <1384465153-29902-3-git-send-email-lho@apm.com>
 <1384465153-29902-4-git-send-email-lho@apm.com>
 <201311151448.16279.arnd@arndb.de>
 <CAPw-ZTmaz3nnV3ThRgecT_RaYYW0bmfWvL8Kr-S3z1aKyUWc+w@mail.gmail.com>
 <CAPw-ZTn1N7+EFu9L6U+P9=9ii3k1BjycYXdNCdxCVPb8SaJWxA@mail.gmail.com>
 <529473DD.1090804@ti.com>
Message-ID: <CAPw-ZTmPgYA+saJPVvB17VOPouDGvR0rd0nrZWi0j3zE7cc2rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> int set_speed(struct *phy, int lane, u64 speed);
>
> it should be phy_set_speed.
[Loc Ho]
But your other functions don't repeat the prefix "phy"?

>>
>> where lane indicates the lane of the PHY and speed is the PHY speed in hertz.
>
> Does lane here means the number of lanes? Is the lane also obtained after the
> training sequence?
[Loc Ho]
Lane here is the lane with you are changing the speed. If there are
two lanes, then 0 parameter would change lane 0. 1 would change lane
1.

-Loc
