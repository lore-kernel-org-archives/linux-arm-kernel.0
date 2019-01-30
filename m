Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6599C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BA721473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jFh8PTeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BA721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gaueGePdN9nTkyc4Hrua+c665DXb3YS2XI9QhG5a5Ls=; b=jFh8PTePQqn0XT
	pxc2khXleHHjlq99SUyfnQh3VwyxTvS+3ktjOW+3JgDgqO2lBKGdon3IyCTg428CEaSENF1jav9/o
	RDAjoe2icSwDYp70JX5NwIc4iE9SmGOnXLxsPUFD1gaNegZPCGwwCc9J3t9u3eBtmj/FbKK2kHM2M
	VBz210fDxqC/GIeX2pPWqqGnzdhS1OxBNklW2urFlveT0q+r7NofYx23L0VLm6cntkrwzDljVACm/
	K0i0mk5IFbuU21SotTC/pY9DPzGiaBHVt7EF+02hbbtREarM92U5rPliYoJzkV42bY3RKc5Ghqp2C
	wXJmkkFszIuRBTogBZQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1got0W-0001Nl-1O; Wed, 30 Jan 2019 16:46:36 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goszx-00013g-Qm
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:46:07 +0000
Received: by mail-qt1-f196.google.com with SMTP id y20so145285qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ODhNe21tGWmLJ5rRP419NkyTlGN+pvxqLtxUx/pdUWg=;
 b=Xeb3sDSDoBQIOW4Sl0qxFQn1wwDjCEeyxozVLBLNuydIik6hiHXJSytHm7iH6OxwEc
 SBLKH+5j9xqBGH3kSC9GKTjWPEE2rpexST/Qu9C9kHovpDq35Srv2jK1/q1xEm7qY7n+
 n+WoiCxh3gvhnFKpykSHT/f0J+5pmTCz0YL7+GQxbvFLH1aR6G7qICc+pBF1hw57T4TO
 Csb/FK3o0mbRTbwzUfm1L7eSSHjxQG6XjfW3+tYuqMCHVEMPR4d0WBLR/c/7baVhHsRT
 JMIm6B4nEvXXfETsVE7bZ8CzAqGc/XnrzSWy5tS23OwJog4SmvpC75CS7i1BvIg1EQhc
 i5iQ==
X-Gm-Message-State: AJcUukelWTl9hEONdYOldq+8wdOJMluVbZpMJErkQw8rsBd8o4E043HF
 LJyWu32POhWOQkJLVPkXqsrFfwvXupF2MvU76VXAB0pS
X-Google-Smtp-Source: ALg8bN5mRONy4poOzxeECFELS7nFOaQRXi2JXsK1D4Q1LFf56ybMCzArRbHvrdHv9ObnnGHOn7fwlRTw1QuFBeM8VH0=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr30152803qtr.319.1548866760393; 
 Wed, 30 Jan 2019 08:46:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org>
 <1f57f120e915ea9af75a45f48c8ef2f446d10486.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <1f57f120e915ea9af75a45f48c8ef2f446d10486.1548052878.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:45:43 +0100
Message-ID: <CAK8P3a2+N9-uLi0GS07JEt3H5hwoku6DWZr+e2DXP-nYHEcOyw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: sprd: Add SC2731 charger device
To: Baolin Wang <baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_084602_199437_689D4C69 
X-CRM114-Status: GOOD (  15.04  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Lyra Zhang <zhang.lyra@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 8:39 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Add charger device node and related battery node for SC2731 PMIC.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  arch/arm64/boot/dts/sprd/sc2731.dtsi      |    6 ++++++
>  arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |   16 ++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> index a2edc25..b52eaf0 100644
> --- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> @@ -17,6 +17,12 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> +               charger@0 {
> +                       compatible = "sprd,sc27xx-charger", "sprd,sc2731-charger";
> +                       reg = <0x0>;
> +                       monitored-battery = <&bat>;
> +               };

I see some of these have already slipped through, but we should probably
fix those and not add new ones: "sprd,sc27xx-charger" is not an appropriate
compatible string, because it has a 'xx' wildcard.

What you should have instead is to list compatibility with specific older
models. You also need to have the more generic string as the last one,
not the first.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
