From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 25 Mar 2013 14:12:25 +0100
Subject: [PATCH 5/9] staging: ste_rmi4: kill platform_data hack
In-Reply-To: <1363902674-6456-6-git-send-email-arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
 <1363902674-6456-6-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdb+_8QLopuc1K_s2hmF=OcMzsG1OR9DnHS1t3f4U+tGKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 10:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> There is only one instance of the platform data for synaptics_i2c_rmi4
> in the mainline kernel, so there is no point of pretending its
> variable here. The only member that has a dependency on the platform
> is actually the interrupt number, and there is a field in the
> i2c_client structure that gets initialized from the board info,
> so we can trivially move the board_into into the platform without
> knowledge of the platform_data structure.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Greg can we have your ACK on this patch to staging so we can take
it through the ARM SoC tree?

(Tell me if you can't retrieve it and I'll send it verbose.)

Yours,
Linus Walleij
