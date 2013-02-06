From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Feb 2013 09:48:09 -0800
Subject: [GIT PULL] ux500 DT related fixes and platform enhancements
In-Reply-To: <20130206135911.GB7519@gmail.com>
References: <20130131115552.GG5301@gmail.com> <20130206135911.GB7519@gmail.com>
Message-ID: <CAOesGMiJTcjdEJzSDkpdV-ZCqN24uVmfjM-HOt+ojErS=98TmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 6, 2013 at 5:59 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Lee Jones (14):
>       ARM: ux500: Change IRQ from low-to-high edge triggered to high-to-low
>       ARM: ux500: Include the PRCMU's Secure Registers in DB8500's DT
>       ARM: ux500: Provide a means to obtain the SMSC9115 clock when DT is enabled
>       clk: ux500: Ensure the FMSC clock is obtainable
>       clk: ux500: Provide an alias for the SMSC911x Ethernet chip
>       net/smsc911x: Provide common clock functionality
>       mmc: mmci: Move ios_handler functionality into the driver

This patch lacks acks from MMC maintainers. Actually, it should just
be submitted like any other MMC patches; to Chris Ball and the MMC
list.

>       ARM: ux500: Set correct MMCI regulator voltages in the ux5x0 Device Tree
>       ARM: ux500: Specify the ux5x0 MMCI regulator's on/off GPIO as high-enable
>       ARM: ux500: Specify which IOS regulator to use for MMCI
>       ARM: ux500: Use the correct name when supplying a GPIO enable pin
>       ARM: ux500: Setup correct settling time for the MMCI regulator
>       ARM: ux500: Use the GPIO regulator framework for SDI0's 'en' and 'vsel'
>       ARM: ux500: Remove traces of the ios_handler from platform code

So, the most of these patches really are just ux500 platform patches.
Please start queuing these through the ux500 maintainers, i.e. Linus
and Srinidhi. We've had cases in the past where you and him step on
each others toes (as with the mach/id.h removal), due to lack of
coordination. It's definitely easier for everyone if the patches come
through (and get acked by) one entity.

The obvious way of doing this is to make sure that Linus (and
Srinidhi) are in control of what's going in and when, so they can
resolve conflicts and not have them break the whole platform for
everybody due to changes they have been unaware of.


-Olof
