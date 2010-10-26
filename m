From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Oct 2010 08:44:17 +0200
Subject: cmpxchg() in recent kernels
In-Reply-To: <AANLkTimyOYEh0gCZTF3JsXeVT3UwoK1VcXgx+zscZmj1@mail.gmail.com>
References: <4CB036B7.7000100@gai.ru>
	<AANLkTi=PeHQRibtU=jv69KVNWovtNsG3S11M0BLCnbRC@mail.gmail.com>
	<20101024214338.GB878@boggieman.bredbandsbolaget.se>
	<20101024220846.GA6041@n2100.arm.linux.org.uk>
	<AANLkTi=sRPzP+SJRpWY4QXtikVFqVVX3tizX5f+17e=B@mail.gmail.com>
	<20101025151319.GA21105@n2100.arm.linux.org.uk>
	<AANLkTimyOYEh0gCZTF3JsXeVT3UwoK1VcXgx+zscZmj1@mail.gmail.com>
Message-ID: <20101026064417.GM8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Aras,

> For reference, this is my uImage make script:
> 
> make ARCH=arm CROSS_COMPILE=${CROSS_PATH} INSTALL_MOD_PATH=${FS_PATH} Image
> 
> ${CROSS_PATH}objcopy -O binary -R .note -R .note.gnu.build-id -R
> .comment -S vmlinux linux.bin

Why don't you use arch/arm/boot/Image instead of doing the objcopy
yourself?  (If it's intended you might want to make vmlinux only instead
of Image.)

Uwe
 
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
