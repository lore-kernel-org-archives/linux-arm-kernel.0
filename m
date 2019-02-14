Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D906C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:25:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E6E2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LNY09Rr2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFXrNl2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E6E2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eCsHI2KuYCMxQvF4SAYed8cLP8gs6E2UsqYpTQth0E8=; b=LNY09Rr2pI2KCV
	nQlxfDSl36mAcBcdGB1o2WBdYjsS3Tu4w0FofCff+JtxdfI2wtOryzrkWmp/X9vBCL7+QZM2zz4in
	x4Fc8uBbUyCaE3w2yuJ8ak9TsZZOJx4lq+IVysp6Or9vWNRTJbOi+4iUYBNmQjG9CUp17XDC4fiK6
	JMu1olvMfz+jCvvzCG/mhcWP/vhXf7PxdpRUtB9ZMn4+7yaYAmFPHKiOScaXnvPuqccR2fsgNtHGs
	vNGq9BXFKdSjpc3LNoqasLUKZfateSjVfgZwf2YvS97vkaM9Ca946THmJNUP+yVlTc3NSoOG6lvfe
	INzPfqCWdH54Ej3xIJng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guPS3-0002bX-Ft; Thu, 14 Feb 2019 22:25:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guPS1-0002b3-G8
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 22:25:50 +0000
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F1AB2229F
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550183146;
 bh=YL85AWpsB8yHn4HE/LjbG0iark5x6TEwUeV1Li2H6xs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HFXrNl2UCqG6EWD9zJ80rHR+SLzhZ0z2p7m8BwVsFKI4qSDLdNCsNjtFUYniNbHIy
 SdnShVPgMlPjYo28+mK7brkQJzlSRJC/O0m8cnrVLHQMbR4G7EjKGzVVw3uGuSLK9/
 rVneQ4FjVLLThNLiykpEJFjds/ugbLvDOV5kFpzQ=
Received: by mail-qk1-f170.google.com with SMTP id p15so4607234qkl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 14:25:46 -0800 (PST)
X-Gm-Message-State: AHQUAuaII1t9KlpJyyKRgTw2F4EZOKPtF9uhRdTfzsV6cgPbQ3FyBbvi
 5HeQNv8MOcSh+G6MFHsSap42hxpjQmIOpYZndA==
X-Google-Smtp-Source: AHgI3IbPbeaayaCLOakH1MmZKpETwRvANLH2Gb0Yo4wRcfifnKOKS4VCZp9wkiin1kvNuuOVeEESHA2tgHEUMWB0eiU=
X-Received: by 2002:a37:94d:: with SMTP id 74mr4734584qkj.79.1550183145609;
 Thu, 14 Feb 2019 14:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-4-ray.jui@broadcom.com>
In-Reply-To: <20190214175725.60462-4-ray.jui@broadcom.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 14 Feb 2019 16:25:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+W=+1=Sj8zQu_ECW9UzEiS8Oya8W_0ZQYPGemXC38qfg@mail.gmail.com>
Message-ID: <CAL_Jsq+W=+1=Sj8zQu_ECW9UzEiS8Oya8W_0ZQYPGemXC38qfg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
To: Ray Jui <ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_142549_557004_9D12084C 
X-CRM114-Status: GOOD (  12.04  )
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
 Wolfram Sang <wsa@the-dreams.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 11:57 AM Ray Jui <ray.jui@broadcom.com> wrote:
>
> Update the binding document to make the 'interrupts' property optional.
> For certain revisions of the I2C controller (e.g., iProc NIC I2C), I2C
> interrupt is unwired to the interrupt controller. In such case, this
> 'interrupts' property should be left unspecified, and driver will fall
> back to polling mode
>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt        | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
