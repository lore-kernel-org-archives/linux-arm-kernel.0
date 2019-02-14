Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC7DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9FE2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hcizq34w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrtlQBPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9FE2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jAsSRivUxsQwmh8WSzs2Nr0veo6ye+5eYKYhP2A4r98=; b=hcizq34wd9YLPT
	5dKQ5tnTwMs17PvI7qP+PstbGugKVfw4P4M7Xt9yrZwn6L8FsWYB60YYoSN8VSe07WxPcEb7ObFTC
	oZjhjoJ/6bWbONfkBcVPV+cHGNI1DJYfAFo0d58/4CwARfoBRb+0J+GPkbCwfxTYR2gscVJaZPoFg
	6R7ZKBpwVdk3i2cYXTNuL1pmbBdLHfW0Vm6fX18kTh/p8VUcGJQ68cuWxoZ3XwQAXBEM0vj+ieXPi
	qbOYBfnr2gWhXOWgZLeMHL1H6CkcX25su8uKKv/pH1dPtnZYuvP5z13kyqXzDVlhUQFFzCLQlHZ6X
	gBQgx23Ni/qf7t0mwnng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guPSm-0002ss-Ox; Thu, 14 Feb 2019 22:26:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guPSj-0002sW-Ot
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 22:26:35 +0000
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 52E2D2177E
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 22:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550183193;
 bh=q6+izAjYkpJKumR76WP8XtF4rZPjRPQaG2hlvlgQ/OU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=lrtlQBPUuLJrf3eEXsWdXL6i1arwVyn0ny0KRZ2rceBEg+ZtHj8eg99skp+bDZ72J
 hoEeXwuHs9XpHqnYpUZKaKFwQICnGKSifYB4QUsyH4loKQnFWNr5QTHH47LTVxEu++
 MmztmiNfiTOZu5VHg8KgdgKisNPTc3AjgR4AV1yE=
Received: by mail-qk1-f170.google.com with SMTP id y140so4598344qkb.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 14:26:33 -0800 (PST)
X-Gm-Message-State: AHQUAuZ5WXDA9bB+JeSLQs5vt6p0CB0XTwrSPklKLKEzgvMzrKT8BBoH
 DjjBu56IpMuDqSW3cq5GDrFtpCDtRJda/Gexeg==
X-Google-Smtp-Source: AHgI3IbbExBUfuNOf+o0KBoR+Zzu+gAXVcHlaHJ+l6wSxlvWVm6ptjiEf1IzhG9L7wLSZxje2w3fKv1esiYVXY10ieA=
X-Received: by 2002:ae9:dc45:: with SMTP id q66mr4714547qkf.147.1550183192583; 
 Thu, 14 Feb 2019 14:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-7-ray.jui@broadcom.com>
In-Reply-To: <20190214175725.60462-7-ray.jui@broadcom.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 14 Feb 2019 16:26:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2sFc=K5tezmdcjLT9v7_5QFZ1F-azMdsXyjf=t7Zycw@mail.gmail.com>
Message-ID: <CAL_JsqJ2sFc=K5tezmdcjLT9v7_5QFZ1F-azMdsXyjf=t7Zycw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm, iproc-nic-i2c"
 compatible string
To: Ray Jui <ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_142633_822892_3FB37BA5 
X-CRM114-Status: GOOD (  12.72  )
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

On Thu, Feb 14, 2019 at 11:58 AM Ray Jui <ray.jui@broadcom.com> wrote:
>
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>
> Update iProc I2C binding document to add new compatible string
> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
> also added that allows configuration of the host view into the APE's
> address for "brcm,iproc-nic-i2c"
>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
