Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF3C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:19:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F006B21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jOMLdnW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F006B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A+cP9N1FajOU5Ob0Kqfg8ITubDOYzpU3v2WSkjgH+ec=; b=jOMLdnW7PVKsVo
	h3B9iAv3qGGfzKlCvSvzzhcSu4BJOacZ/L4rKnTpuVbVoeRf7bMGLmZaRFERVlz/k1UOHVok0OByW
	JeBTWASX/drjo9451kHWIFbs1HRcKso+3A/s/5j5kHIQhwjFYsGQIBmDTERVM5w4gQVQ9pG0fPJMq
	HP/jJi0ID2xET3v4SfW4yDffAz78X7tBKsox41wSJ4I8VmSHSwcvQY95EEiOdWuZxnDkEcBXRnhkN
	q4lls3n1dvumhCSsEm9VPtXXnxSYxflvcyexhyMITLC3JW8tKTs+fhvfSDn8CMkVhpa0KyqCqav5h
	t3anKJtfk2DsyO9pg9tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfAOr-0008In-DJ; Thu, 03 Jan 2019 21:19:33 +0000
Received: from mail-it1-f196.google.com ([209.85.166.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfAOo-0008IP-1Z; Thu, 03 Jan 2019 21:19:31 +0000
Received: by mail-it1-f196.google.com with SMTP id a6so44493102itl.4;
 Thu, 03 Jan 2019 13:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YoxD5EZeVYASwrmoudzMU0+gZwFYA+BTgpdoSi54dfw=;
 b=IXjKwoXySh9sMGb9DedAXRI2VLl4lYgLVVV3cSdIdStO514ZZbvOzZHSLJCFBnL8KB
 B8S+iSdSHEIq0aRr8HfJQVB+u1MP+M6nyL56a/rZ0AAXFHV2wuQLQbUPgXEMV3rVo/ri
 +R5ZM0dDkWXV7r2n7jDry21TAZzk1A6IH+S3WLsnK+aqv+lOnyYT/QKbkUz3OiEZB97q
 APlETpuIuqIb5b2+g58q919+3s9PEz5rU7ZkIkMcHB0Z93+88et8BmQBlqWyHGCN/FFM
 kPWuRK/7JNoBEL5S5Pf3GErVmqmVlOPqtWrp0ooCx91hvwjhJZN/Qs8XF1PvwTH/rSaU
 8rxA==
X-Gm-Message-State: AA+aEWbwc+dU+ali36sFWcyiQ715tO16l+OMoqB+EYzoTrQg0St9UKyD
 HZ6jE97fYAATe4JaE4zTt2w6SWI=
X-Google-Smtp-Source: AFSGD/Wd2MaHzdxJWHSS9bfBHsaDJ6oyWXZFtVE2PnUEaPsYDnvVZH3fF7Cg7eikgvG1v2rxxJA5cg==
X-Received: by 2002:a24:784a:: with SMTP id p71mr35945684itc.158.1546550368955; 
 Thu, 03 Jan 2019 13:19:28 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id e10sm24833968ioa.65.2019.01.03.13.19.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 13:19:28 -0800 (PST)
Date: Thu, 3 Jan 2019 15:19:26 -0600
From: Rob Herring <robh@kernel.org>
To: Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [RFC,1/5] dt-bindings: Add a binding for Mediatek SCP
Message-ID: <20190103211926.GA7622@bogus>
References: <20181226075330.82462-1-pihsun@chromium.org>
 <20181226075330.82462-2-pihsun@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181226075330.82462-2-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_131930_081051_23483D60 
X-CRM114-Status: GOOD (  15.84  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>,
 Nicolas Boichat <drinkcat@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 26, 2018 at 03:53:09PM +0800, Pi-Hsun Shih wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> Add a DT binding documentation of SCP for the
> MT8183 SoC from Mediatek.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> new file mode 100644
> index 0000000000000..b07e5c4ca9af1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> @@ -0,0 +1,9 @@
> +Mediatek SCP Bindings
> +----------------------------------------
> +
> +This binding provides support for ARM Cortex M4 Co-processor found on some
> +Mediatek SoCs.
> +
> +Required properties:
> +- compatible		Should be "mediatek,mt8183-scp"
> +- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)

Seems like this is going to be incomplete considering this used for the 
CrOS EC.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
