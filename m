From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Jun 2013 22:13:04 +0200
Subject: [PATCH v2 02/11] clocksource:global_timer: Add ARM global timer
 support.
In-Reply-To: <51B72E9A.6070006@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856087-6452-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdbQCRKBzRF4HzNsXHwXCLJJcFZ9T36GPmmYsnX1OfgGRg@mail.gmail.com>
 <51B5D7A6.1020101@st.com> <51B72E9A.6070006@st.com>
Message-ID: <CACRpkdbppRqnMYknbBy8JpAVtujMOEQvyczXTmpvkQuxgikFog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 4:05 PM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:

> Doing this is not adding any value to the driver, because
>  1. Currently the driver only support DT boot paths, in my previous RFC
> patches, Arnd suggested to get rid of the header as all platforms are DT
> now.

In that case why do you have the separate global_timer_init()
at all? Just move that code into global_timer_of_register() and
also remove the #ifdef around CONFIG_OF and make the driver
depend on CONFIG_OF in Kconfig.

After this you realize that all that business with
clk_register_clkdev() / clk_get_sys() is just pure surplus
baggade, you just use of_clk_get() and that's it.

Yours,
Linus Walleij
