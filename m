From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 17 Feb 2017 17:16:26 +0100
Subject: [RFC 4/4] iio: trigger: add GPIO trigger
In-Reply-To: <1487347429-31761-5-git-send-email-fabrice.gasnier@st.com>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
 <1487347429-31761-5-git-send-email-fabrice.gasnier@st.com>
Message-ID: <06f74b54-91fa-31c5-f015-52a6524059ef@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2017 05:03 PM, Fabrice Gasnier wrote:
> GPIOs can be used to generate triggers for any IIO device.
> Introduce generic GPIO trigger driver. It offers some options
> to tune polarity (e.g. rising/falling edge), and label so trigger
> name may be customized.
> By default, gpio triggers will be named gpiotrigX, where X is gpio
> number as returned by desc_to_gpio() call.
> Rising edge is selected if polarity isn't set.

If you want to use the GPIO only as an interrupt, just use it as an
interrupt directly, no need to go the route via the GPIO.
