From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Jun 2017 00:06:06 +0200
Subject: [GIT PULL 2/2] SoCFPGA update for v4.13
In-Reply-To: <CAK8P3a2DFrabNdJu3d1V5F_uWRz0C+sPgqm9mnA_Wpzy6FYNDQ@mail.gmail.com>
References: <1498059352-9483-1-git-send-email-dinguyen@kernel.org>
 <1498059352-9483-2-git-send-email-dinguyen@kernel.org>
 <CAK8P3a1vZVQ5MZDU+qp62LCLnF8z-9LFH=c7XYj=ZnPUzVMjOA@mail.gmail.com>
 <CACRpkdbCrKo7Uvhdyx+4_hMQrPCYaMMijHpYzEY+2MePjpr73g@mail.gmail.com>
 <CAK8P3a2DFrabNdJu3d1V5F_uWRz0C+sPgqm9mnA_Wpzy6FYNDQ@mail.gmail.com>
Message-ID: <CACRpkdZeitT8sYui3W8Zqg5EyiGDtgbC5cGFfwYDDLaLR=92Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 2:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>> Helping out ridding the kernel of users of the old GPIO global
>> numberspace ABI is appreciated though.
>
> I guess there is no easy way to figure out which drivers are needed on
> socfpga and do those first, right?

Nah, we have a few hard cases.

The most annoying one is with regulators, those need to grab the
same GPIO line several times and use in parallel. It is a valid case,
so we need a way to get GPIO descriptors non-execlusively for these
so we can deal with it properly.

Then there is a bunch of cases where it's simpler, those are low-hanging
fruit. Like the conversion of backlight on GPIO I sent recently. They just
need being churned out one by one.

Yours,
Linus Walleij
