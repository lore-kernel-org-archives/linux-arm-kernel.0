Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8044C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:27:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EE520881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="astxPBYl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mqZ3RaxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EE520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sgbPwfaF9sND25oelquOQotq2I3c3o1YQWcH8lpyzOA=; b=astxPBYlk2JXxU
	k6kD6hBX5P/34vEzdCLIC6rgS3I0nSMDVRww285uDHqRsk0FaF1yixAw6wZ/wgcm0LWPtDyGGJ0VO
	jkz3NzhhXHxADgs/kyP1Nn0Iy+2cjJGjqJn2hXhvp61/CzvgPqxi5Zv+ArLLXcrKtzjTt9Tn9MGhQ
	t9uMSKiPcPJEXGmLAw4G3nzsDXDYzF9OEexP5cb+VHgdbmZvGDr2YsnqE65LN4CD8YQ6hnNvKCBoB
	/BxSMQTbinuUwWKVZ6fU14ucPchvyB41gFc6BMTGrj5NZHUJbQQA+QZbNjecBgYdXxgbyMp7GP/Y5
	XnReOtInYiRXFQus3YFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gogX0-000440-A3; Wed, 30 Jan 2019 03:27:18 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gogWx-00043a-5n
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 03:27:16 +0000
Received: by mail-qk1-x742.google.com with SMTP id w204so12932040qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tryZkG1b0OOMU3opyrQRs9lUM6ZpHAug1gUo09Q4LbQ=;
 b=mqZ3RaxGJf0I6S7YH0+BCdWmnKDFwLMul6X9xVIEypnqwSfbwGSp9QWYk8oomNbtN2
 m4PA2GKRHGi1JlJP+R+QZFMc/WfcEZmlMxXZjL66bii4v7atS+PNbbEhB3m8j+vyrZft
 waIM029yT8Ydg5gZoWqaxUS/NTCBB81jNTxRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tryZkG1b0OOMU3opyrQRs9lUM6ZpHAug1gUo09Q4LbQ=;
 b=MyhHqX5/fuFVIgNqZyvxE1rAPfo9rGjvHKskqDfMpAL+VVNTQnRaX/jKW5FI0ti0v0
 iCwbE7J3dbpKBPWFINdtjRCPh7eWYKQg8G+N6h49wM1PY/lBIKy3srV5YMyMxvtsx7VF
 7yAKYIDpeN24y+myO/LgCXAEap1ZB8iSekUbkS6J6z2E0AOAZMbibhN8+XST4HwluLXi
 q2sHfegumZd3IOvY3TcpbCvrZm6BuDYIHIoG2Ifod45hNGmCvNdSZka4wN8A/f00BU5y
 Y72P+ifnh10cyOgN+/jpLiv0Q27Cx0sOgl/isQ9g8joO++R12N2yw/Wj6cv7gOUOH/d+
 9JMw==
X-Gm-Message-State: AJcUukeZTGg+SdNTb4oPEz5mfFpfTGv7vSG7zizxNNcNNEgYfxXTKv63
 YEsgs2jXc632lL29u/a5dTF0YL7UvWNM4aJ2t+4=
X-Google-Smtp-Source: ALg8bN6VVbtR7psR0gbQFYO2JTPBCIwNB7xYBro8ejws2cyBvtvwN+ijOPde+6LF7jy35U4UFbgeqiZfgZfhQG8X6hg=
X-Received: by 2002:a37:a391:: with SMTP id m139mr25487860qke.11.1548818832043; 
 Tue, 29 Jan 2019 19:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20190123230733.1821501-1-vijaykhemka@fb.com>
In-Reply-To: <20190123230733.1821501-1-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Jan 2019 14:27:00 +1100
Message-ID: <CACPK8Xc91m9TWoRSgDCT7bVJC=C=w7mse8xbdCgw5vMVgMXM=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
To: Vijay Khemka <vijaykhemka@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192715_253837_8ED9629F 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@aj.id.au>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 10:07, Vijay Khemka <vijaykhemka@fb.com> wrote:

> index 73e58a821613..d60dbb019f82 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts

>
> +&peci0 {
> +       status = "okay";
> +};

I don't think we have an upstream tree that contains a node called
peci0. Therefore this does not build.

I have dropped this hunk from your patch. Please make sure you test
before sending patches.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
