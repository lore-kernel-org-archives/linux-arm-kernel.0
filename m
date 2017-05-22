From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 May 2017 11:06:08 +0200
Subject: [PATCH V2 3/5] pinctrl: imx: add soc specific mux_mode mask and
 shift property
In-Reply-To: <1495177545-23006-4-git-send-email-aisheng.dong@nxp.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdbz44c=kM_0ZGNUJGQXvLuOUv=WewWFbqYWwYSZu=Vtxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 9:05 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> MX7ULP MUX mode mask and shift bit is different from VF610.
> Let's make it a platform specific property for the later easy of
> adding MX7ULP support.
>
> One trick in exist code that Vybrid hardcoded the config part
> as 0xffff because its mux_config register BIT[15-0] are all configs
> part. But it's not true in ULP, so use mux_mask instead to address
> the difference.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>
> ---
> ChangeLog:
> v1->v2:
>  Minor changes:
>  * add more explanation about Vybrid trick in commit message.

Patch applied with Shawn's ACK.

Yours,
Linus Walleij
