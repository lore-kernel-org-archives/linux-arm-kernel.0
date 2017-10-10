From: kernel@esmil.dk (Emil Renner Berthing)
Date: Tue, 10 Oct 2017 13:04:20 +0200
Subject: [PATCH] arm64: dts: rockchip: enable touchpad button for
 rk3399-gru-kevin
In-Reply-To: <4174027.Z5MyPRUDcj@phil>
References: <20171009184028.11829-1-kernel@esmil.dk> <4174027.Z5MyPRUDcj@phil>
Message-ID: <CANBLGcx187QrX3pgUAjvBmPbyJsX7ZiYdWXhamM-atEe+Mqe3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2017 at 11:33, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Montag, 9. Oktober 2017, 20:40:28 CEST schrieb Emil Renner Berthing:
>> Adding the linux,gpio-keymap entry also has
>> the side-effect of making the driver register
>> the touchpad as a touchpad rather than another
>> touchscreen.
>>
>> The index for BTN_LEFT was found by trial and error.
>>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>
> looks good to me. I'll just give the ChromeOS people a chance to
> respond before applying [maybe they can even tell what the other
> keys are :-) ]

Good plan. As far as I can tell their kernel doesn't send anything but
BTN_LEFT either. It's just that the controller supports multiple
buttons, but not all are necessarily connected to any button.
Their version of the driver has logic to detect the proper keymap
whereas the mainline driver gets it from this devicetree entry.

/Emil
