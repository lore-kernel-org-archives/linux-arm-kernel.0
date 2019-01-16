Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF557C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:13:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D739206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CS+IViD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D739206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iL3bFtl/jNWMLUIDYttcbxFJKHvmAGhb6M14GXKMi/w=; b=CS+IViD8UN0F9H
	EBbeNtQR7F6KLh0I2YmH8P/pempy+s61WBBKNhaViUcNWzh9+HxgPjpiCjYLhsPJmFziOq0nkzjbB
	2MYtBos20XlCPHDRKveltMn+f8d3dcoS9cmJ7dkHYzKEjwqaZLgZaZx2NMhs7Mv/aMy4rVXm2nctE
	UhCU+0PPHRB18pKeclwD4AlhuywK250L7Fjo3Yq+k/7snAi2IdKYQu4O1sSYhEXngNR3EHlBXDrW+
	RuAjG0UmM1pYHEzCgMLsb8jEr3Hu9TQOji9jfevC+Tbau3mqv8qqWeOfIWd9SpQ4j2ZNN3zcXY48U
	V/IOy2Xy3rFqLx2eN3pA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjsUj-0007vP-27; Wed, 16 Jan 2019 21:13:05 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjsUe-0007uR-Ri; Wed, 16 Jan 2019 21:13:02 +0000
Received: by mail-ot1-f65.google.com with SMTP id n8so9111582otl.6;
 Wed, 16 Jan 2019 13:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sLMOU4TuT/n7Zwjd7DiZILBoIc6AMNXlwcnfTUK5xsQ=;
 b=sahcw4Td9XXJqeMyCpUdyBD4RxKNSWvFOI9G/Bq0sEGYc53XV/baFRGJGILOWFU880
 pbBsiZcByc0JwOpWjNtXfVz6lJktS06591HKl/IqFhRGQHklyxX0OXmhmJpfxy6qNIfR
 xoJo57KqesdJN+W30cJ/jTE6PtJ8Vb6mnkYJ9yk4fCLL7LbfzU0ccoaSuXqWOpm2ZxA0
 vJp7weFbOIKk0XkToY3gXRDI/dj5Wwm7FyrVyGMPjI3g7vj7+TsGj6pehXroOYhjueHW
 4MynNicElBYezkixbnPRHNzmVkQeyuEpSPUSQcWzt33qTQ787BalH7YB1Vn85IkT1mzu
 KkQQ==
X-Gm-Message-State: AJcUukehLsO4VH3lLvHTX/r2YT56cEjZ+CmIGw/1I07sczzUeWXR90k5
 1slg/kuS9pTQ6bQl3a3Szg==
X-Google-Smtp-Source: ALg8bN6xPQFCUV6aoSTk3CJH7sFIhiNo5OHlySiM3DO0WoW0UrfGnB+BHKblGRivv83uVtTZxRf59A==
X-Received: by 2002:a05:6830:1004:: with SMTP id
 a4mr6741471otp.254.1547673179547; 
 Wed, 16 Jan 2019 13:12:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i22sm3057049otp.7.2019.01.16.13.12.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 13:12:58 -0800 (PST)
Date: Wed, 16 Jan 2019 15:12:58 -0600
From: Rob Herring <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: Add DT for NanoPi M4
Message-ID: <20190116211258.GA29888@bogus>
References: <cover.1547466003.git.robin.murphy@arm.com>
 <a96995cfa599792b24e740ce46d53bd68ef1d462.1547466003.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a96995cfa599792b24e740ce46d53bd68ef1d462.1547466003.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_131300_899877_862066FB 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-rockchip@lists.infradead.org,
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 14 Jan 2019 12:05:31 +0000, Robin Murphy wrote:
> There are a number of subtle differences between the nanopi4 variants,
> and where they disagree, the common DTSI currently follows the details
> of NanoPi M4. In order to improve matters even more, let's add a
> separate DTS for the M4 to which we can start splitting things out
> appropriately. The third variant, NanoPi NEO4, is a lot closer to the M4
> than either is to the larger T4, so arguably could get away with just
> sharing the M4 DT for now (plus I have neither of the smaller boards to
> actually test with).
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Fix the copy-paste binding thinko
> 
>  .../devicetree/bindings/arm/rockchip.yaml      |  6 ++++--
>  arch/arm64/boot/dts/rockchip/Makefile          |  1 +
>  .../boot/dts/rockchip/rk3399-nanopi-m4.dts     | 18 ++++++++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
