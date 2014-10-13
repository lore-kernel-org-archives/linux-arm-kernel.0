From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Oct 2014 11:05:14 +0200
Subject: preferable method for pinctrl driver
In-Reply-To: <54379C10.3050004@rempel-privat.de>
References: <54379C10.3050004@rempel-privat.de>
Message-ID: <CACRpkdYG6sNEfKNJBdbYCn4AbGiX2OfQAVJorR64cbB_gsWDbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 10:42 AM, Oleksij Rempel <linux@rempel-privat.de> wrote:

> Looks like there is at least two pinctrl driver types:
> - imx23 which makes function description insight of DT;
> - tegra with function descrption in the source code.
> which way is preferable?

The Tegra way. The driver should know about all groups
and functions, the DT should just configure the functions to
groups relation.

The i.MX driver happened before the DT use for pin controllers
was thought through.

> Other question, i didn't found exact same HW, do it make sense to merge
> this driver with existing one? Are there some similarities with this one?:
> http://pastebin.com/hW82Xupq

No idea, that's very little HW information. However
silicon vendors often du their I/O cell layout themselves
so many pin controllers are very unique.

Yours,
Linus Walleij
