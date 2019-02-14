Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6FCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22952229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XoV4SpLc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV7SIqXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22952229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r6SaWnwuxXHYFOFFOR0ay2TKWXCgY+l0D++ISdXKfcw=; b=XoV4SpLcXRaHHF
	vYErzgRAfqJxdatkM5qhQbosB8n5UH5nRXZqafdOq+J94gQdGWhzLtt+1DO5VCNdZzdu4xFO7INVo
	KSI2QtK3FfZgk5LWFMtePt9LNnKYJSEwOXvqsMYfUqVceFF1CbXd7Bd1Kv8/OryEG8NKgSQthEw9F
	iyLoDO1IY/biOXPuoEPB/fYjhl5rB3c/DvsadpNWa2GL3uvFCg7J/BOTLzzfNpyfw6oQq6DPUXu85
	1hbzFbfBqCTS3URE9sfmH3p+ZWYZ7VNEEPU3iZvBfUnpW1U3zZ4NuP6u8C6ZaYSsCPP2RTLqjMLS7
	8TupzqqIlUI0Fw759a3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guHao-00018L-E0; Thu, 14 Feb 2019 14:02:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guHal-00017x-UK
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:02:21 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9FF54222D9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550152938;
 bh=hX9pWkxgVzMfutIVf1friNZvd9QbP9PurqC/eXn/pTM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pV7SIqXwcq7UBg7gwWpdmTFkPN7h8GVcZ7gEVgLg3MrhQ9kQNRPQug6L7kjAeWfiO
 liFchfzwF9NFGkkW7nGkQ7MyPCg99vO+zpLD2Gh4LYwKD2ZCMKbHeP6h9rguuFeqdC
 kEzIPgALWyXpHLUH8gzC9QgPU3mYRsKtGvSVFC/0=
Received: by mail-qt1-f173.google.com with SMTP id 2so6915592qtb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:02:18 -0800 (PST)
X-Gm-Message-State: AHQUAuYTzwlZnjZb7/ot1d6VStDaY6x7hxtwbTofjEFMCrqs63a+ERbG
 76l/8tuoQt0uuCwzQOdVxX2yGlobAYGSlO7zvQ==
X-Google-Smtp-Source: AHgI3IYx+ALS17jgxLkv693q9nJ0Uc8AvrIdj0TNhfDOfUSAO+Ybt4k4QiVhipWDHP+klWPCEOCV+S1UtbL3GIiT12Q=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr3106313qta.76.1550152937642; 
 Thu, 14 Feb 2019 06:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-7-ray.jui@broadcom.com>
 <20190213211807.GA20560@bogus>
 <6de51a50-cd7c-dbf8-15d8-8d2fd441d831@broadcom.com>
In-Reply-To: <6de51a50-cd7c-dbf8-15d8-8d2fd441d831@broadcom.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 Feb 2019 08:02:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
Message-ID: <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm, iproc-nic-i2c"
 compatible string
To: Ray Jui <ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_060220_011477_CA41DD23 
X-CRM114-Status: GOOD (  17.82  )
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

On Wed, Feb 13, 2019 at 4:09 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
>
>
> On 2/13/2019 1:18 PM, Rob Herring wrote:
> > On Mon, Feb 04, 2019 at 03:15:52PM -0800, Ray Jui wrote:
> >> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> >>
> >> Update iProc I2C binding document to add new compatible string
> >> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
> >> also added that allows configuration of the host view into the APE's
> >> address for "brcm,iproc-nic-i2c"
> >>
> >> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> >> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >> ---
> >>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> index d3a3620b1f06..02e82d20239e 100644
> >> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> @@ -3,7 +3,7 @@ Broadcom iProc I2C controller
> >>  Required properties:
> >>
> >>  - compatible:
> >> -    Must be "brcm,iproc-i2c"
> >> +    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
> >>
> >>  - reg:
> >>      Define the base and range of the I/O address space that contain the iProc
> >> @@ -24,6 +24,9 @@ Optional properties:
> >>      Should contain the I2C interrupt. If unspecified, driver will fall back to
> >>      polling mode
> >>
> >> +- brcm,ape-hsls-addr-mask:
> >> +    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
> >> +    'APE' co-processor
> >
> > What's the data type and size? What are valid values?
>
> It's an unsigned u32 mask value. An example of a valid value is for
> example 0x03400000. Do you want any of these added to the paragraph above?

Yes. Bindings should define constraints.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
