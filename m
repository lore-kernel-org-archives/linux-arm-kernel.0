From: bcm@fixthebug.org (Christian Daudt)
Date: Thu, 12 Dec 2013 13:35:29 -0800
Subject: [PATCH v3 3/6] pinctrl: Make PINCTRL selectable by
 defconfig/menuconfig
In-Reply-To: <CACRpkdauqYNiby-ta3c_he2ovG__0e6ubmzZ8Bx1cP_OzK4=LQ@mail.gmail.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-4-git-send-email-syin@broadcom.com>
 <CACRpkdauqYNiby-ta3c_he2ovG__0e6ubmzZ8Bx1cP_OzK4=LQ@mail.gmail.com>
Message-ID: <CAEPRUYpsp_FVobY_DeEQU2+rCD7q7T=p7k++XvG-22x-OWHY8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 12:39 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Dec 11, 2013 at 7:37 PM, Sherman Yin <syin@broadcom.com> wrote:
>
>> Adds a string to the PINCTRL config option so that 1) CONFIG_PINCTRL=y would
>> not be erased by make config, and 2) PINCTRL option would show up in menuconfig.
>>
>> Signed-off-by: Sherman Yin <syin@broadcom.com>
>> ---
>> v3: added to patchset
>
> NAK. The pin control subsystem has been designed so that
> you should select the pin controller through select statements
> from the SoC using it.
>
> This was requested at one time by Linus (Torvalds).
>
> You need to convince me that this is really needed.
>
> Yours,
> Linus Walleij
Hi Linus,
 I had requested this from Sherman. The reason is so that pinctrl can
be selectable through defconfig, instead of through SoC select
statements. And the reason for that is so that, in the future, some of
these can be switched into loadable modules (which can't be done from
Kconfig). This will become necessary with the move to multiplatform -
we won't be able to have everything static anymore.

 Thanks,
   csd
