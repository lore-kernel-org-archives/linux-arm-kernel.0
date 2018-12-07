Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21219C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:13:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E189320838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hgYf4Y9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E189320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BgYxWF/+9B0Dkdxbqx2GEbixSh7SHornZZPK8Q3yXkk=; b=hgYf4Y9Bd+BV0G
	5WUU11BIwbBPGMaO5cCqoWXSY7OpJI1UMCGsPl3mDJ7TPPYHiwfmYHWaq1p0Sc7YwQklnhZNg41up
	TIvkwJ9Mce3OAJwTClSovnWMQCvbQQZ6XWFlomsFIjY6OyOfYKyB8y44voa6DXszhhEXM978WXTPf
	hgXjIKPOmwFcW5tMPf6KXZC2wRTNXOaiyCNyeoCrIYqbhfzKCjfTWCteJxVd8z5EnXsXF1xgdHsCH
	/83JmMcfuEDTaP3wT/w6QaFQgXk+URs1LXToprPQWkQ00A5ytVk1ujBaWTuHdN9o72jhr/NCOBUgg
	JWRiudjc6ofXNxijdlSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPJT-0002wb-Ca; Fri, 07 Dec 2018 23:13:39 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPJQ-0002vh-KD
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:13:38 +0000
Received: by mail-ot1-f66.google.com with SMTP id 40so5366830oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HAZLB5b01POqOGjmOzQANT2uEEynRmpPNy+sjySi55s=;
 b=T7VLk7C61BiaRIvtqXBm4JfTP75TQH+CXDpDdwTdLwWXo8SPrvgzFKpEpiamhs0TbS
 nLPhF/iQUKvUUhFPna8k1ZjF9FQfGVWw37iP7RRMo9BRucgRd3eC8Awwjlpju32B5fD3
 1AWJKzaY8BUvypC4qg4rkEmtX1nLYK4NpghNoY9qrZ3CIWwzQG5L0JLdOET76S2LIOwD
 YGrF69Bw/aWn7bWye3FhtAeC/YJw8fOKRCs/Glf/osVa63Co3OerwHBw+mkva+pM8uRR
 bOmJ+lXloksut8dBCpn41+7ANtRz3Ccog1bfD6Ji2lVoPFtRZ4chGFhEgEpD6CtsnAdE
 m5gw==
X-Gm-Message-State: AA+aEWZRBopB8R6ajl9OHmAe6pjeiDzU76j2isNGl7cdfbf28Sf4oul0
 YpOVwWQdaCxhEwTwacyXkA==
X-Google-Smtp-Source: AFSGD/Ueeu7MD6cA9sMKipfPB176YPmUvIUDBn6Beb9ETKeqMYNGavyMi2x9YFpI/t2PRXxaqIzmQQ==
X-Received: by 2002:a9d:346:: with SMTP id 64mr2848722otv.90.1544224404594;
 Fri, 07 Dec 2018 15:13:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 52sm8216224oti.30.2018.12.07.15.13.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:13:23 -0800 (PST)
Date: Fri, 7 Dec 2018 17:13:23 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V4 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20181207231323.GA10231@bogus>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
 <1543458696-4741-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543458696-4741-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_151336_668945_1DD7C281 
X-CRM114-Status: GOOD (  13.35  )
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
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 dl-linux-imx <linux-imx@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "edubezval@gmail.com" <edubezval@gmail.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "ezequiel@collabora.com" <ezequiel@collabora.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng DONG <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 02:37:24 +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and thermal sensors etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get temperature from thermal sensors, this patch adds
> binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *move binding doc to SCU since it is belonging to SCU;
>   *change compatile string to start with "fsl" instead of "nxp" to align with other nodes in dtb.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
