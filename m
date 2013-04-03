From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 15:28:03 +0200
Subject: [PATCH 0/3] gpio: remove GENERIC_GPIO completely
In-Reply-To: <1364562678-8945-1-git-send-email-acourbot@nvidia.com>
References: <1364562678-8945-1-git-send-email-acourbot@nvidia.com>
Message-ID: <CACRpkdak79-KuSXdRb7B83Xe+6-f-gNK12Q+EVbXNPSwJLqgrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 2:11 PM, Alexandre Courbot <gnurou@gmail.com> wrote:

> Since I have received no death threat from architecture maintainers I'd like to
> proceed with the remainder of this work so that it doesn't go half-baked into
> 3.10. These three patches finish the removal of the GENERIC_GPIO config option
> which has been made equivalent to GPIOLIB in the previous series. It does so by
> first changing all references to GENERIC_GPIO into GPIOLIB in driver code and
> configuration files, and then removing the unused option from the Kconfig files
> where it is declared.
>
> The last patch in the series confirms gpiolib in its new role as GPIO framework
> by renaming CONFIG_GPIOLIB into CONFIG_GPIO, following the model used by other
> frameworks. This name changing might rise concern but it seems more logical to
> me and the historical gpiolib name is still mentioned in the documentation to
> relieve the confusion.
>
> If I can get a few acks on these (or at least the first two ones) I'd like to
> include them into my next branch as soon as possible so points of breakage can
> be fixed. There are indeed a few new users of GENERIC_GPIO (CC Romain, I sent a
> warning but saw no action so far) in the next tree and compilation will break
> for them.
>
> Another issue, I could not update the Chinese documentation in a satisfying
> manner due to my absence of Chinese skills. Hope that will be forgiven.
>
> Alexandre Courbot (3):
>   Convert selectors of GENERIC_GPIO to GPIOLIB
>   Remove GENERIC_GPIO config option
>   Rename CONFIG_GPIOLIB to CONFIG_GPIO

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
