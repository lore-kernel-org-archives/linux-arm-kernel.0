From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 May 2012 12:51:16 +0000
Subject: [PATCH 3/9] ARM: mmp: support DT in irq
In-Reply-To: <CAN1soZz5b0bc10isc6syxM7WzKfvVqc-HzotW6Auqv1A1mnC9A@mail.gmail.com>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <20120427190620.D3C313E0B4D@localhost>
 <CAN1soZz5b0bc10isc6syxM7WzKfvVqc-HzotW6Auqv1A1mnC9A@mail.gmail.com>
Message-ID: <201205021251.16967.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 May 2012, Haojian Zhuang wrote:
> I use two CONFIG_OF in this file. The first one is used to record
> register base address
> of interrupt controller. In legacy code, the register address is
> hardcoding. Do you mean
> that I should remove this CONFIG_OF?

Unless it's a noticeable performance impact, I would recommend just
always using the mmp_icu_base variable, even for when CONFIG_OF is
disabled.

	Arnd
