Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C0C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D163520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lvOjKr1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D163520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TWBzUghbfF4abzurHP3ItgPFmV7QjL2PxT3nelQAe8E=; b=lvOjKr1gQR5NiY
	bgylza9LGSP1NzYU7leox+BKvFcyO3BdRaLI0ZHjoJkjFHWqrGzgIOYFHFPS84m7DiPh72qZM/dxI
	o3ffh6OWPeEQ2VYhNpiP9utfubV7rTK6MqhhYZxTv+rKipB8T/c6IP3WK4hGQWiamZKwKvkBxcPet
	aROfmOv2OCY3HiWWAwttbiCV4lJpJFzwbb9B3wWsP+ru3H0XRZPOH24Prer5YB/nhebT6slH807EG
	GcFa1vPQ2tecV7ATPFqFHF1bYapp4weLD5RJ0AbOBR7/QyxGTf/+gMMVciV+2N7d5I1WbfWWcy83V
	gmr4iHsteRrmyHLIz1mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxC2t-0005eO-03; Fri, 22 Feb 2019 14:43:23 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxC2p-0005d3-7t; Fri, 22 Feb 2019 14:43:21 +0000
Received: by mail-oi1-f195.google.com with SMTP id i8so1851804oib.10;
 Fri, 22 Feb 2019 06:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8UqyK51WWUMv62f/xSf/NgWglLHOsqA+OVLyel2pKmk=;
 b=uGhRCs3jMn01H9CVJ5xa5J90ugBzr7pq1FtnqT97WB9ZZ0Md7zlvuSrFmK9d4xDX3l
 teuBAnQCvI3twB/NTtvcYJ72sNpJdy/z4k0TNoP1hVbFKMsPseDxg09Dv9Ydf9Ik4gl6
 Nq+WHUqVhzHtu3h2LkKFyYZCANOBDf0bjveVpKGpoICrVBcy1FYmiwRY5x11ECkzycGl
 OIy4vMoUooz3KhwRK0XrUpIRvw3yiTL+45SBfr+B3cfBhRPWNf8HnC74xEAURS+a4rwW
 QbZW0cagZqrQOFF5pyKXfMK/TLLyAnUQEo+j5RP9RguT84fk/AsljAcyFtg45s6HszBz
 9mJg==
X-Gm-Message-State: AHQUAuYItVn2OY3LA7UyFEBXTVpEru4rpNkCjXZvLkvz7IjcFhb+kHnh
 Us6QLbZQ3gw5TfG8TrYU4A==
X-Google-Smtp-Source: AHgI3IbiU1/o2lREFx/T/rryMFh7rCjg6zqfdW6sBders53BoAnhdFu0fjZj/gWekkZ2rMhOJUEG9w==
X-Received: by 2002:aca:4c10:: with SMTP id z16mr2650708oia.53.1550846598019; 
 Fri, 22 Feb 2019 06:43:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a4sm642157otc.21.2019.02.22.06.43.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 06:43:17 -0800 (PST)
Date: Fri, 22 Feb 2019 08:43:16 -0600
From: Rob Herring <robh@kernel.org>
To: Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: Add a binding for Mediatek SCP
Message-ID: <20190222144316.GA19284@bogus>
References: <20190221084729.101784-1-pihsun@chromium.org>
 <20190221084729.101784-2-pihsun@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190221084729.101784-2-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_064319_605145_AE4C6313 
X-CRM114-Status: GOOD (  23.64  )
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

On Thu, Feb 21, 2019 at 04:47:24PM +0800, Pi-Hsun Shih wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> Add a DT binding documentation of SCP for the
> MT8183 SoC from Mediatek.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
> Changes from v4:
>  - Add detail of more properties.
>  - Document the usage of mtk,rpmsg-name in subnode from the new design.
> 
> Changes from v3:
>  - No change.
> 
> Changes from v2:
>  - No change. I realized that for this patch series, there's no need to
>    add anything under the mt8183-scp node (neither the mt8183-rpmsg or
>    the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
>    directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
>    created by SCP name service.
> 
> Changes from v1:
>  - No change.
> ---
>  .../bindings/remoteproc/mtk,scp.txt           | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> new file mode 100644
> index 00000000000000..8cf8b0e0d98a4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> @@ -0,0 +1,37 @@
> +Mediatek SCP Bindings
> +----------------------------------------
> +
> +This binding provides support for ARM Cortex M4 Co-processor found on some
> +Mediatek SoCs.
> +
> +Required properties:
> +- compatible		Should be "mediatek,mt8183-scp"
> +- reg			Should contain the address ranges for the two memory
> +			regions, SRAM and CFG.
> +- reg-names		Contains the corresponding names for the two memory
> +			regions. These should be named "sram" & "cfg".
> +- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
> +- clock-names		Contains the corresponding name for the clock. This
> +			should be named "main".
> +
> +Subnodes
> +--------
> +
> +When CONFIG_RPMSG_MTK_SCP is enabled, subnodes of the SCP represent rpmsg

Bindings can't depend on kernel config options.

> +devices. The names of the devices are not important. The properties of these
> +nodes are defined by the individual bindings for the rpmsg devices - but must
> +contain the following property:
> +
> +- mtk,rpmsg-name	Contains the name for the rpmsg device. Used to match
> +			the subnode to rpmsg device announced by SCP.

I don't think this belongs in DT, but without some examples I'm not 
really sure.

> +
> +Example:
> +
> +	scp: scp@10500000 {
> +		compatible = "mediatek,mt8183-scp";
> +		reg = <0 0x10500000 0 0x80000>,
> +		      <0 0x105c0000 0 0x5000>;
> +		reg-names = "sram", "cfg";
> +		clocks = <&infracfg CLK_INFRA_SCPSYS>;
> +		clock-names = "main";
> +	};
> -- 
> 2.21.0.rc0.258.g878e2cd30e-goog
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
