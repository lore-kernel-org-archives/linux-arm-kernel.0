Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1F1C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:33:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BBE20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lOoWk2Wm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNL/kO9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BBE20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vqj+bRxKD73wCSMqFLY8TRkSe+bKLtZDCju9nBZwRYg=; b=lOoWk2WmNTFk4h
	Drwr7eUiFZtzcKeq4lKGXB4nuv7KX7LXk7ILU6/WCtssPKNCel6yA2pTy5Fx7p9HWqyrNIumGeAa5
	IPrppEw6nDV4GB/OiQ7e+nKiYws7JAwAWc3NVMcXwyax88urIEpNgHpM2c3SkCUqb5qhtOd+kWwbX
	QKTDQbZb6V3OcLCnpDVVqsml9IO+GQ7nnR1WXLOvqYgd8KRb8MEPIjgBYyo9mzNe89u/d5WWzra3O
	ZpOhFn8sZdZDDTrRaY6Ygp2bbfvWt9LRHmLjwuPXAAyArVM6GTTcqL3Ey+cLLPZ8fCnGhbqXOy82k
	7B6ef0be15RVSHJ5DN8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1FV-0001An-S4; Thu, 17 Jan 2019 06:33:57 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1FS-0001AO-P4
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:33:56 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so3975557pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aqC+vB4fSjRN90IibQ7rlURw1TMhvABYquzwyDXgypA=;
 b=NNL/kO9CdzEPti7SThDJKLv7Yq+SCVjXCEv003EZOStG3hNTBpZfyr6YP2iPuGFqD/
 MOLr/6bfHbUk+HqbJjIer6QZDxP24yIvm4NpTf1EcEBIYGpOX2Mr2QPcU/pAWw0rRUpB
 B8K5bFtba6YWPktyH7QWTfPTRL38b8zQRjZ2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aqC+vB4fSjRN90IibQ7rlURw1TMhvABYquzwyDXgypA=;
 b=jZ/aBWLl78e4kXvbb5XDVv9Zkua/ZdLtWrhO4vcugs0tAMV1mDm4c3RgfAPlCs6Wxf
 OQQL7VztQckvYZ0Xefst79XXLyObrIO9db/oH1uaK3g8BWoyAdZjmjekA2+SZoczmO7c
 8kSsH3Lk8yz25jDcwF+C4KlQz4GuXPeLDLgpRkuhVZmqecrBu09AInQ2R7GfZsikPgLL
 MG2/S2SZnEG+p94hDgy9q4t6vM6gFqonG0khECJRKN55IoSNLao0ZTljOXHloYXEQZVi
 crsARTaYZX1oZ7q7ycJRE//hAEzuJ2Fz2LvushDkG9BtZwAaGpVWgk9JgI4cz2DxtNVb
 nQpQ==
X-Gm-Message-State: AJcUukcukpXh5oc4aTyAmVxtOJE6yABB8rs8kZFRdwKJXaYn9YiD71kv
 egneWoR3RPc8qsvY//vkYn7uGA==
X-Google-Smtp-Source: ALg8bN6ggp1MCPExQs+vQQxL2bvJB70+5pOHGn4EVdYjBbSFbcYTmWXyX/5SrPW/Mj7UW3le2dfSgQ==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr13619330pfm.71.1547706833568; 
 Wed, 16 Jan 2019 22:33:53 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id b4sm793210pgq.65.2019.01.16.22.33.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:33:52 -0800 (PST)
Date: Wed, 16 Jan 2019 22:33:12 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Message-ID: <20190117063312.GE25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_223354_833910_5D9DB613 
X-CRM114-Status: GOOD (  22.25  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, david.brown@linaro.org, linux-clk@vger.kernel.org,
 jassisinghbrar@gmail.com, jagan@amarulasolutions.com, andy.gross@linaro.org,
 sibis@codeaurora.org, devicetree@vger.kernel.org, arnd@arndb.de,
 niklas.cassel@linaro.org, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
> to keep the software model of the clock in line with reality, the
> framework transverses the clock tree and disables those clocks that
> were enabled by the firmware but have not been enabled by any device
> driver.
> 
> If CPUFREQ is enabled, early during the system boot, it might attempt
> to change the CPU frequency ("set_rate"). If the HFPLL is selected as
> a provider, it will then change the rate for this clock.
> 
> As boot continues, clk_disable_unused_subtree will run. Since it wont
> find a valid counter (enable_count) for a clock that is actually
> enabled it will attempt to disable it which will cause the CPU to
> stop. Notice that in this driver, calls to check whether the clock is
> enabled are routed via the is_enabled callback which queries the
> hardware.
> 

With the CPUFREQ referencing the CPU clock driver, that has decided to
run off this clock, why is it not refcounted?

Regards,
Bjorn

> The following commit, rather than marking the clock critical and
> forcing the clock to be always enabled, addresses the above scenario
> making sure the clock is not disabled but it continues to rely on the
> firmware to enable the clock.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/clk/qcom/hfpll.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> index 0ffed0d..9d92f5d 100644
> --- a/drivers/clk/qcom/hfpll.c
> +++ b/drivers/clk/qcom/hfpll.c
> @@ -58,6 +58,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  		.parent_names = (const char *[]){ "xo" },
>  		.num_parents = 1,
>  		.ops = &clk_ops_hfpll,
> +		.flags = CLK_IGNORE_UNUSED,
>  	};
>  
>  	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
