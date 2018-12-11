Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD6CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:43:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA8920849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ND1OCcfN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKT2Tzdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA8920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gm20JB40ELtq1ivpSUhdCZSMaWSsBt/DKVsxNr+FEP4=; b=ND1OCcfNZD78zU
	k9S1MqKPQp/IAjE3uv7YNx6GEJhzS20DoV//TY73OkK929xsrl79AaDeKE3E7KOvNGR9Imlt3pNtj
	lAeRARU5z5tUNsv4qagHiutDWqZDJD6GK9i2jIqTnf7bj39Ymt3YK38t0XNHGxlt7wevxfz2dsBVy
	kF6ldn1xfBrcrdawKwOQ9Fir4OwcJBw/dY9GcTpnAwDxpzqB757DUbosUIMRR3uePVjEaA6scPIfn
	gElTF8KAvn0ocFFwpA1kQBT+lH153pVcHBRlYS5qni+2wwq+wcMmjeCHTUIPUNkpyI2cGR46cnpYj
	6cCuhHb7QS4x6+7khnew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeZj-0001eS-MH; Tue, 11 Dec 2018 09:43:35 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeZX-000167-PF
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:43:33 +0000
Received: by mail-ua1-x944.google.com with SMTP id e16so4883767uam.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qiCVCqL8DPBEqqUZ9Lkm11QkiqOa+zItnYetZ5jc2W4=;
 b=PKT2Tzdi+fV9EVYj6CKY2Cr5xBcsIDOxBV+AGZS7uXXQjH7fzOY9HCOX8AvFVH6A4U
 jt8YA3KPthxCPzuab73HPP54OyR5L7bBQlpAD+CrQbRmFionC9TJt+RgubFP+23weoZJ
 3fbfSobZXGULbOJjULjvM9u0aSu6+JPxo+XEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qiCVCqL8DPBEqqUZ9Lkm11QkiqOa+zItnYetZ5jc2W4=;
 b=o5zpwbfINVr3C5cEdMA9crbu6dFDnxGb8lPYT0krYvwIfk25aB0AH7+xbkqVwARAoY
 2Ulb1etcoI6qRByU0gsxwv6spC7ChjNyrDj7zxzBzIBz0G6XoYYDcKRd6D/ReS+o0HXw
 VHXnufFpVVDieiTsT6Xn1llU6UPzJ1GQf5XQZz7zcZn1mIpUXI0X/NJc/KBu2q6Nv/5l
 WfpdyZYmxliZPElFqyAFegGJdZvuR6EV8dhd6Q3SwHxzlCcHGQVZyy2cBSZHbOvI7x1I
 xjrHrU73Bmg+HL7T1XlKFv2UIj608nUfi7QnxkRHGCFUMepN80Kow64zNtbV+Vi+Hc2y
 OUyw==
X-Gm-Message-State: AA+aEWb9VGMBDjSIwklh+s3CTJ/c7jOfEMKijpCszECM63JKXYxCBBwZ
 W/2kuJpMFqQPX24/Un578RgBoZMxaL8UXFCF7rA9KA==
X-Google-Smtp-Source: AFSGD/VGXOGhRU+5j41SWhMn/JGDx25SC/LQU9uF8R3wQtVvb2xPc1rTO8zBx+jYhJwht90zrDsmaHjc4MhvvQPkVx8=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr6993247uar.39.1544521391423;
 Tue, 11 Dec 2018 01:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-5-robh@kernel.org>
In-Reply-To: <20181205195050.4759-5-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Dec 2018 10:42:35 +0100
Message-ID: <CAPDyKFq2x=BKVc36xqyjjjh5xMZa_Ws=-wv9bwadiNkBEgmsdA@mail.gmail.com>
Subject: Re: [PATCH] clk: Use of_node_name_eq for node name comparisons
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_014324_547055_22270B7C 
X-CRM114-Status: GOOD (  17.57  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: DTML <devicetree@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>,
 Mike Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tero Kristo <t-kristo@ti.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 at 20:50, Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

For the ux500 part:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/clk/renesas/clk-mstp.c   |  2 +-
>  drivers/clk/ti/clkctrl.c         |  2 +-
>  drivers/clk/ti/dpll.c            |  2 +-
>  drivers/clk/ux500/u8500_of_clk.c | 10 +++++-----
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
> index 1c1768c2cc82..765175d1148a 100644
> --- a/drivers/clk/renesas/clk-mstp.c
> +++ b/drivers/clk/renesas/clk-mstp.c
> @@ -280,7 +280,7 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *unused, struct device *dev)
>                         goto found;
>
>                 /* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock */
> -               if (!strcmp(clkspec.np->name, "zb_clk"))
> +               if (of_node_name_eq(clkspec.np, "zb_clk"))
>                         goto found;
>
>                 of_node_put(clkspec.np);
> diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
> index 469f560ae1cf..40630eb950fc 100644
> --- a/drivers/clk/ti/clkctrl.c
> +++ b/drivers/clk/ti/clkctrl.c
> @@ -448,7 +448,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
>         char *c;
>
>         if (!(ti_clk_get_features()->flags & TI_CLK_CLKCTRL_COMPAT) &&
> -           !strcmp(node->name, "clk"))
> +           of_node_name_eq(node, "clk"))
>                 ti_clk_features.flags |= TI_CLK_CLKCTRL_COMPAT;
>
>         addrp = of_get_address(node, 0, NULL, NULL);
> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> index 92e28af7afba..6c3329bc116f 100644
> --- a/drivers/clk/ti/dpll.c
> +++ b/drivers/clk/ti/dpll.c
> @@ -410,7 +410,7 @@ static void __init of_ti_omap3_dpll_setup(struct device_node *node)
>
>         if ((of_machine_is_compatible("ti,omap3630") ||
>              of_machine_is_compatible("ti,omap36xx")) &&
> -           !strcmp(node->name, "dpll5_ck"))
> +            of_node_name_eq(node, "dpll5_ck"))
>                 of_ti_dpll_setup(node, &omap3_dpll5_ck_ops, &dd);
>         else
>                 of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd);
> diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
> index d5888591e1a9..18a3c4522831 100644
> --- a/drivers/clk/ux500/u8500_of_clk.c
> +++ b/drivers/clk/ux500/u8500_of_clk.c
> @@ -545,21 +545,21 @@ static void u8500_clk_init(struct device_node *np)
>         for_each_child_of_node(np, child) {
>                 static struct clk_onecell_data clk_data;
>
> -               if (!of_node_cmp(child->name, "prcmu-clock")) {
> +               if (of_node_name_eq(child, "prcmu-clock")) {
>                         clk_data.clks = prcmu_clk;
>                         clk_data.clk_num = ARRAY_SIZE(prcmu_clk);
>                         of_clk_add_provider(child, of_clk_src_onecell_get, &clk_data);
>                 }
> -               if (!of_node_cmp(child->name, "prcc-periph-clock"))
> +               if (of_node_name_eq(child, "prcc-periph-clock"))
>                         of_clk_add_provider(child, ux500_twocell_get, prcc_pclk);
>
> -               if (!of_node_cmp(child->name, "prcc-kernel-clock"))
> +               if (of_node_name_eq(child, "prcc-kernel-clock"))
>                         of_clk_add_provider(child, ux500_twocell_get, prcc_kclk);
>
> -               if (!of_node_cmp(child->name, "rtc32k-clock"))
> +               if (of_node_name_eq(child, "rtc32k-clock"))
>                         of_clk_add_provider(child, of_clk_src_simple_get, rtc_clk);
>
> -               if (!of_node_cmp(child->name, "smp-twd-clock"))
> +               if (of_node_name_eq(child, "smp-twd-clock"))
>                         of_clk_add_provider(child, of_clk_src_simple_get, twd_clk);
>         }
>  }
> --
> 2.19.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
