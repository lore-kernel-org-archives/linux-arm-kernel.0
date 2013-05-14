From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 10:23:17 +0200
Subject: [PATCH 2/9] mfd: ab8500-core: Use the correct driver name when
 enabling gpio/pinctrl
In-Reply-To: <1368019749-19455-3-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbBh1cF468zMbDNfpgsUKERPHONbLeY=VSDNBhG25B0gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 3:29 PM, Lee Jones <lee.jones@linaro.org> wrote:

> When we're using Device Tree to enable GPIO drivers we're forced to be
> OS agnostic, thus we are forbidden use names like pinctrl as they are
> specific only to Linux.

Oh that depends. I have hade lectures on pin control at the embedded
systems conference and there I treat it as a neutral term referring to this
kind of electronic constructions.

However how something is established in OF ontology I don't know so
you might be right there, but you're making it sound like
Documentation/devicetree/bindings/pinctrl/
should not exist and all those bindings be moved to gpio or
something if the assumption that "pin control" or the abbreviation
pinctrl is a Linux-specific term. (Which is not my interpretation.)

> However, when we are registering devices using
> internal systems such as MFD or platform registration, we can use such
> terminology. In this case we can and should use the platform device ID
> mechanism to specify which device we wish to utilise by detailing
> pinctrl-<device_name>.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

The commit message should state what regression it is actually
solving. Which is that when using a non-DT boot, the ABx500
pinctrl devices are not probed, right?

Apart from the commit message:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

On the patch as such.

Yours,
Linus Walleij
