From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 00:37:00 +0200
Subject: [PATCH] pinctrl: sunxi: Fix multiple registration issue
In-Reply-To: <1400768727-7338-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1400768727-7338-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdao9RqUQaueN3B81snhXzRp692xDyps3CePoqiygnbmwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 4:25 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> When the support for the PRCM muxer on the A31 has been added, the global
> static pinctl_desc definition has been left as is. Unfortunately, this
> structure is used to register the pinctrl device, and prior to this
> registration, we set the name and pins field.
>
> Since this structure is shared across instances, that means that the latest
> registered pinctrl device wins in setting the name, pins and pins numbers,
> which is not really a good thing.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
