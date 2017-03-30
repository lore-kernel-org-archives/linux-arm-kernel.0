From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Mar 2017 17:38:23 +0200
Subject: [PATCH v5 2/3] ARM: w90x900: let clk_disable() return immediately
 if clk is NULL
In-Reply-To: <1490692624-11931-3-git-send-email-yamada.masahiro@socionext.com>
References: <1490692624-11931-1-git-send-email-yamada.masahiro@socionext.com>
 <1490692624-11931-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK8P3a34huU3UNYX8i+3cVMMpz=31yR+2WzmtyOYBP4rPpmwZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 11:17 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> In many of clk_disable() implementations, it is a no-op for a NULL
> pointer input, but this is one of the exceptions.
>
> Making it treewide consistent will allow clock consumers to call
> clk_disable() without NULL pointer check.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
> ---

Applied to next/fixes-non-critical in arm-soc, I don't think anybody else
was going to apply it. Thanks!

     Arnd
