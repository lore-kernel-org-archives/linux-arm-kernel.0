Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20687C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:45:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA8520661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h/x8J8Zb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSCzaEbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA8520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KypczgPygRKsfN7VNjJcomrWuhpCA7nG/2YpEJBNoJs=; b=h/x8J8ZbturChN
	sThtaQmbOQH/al7xRNhGTnjsUEVy5ree5LYY+AHGTs3bbaE2H+yjJyUTXrwW9nwGFFNBSKTeZBeZw
	sZpvoQe0P2ep2nLf1Cz2eQY4se6LR/v8xVOJHNyz0zpjn68U3vJ7e5EptGXjFo7cz92lqKCG+XT4x
	L+eEENRUf2q6k/n/5IF27PcnUqNyvLM0m4JO29YQbaQjo+8qdmSjbNLhWsmPADYLzEHnO2ZgqI9HR
	MlsmmsiqzpCKIX/AX8iZwYtfT49BozcJE8uCtSxFTIJi/eP5FKujL1wMSqy4PJNC2Q8KgteQxQq68
	vqgQKR0VZVobJnOn0FAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTu9M-0007fI-RU; Mon, 03 Dec 2018 19:45:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTu9J-0007eq-L3
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:44:58 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 239DC20661;
 Mon,  3 Dec 2018 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543866287;
 bh=1siojgpWf3s44PKIfrW/66aYWSoF8Oth97Vx5uH8Op4=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=ZSCzaEbBj428g7aNK0ctsAP4h6XhBHsUsOLIS8HuRw69MJ1LfmGcoszLoSBMDR2HX
 ylvhgLylFgV5K0LSHLhO/qWLXzImnSzm9qWxoCtkhtIdw1dk149n9oZ5ImqXzjOO8e
 wih5K5Jty6E7ysjcCG++2bLEmZCZxfdk852xVSdw=
MIME-Version: 1.0
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542809234-539-7-git-send-email-aisheng.dong@nxp.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
 <1542809234-539-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386628648.88331.6049034476912976846@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V8 6/7] clk: imx: add lpcg clock support
Date: Mon, 03 Dec 2018 11:44:46 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_114457_723429_71DEEA18 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng DONG (2018-11-21 06:12:38)
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
> new file mode 100644
> index 0000000..15b7d94
> --- /dev/null
> +++ b/drivers/clk/imx/clk-lpcg-scu.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP
> + *     Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +static DEFINE_SPINLOCK(imx_lpcg_scu_lock);
> +
> +#define CLK_GATE_SCU_LPCG_MASK         0x3
> +#define CLK_GATE_SCU_LPCG_HW_SEL       BIT(0)
> +#define CLK_GATE_SCU_LPCG_SW_SEL       BIT(1)
> +
> +/*
> + * struct clk_lpcg_scu - Description of LPCG clock
> + *
> + * @hw: clk_hw of this LPCG
> + * @reg: register of this LPCG clock
> + * @bit_idx: bit index of this LPCG clock
> + * @hw_gate: HW auto gate enable
> + *
> + * This structure describes one LPCG clock
> + */
> +struct clk_lpcg_scu {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +       u8 bit_idx;
> +       bool hw_gate;
> +};
> +
> +#define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
> +
> +static int clk_lpcg_scu_enable(struct clk_hw *hw)
> +{
> +       struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
> +       unsigned long flags;
> +       u32 reg;
> +
> +       spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
> +
> +       reg = readl(clk->reg);

Use readl_relaxed() here?

> +       reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> +       if (clk->hw_gate)
> +               reg |= (CLK_GATE_SCU_LPCG_HW_SEL |
> +                       CLK_GATE_SCU_LPCG_SW_SEL) << clk->bit_idx;
> +       else
> +               reg |= (CLK_GATE_SCU_LPCG_SW_SEL << clk->bit_idx);

Write this as:

	u32 val;

	val = CLK_GATE_SCU_LPCG_SW_SEL;
	if (...)
		val |= CLK_GATE_SCU_LPCG_HW_SEL;
	reg |= val << clk->bit_idx;

> +       writel(reg, clk->reg);

This can stay "stronger", so no writel_relaxed().

> +
> +       spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
> +
> +       return 0;
> +}
> +
> +static void clk_lpcg_scu_disable(struct clk_hw *hw)
> +{
> +       struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
> +       unsigned long flags;
> +       u32 reg;
> +
> +       spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
> +
> +       reg = readl(clk->reg);

readl_relaxed()?

> +       reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
