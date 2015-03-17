From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Mar 2015 13:07:19 +0100
Subject: [PATCH] pinctrl: dt: at91: new binding
In-Reply-To: <1424943294-8805-1-git-send-email-plagnioj@jcrosoft.com>
References: <1424943294-8805-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdbNLE+VjhvSgsU4oqAc03ieCNyiLkUzbjEiu_LFof-Unw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 10:34 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> +For each peripheral/bank we will descibe in a u32 if a pin can be
> +configured in it by putting 1 to the pin bit (1 << pin)

This seems to be describing driver intrinsics in the device tree, like
how the hardware is routed on the inside and what it can do.

IMO that is driver territory, the driver should know these limitations
and protest if you try to do something illegal.

Anyway as the AT91 maintainers seem to disagree I will allow some
more time for discussion before merging the patch.

I can't really have one AT91 maintainer NACKing another, it doesn't
matter that this is a separate driver, in my book the MAINTAINERS
entry for AT91 as a whole overrides that so can you please find an
agreement on how to handle this or I will stall the patch until
you're in agreement.

ARM SoC maintainers input would be welcomed.

Yours,
Linus Walleij
