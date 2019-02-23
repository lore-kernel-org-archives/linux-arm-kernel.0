Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:40:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2658320665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qdpgdZ99";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFl/S5dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2658320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d12tGK+UMbr0y4+0kJj9j0H5/U+KwF4bGa0v3624Xl8=; b=qdpgdZ99e1Oel1
	LQkjYs++XEIYE6I3gdYsCFiu1fQ7q8HP4UKsyFLe0tV1CDMDV3msLxiOT144+0y5GPe/NDk3F7IYD
	kbc7dzoK+BaToVW0RVZGgUPyeM/hrBM7wDkguArogAAsHd4j5+PRfzqXyVhDirzsxqkSWezndV7L5
	BiljulHlrgf5uV7wio30DWcaCHPwJqwDIeTSKR4kymT3AQZ75+P9EJQgWbcp2sJeJXPvmINqPnCB2
	2IpNjTgUlgQtZ613zyqySE0nGJVg9aXu2nc/xH7xewSjRHb01iKtfITMlzQxHNJLs6ZEMCu+t55V/
	9e61NexlASyD5UuO1Ksg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxf1w-0003wN-27; Sat, 23 Feb 2019 21:40:20 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxf1s-0003vw-Pz
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 21:40:18 +0000
Received: by mail-pl1-x642.google.com with SMTP id 101so2697041pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=K/cw/i+biX0xbzs1U/A5+Hg2bR0HgcIHCETYcKZn9BA=;
 b=aFl/S5dY7FViy+Ul4JqGXxC/tKj4PKPMkAgPMZlX1+vQ7Bx7GL4EsxdRN5mOqknwBJ
 odxExLrlyV+/7zi1/Jwa2z+yEtt0nYxD8ebBMmbAkkvAp7YDn+BLd5EM9VWlWOLD93IZ
 nZ3op9eUN743CljmOLuJzInlYvSs3Hzvyjx6KP0ytWFUaKMcfjEs7RmAWjA3TZEOZq/K
 LQj+U0yUvZdA2i+yBDSiqfKe1j1ZsJuM8fU7X9kRA2lw5Ty5rA9RFpRxzTAUueMw8Jkq
 udZ0FD/0ZGXlDSpRXjbmt07ccj67bacfoQbRg+ltzC0pH/hRktGvMHOJpqKry4GLkBbk
 hRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=K/cw/i+biX0xbzs1U/A5+Hg2bR0HgcIHCETYcKZn9BA=;
 b=XmkkiM4Be7ZD8GKNkigxhzg3PaHigkc341Jok7oqVzCnN5N58LkTh5sSK+70jhTbyY
 1qnSyLE5R2NPTKhJstY9KrLWV+SwD5OsSpYCR49xu7Fs/7waeKXW0rJs+Nf6MQ7FPK/s
 KsJzy0bG76N3IQWzu6fnM52O3KtAAXkntWCPoYEzir/MLO5L60rJUaGmPpP8L5ADUE2L
 nTR2Z2hcR2PSXNgVRjLWTyp9v5f/yhwi+7PeFxd0rrCORxU62V4b+hZyGh2lofL6Txnv
 a92sW0Tn37KrKy5No/stvZ7CyEWJqWRpF6g2s/V4QFqUAizQJt9/HeuxaDyd8q77H1NY
 XEyg==
X-Gm-Message-State: AHQUAubtFwK9nvcPx0MKg4TJdmNinwMwWv5VXqmdozStkEd2NkdCsvXq
 9K8F50LYdUyjQgBzpKmTQBg=
X-Google-Smtp-Source: AHgI3IYH1OXM8cGDa7ACH/eSL++QXZuFZ8mCW7sMC0Dm+XCrMzSDtUsZJ9QzSHtf7Z9sT6X8lndJQQ==
X-Received: by 2002:a17:902:264:: with SMTP id
 91mr11281442plc.108.1550958016031; 
 Sat, 23 Feb 2019 13:40:16 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id q28sm6734443pgl.35.2019.02.23.13.40.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 13:40:15 -0800 (PST)
Date: Sat, 23 Feb 2019 13:40:19 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20190223214018.GC1472@localhost.localdomain>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
 <20190223213759.GA1472@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190223213759.GA1472@localhost.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_134017_022470_2BCDEC45 
X-CRM114-Status: GOOD (  24.88  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 23, 2019 at 01:38:00PM -0800, Eduardo Valentin wrote:
> On Thu, Feb 21, 2019 at 06:38:30AM +0000, Anson Huang wrote:
> > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> > system controller, the system controller is in charge of system
> > power, clock and thermal sensors etc. management, Linux kernel
> > has to communicate with system controller via MU (message unit)
> > IPC to get temperature from thermal sensors, this patch adds
> > binding doc for i.MX system controller thermal driver.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes since V7:
> >         - remove unused property "tsens-num";
> >         - improve the compatible description;
> >         - update examples according to latest dts file.
> > ---
> >  .../devicetree/bindings/arm/freescale/fsl,scu.txt     | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > index 72d481c..d89147e 100644
> > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > @@ -122,6 +122,19 @@ RTC bindings based on SCU Message Protocol
> >  Required properties:
> >  - compatible: should be "fsl,imx8qxp-sc-rtc";
> >  
> > +Thermal bindings based on SCU Message Protocol
> > +------------------------------------------------------------
> > +
> > +Required properties:
> > +- compatible:			Should be :
> > +				  "fsl,imx8qxp-sc-thermal"
> > +				followed by "fsl,imx-sc-thermal";
> > +
> > +- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal.txt
> > +				for a description.
> > +
> > +- imx,sensor-resource-id: 	Property array to specify each thermal zone's sensor resource ID.
> 
> If this is an array...
> 
> > +
> >  Example (imx8qxp):
> >  -------------
> >  lsio_mu1: mailbox@5d1c0000 {
> > @@ -168,6 +181,12 @@ firmware {
> >  		rtc: rtc {
> >  			compatible = "fsl,imx8qxp-sc-rtc";
> >  		};
> > +
> > +		tsens: thermal-sensor {
> > +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> > +			#thermal-sensor-cells = <0>;
> > +			imx,sensor-resource-id = <IMX_SC_R_SYSTEM>;
> 
> then this example should have an array, to be better express how this is
> supposed to work. Can you please resend this with an array instead?

I mean this could be one example of an array with more than one element.

> 
> > +		};
> >  	};
> >  };
> >  
> > -- 
> > 2.7.4
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
