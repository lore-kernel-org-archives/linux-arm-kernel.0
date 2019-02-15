Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E247C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:02:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16CC21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VqO0JJzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16CC21B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k4jWD98BABr6krs+ap4eUv15JtnXRZdtAZc8Dffjs/A=; b=VqO0JJziBmcEnB
	adpyF6l+LEUouLa/l+z3nt3kX8GGr9JWPAIM9CL2nvbAUR5wrVn+7/67r3rTj5YuXIBlkXR7SCKIE
	nPYf3NYqiUWqldK4j2uxI9Gvfr8Ym6+e7uJCpnPOkVEi1wgBfYr4YXSJUdAd2jiVXZ16bHElZUd6z
	yVEjcTVmw7JbTm+PSProA9/rU2YuFGcFkkgEIFBQrWCnqLXyTanADE4FhZvM88o/NHG8ztdzgk5Ji
	xfLy9nU3XORoK/0+g5w6iJp59cMTj0bNOZp8GFynmEWzAWu2bENdb5JDAFV2h0hsNNYO/RxW3Jwr3
	5BSLXcU7pWjUXR3DyLjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujgz-000212-VA; Fri, 15 Feb 2019 20:02:37 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujgw-00020e-Ob
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 20:02:36 +0000
Received: by mail-qt1-f196.google.com with SMTP id p25so12056140qtb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 12:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wNBu8YUL9FclCL7/VIQQFcNrowBc2EUMCY0kWHxaIKY=;
 b=r7ozW25OFclVANbaoJy8AtcOGPODkHJvkguG2eh3vW/zxmwNVXr9ii494zyXvjsZqu
 LB3plGgQomHBn3/WU+75ZnM4DELjxcJrCcwJUl5H+g87Dn63A7oErSUXoj++Uet+oWQv
 CilJexI7LuWeBqmj0eXciWKA/tAITB+MMYFJ0eelem++0doeG3jaya6EjRwhTqlGpBO4
 +EiA/zzeiN9rE60aJD1+smXovhBnTE4jEHFTTrwSVl0PMxaSbezFWlAtJUB/z3fo3Qgg
 XnOAqn4ctdHizTFas41KelNHSmxTkRfB1nwiFsU0NtCDFExgue/YdLhxaYGg/Hk9Il1Y
 csPw==
X-Gm-Message-State: AHQUAuaD0wLZvCXFaK7yuFSG4C2BeabAjjktijCJJHU+Gqit5aGU+RGA
 Kn1etvoD6XyZRth2SymhfIZqGJ8cg7Y1V4RHrpE=
X-Google-Smtp-Source: AHgI3IYN6jhdxxtDfJoBa5J1RayI7ywxZ/n7X2ko0oqkqzkK3KRrxbwkQgaTSBson7DjPU0XVTsRh/KeGsaVJzIqB3M=
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr8732671qvn.115.1550260953755; 
 Fri, 15 Feb 2019 12:02:33 -0800 (PST)
MIME-Version: 1.0
References: <1550259289-21779-1-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1550259289-21779-1-git-send-email-andy.gross@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 21:02:17 +0100
Message-ID: <CAK8P3a2P7zgiNDtH=YBf8ziCXrdLZ3HJMso3bZAKo5FBcjEmyA@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Device Tree updates for 5.1 - Part 2
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_120234_793380_F3DA545A 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: Kevin Hilman <khilman@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, arm-soc <arm@kernel.org>,
 linux-arm-msm@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 8:34 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> The following changes since commit 40122db87778970c96062c9f49b42cdf6809bf94:
>
>   ARM: dts: ipq4019: Remove skeleton.dtsi (2019-01-22 15:04:51 -0600)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-5.1-2
>
> for you to fetch changes up to 97131f85c08e024df49480ed499aae8fb754067f:
>
>   ARM: dts: qcom: ipq4019: Fix MSI IRQ type (2019-02-06 15:53:17 -0600)
>
> ----------------------------------------------------------------
> Qualcomm Device Tree Changes for v5.1 - Part 2
>
> * Fix MSI IRQ type on IPQ4019

Pulled into arm/drivers, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
