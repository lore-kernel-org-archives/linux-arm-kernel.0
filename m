Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28CFC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:46:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AF920666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AwxLnrPL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NV/Vv8oK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AF920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fqIUO72LSVvM0M0+q6PB55MWg/QCfD+Q6/6FouZHOxc=; b=AwxLnrPLSE7CS5
	YIdrIwpB+EmFi0F0OHuU0Z6pLT3rTzMDq9FG8QCBczalSuCE9zPbrSILQDkMxvETUG9j+Do36Tw0M
	DVjl0r7zC7MRtFWmlMIofYsItrQYmfLrNWA22Mt09UzXkLS4jnIN+KdHXeqWGYci8p4/u+Qq0hek4
	PbvZw1hCkWNstuBnDnTc028yjgutt0vhCYxk/LvCcT9bEHHt8zrsGGVW3xfdWemwHb7bGwqzXKPYg
	tISij8ypQE38DKVQWdBVE9vgs5EzRseE+6fMzbKanSo+8QyTCp2Z+SNZ2kbSmUZdctRV12uhm0Z/r
	lXvcxPEr7AV5IMckoHbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTknz-0007s1-KK; Mon, 03 Dec 2018 09:46:19 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTknw-0007qx-0X
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:46:17 +0000
Received: by mail-io1-xd44.google.com with SMTP id n9so1836580ioo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iX/oVY2dCQZV9wB0dqBOQ1Y9CXOpcurqPsBoTPeFU9A=;
 b=NV/Vv8oKkJbOGgncyncAly3ZM3ixLFbHtO2wBAZNJkiKfS8NNSJAvawVnaWZpaAEQX
 Z+nP1lQurEARSabZUKSz6zimgjAtIyFt7dzvJqI3yoO5fcSD/Plmpi4q0nBrbAsbclPM
 991fESTLZzEnNM73/aDK8+3eUSVLjuuFKrel4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iX/oVY2dCQZV9wB0dqBOQ1Y9CXOpcurqPsBoTPeFU9A=;
 b=hEBfgJNkgzhc7MZHxEzbXj6/RHBxKrQJO5wF4O/Md3xMzMu4eAEisxwkODLmUtxgx5
 Fv20C2+c4iyliKv/QQVyybRsLEv0eYLzqR11n2TYnhOP9ELlHyF1qLBZlvV9zk1PUGi3
 lCnZV1U6YhzXzNfUr+HPQAvle7ivlO5aqM3EsE/vunqo/WIrNeWnJZdYymNdi3fg8/tq
 LWjVumMEUU5AiFmJGmzEyzXwy/Nq7YJ6pECZdnnmhnL1OUo4gQ1KoFEToD8aFTWct51M
 KO0SQTHkHmN5LSB05LgPk9bwzyln951LnVyAWy+vepVMkRfphonNEBNuDIOMqob8jwCJ
 aGJw==
X-Gm-Message-State: AA+aEWb804NuDfO1f8kHDZPdXB9g/wi2l/IvpK39LZRxGVv2lPfY1v5g
 lmhBWbkk3Ec7/3XwrHbRuZlae0ss6zhRgGDM6Mxu4A==
X-Google-Smtp-Source: AFSGD/VvDosaN9x1V3PzhUddlNU+hYmKF3M8EwPXRb7DRfo05o2o5+fTkBK3IDds4HzoEe/vUi7ncvBlKICaEGvRjME=
X-Received: by 2002:a6b:1411:: with SMTP id 17mr13372052iou.252.1543830365247; 
 Mon, 03 Dec 2018 01:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-5-wens@csie.org>
In-Reply-To: <20181130075849.16941-5-wens@csie.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 3 Dec 2018 15:15:54 +0530
Message-ID: <CAMty3ZB6p8Uv7abMC8jDHHYwdAeuBen2GPjOhN=wEL7+=DDt3g@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: dts: sunxi: h3-h5: Add pinmux setting for CSI
 MCLK on PE1
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_014616_056915_19B6CEA6 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 1:28 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Some camera modules have the SoC feeding a master clock to the sensor
> instead of having a standalone crystal. This clock signal is generated
> from the clock control unit and output from the CSI MCLK function of
> pin PE1.
>
> Add a pinmux setting for it for camera sensors to reference.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The CSI controller found on the H3 (and H5) is a reduced version of the
> one found on the A31. It only has 1 channel, instead of 4 channels for
> time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> "fallback" to a compatible that implements more features than it
> supports.
>
> Drop the A31 fallback compatible.
>
> Fixes: f89120b6f554 ("ARM: dts: sun8i: Add the H3/H5 CSI controller")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
