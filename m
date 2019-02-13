Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAFCC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:43:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9F120700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BXiQdk/8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxJpZinK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9F120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EM2hdFNl9wnaYe6cFZ7Ccnqb0IVPnD+008voURj2MP0=; b=BXiQdk/8lEVY3l
	4mnMyzcgNeLJSxFwfFp9P3ZHaYcUE2U2vUeIs29A+7zOO7ms2kqyt0xAwVMctxUSHpVTiepFDvTbz
	dpxKHDMA9ruhWKJmNgNTs4g1NiypckoJI9BYuuVObE6aVnaET0YAsUMUiSOQ2LRuwE/nugQAS9gZ4
	/HjBhGiVziEUK46aI/TojnDYPSwi//4qwxm1czGtHWvqxYWn9oc7/R5jrcp4E/WUpqhtP+zNbYfik
	hTocPH0gWAoQ39IH0M4f1iH91t7YQowRsOjgoqcFK9IQthVZNoZ9jcY7yDHOxMGmcL4GVYkP8Fn4Q
	+W9hV9D96CURPI4Z5o+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyYo-0001WF-Du; Wed, 13 Feb 2019 17:43:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyYk-00017X-Gu
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:42:59 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A34D20700;
 Wed, 13 Feb 2019 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550079777;
 bh=8/a6GqEt6IT+kCPU/DD4c6vSzGl+dSgpHTaX8RXnqr4=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=oxJpZinKS2N45QtSrCM9rsIGt2314DzJ/uiBNjioVEzC7Ndm2NZxLbyQiaZHOAxIY
 3SNsKq49ZQXqcjZUe4HcmiE085f2ytnPehwdBtc5ZpD/uO6yjMRJfVYSV+n9wRb+u3
 ZEDxworNAcBcZ/x170y1BbLh1LjykvNTmDKeYpdo=
MIME-Version: 1.0
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
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <1550073243-11242-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V3 2/2] clk: imx: scu: add cpu frequency scaling support
Message-ID: <155007977634.115909.4465011219844819801@swboyd.mtv.corp.google.com>
References: <1550073243-11242-1-git-send-email-Anson.Huang@nxp.com>
 <1550073243-11242-2-git-send-email-Anson.Huang@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 09:42:56 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_094258_592063_286780CA 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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

Quoting Anson Huang (2019-02-13 07:59:32)
> @@ -145,6 +161,39 @@ static long clk_scu_round_rate(struct clk_hw *hw, unsigned long rate,
>         return rate;
>  }
>  
> +static bool clk_scu_atf_set_cpu_rate(struct clk_hw *hw, unsigned long rate)
> +{
> +       struct clk_scu *clk = to_clk_scu(hw);
> +       struct arm_smccc_res res;
> +       unsigned int cluster_id;
> +       int i;
> +
> +       /* CPU frequency scaling can ONLY be done by ARM-Trusted-Firmware */
> +       if (clk->clk_type == IMX_SC_PM_CLK_CPU) {
> +               for (i = 0; i < ARRAY_SIZE(imx_sc_cpufreq_data); i++) {
> +                       if (!strcmp(clk_hw_get_name(hw),
> +                               imx_sc_cpufreq_data[i].clk_name)) {
> +                               cluster_id = imx_sc_cpufreq_data[i].cluster_id;
> +                               break;
> +                       }
> +               }

Is there some reason why these clks can't be determined once at boot
time? It would be a good idea to avoid doing any sort of string
comparison here, instead just calling the right arm_smccc_smc with the
right arguments based on code that registers those types of clks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
