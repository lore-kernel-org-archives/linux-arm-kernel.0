Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9664DC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A7920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A0F1rUG6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HE7XWSZs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiXOPD/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A7920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6uM4DKD/azjp4+YP8mUzPT+JcxLa7jJVYXHfc56/QYk=; b=A0F1rUG6zcJRX7
	hbnBK8MRh/jZvPahSeAGFVaEEqHOw1MH2WOMDqmNHK/4SuLimyPe2DS1q3KzIxRcKeF4avdZx+CgQ
	Xr87QaIOdPd0+5VfbBdpbsCjWqV5CwXj90XXSzA18OnLGdwMNjya9OY89p/IEUHgSlDoLiRvE43n8
	W4J6z+k7LRAbCh9qGxIdiTT6yB5WRklai0r1RofE4P04ZCpeVQSDezi5xTqqybhLf2bKtDP/xwz9A
	qjyy9BiGhmcGL5GWppOB/GtQYDLZxxsfTnD2mLa9kWwvPh+N+eId2mLDnMn0n4TawoZM3WX3e8QpC
	+2B/1VhAU7quNWA/FZnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKyO-0001YY-UI; Fri, 07 Dec 2018 18:35:36 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKxl-000848-2s
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 18:34:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4IjefWABedlWVdbikXrG7OV5ArZozmuAiUdCDIThL2w=; b=HE7XWSZsqcmikMr2jqMSsiMY6
 gzFNdN/grhJ86M+yNdOuDaMyMaZy/yujTPiGLRAIoTA901SDO0FOrqC/jHtwXvcyMwM5FPyG0ILZG
 EP9GzEpXU9kBLKcGAQuWW3+whOstN9bsuMYqeSFUjenhPZiliZJthUv9CMkQ8WRZnjU+FWTW5CQng
 Pw6WJK+7UXr4dRG2coAUeRDcAnuVHFDBIvLCTyCgLdNdXFpbnpwZxhzO4VDtuvdT11Q+7nQ8BbXIZ
 dCARg+j55doddeTBL/qGn5R1flww22cdbOolbjDxDvK9/EMmo8fLg6zYm6wZLOeL0hHwGp5rSF3Gb
 yw7CO3rIA==;
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKxi-00085N-AQ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:34:55 +0000
Received: by mail-pl1-x642.google.com with SMTP id u18so2193212plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4IjefWABedlWVdbikXrG7OV5ArZozmuAiUdCDIThL2w=;
 b=OiXOPD/m4mehY4U7XfVXD0oq3PcZ/bMVXlTTQ4+ikcchZ+skqWCT+SNVFSwz6P4L8v
 xRAcKklpKipvvR36wjTianQYY3FDdTR4nLYXXEA8PvxW8hBf3oaTjMAJ/M8nalKF8j37
 FVqUo66pxolzCNNuXgREJF0jIHTyHTzCcY5+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4IjefWABedlWVdbikXrG7OV5ArZozmuAiUdCDIThL2w=;
 b=ae1acSA9TKHW5v/xwpMCPQtMmZwmMkKIPhYgODIUUspvf/cWdMJUyyOtigH2kJi1do
 wZ1eLY0ihAMTLT4j9GFqT9ND6KQ5xU8JjTVLoIvQuZQ4n/e/UmYAxMuJmjA8I/OjKtqC
 Ipmweo51RVRX3/b6r6J7LmD/FVBh9Wg/mHiY5jbvnYXCz67u415TdUb/X3Kr1Sav+oTg
 D/M9xTVbRtHEgKWgmM412LqcosQXaLMv47WmCxCbk9mxYE+x+gFC/E6h1fG374LHZUkz
 G0lNxtXKR1xG20xMPTaURXjyztaCTHYnNlwfBG92XseZP1y0zEysJJV6y8+pu7qK52iO
 YP2g==
X-Gm-Message-State: AA+aEWZfcP7UQCYKYWgRENsa4MlnI1WbLfPVWH00GhjIHVUAIRqr8sDZ
 Ry1s69JgbfRv+rzM4KEBqnnNUw==
X-Google-Smtp-Source: AFSGD/UfKwJpk/G3hgq03xbj5zOYwclGjEBXUDUZUOHUUJ9sm8OmYKMvoViQC23v3ShK6p1fKeKblA==
X-Received: by 2002:a17:902:6e0f:: with SMTP id
 u15mr3090483plk.175.1544207680028; 
 Fri, 07 Dec 2018 10:34:40 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 19sm5839710pfs.108.2018.12.07.10.34.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 10:34:39 -0800 (PST)
Date: Fri, 7 Dec 2018 10:34:37 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH] arm: dts: qcom: msm8998: Fixup clock to use xo_board
Message-ID: <20181207183437.GD5232@tuxbook-pro>
References: <1544207605-23901-1-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544207605-23901-1-git-send-email-andy.gross@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_133454_553165_AF45427F 
X-CRM114-Status: GOOD (  18.04  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri 07 Dec 10:33 PST 2018, Andy Gross wrote:

> This patch sets the msm8998 xo clock name back to xo_board.  Recent
> clock tree changes fixed the clock tree and the change to the xo name
> is causing issues.  Let's change it back and leave the xo label on it.
> 
> Fixes: 634da3307b08 (arm64: dts: qcom: msm8998: correct xo clock name)
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 49f0fee..c2423c9 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -54,7 +54,7 @@
>  	};
>  
>  	clocks {
> -		xo: xo {
> +		xo: xo_board {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <19200000>;
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
