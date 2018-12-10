Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:43:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5642B2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jbbraLPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5642B2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PtJG41QVFDgzpWGuFgYmWDJJXxU20GbpsQDJwxUZkNA=; b=jbbraLPubytadR
	67tBCg41riDCA1kKPhhLimbBvsc+vWLn6Ch2O0Gyk7mt6pOdqJ2anJx5/mF6yMZUDQhHyVul8/WdB
	WavPE69I1ob2BVod4FD0wgqjvcVB+saqI77fQOWyMcvpT5hEP0/aoN0PYTFUIOhfvyAMZqzSnHtcl
	Zb78Pd1xcIJUT+UCu8PaOKyVdGPEK4Y5hpb9RUEBsGy2IRnwXydB0L8adg0l4sAbRbgrnQO1NN0Kk
	A5g2c4RCaMyvpi2i4wYyK8DQiwghMw2h654O/+PsYXEOKWVE6b6i1ZKwas71T2p/Wnmcgr4Tya28F
	9B1/Ti/TyjNzCH4rstMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUGU-0005xa-RX; Mon, 10 Dec 2018 22:43:02 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUGS-0005xD-5p; Mon, 10 Dec 2018 22:43:01 +0000
Received: by mail-ot1-f65.google.com with SMTP id a11so12111704otr.10;
 Mon, 10 Dec 2018 14:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+yRQXceFb/IPFEltv/R5npJDmRvwMe8M1ZtEVmjhIBQ=;
 b=uKDCWqNcyW8m9bp6osZGuOI9qVQf6GEetXz91+FzsT3z0fWcJtb6c3rKG1mmA5SMH2
 Qpjvn+lixcK1gNeb4LQgGpXGS7bH9UWQ7xb73OutCg2YJ352Wk1qpxf2fG+g/uIbp463
 N2xLnE3R7JWSG9OSuGlZwklZ04GHCoFTFOjyYr/HedeHUrBIFDzSg4i5Bzet6+axwDvS
 xvzVe/EjzL87rYbzIAj4DqG8mqryz/465MyMFUb2jm0gKaBZLMVaeSYY9EKTuUo8gjtB
 U8fALh2VgwpDlZKg91iUPiAKi65yI1Gs9J2VPx2EZEMPywLYND66HIt47/jvY5t6DQWS
 v80Q==
X-Gm-Message-State: AA+aEWbtgvbyqU6PtmyCnbk4GibV6dQVTDjJxrTKYZbvnBWF602xJmcn
 Vdh+01QALpEDIbBfM6kNlw==
X-Google-Smtp-Source: AFSGD/UL+ZGjMlQQ0g/4rthh80PZqylXwlKvDfDCDAHYf91zct7UGF1gZ8n9SCMkt9vZOye3NN3JtA==
X-Received: by 2002:a9d:6c3:: with SMTP id 61mr10568340otx.314.1544481769088; 
 Mon, 10 Dec 2018 14:42:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id k11sm642512oib.35.2018.12.10.14.42.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:42:48 -0800 (PST)
Date: Mon, 10 Dec 2018 16:42:48 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: bcm: Add Raspberry Pi 3 A+
Message-ID: <20181210224248.GA1313@bogus>
References: <1543949899-13380-1-git-send-email-stefan.wahren@i2se.com>
 <1543949899-13380-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543949899-13380-2-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_144300_213326_6C9D2D60 
X-CRM114-Status: GOOD (  13.03  )
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
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>, Ray Jui <rjui@broadcom.com>,
 Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue,  4 Dec 2018 19:58:17 +0100, Stefan Wahren wrote:
> This adds the root properties for the Raspberry Pi 3 A+ .
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
