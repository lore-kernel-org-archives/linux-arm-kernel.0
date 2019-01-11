Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:01:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBE120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WnbWGEVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBE120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=46h1rhzyGS/hQeoXayv37dms87IQMlar/x4o351NgMU=; b=WnbWGEVlhTVsoI
	irwV6I0Tj2DXFTaq/QzOWXIkv0dUf11k8zDnYtJaJ7Lr6AbnGQAcyQGDe09T6H5JqytGrcQSm30rR
	Q58YgI7VMMZjEHeCDJ3DR7H4lxm+g9k7flZ0GZDfQ7Y8qTFdJRC+5DfjaB3kSfXBaBHShrWy6aEO+
	jwF6MqyktK+FyFas573Yst8q3R44iXW5UObWRdKzcCJGACpqZhxsPGBExJg8UfElVsyCtqVR6oNaG
	Kk6oyZxBSGy6XlOJwOjBkBYPFKTbmMDPxZ02spyHbOseLlr13/ndhADUctXlv2ZftYLNuqLQaQpy/
	aoz8GHDbQe4GpEV90PHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi4sA-0007fz-Cr; Fri, 11 Jan 2019 22:01:50 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi4s6-0007fL-BW; Fri, 11 Jan 2019 22:01:47 +0000
Received: by mail-oi1-f195.google.com with SMTP id c206so13485480oib.0;
 Fri, 11 Jan 2019 14:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0tStMa96wWRBx/17NVFv5fNcGi6PQn9ez/Jg7jJbYYY=;
 b=N1H286iAKqlokRmJyNsli24Dma/8p/6wcjeinQ680ABFidp7F/xH+uaTWpk2JwFKve
 3VGf4yA6p1zRUK9qkZ09NZM5iWKdlWHmORYTyviB295lwy9yDO+bXm7gbNuEoNIhjLNH
 vb+nZemoOlI2V3RksB2RRoBgX1YDl6JidPyWfWWcPrOzyoH+kin6d4iIeYoMe0tNE0Ql
 +wA1nrDzBQFXOhtGDo+kMIWkMKumrxIJBMh3HVolQ4hQKxTQ8cVYLl0TMLRlBfqQsq8+
 6lTAl+8JOrvRdTN2U3aMKvom8RUadnn+3Q1j36GdgNLSRzdXclLME5CL2FslZcKPKZNN
 WQzg==
X-Gm-Message-State: AJcUukcASoMwFAhvGDxXW9gJBh6G+RUjr6JH5TTNn8NuZ2IXIEX3V4An
 IExdn1kCU5FmCnebPs0dSA==
X-Google-Smtp-Source: ALg8bN63za8BAGWhUqzOFOZZ1QY+ffJb1ewVbVuep621A7M3Sr9g6Jym+AFehu9hvqD5aCFKyg6sog==
X-Received: by 2002:aca:408b:: with SMTP id n133mr10616927oia.44.1547244105188; 
 Fri, 11 Jan 2019 14:01:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s186sm37393055oif.0.2019.01.11.14.01.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 14:01:44 -0800 (PST)
Date: Fri, 11 Jan 2019 16:01:43 -0600
From: Rob Herring <robh@kernel.org>
To: Pragnesh_Patel@mentor.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: add ROCK Pi 4 DTS support
Message-ID: <20190111220143.GA9773@bogus>
References: <20190106044030.1484-1-Pragnesh_Patel@mentor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190106044030.1484-1-Pragnesh_Patel@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_140146_399079_02A1BF8D 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 heiko@sntech.de, linux-rockchip@lists.infradead.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Akash Gajjar <Akash_Gajjar@mentor.com>,
 linux-kernel@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Pragnesh Patel <Pragnesh_Patel@mentor.com>,
 linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Olof Johansson <olof@lixom.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du <djw@t-chip.com.cn>,
 Ezequiel Garcia <ezequiel@collabora.com>, Liang Chen <cl@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 6 Jan 2019 10:10:10 +0530, <Pragnesh_Patel@mentor.com> wrote:
> From: Akash Gajjar <Akash_Gajjar@mentor.com>
> 
> ROCK Pi 4 is RK3399 based SBC from radxa.com. board has a 1G/2G/4G lpddr4, CSI,
> DSI, HDMI, OTG, USB 2.0, USB 3.0, 10/100/1000 RGMII Ethernet Phy, es8316 codec,
> POE, WIFI (for Model B only), PCIE M.2 support on board.
> 
> This patch enables
> - HDMI Display
> - Console
> - MMC, EMMC
> - USB 2.0, USB-3.0
> - Ethernet
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> Signed-off-by: Pragnesh Patel <Pragnesh_Patel@mentor.com>
> ---
> changes in v2
> - hdmi regulator name correction
> - replace gpio pin number with appropriate macro
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-rock-pi-4.dts    | 606 ++++++++++++++++++
>  3 files changed, 612 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
