Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C262C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EE721904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WtZ9XYG/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZTsVZJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EE721904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mt4jiLYKd2vcamEicgePfkZU97e2FK9MyFqGQR+ehPg=; b=WtZ9XYG/6axBv9
	yG+uiSfDAJhtuPNEiilWQ6FJkbuzEnC+8mRYYK/Hc2W2FlarFiiC6+XMXOL9pbxU+E28aTMwD08xi
	n0APKnzMlpE5XnGstEK1qNxHyQj1i/0mRdQ7gApdN06UdASahEErhiOFEDUb4R8kZ7ZuTKaEhRv6T
	OMs+q5Wb1i4tIyQafYlmfbOWfs4fol2vf/PvALu9OKTsxA2sxwnzDdQwI0pqTkf9vZePuNs5YH0xd
	5B2Gl/cIn5T5xeRwAIJtW14/7C93tubGOWEeNGr83aBxeL0NykzlpTvmB7QcW+cs/AflNCCn+3QUZ
	U78MSmnHFcCf6Mox+cYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtx6w-0001Zn-W7; Wed, 13 Feb 2019 16:10:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtx6t-0000rI-Cd
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 16:10:08 +0000
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6CF92222B2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550074206;
 bh=1Ga0mlGbTkzTQOsOeEwy2Txp35a5K/9pjOTNmVoOdik=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=RZTsVZJxvrH/bhyKesfZoDwA2bSsvjfJ6bpsnQuA1hJ3gFKYZuM9M/+V/hORjgDvB
 U6vMuRtcANibSffBB/pz56v4+rEaQO5rpuFQmE2UFdQc4OH5j8Jk66HSavAebKj9/t
 jiTWYiLln42DmxNaDwU+uEpkc2vIQbFHmFIpXZ7A=
Received: by mail-yb1-f182.google.com with SMTP id x9so1117901ybj.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 08:10:06 -0800 (PST)
X-Gm-Message-State: AHQUAuZAoH9VzDyajVfatuJpGGTs+hHU0tmRRlIRg5K+wKbYv92783UU
 saOVxiooh22j5+7chSnHWl6SzrDR5yaoECgn2Q==
X-Google-Smtp-Source: AHgI3IanZ3XokatEDtDVHGOCDtEM6FP+/DzqrlPsFEYfk2wta6svpTb9pnJnBWfdKNHT9TnSg1jtif/aVEEJ78GLltY=
X-Received: by 2002:a25:6642:: with SMTP id z2mr1193642ybm.302.1550074205596; 
 Wed, 13 Feb 2019 08:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-6-robh@kernel.org>
In-Reply-To: <20181205195050.4759-6-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Feb 2019 10:09:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
Message-ID: <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
To: devicetree@vger.kernel.org, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_081007_479898_BE1C497F 
X-CRM114-Status: GOOD (  18.45  )
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
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 1:50 PM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/devfreq/devfreq-event.c     | 2 +-
>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Can someone apply this please.

>
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index d67242d87744..87e93406d7cd 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -240,7 +240,7 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
>         }
>
>         list_for_each_entry(edev, &devfreq_event_list, node) {
> -               if (!strcmp(edev->desc->name, node->name))
> +               if (of_node_name_eq(node, edev->desc->name))
>                         goto out;
>         }
>         edev = NULL;
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index c61de0bdf053..c2ea94957501 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -529,7 +529,7 @@ static int of_get_devfreq_events(struct device_node *np,
>                         if (!ppmu_events[i].name)
>                                 continue;
>
> -                       if (!of_node_cmp(node->name, ppmu_events[i].name))
> +                       if (of_node_name_eq(node, ppmu_events[i].name))
>                                 break;
>                 }
>
> --
> 2.19.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
