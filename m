From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 22:13:28 +0200
Subject: [PATCH 3/4] gpio: make handler_data configurable while using
 gpiolib_irqchip
In-Reply-To: <1397544229-20545-4-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <1397544229-20545-4-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdb8rmMDXS1kfcq7wgOnG2XsPm_bxb15z9_9d3E+trBfQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> since it is called handler_data, drivers should have the ability to
> set handler_data based on real hardware.
> GPIOLIB_IRQCHIP doesn't use handler_data by itself, so it will not
> break GPIO core.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

NAK, the whole idea with the function gpiochip_set_chained_irqchip()
is that its sets things up so that the gpiochip is passed as handler
data on the parent IRQ, akin to how the gpiochip is passed as
chip data on the cascaded IRQs.

Yours,
Linus Walleij
