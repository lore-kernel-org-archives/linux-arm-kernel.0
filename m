Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AFEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:11:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD69C205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C8GRUgnP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k420iDie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD69C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pBz6ELmaMDs5BB2ACqbS3MvN7Qf4b8IftkgCLKvdaWM=; b=C8GRUgnPKWZeFV
	SOwGepDCvBnOe/4TF33XgZ/+TzFlm5rTjD0vaPb5ZOXnO+21kvrm7uclPr0ya4vIkGZi4jYM72Ij7
	aHdNQtYdhluTls+5x86B6q4ZwNn+hGr3CaWOswexE2XV73SP2tCjsi37CjyapBxlXi4/X+hJGZeiW
	0rTC9muOi+95qy2+nR+Ht+OWiYNHP1mPMrv4A7ICxc9sW8EtxHyNe/mFbOyNGOhpuKJM4GTcZ74YH
	s+vrKyxBYUAG7wLQki3vi/+06sK7Ss7ycdpkMS9YM6N9qMll2i9q7ztLSqzZn0EFO4uQF09NIG6sn
	Zyk7K8EH6z3IKUpm3Hmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFIZ-0004Wd-1T; Fri, 22 Feb 2019 18:11:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFIV-0004WH-D8
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:11:44 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E65D5205C9;
 Fri, 22 Feb 2019 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550859103;
 bh=z9GfSWmEy+4BeueRBKwvrwdgS3pjD+tENf7hvjosMwQ=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=k420iDiel0bMqAmf47xL4TtQ/1RWLUlI1+8l+WWjxqe9poklcyuFN/SBtWImtxjiD
 R1JoWrZG39joFVKWVLOzN/uhkfZkCq0wA4GUE/KFWMKzdE9cf3tM3+gTWiM9kXOLDi
 skM0ne0K+1VXQVXOfDAN3say/b7v16bt1Qexfddg=
MIME-Version: 1.0
Subject: Re: [PATCH v2 05/14] clk: qcom: apcs-msm8916: get parent clock names
 from DT
Message-ID: <155085910216.77512.12604271825136479370@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org,
 david.brown@linaro.org, enric.balletbo@collabora.com, heiko@sntech.de,
 horms+renesas@verge.net.au, jagan@amarulasolutions.com,
 jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com,
 mturquette@baylibre.com, olof@lixom.net, robh+dt@kernel.org,
 sibis@codeaurora.org, will.deacon@arm.com
Date: Fri, 22 Feb 2019 10:11:42 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_101143_456157_63077AAF 
X-CRM114-Status: GOOD (  10.57  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:52)
> @@ -61,6 +65,25 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>         if (!a53cc)
>                 return -ENOMEM;
>  
> +       /* check if the parent names are present in the device tree */

This looks odd.

> +       ret = devm_clk_bulk_get(parent, ARRAY_SIZE(pclks), pclks);
> +       if (ret == -EPROBE_DEFER)
> +               return ret;

Why can't we use of_clk_parent_fill() if we know this is always a DT
platform?  The parent clks may not be registered at the time of probe?
Maybe this series should wait for the parent registration stuff I'm
working on so that this can be made simpler.

> +
> +       if (!ret) {
> +               gpll0_a53cc[0] = __clk_get_name(pclks[0].clk);
> +               gpll0_a53cc[1] = __clk_get_name(pclks[1].clk);
> +               a53cc->pclk = pclks[1].clk;
> +       } else {
> +               /* support old binding where only pll was explicitily defined */
> +               a53cc->pclk = devm_clk_get(parent, NULL);
> +               if (IS_ERR(a53cc->pclk)) {
> +                       ret = PTR_ERR(a53cc->pclk);
> +                       dev_err(dev, "failed to get clk: %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
>         init.name = "a53mux";
>         init.parent_names = gpll0_a53cc;
>         init.num_parents = ARRAY_SIZE(gpll0_a53cc);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
