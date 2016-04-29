From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 10:40:59 +0200
Subject: [PATCH RESEND 1/2] pinctrl: ns2: add pinmux driver support for
 Broadcom NS2 SoC
In-Reply-To: <dc5a5c07-7acd-ae28-cf5c-187d58de64c9@broadcom.com>
References: <CAL2FKYnJNVOcB7aYwkwRAGSq5ufg+CJowJCnzpBEYiTMev0B9A@mail.gmail.com>
 <dc5a5c07-7acd-ae28-cf5c-187d58de64c9@broadcom.com>
Message-ID: <CACRpkdZb=jc8pAhxPWSF2nJnEeAU3JenTfNyZwZDrtgq4QoGsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 8:24 PM, Ray Jui <ray.jui@broadcom.com> wrote:
> On 4/17/2016 8:34 PM, Yendapally Reddy Dhananjaya Reddy wrote:

>>>
>>>         /* not all Iproc GPIO pins can be muxed individually */
>>>         if (!chip->pinmux_is_supported)
>>>                 return 0;
>
>
> NS2 does not support GPIO pins to be muxed individually. The call to
> iproc_gpio_request should be rejected for NS2 since
> 'chip->pinmux_is_supported' is false.

Aha, I see.

> since NS2 can only support group based GPIO configuration, the
> above functions will be rejected because "pinmux_is_supported" is false:
>
> chip->pinmux_is_supported = of_property_read_bool(dev->of_node,
> "gpio-ranges");
>
> Here, "gpio-ranges" should never be defined on NS2 DT files.

Makes perfect sense.

So for this hardware, muxing will always be done orthogonally
(using some pinctrl hogs or similar for GPIO).

I'm waiting for a version fixing the bool Kconfig issue, then I guess
the driver is ready for inclusion.

Yours,
Linus Waleij
