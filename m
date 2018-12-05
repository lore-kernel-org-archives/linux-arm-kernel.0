Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84D5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:13:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC6F20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bwi/gjPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC6F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8eyLfpXRf60Jy3uNvLk1HuRm2qTqTWYwmfAXmJt8F40=; b=bwi/gjPsBcur2Z
	HBAwDYM3WQYsj8Q09Tmbv8Ar7ArAHuIvAg9celYC0sHuO5xmQrtdWx7O3HwaY3m85jd3n9t8k0GSN
	LsYZJsKdJBobT1tQ8b2nAMWMmKytAMrmcPzaVKQ1UxDKY0YISmFWKrC6lNDwvKTNAXhdMP3NFiBca
	Lu1wa7J4SLSs9+9HpFfh0pAGB9BSMsqPpIplfS/Sc6gS5qXUc7sg2sj+k5OEEB/ZyMUuI5OpQuKe3
	rEnJq5SeNtJEr8maQdK5wWrioNGnU8dvqgWsikyP1RNyC1FaYDRSwZkxSOt8sRI5l/EDnf5KeTSMN
	202byLGk3Sgxuzc7EgdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZnl-0002bf-3L; Wed, 05 Dec 2018 16:13:29 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZnh-0002Ns-QV
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:13:27 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id F421D13F8EA;
 Wed,  5 Dec 2018 17:12:58 +0100 (CET)
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
To: Jeffrey Hugo <jhugo@codeaurora.org>
References: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
 <1542314695-24071-2-git-send-email-jhugo@codeaurora.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <b50bc3d4-f80b-6adb-c28b-1be254eb7e16@free.fr>
Date: Wed, 5 Dec 2018 17:12:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542314695-24071-2-git-send-email-jhugo@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_081326_001192_3264833D 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 15/11/2018 21:44, Jeffrey Hugo wrote:

> The root parent clock of most msm8998 clock is the "xo" clock.  The DT node
> is incorrectly named "xo_board", which prevents Linux from correctly
> parsing the clock tree, resulting in most clocks being unparented and
> unable to be manipulated.  The end result is that we can't turn on clocks
> for peripherals like SD, so init usually fails.
> 
> Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 78227cc..a948d4b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -53,7 +53,7 @@
>  	};
>  
>  	clocks {
> -		xo_board {
> +		xo {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <19200000>;
> 

Isn't there going to be a problem for msm8998 in drivers/clk/qcom/clk-smd-rpm.c
which uses "xo_board" for parent_names?

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
