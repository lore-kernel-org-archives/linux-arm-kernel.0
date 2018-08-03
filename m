From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 3 Aug 2018 18:05:34 +0200 (CEST)
Subject: [PATCH] staging/vc04_services: Use __user annotation for
 user-space pointers
In-Reply-To: <CAGR7KeqKzxqEM=jmKG-KK=xtDXHS2umUsRrUqVawjuUUrxSgxg@mail.gmail.com>
References: <20180724083217.20921-1-cmaiolino28@gmail.com>
 <20180730085811.GA30820@kroah.com>
 <CAGR7KeoDrp8FBX_H1a8h9hVFF_w9mLXGkvCT6jJAacG7-morRg@mail.gmail.com>
 <f6a7405a-4251-c6b8-470f-d50137fb9b00@i2se.com>
 <CAGR7Keo6zD_M+KHMkK8dDm=oujkwxM7Dv7weT11+oKtJNOZpFA@mail.gmail.com>
 <46f35184-fbb5-985c-a5b1-d6ab27ced8bc@i2se.com>
 <CAGR7Keqb6B7bYHM7AFm68K7gyBkMXvM2Z=3uvp4HJ7pW-LURSg@mail.gmail.com>
 <cdcd7246-9cf6-22a9-a828-3b7925480d90@i2se.com>
 <CAGR7KeqKzxqEM=jmKG-KK=xtDXHS2umUsRrUqVawjuUUrxSgxg@mail.gmail.com>
Message-ID: <1349608474.81150.1533312334425@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlos,

> Carlos Maiolino <cmaiolino28@gmail.com> hat am 30. Juli 2018 um 11:57 geschrieben:
> 
> 
> On Mon, Jul 30, 2018 at 11:49 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Am 30.07.2018 um 11:43 schrieb Carlos Maiolino:
> >> On Mon, Jul 30, 2018 at 11:34 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >>> i think easiest the way would be to get a recent Raspbian Lite (
> >>> https://www.raspberrypi.org/downloads/raspbian/ ),
> >>> build the kernel with bcm2835_defconfig, modify config.txt to use the
> >>> upstream DTB, add the upstream kernel and DTB to boot partition.
> >>>
> >>> The following command must be successful:
> >>>
> >>> vchiq_test -f 1
> >> K, I'll take a look and find a way to test it, I don't have a rPI at
> >> the moment to test
> >> it, I'll take a look if I can borrow one. in mean time, can it be
> >> tested somehow in x86 environment?
> >
> > I don't see a chance because this driver talks to the VC4 firmware.
> >
> 
> kk
> 
> thx

i only want to point out that there was a regression (deadlock) in linux-next, which has been reverted [1] / fixed.

[1] - https://lkml.org/lkml/2018/8/2/578
