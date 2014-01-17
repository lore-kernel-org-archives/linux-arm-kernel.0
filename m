From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 17 Jan 2014 12:48:22 -0300
Subject: [PATCH 06/18] ARM: dts: omap3-overo: Enable MMC2
In-Reply-To: <52D92E93.8050804@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
 <1389286092-27087-7-git-send-email-florian.vaussard@epfl.ch>
 <CABxcv=nO1ZtC7wjVSq+Qw9AmFGahpDUSjOZOO1+tYHhqo9P0Pw@mail.gmail.com>
 <52D92E93.8050804@epfl.ch>
Message-ID: <CABxcv=nLpKjX8zVdDDUrfwfyOh2C+Gt4O6Sj7xhtudT5LJXr-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Florian,

On Fri, Jan 17, 2014 at 10:22 AM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:
> Hello Javier
>
> On 01/09/2014 09:43 PM, Javier Martinez Canillas wrote:
>> [adding Enric Balletbo to cc]
>>
>> Hello Florian,
>>
>> On Thu, Jan 9, 2014 at 1:48 PM, Florian Vaussard
>> <florian.vaussard@epfl.ch> wrote:
>>> MMC2 is used by the on-board WiFi module populated on some boards
>>> (based on Marvell Libertas 8688 SDIO).
>>>
>>> Note: currently WiFi only works on cold boot, as the module is not
>>> properly reset (missing binding for the GPIO reset).
>>>
>>
>> Have you looked at commit 0e9fd777 ("ARM: dts: omap3-igep: Add support
>> for LBEE1USJYC WiFi connected to SDIO") ?
>>
>> If I remember correctly the LBEE1USJYC Wifi/BT combo module is
>> basically a Marvell Libertas 8688 Wlan and Enric got soft reset
>> working too by adding a GPIO property to the regulator for the reset
>> GPIO.
>>
>> Hope it helps,
>
> Thank you, I got it working. It is a bit messy, as I have 3 GPIOs
> (poweron, wifi-reset and bt-reset). As a regulator can control only one
> GPIO, I had to define 3 regulators, and assigning them to the vmmc,
> vqmmc, and vmmc_aux. I hope that a better solution will pop-up in this
> thread [1]. It is a pity that the previous version of the GPIO-reset
> controller was not merged.
>

Glad to know that you got it working and yes it is a bit messy so
let's hope that a cleaner solution will be the result of the current
discussion on that thread.

> Florian
>
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/294907

Best regards,
Javier
