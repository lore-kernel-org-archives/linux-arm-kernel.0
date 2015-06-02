From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Jun 2015 18:21:20 +0800
Subject: [PATCH 0/3] ARM: dts: sun8i-a33: Support for Sinlinx SinA33 dev
 board
In-Reply-To: <556D80F8.5050106@redhat.com>
References: <1433239443-738-1-git-send-email-wens@csie.org>
 <556D80F8.5050106@redhat.com>
Message-ID: <CAGb2v66nVAHBZv4hZQBaTRd2GsHJtT7n-ARxRnUxXZXQDsM_1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 2, 2015 at 6:10 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 02-06-15 12:04, Chen-Yu Tsai wrote:
>>
>> Hi Maxime,
>>
>> This series enables support for the Sinlinx SinA33 dev board. This
>> is a core/daughter board SDK kit from Chinese vendor Sinlinx. The
>> core board itself does not have any special connectivity, so I
>> didn't split them into 2 files.
>>
>> The series is based on Vishnu/Hans' A33 series (v2). As the last
>> (dts) patch was not merged yet, there might be a conflict in
>> dts/Makefile.
>>
>> Patch 1 adds a pinmux setting for uart0 on PB pins. This is new on
>> A33, and is much better than using R_UART for console on A23, as
>> we can also see messages from BROM/boot0 when developing, and also
>> use the same earlyprintk settings as other sunxi platforms.
>>
>> Patch 2 adds a pinmux setting for 8 bit eMMC on mmc2.
>> mmc2 also has a reset pin, though I'm not sure if our mmc driver
>> actually uses it. Not using it seems to work anyway.
>>
>> Patch 3 adds the dts file for the SinA33 dev board. Just the basic
>> set of features are enabled: UART console, MMC, LRADC.
>
>
> Cool stuff, looks good to me. Note I plan on adding support for
> the musb and usb-host on the A33 tonight, I've a 10" tablet which
> has both an otg and a host usb port.

I've a series for A23/A33 host usb done at

    https://github.com/wens/linux/tree/sun8i-usb-host

which I'm getting ready to post. We're already at -rc6, so the
phy driver might not make it. My dev board also has OTG, but
VBUS is a physical jumper. I'd be happy to test though. My
A23 tablet also wants OTG to have USB ethernet. :)

> I'm not sure if I'll post the series for this right away as I'm
> still waiting on some dependencies to get merged first, but keep
> an eye out on my sunxi-wip tree as something should show up there
> tonight (CET).

Thanks!

ChenYu
