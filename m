From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 19 Oct 2010 23:57:33 +0200
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <201010192258.27988.arnd@arndb.de>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<AANLkTimDdPUjo+65vBL0PTQ3b=5NpeVT28XrdkYqx3Ex@mail.gmail.com>
	<AANLkTinNfERyi_bTWc7LOKR1uRLC3E612ubFKBLxWB1E@mail.gmail.com>
	<201010192258.27988.arnd@arndb.de>
Message-ID: <AANLkTimx8abJzUo-+BGbM6QxGdMF3dO=dbh_UG=FsWMZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 10:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> If a hwspinlock is taken over a long period of time, its other user
>> (with which we try to achieve synchronization) might be polling the
>> OMAP interconnect for too long (trying to take the hwspinlock) and
>> thus preventing it to be used for other transactions.
>
> This sounds exactly like any other spinlock.

The difference is hardware-specific: the hwspinlock device is located
on the OMAP's L4 interconnect where access is slow, wasteful of power,
and spinning on it may prevent other peripherals from interconnecting.
