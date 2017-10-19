From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 17:35:36 +0200
Subject: [GIT PULL 1/1] Broadcom devicetree fixes for 4.14
In-Reply-To: <20171006222014.2704-1-f.fainelli@gmail.com>
References: <20171006222014.2704-1-f.fainelli@gmail.com>
Message-ID: <CAK8P3a3-XhQtw+BsZXTC_PYpDxEeqYhkUhpjemLoiGPL8hgTAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 7, 2017 at 12:20 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoC Device Tree fixes for 4.14,
> please pull the following:
>
> - Loic fixes the console path on the Raspberry Pi 3 which was not correctly set
>   and would cause all sorts of confusion between the Bluetooth controller and the
>   kernel console

Sorry for the delay. I've merged it into fixes now to make things work for you,
though it still seems that there is something wrong with the patch: you now
have the 'aliases' node in the bcm283x.dtsi, which doesn't seem appropriate.
There might be different board based on the same chip that don't all expose
the same uarts at the same physical connectors, and you might have a .dts
file that overrides those aliases, which gets really messy.

Please put the aliases list into each .dts file for this platform and make
sure you list them with the right numbers.

     Arnd
