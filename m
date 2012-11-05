From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 5 Nov 2012 16:16:43 +0530
Subject: [PATCH 0/9] Pinctrl: SPEAr: Fixes for 3.7-rc3
In-Reply-To: <CACRpkdZ+KhTQq+vrtoCVH2Y7fV4aT6JNzo+dL1Dg-GM8usb=Lg@mail.gmail.com>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
 <CACRpkdZ+KhTQq+vrtoCVH2Y7fV4aT6JNzo+dL1Dg-GM8usb=Lg@mail.gmail.com>
Message-ID: <CAOh2x=nZRowRXNcOYT3P83mUS3wu==F=-L7mhYa5OYg2p30UCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2012 at 4:08 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Oct 27, 2012 at 11:17 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> This patchset fixes many errors/mistakes in current pinctrl configurations for
>> various SPEAr SoCs. Please see if they can be merged in next rc release, if they
>> look fine to you.
>
> First sorry for taking so long...

Delay was expected as you were in connect :)

> Basically I have a hard time believeing these are regressions.
> I have applied patch 1, 2, 3 and 5 to fixes but I want an argument
> of why patch 4 and 6-9 are causing regressions in the current
> mainline kernel.
>
> I suspect they are fixing regressions in a non-mainline kernel
> which is none of our business, but convince me and I'll move
> them to the fixes branch ... I have still merged them, but aimed
> for v3.8.

Frankly speaking i haven't thought from this perspective while sending them.
Just grouped the fixes/mistakes together :)

- 4/9] pinctrl: SPEAr1310: fix clcd high resolution pin group name
- 6/9] pinctrl: SPEAr1310: Separate out pci pins from pcie_sata pin group
- 7/9] pinctrl: SPEAr1310: add register entries for enabling pad direction

This is important and pad multiplexing is incomplete without fixing
pad directions.

- 8/9] pinctrl: SPEAr1340: Make DDR reset & clock pads as gpio

This is important, otherwise DDR may not work.

 - 9/9] pinctrl: SPEAr1340: Add clcd sleep mode pin configuration

You can add 4,6 and 9 in your linux-next branch. :)

--
viresh
