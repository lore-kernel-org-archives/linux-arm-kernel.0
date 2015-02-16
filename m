From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 16 Feb 2015 12:09:43 +0100
Subject: [PATCH v4 0/3] about data busy
In-Reply-To: <54E184B6.90808@samsung.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
 <CABxcv==G_sKsvWHX6rJP7EUv8jE=01k-JeGGXgiwiCN53pxdmQ@mail.gmail.com>
 <54E184B6.90808@samsung.com>
Message-ID: <CABxcv=mHAJLviM1ACJKW3cH2JgtuCVp6-54bORaWY=dw4hP-oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jaehoon,

On Mon, Feb 16, 2015 at 6:48 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 02/15/2015 08:41 PM, Javier Martinez Canillas wrote:
>> I modified [1] your patch #2 to do what Alim suggested and only with
>> that patch on top of linux-next I have neither the the "Timeout
>> sending command" error nor the uSD not getting detected errors. Linux
>> mounts the rootfs from the uSD and the wifi SDIO device is enumerated
>> and listed in /sys/bus/sdio/devices/
>
> it needs to check when clock value only update.
> As Javier and Alim are mentioned, if check whether card is busy or not in setup_bus(),
> should be processed unnecessary checking.
> (According to TRM, before disabling clock, check whether card is busy or not.)
> if my thinking is right, chekcing is located more exactly before mci_writel(host, CLKENA, 0).
>
> And i recommend if CLK_GATE is enabled, clkgate_delay sets to the bigger value than 3.
> I'm not sure Javier's issue is same thing..I will check more this.
>

Thanks for checking, do you have access to a Peach Pit or Pi
Chromebook to reproduce the issue I reported? Please let me know if
you need any help from me.

> Best Regards,
> Jaehoon Chung
>

Best regards,
Javier
