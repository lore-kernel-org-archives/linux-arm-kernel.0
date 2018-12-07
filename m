Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D26FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:48:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AE020838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CHs4Uck9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AE020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eXefPtVklUzdBHkd6JtoBwakkVBG6PvFmDR69Vhiiu0=; b=CHs4Uck9pMrk7x
	8hUQW40zPjzf9v/D/ZCvxVOCsA/L0fw/KFBSoaQ7u5ZkdbRV07s18Xv1X7MM/LpDPbi4ULcprPew7
	Bgnqb+DYdYOf6IQXSa19Q9FkSBKTetYXtCiQXHgakuRdB9Nh773rNRjhHF2781tX0eQsCuznkXMGB
	busDf/IQRsRgpYi+GyHbeR/VtbDRpbmHyt+dY2VumpJRzaGBJHz/200ipfPy4JebpLbEjeJC5yzFe
	IPOU2QlwcFECGVmwbKDd5jhQHIs3nB7tKoPKLZdRxlfJLb4xpaz05bPhe40/XI0o75wI00YBCrf8Z
	iTQBGp3+eP5hh9WW/lbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPrV-0007fu-Me; Fri, 07 Dec 2018 23:48:49 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPrS-0007et-IZ; Fri, 07 Dec 2018 23:48:47 +0000
Received: by mail-ot1-f68.google.com with SMTP id w25so5372301otm.13;
 Fri, 07 Dec 2018 15:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fzCzl/65tvmZFauhKWp5zjohQjwhB4mb0SUi5YOpnUc=;
 b=VZ0x68AN6ZwzjqTkCNYcT+iMcqov92bFzhnlcrKcIBz5EeMOeGX90B4oC7qjXR1ZtL
 1OUTTzbEpGFWAA21GJXGYpiaUX0+FmlKYbCu/E1CP3ijmRO5SNMQxtwkntAz7KdUcUzD
 R2tSnJugqi92l0V28l8VY1s5axOA7AVtqnUlqtp7qmtVnvIEB0fS72uCnPRN7QGhY2hd
 N5jYfT0utJsjYtwpUPDHgvfP8VzaslqMDwIFAIhty9vafCpPP1306Pr4sdpus7/6V5Qg
 iPp/nYYZnd6YnE8xq8IJpfNtirIyAaM4RZOUJNoP9v5YQYsOKPL3McYdD8/I9hMFsnLe
 6JUQ==
X-Gm-Message-State: AA+aEWbp39kqHL2gybLjXoa0hQ9qIC4S38Sfs56XNyJRuiX7iAu8ugLh
 PT+7xzrNiUDFNhlKzMnRrA==
X-Google-Smtp-Source: AFSGD/WnLfEg74sCwk9cOMH1HAZMam8b6HBe/9N2On/XXa19A+N0aUu4fd6iOdOgRhfYoZSKn4MrIA==
X-Received: by 2002:a9d:172e:: with SMTP id i46mr2700886ota.322.1544226515252; 
 Fri, 07 Dec 2018 15:48:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id v3sm7302040oib.57.2018.12.07.15.48.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:48:34 -0800 (PST)
Date: Fri, 7 Dec 2018 17:48:33 -0600
From: Rob Herring <robh@kernel.org>
To: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 1/5] dt-bindings: soc: Add a new binding for the
 BCM2835 PM node.
Message-ID: <20181207234833.GA27917@bogus>
References: <20181130202743.20585-1-eric@anholt.net>
 <20181130202743.20585-2-eric@anholt.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130202743.20585-2-eric@anholt.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_154846_606092_82DD5EC0 
X-CRM114-Status: GOOD (  11.37  )
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
 Florian Fainelli <f.fainelli@gmail.com>, linux-watchdog@vger.kernel.org,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 30 Nov 2018 12:27:39 -0800, Eric Anholt wrote:
> This binding supersedes the bcm2835-pm-wdt binding which only covered
> enough to provide a watchdog, but the HW block is actually mostly
> about power domains.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
