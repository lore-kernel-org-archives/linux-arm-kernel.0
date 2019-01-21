Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F9C2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:47:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE9120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U+32tz4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE9120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oDiI1673xwnYlb+7QgZSXTvHP98/djIbsP/6HlNQKh0=; b=U+32tz4skcxViv
	cJfQ2HhupG0zRGhudgM40SuKHBKHQgm3ywiQO1xa44y7TpQ8eKsH7XT7rM/9IEMWif2t/OPrXiVu1
	GCgAkm2TLL6uuqNDW+fDaZJEAAuxsB88DKojbx3U/xI73TCCUVhZe6OzXgIDZ0bKHrFdLw7CC5M5y
	guXTlHGqlpNxmyJrZSjWbseyl/IW7coa4pe0UTHgMcGsZV/1DMhA3pcZy/S1NVAEQUy7o3pRsgwJj
	RtK+pYt7rYZCuLc98GE2M4qxCTPAxSFwYuAxbNEHq5RyJC8Gmm44PYBuCQVZPu3W2TkQe56OWCDWT
	+eycsk1mUEDlBEXpnbZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbmi-0002F5-IG; Mon, 21 Jan 2019 15:46:48 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbm2-0001fl-Mu
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:46:23 +0000
Received: by mail-oi1-f195.google.com with SMTP id t204so14854634oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ha4x6ul4D1MkN/u9NGKVHR88B0fKxkfsJVzB1Wl7ytc=;
 b=I2WFXDvarv7hGkAkdz+BvGWD+8PI0tXOtsmVHHgGPEQpB07V15Tz1DRUbRN9+3dlyQ
 PfZe2lvJEXcWV8HKWLY2XE/dt//d/U//64ZNLdz/k3T65Er4e/w+0FCZr+O4YeQFuSMo
 Rh4321PIWGj89CO3RGXVE9r2UwToO6ZQ9X6M/9WF3U/FUXbqKIgd1j66sh1Kz0t6DYjd
 bqOm6Xt9JUDJ3AToVrmqnsQf2spE9+c0je5TgPb5zLqzQhtxbPY+4QMWJBkcqk19HL0g
 zTeYLLhvy4mdN1s5aCT6P+nJDMaPL77v8EPpILnGXZ2v0Sc6fh9ChRwb0ZXVRMHopC4h
 7jBA==
X-Gm-Message-State: AJcUukfx8a4p82TErlTT3PvI4GJLGBwm/ySV+sfNWLjOoF5KNqHt902l
 b6oAIlupjOCZjMy/jKw+aA==
X-Google-Smtp-Source: ALg8bN5v1cWPqknWj916R9twcYnGsRfn95vwAPSo41mss88VjKmQqC9Ng8VbLOBSRJ8Z4kftiroMUQ==
X-Received: by 2002:aca:a11:: with SMTP id 17mr5734647oik.15.1548085565792;
 Mon, 21 Jan 2019 07:46:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n130sm6198661oif.10.2019.01.21.07.46.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:46:05 -0800 (PST)
Date: Mon, 21 Jan 2019 09:46:04 -0600
From: Rob Herring <robh@kernel.org>
To: Nava kishore Manne <nava.manne@xilinx.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: reset: Add bindings for ZynqMP reset
 driver
Message-ID: <20190121154604.GA30149@bogus>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121173835.21173-4-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074606_743420_F2A895AC 
X-CRM114-Status: GOOD (  11.35  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Nava kishore Manne <nava.manne@xilinx.com>, linux-kernel@vger.kernel.org,
 Jolly Shah <jollys@xilinx.com>, RAJANV@xilinx.com, robh+dt@kernel.org,
 michals@xilinx.com, linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 23:08:32 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP reset driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
> Changes for v3:
> 		-Moved reset outputs definitions info into
> 		 a header file(xlnx-zynqmp-resets.h).
> 
>  .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 +++++++
>  .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 ++++++++++++++++++
>  2 files changed, 182 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
>  create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
