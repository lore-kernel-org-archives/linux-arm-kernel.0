Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:12:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EC4206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nQFuEVq/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4o2np/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EC4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YKfVheykVdUZ847M/V6H9GNXuH5Z28t7suZM6leAvuU=; b=nQFuEVq/essONO
	uJSOYkLblJ+U52azgkOg6Ori8mlNClqcgUmC7qVur1PmxTzJIO2hrSmgCKeHSqOnMgNR0R4NoESrz
	oO2vEp8gMJuriW6dzvy2IhWV/5KEUcWv5g75A9DbKpBOKTAqsbkbSi4Z1KkJS4IT5i67yvkcAjntY
	jU9+mPGic5Qhs0SJ6J9lwE1+8OQR22blynyeiiuHmFR/NatSbJjJw99yVA2i9bkXVdDe16T9lz8SY
	cWdMXnTCHTG/wmCR9yz/mnoF5NLsm/c6xLf5LiwPUSlhNI+5JTl4G+t5I/qdpNAygdqakkDoYYlPl
	GoF7ciOAgGfJl8pMzbcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFJR-0004pP-2J; Fri, 22 Feb 2019 18:12:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFJK-0004oq-Qj
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:12:39 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6B909206B6;
 Fri, 22 Feb 2019 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550859154;
 bh=LjMXoNtcXYUdEOY3ueVHbXKeT7w1E5goTW+q5BHQ3Bc=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=D4o2np/8wAIqY/xnEO//3DssQfk9LiQyqN1Oi6ZiIzmf92/olWsKS1WmIr8GtDy+t
 AEWfLhzsr3t4cPTXVjZVc1gggpFd3UDQqTYMrOKIzokxq8+kWj1OOxCGpQ8/xK9Vjy
 t8RbFaI32zPDiM4SvN4alme5PUU8Yrzafo7dox5M=
MIME-Version: 1.0
Subject: Re: [PATCH v2 08/14] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Message-ID: <155085915374.77512.3766517034394591147@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org,
 david.brown@linaro.org, enric.balletbo@collabora.com, heiko@sntech.de,
 horms+renesas@verge.net.au, jagan@amarulasolutions.com,
 jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com,
 mturquette@baylibre.com, olof@lixom.net, robh+dt@kernel.org,
 sibis@codeaurora.org, will.deacon@arm.com
Date: Fri, 22 Feb 2019 10:12:33 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_101234_878384_9F02F6A9 
X-CRM114-Status: GOOD (  19.33  )
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

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:55)
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
>                 .parent_names = (const char *[]){ "xo" },
>                 .num_parents = 1,
>                 .ops = &clk_ops_hfpll,
> +               .flags = CLK_IGNORE_UNUSED,

Please put some sort of similar comment in the code so we can find it
without git history digging.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
