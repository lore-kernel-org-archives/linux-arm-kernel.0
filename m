Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318EBC37121
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:27:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EF22089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hKd//l8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EF22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6e9ThpvGmJpDxPz2LoS2bTAGgF8VG62nfjH5kSdqBEc=; b=hKd//l8PQWxSlk
	noOxqXz90bETO69VIMl38P1RokEfmBn8pjQYjJmKBGNecDq5+b7sonikuAC2LCO0McJSquDYMWrp9
	fe8yha20ehtxNfvJ+hZPrHUGetZaa77v+soSPmOZPQfzkimLD7tLbo5Ryav9cFblKbvMfGmNLvz9Q
	vbGxv/P1X/L0CaoRVGfla3I3wA3WKo2P+Nuv71r/x1AXQw7OIyBcBWd1JnhUnWm46pjjF77e4icpR
	7RBi/pnP9t2GMT4E9qI/c37FVwJFypL0r/NOwliuXf2ftnuPOll12mtAgQ7+th1ql/23FkV0ci77J
	zvnuzSmqqj5piX4S5fPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gliyc-00089R-Tg; Mon, 21 Jan 2019 23:27:34 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gliya-000896-1j
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 23:27:33 +0000
Received: by mail-oi1-f196.google.com with SMTP id v6so15936143oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 15:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QAEazAvtZGRVmztR0fZs7peeBmBQfNODzrZoRRkZ2+E=;
 b=EoLyPElwMxWYB+//VBOFHWe68xlTYTpbMmBIGwsPiWb5Y8KBa67/AaNRgHQecUrTbU
 Ktpjel6RKjrGvivuFd+5jF/aUOn77dWVDz0kxDZpUISg3CK/fHtEvoMHri6EfWhMYBwG
 SiP/da8gEyKJ5nWRDOgO8KxdzIwJmapm29MPovR7nubS4O/vz6Y2ZrEeeuv2rzbi8qKl
 PN4ab3bS59xIgU3A1LQ61pqwtA3f2f8M5/vlMzi2jIxF4JfGc4yyR16SDkxgOtNBp+0I
 9bAq0J3xVDF6KCJ4zwNt9hgSk37MQPdwIm+LGWaJ2zUQWYvQ4ucrGHg2RjEzTAPcWILy
 Mo6g==
X-Gm-Message-State: AJcUukesl6EpEa+fwr8++F26ccIP8HYJQRxnkfIFJ6jkEqVR/zQpvv7D
 woJrWmh5bRjLNOqAc2YPjQ==
X-Google-Smtp-Source: ALg8bN6NodnEkkJvprhSDsOkQyWETycLI0imaTFl/Iy7Pb0+Q05zVAycdcoM/CR/TcTjXYk2Y6p8Pg==
X-Received: by 2002:aca:4e11:: with SMTP id c17mr6686465oib.254.1548113251114; 
 Mon, 21 Jan 2019 15:27:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id c78sm8060369oig.30.2019.01.21.15.27.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 15:27:30 -0800 (PST)
Date: Mon, 21 Jan 2019 17:27:30 -0600
From: Rob Herring <robh@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH RESEND v1 2/4] dt-bindings: fsl: scu: add imx8qm scu
 clock support
Message-ID: <20190121232730.GA22676@bogus>
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
 <1547207400-28307-3-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547207400-28307-3-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_152732_090419_802E4AA6 
X-CRM114-Status: GOOD (  16.45  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 11:56:00AM +0000, Aisheng Dong wrote:
> Add imx8qm scu clock support
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 5ec6dca..b6a883e 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -71,7 +71,8 @@ This binding uses the common clock binding[1].
>  
>  Required properties:
>  - compatible:		Should be one of:
> -			  "fsl,imx8qxp-clock"
> +			  "fsl,imx8qm-clock",
> +			  "fsl,imx8qxp-clock".

No need for the punctuation here. The whole point of one per line is to 
have 1 line changes. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

>  			followed by "fsl,scu-clk"
>  - #clock-cells:		Should be 1. Contains the Clock ID value.
>  - clocks:		List of clock specifiers, must contain an entry for
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
