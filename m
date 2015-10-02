From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 03:00:10 -0700
Subject: [RFC 2/3] mmc: sdhci: add host_ops->voltage_switch callback for
 all other voltages
In-Reply-To: <55E6B129.1030002@linaro.org>
References: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135938-8056-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150902150442.118d3305@xhacker> <55E6B129.1030002@linaro.org>
Message-ID: <CACRpkdbQX1xfMEiHwUe7FRUvtsQGbNhO6VK2=8FAgrYE9GzsoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 2, 2015 at 1:19 AM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:

> Not quite sure whether regulator would be right fit for this.
>
> Initially I was thinking of making use of pinconf framework, using
> PIN_CONFIG_POWER_SOURCE, but that too I am not sure is the right way of
> doing it.
>
> Probably, question for pinctrl maintainer. Looping Linus Walleji.

We have another pinctrl driver exposing the occasional fixed regulator
for exactly this purpose, see:
sh-pfc/pfc-sh73a0.c

So use the same mechanism for this driver.

Yours,
Linus Walleij
