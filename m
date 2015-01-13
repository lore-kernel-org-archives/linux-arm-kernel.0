From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Jan 2015 13:22:44 -0800
Subject: linux-next: Tree for Jan 13 (arm build failure)
In-Reply-To: <20150113212100.GA26229@roeck-us.net>
References: <20150113174128.7c108b18@canb.auug.org.au>
 <20150113212100.GA26229@roeck-us.net>
Message-ID: <CAOesGMgak9F4YG49dvZMNUdSgcEKJ8ZmuWTYwGakqpW6_v36kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 13, 2015 at 1:21 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jan 13, 2015 at 05:41:28PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20150112:
>>
>> The imx-mxs tree gained a conflict against the arm-soc tree.
>>
>> The mvebu tree gained a conflict against the arm-soc tree.
>>
>> The net-next tree lost its build failure.
>>
>> The usb-gadget tree gained conflicts against the usb.current tree.
>>
>> The pinctrl tree lost its build failure.
>>
>> The akpm-current tree gained a conflict against the char-misc tree.
>>
>> Non-merge commits (relative to Linus' tree): 2710
>>  2658 files changed, 84945 insertions(+), 45898 deletions(-)
>>
>
> New arm build failure.
>
> Building arm:imx_v6_v7_defconfig ... failed
> --------------
> Error log:
> make[1]: *** No rule to make target 'arch/arm/boot/dts/dtb-', needed by
> '__build'.  Stop.
> make[1]: *** Waiting for unfinished jobs....
> make: *** [dtbs] Error 2
>
> Bisect points to commit 6f1650f15bc ("ARM: dts: Only build dtb if associated
> Arch and/or SoC is enabled").

Yep, it was fixed in arm-soc shortly after sfr had fetched it, and
should be fine in today's -next.


-Olof
