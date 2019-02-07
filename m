Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B537CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:24:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCB82175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a+7lEQ2B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNWX3uWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCB82175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wVDfQ+LktjsLYlj+aNnUsaCp6PwajKpv5WXnVGlTu2I=; b=a+7lEQ2BDVqUl9
	LwsLikawKqU47xc8RqR+mj5ERUzwG6KGNOh+XPCU9RDAsHw0CPJX4toJJjxxuuhN+VzTnb8lUTdHm
	v7eiTXZEoffPEEg/N597zGjMrZ6lIsTesQk111YJrIKvCnQsDrUBjS5nGwn5R7mOJjwcxwLK95QJ8
	VVuTL/3+mJmh+xIQ6KCpfZt/Jp3xoNg5iPDTr629FMuGQsbBf+iyRJpFOfchrd5zbsXfokrIHhnDl
	hLF+OLnsJVP83/6N8roP2iJHlaiqndMYfbNqarvf8zrd3PUnWV2Bg2ASdRY6Xm5d1XhBqMdc5/++u
	BC4xMTIih+SVOo0OYsTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqDI-0005Fr-CH; Thu, 07 Feb 2019 20:24:00 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqDE-0005F7-3X
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:23:58 +0000
Received: by mail-it1-x141.google.com with SMTP id c9so3205861itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=riL4aeMftZuDVY32mI/ge9A/S6BebOCGCnHi7iOKIiE=;
 b=QNWX3uWEZqSGHcRLpY4B1BGQaviXUBpnwRUuQ7dG4mLUjiiQr9jc4DiGsCJ2LtT/r6
 T3lbX+GvvR9x+4xVwMHc8lgBagTaVZlEKf0LeRQfA3KZE2D7sg9jc6/5h+vyoli+Od3l
 yERijrIkAr2sdIosEjrAqzuBbddsHNI1dppWDWYU6LZeCHAoFeHOBnxNwj2AxIEKyjdS
 WKxnNPx0cMyHaU09M0BYB3is6TtK1xwlGllvoM0JPe4Rdt6fymWp9nugBEdXQMXSVjB+
 dwan7kKpAntN2ivv2Nqb9j2G9BNRv046QHvwqqTa/vFESEk0eM2FjVD8mRqQD6YHbqN2
 4YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=riL4aeMftZuDVY32mI/ge9A/S6BebOCGCnHi7iOKIiE=;
 b=nR9P+7E+gsl9yvLew8xpoXxGtVNz1dCS5W9KJTPCXrzoCHanFRmSPGPRUWQmG+e29v
 Ow2cKKphEyIpUr9MmP1g+iF0Hn/gKaJ3wQqdwBthskWawp8DBto/eGPV3aLTGarocFeB
 gpjN5Yy82ITlkuhmNSn8gDW/pizAYCJRxJ4hFkJklpFJddIx7FcQDYeNX+pjyM40vlt5
 5WLeuI4BcoqV9MhOXV7azS1Jot0d1uyXAXXU0/lYbZay0UzZYgTcMTPP10gQPURcFyci
 KAnAK+ZHtx+ejSyvJPtDBauiog0J5y4Jf2CqQFKvGnB2/JIB61edShK1zz7GT2ckn9cE
 WQ4Q==
X-Gm-Message-State: AHQUAuayukXbAhDWDQWxX9c2NvKw1Plcwl96YDwAzQ2aqTvqLAqFc4Yu
 E+odQelmCYVQ2qQEqOlQhzEeQk/1eyxiT9rMTJEvSg==
X-Google-Smtp-Source: AHgI3Iabjx4wq+Co5s+X0CHwdrtDxpzfMrJe50WGxdf3XpiGAUHw3ZZ3/1ISLL179jtUAvmQTT/1XBWgaqUcNcNnPQk=
X-Received: by 2002:a5d:960e:: with SMTP id w14mr8738373iol.86.1549571035185; 
 Thu, 07 Feb 2019 12:23:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <f5712a48f499d3b2e89f58a43eb30d3dff8b1103.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <f5712a48f499d3b2e89f58a43eb30d3dff8b1103.1548981329.git.saiprakash.ranjan@codeaurora.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 7 Feb 2019 13:23:44 -0700
Message-ID: <CANLsYkzUwii1NrAPGUr3A-odSLe+L63sDErvRnym0MDg0Hkt0g@mail.gmail.com>
Subject: Re: [PATCHv7 4/6] coresight: etm4x: Add support to enable ETMv4.2
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_122356_144143_DF771140 
X-CRM114-Status: GOOD (  18.11  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Tingwei Zhang <tingwei@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 at 17:54, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> SDM845 has ETMv4.2 and can use the existing etm4x driver.
> But the current etm driver checks only for ETMv4.0 and
> errors out for other etm4x versions. This patch adds this
> missing support to enable SoC's with ETMv4x to use same
> driver by checking only the ETM architecture major version
> number.
>
> Without this change, we get below error during etm probe:
>
> / # dmesg | grep etm
> [    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
> [    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
> [    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
> [    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
> [    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
> [    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
> [    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
> [    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22
>
> With this change, etm probe is successful:
>
> / # dmesg | grep etm
> [    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
> [    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
> [    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
> [    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
> [    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
> [    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
> [    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
> [    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index dd9b9b5ebb84..08ce37c9475d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -55,7 +55,8 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
>
>  static bool etm4_arch_supported(u8 arch)
>  {
> -       switch (arch) {
> +       /* Mask out the minor version number */
> +       switch (arch & 0xf0) {
>         case ETM_ARCH_V4:
>                 break;
>         default:

Applied.

Thanks,
Mathieu

> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
