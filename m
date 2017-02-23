From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Feb 2017 16:03:28 +0100
Subject: [RFC 3/4] dt-bindings: iio: add support for GPIO triggers
In-Reply-To: <1487347429-31761-4-git-send-email-fabrice.gasnier@st.com>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
 <1487347429-31761-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <CACRpkdaFLMDhYZJrO=-MuSG31aO5vOZ2KX3_c95jzze46pymmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 5:03 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Document Industrial I/O GPIO trigger support.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
(...)
> +- gpio-trigger-rising-edge: A rising edge on GPIO will trigger.
> +- gpio-trigger-falling-edge: A falling edge on GPIO will trigger.
> +  Note: Both rising and falling edge may be used. In case none of
> +  rising or falling edge is selected, rising edge is selected by
> +  default.

We have GPIO_ACTIVE*_HIGH and GPIO_ACTIVE_LOW in the
gpios second cell already.

Can't we simply use that and specify that for this usecase, reading
that cell as GPIO_ACTIVE_HIGH == trigger on rising edge and
GPIO_ACTIVE_LOW == trigger on falling edge?

Yours,
Linus Walleij
