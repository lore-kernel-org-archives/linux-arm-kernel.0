From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 3 Jul 2012 14:15:06 -0700
Subject: [GIT PULL] Integrator common clock
In-Reply-To: <CACRpkda5xQLr+fhnsWm4ONUCzJxtMMCLkS2ek9ufDPV-u7PsGg@mail.gmail.com>
References: <CACRpkdYj46c1dpBhassGn2DWOpcmHHUQcUGb6VZ-bVL8bc2PJw@mail.gmail.com>
 <20120620212046.GI4402@gmail.com>
 <CACRpkdaDUvfEV-7zTTyb+NbZ1WnN+iz+9QzDCVESeizCowOCsg@mail.gmail.com>
 <CACRpkdZGjMa8dBdc_wrTxHUxHUTwzQM9W55XyU+6VEBnXb8z5g@mail.gmail.com>
 <CACRpkda5xQLr+fhnsWm4ONUCzJxtMMCLkS2ek9ufDPV-u7PsGg@mail.gmail.com>
Message-ID: <CAJOA=zOaXf6QzF9yhcoTTaPYr-9=L2h5r5AvmMxoSbroJJrOFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2012 at 12:29 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jun 22, 2012 at 11:58 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>
>> I saw that an older version of the patches is on the clk-next branch
>> in your git, if you're carrying these please take the latest, I created
>> a branch based off v3.5-rc2 (as I see you're using this) at your
>> convenience:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
>> for-mike
>
> This is still the case, please pull this version of the patches
> (the last that were posted to the mail list...) or tell me to resend
> them if that is better.
>

Linus,

Thanks for the re-ping.  I've dropped the old ones and taken in these patches.

I made one trivial change which is to drop "depends on COMMON_CLK"
from both of the entries in drivers/clk/versatile/Kconfig.  COMMON_CLK
is implied since we source your Kconfig from within a menu item that
depends on COMMON_CLK.

Let me know if that is alright with you.

One last (maybe stupid) question.  I don't see that ARCH_VERSATILE
actually uses COMMON_CLK, but uses a legacy platform-specific clk
framework.  Is that intended?

Thanks,
Mike

> Nice to see the tree in -next!
> Linus Walleij
