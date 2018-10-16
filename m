From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2018 10:00:19 +0200
Subject: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <20181015221629.13924-1-stefan@agner.ch>
References: <20181015221629.13924-1-stefan@agner.ch>
Message-ID: <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 12:16 AM Stefan Agner <stefan@agner.ch> wrote:

> When functions incoming parameters are not in input operands list gcc
> 4.5 does not load the parameters into registers before calling this
> function but the inline assembly assumes valid addresses inside this
> function. This breaks the code because r0 and r1 are invalid when
> execution enters v4wb_copy_user_page ()
>
> Also the constant needs to be used as third input operand so account
> for that as well.
>
> This fixes copypage-fa.c what has previously done before for the other
> copypage implementations in commit 9a40ac86152c ("ARM: 6164/1: Add kto
> and kfrom to input operands list.").
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Please add:
Cc: stable at vger.kernel.org

I am on deep waters with ARM assembly, admittedly. So I wanted to
ask: OpenWRT has this cache patch:
https://github.com/openwrt/openwrt/blob/master/target/linux/gemini/patches-4.14/0001-cache-patch-from-OpenWRT.patch
I do not know why (sorry).

Do you think that patch is actually a hack to hide the problem
fixed with this patch? (OK maybe stupid question but...)
it appeared anonymously in OpenWRT with the commit message
"add v3.18 support" at one point.

Yours,
Linus Walleij
