From: arasv@magellan-technology.com (Aras Vaichas)
Date: Tue, 26 Oct 2010 23:10:08 +1100
Subject: cmpxchg() in recent kernels
In-Reply-To: <20101026064417.GM8554@pengutronix.de>
References: <4CB036B7.7000100@gai.ru>
	<AANLkTi=PeHQRibtU=jv69KVNWovtNsG3S11M0BLCnbRC@mail.gmail.com>
	<20101024214338.GB878@boggieman.bredbandsbolaget.se>
	<20101024220846.GA6041@n2100.arm.linux.org.uk>
	<AANLkTi=sRPzP+SJRpWY4QXtikVFqVVX3tizX5f+17e=B@mail.gmail.com>
	<20101025151319.GA21105@n2100.arm.linux.org.uk>
	<AANLkTimyOYEh0gCZTF3JsXeVT3UwoK1VcXgx+zscZmj1@mail.gmail.com>
	<20101026064417.GM8554@pengutronix.de>
Message-ID: <AANLkTin7B++tqimD2UK1bkhUS9QuCYmbch2QYMqAd8p4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/26 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Aras,
>
>> For reference, this is my uImage make script:
>>
>> make ARCH=arm CROSS_COMPILE=${CROSS_PATH} INSTALL_MOD_PATH=${FS_PATH} Image
>>
>> ${CROSS_PATH}objcopy -O binary -R .note -R .note.gnu.build-id -R
>> .comment -S vmlinux linux.bin
>
> Why don't you use arch/arm/boot/Image instead of doing the objcopy
> yourself? ?(If it's intended you might want to make vmlinux only instead
> of Image.)

My best guess is that it's carried over from my 2.4.x days.

A quick Google search shows several U-Boot image building tutorials
that do this.

e.g.  http://www.ronetix.at/an008_ARM_Linux_Debugging.html

It was never a problem until GCC v4 was required for a clean kernel
build but I will certainly review my build scripts with this in mind.
:)

I only do kernel work every few years as needed for the company
product, so I tend to play catchups on these changes.

Aras
