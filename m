Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2251DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:08:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58CC206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eJ1S7HSd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvJ71P0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58CC206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K4tRsZ62GGEGSQE/bwY6HihVhChhEKxLRqgS+xtNJfo=; b=eJ1S7HSdh18Ucx
	88RK+FRck9wsPVF/sIegseHE+n3CJHxhdLL0w/snVMQYuvhEbFYYW50/D6c4Cj3THaOJOrGlZPQbm
	EfhfP3bws0bb6GoaP38x+pHRekO3Q9/jhE0EYGzDk0Sn82nSQb5CUDLMAosl827WnyA9vQCTAYEA1
	331Jb6MvwpiDD1wU3b8psUXNQuuuVwfyWqO7y+ZYeoor9AHvxMfZ4M/dPjHbgjjoK0+ptlDhb4vyr
	r1uKUPoEO4NQKONKEDoiQohMD8qb8ngKVzkhEJSv+5gMsnCsD+jF3xwBIVJ7OtwHpqFNZbOhBBwpg
	jd6psUmdZDzwG8tJJCJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGBF-0001mb-7w; Fri, 22 Feb 2019 19:08:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGB9-0001lm-A0
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:08:12 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D23B3206BB;
 Fri, 22 Feb 2019 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550862490;
 bh=zn5gREfnAEgVz2BI4KrdGye4NvLUosAjzJ0G//JMftY=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=rvJ71P0vQdSAFNlEJjZ4Pe8azzNtfsV9AtdZmcTkrOuZxK9geLTwKtG7YAf3l8Vwm
 qWX1lnThkUN9xUae0vOKy2p3arrmCbUPxQZo2AWLVfKPqH/orPjaPlLAAxHIC359l6
 YxCnzqmv8kafRdWDmgPjp8LHeKyvH7XdIBIXTvIQ=
MIME-Version: 1.0
Subject: Re: [PATCH RESEND V6 2/2] clk: imx: scu: add cpu frequency scaling
 support
Message-ID: <155086249004.77512.8709011386763447047@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com>
 <1550802436-13007-2-git-send-email-Anson.Huang@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550802436-13007-2-git-send-email-Anson.Huang@nxp.com>
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
Date: Fri, 22 Feb 2019 11:08:10 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_110811_367382_2AD7D944 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Anson Huang (2019-02-21 18:32:10)
> On NXP's i.MX SoCs with system controller inside, CPU frequency
> scaling can ONLY be done by system controller firmware, and it
> can ONLY be requested from secure mode, so Linux kernel has to
> call ARM SMC to trap to ARM-Trusted-Firmware to request system
> controller firmware to do CPU frequency scaling.
> 
> This patch adds i.MX system controller CPU frequency scaling support,
> it reuses cpufreq-dt driver and implement the CPU frequency scaling
> inside SCU clock driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Ah I missed one thing, see below.

> @@ -180,6 +185,23 @@ static long clk_scu_round_rate(struct clk_hw *hw, unsigned long rate,
>         return rate;
>  }
>  
> +static int clk_scu_atf_set_cpu_rate(struct clk_hw *hw, unsigned long rate,
> +                                   unsigned long parent_rate)
> +{
> +       struct clk_scu *clk = to_clk_scu(hw);
> +       struct arm_smccc_res res;
> +       unsigned long cluster_id;
> +
> +       if (clk->rsrc_id == IMX_SC_R_A35)
> +               cluster_id = 0;

Do we still need to check this anymore? Why not just always use
cluster_id 0?

> +
> +       /* CPU frequency scaling can ONLY be done by ARM-Trusted-Firmware */
> +       arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
> +                     cluster_id, rate, 0, 0, 0, 0, &res);

Because not checking would make this work, vs. checking causes this code
to sometimes use an uninitialized value from the stack.

> +
> +       return 0;
> +}
> +

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
