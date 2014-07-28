From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 16:38:10 +0200
Subject: [PATCH v15 04/12] ARM: hisi: enable HiP04
In-Reply-To: <1406555876-11989-5-git-send-email-haojian.zhuang@linaro.org>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <8907471.Ro9UvPAAAE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 21:57:48 Haojian Zhuang wrote:
> +
> +static const char *hip04_compat[] __initconst = {
> +       "hisilicon,hip04-d01",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
> +       .dt_compat      = hip04_compat,
> +MACHINE_END
> 

One last-minute comment: you match the ID of a particular board (d01)
but the string lists the name of the SoC family.
I'd just changen the match table to list "hisilicon,hip04" directly
rather than the board.
In the dts file, the root node should already be compatible with both.

	Arnd
