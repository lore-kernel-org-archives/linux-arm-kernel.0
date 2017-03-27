From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Mar 2017 16:21:25 +0200
Subject: [GIT PULL 1/4] bcm2835 arm DT updates for 4.12
In-Reply-To: <1533334801.217079.1490439824805@email.1und1.de>
References: <20170321193952.10270-1-eric@anholt.net>
 <CAK8P3a2X0LYeidiPw4xN07WdU86Ah3_nJeropNSieJWxsHoEmA@mail.gmail.com>
 <1533334801.217079.1490439824805@email.1und1.de>
Message-ID: <CAK8P3a1wKL-LFH=EfG5a8u-Wn_nDCBBtaJ7Tb-ctHJekbR=7qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 25, 2017 at 12:03 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Arnd Bergmann <arnd@arndb.de> hat am 24. M?rz 2017 um 23:25 geschrieben:
>>
>> Just a quick question: how do you plan to switch between the SD host
>> drivers? If I understand this right, there are two working hardware blocks
>> that can connect to the same slot. Do you have to configure this in
>> device tree using  hardwired pinctrl settings, or can the user pick
>> one of the drivers at runtime?
>
> via device tree
>
> The relevant changes [1] hasn't been merged yet.
>
> [1] - http://marc.info/?l=linux-mmc&m=148896494931931&w=2

Ok, I see. I can't come up with any better idea either, but it's unfortunate
that we can't describe the hardware correctly in this case, with a DT that
lets the OS choose the right driver, so we can't have a DTB file that
work on old and new versions of Linux, or across operating systems
when some of them only provide one of the two drivers and other OSs
want to the use other one.

       Arnd
