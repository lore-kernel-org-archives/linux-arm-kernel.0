From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 31 Oct 2018 14:38:56 +0100
Subject: [PATCH v3 0/7] Standardize onboard LED support for 96Boards
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdYThcGjdV9Ezs4qMr8K6_jH40SDUgt0Tps8d+_4sSESyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 10:43 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> This patchset standardizes the onboard LEDs on 96Boards by maintaining
> common labels and triggers as below:
>
> green:user1  default-trigger: heartbeat
> green:user2  default-trigger: mmc0/disk-activity (onboard-storage)
> green:user3  default-trigger: mmc1 (SD card)
> green:user4  default-trigger: none, panic-indicator
> yellow:wlan  default-trigger: phy0tx
> blue:bt      default-trigger: hci0-power
>
> This standardization is required to provide a common behaviour of LEDs
> across all mainline supported 96Boards and also making it easier to
> control it using an userspace library like MRAA.
>
> For Rock960 and Ficus boards, the LED support is added in this patchset.
> Rest of the boards are converted to adopt the standard.
>
> Note: Since there is no UFS trigger available for now, user2 LED trigger
> is set to none on HiKey960.

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It makes a lot of sense to try to unify the userspace ABI so we get
some kind of order here instead of trying to counteract it with
per-device kludges in userspace. It definately makes things better!

Yours,
Linus Walleij
