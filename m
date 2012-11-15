From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 15:17:10 +0100
Subject: [PATCH 01/14] pinctrl: SPEAr: add spi chipselect control driver
In-Reply-To: <4a92290e8a3b1a19c3a5e864edfa7badfc2af5d0.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <4a92290e8a3b1a19c3a5e864edfa7badfc2af5d0.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdb9tSUUGQjWdHqRr5rUSyiPgWm2i3-QZq9VbWFY2EAQeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2012 at 5:39 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> From: Shiraz Hashim <shiraz.hashim@st.com>
>
> SPEAr platform provides a provision to control chipselects of ARM PL022
> Prime Cell spi controller through its system registers, which otherwise
> remains under PL022 control which some protocols do not want.
>
> This commit intends to provide the spi chipselect control in software
> over gpiolib interface. Since it is tied to pinctrl, we place it under
> 'drivers/pinctrl/spear/' directory.
>
> spi chip drivers can use the exported gpiolib interface to define their
> chipselect through DT or platform data.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> Reviewed-by: Vipin Kumar <vipin.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This sure looks good, sorry for the delay.

Just one question: since this driver is not using any
pinctrl interfaces, why is it under drivers/pinctrl/*?

Shouldn't it be under drivers/gpio from a technical
point of view?

I think I'd accept it under drivers/pinctrl/spear/*
if you just want this to keep everything SPEAr-related
in one place though, so enlighten me.

Yours,
Linus Walleij
