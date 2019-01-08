Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F25C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:25:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF7B2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A+whT0C3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bxc+0NZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF7B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=j05Hd+bGqoeJ868OM5wdWwoaOtN3gHEukhkEBDFoMtM=; b=A+whT0C3gARA2kQSfEZi2Gs5NF
	ZhirHe9E6s26rcDKGX9OUtxKib17sOkmtvXnKw0GC5CMLHRH2RSfiyrqsW5r2LeDkTxaPWTBu3xPq
	mdWA/lHi65vodzRV4WvZUi5y3J6AHEGCjGmRE7dqqzZ02RtAkiiy11a95Fl71+EzA3/AB19VoxGqG
	ZBePlRXyZBWmj/m0qXC2wKGu8/GonazpGM50nFmWXcRz1or+7DjxgHV6eIBUmLCz2ORerXsceZa2I
	bRMu1Xu3tkNeos1rME8kvcq2K6VhU8w7Fk9vQ5NWI13WyoBqKG4rhrfsYC5lRF+rKeKgb0VeQFWsi
	gJaZNoag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggv7x-0001n7-1M; Tue, 08 Jan 2019 17:25:21 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggv7t-0001mM-Hh
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:25:19 +0000
Received: by mail-yb1-xb43.google.com with SMTP id x201so1870922ybg.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 09:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=3bg8CAnFW238OIcpYA+0yZo5cJSugpakiBbJrbNjlKY=;
 b=bxc+0NZBmNtmzZMFuoxksibf2LzHorp/nJMXDwUNg7SuoiEObIn4J09MT+DLuweAVa
 JB3bqQiR4K6Iti0lpHx7ZI+HRS5MzEDUEtg7kHNYx0CESX/FmstrhT8Rr4YKEFGb+eXT
 U/6VAgfV9e1tvwFIsWW84RBpT+3FF8kNYIl0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3bg8CAnFW238OIcpYA+0yZo5cJSugpakiBbJrbNjlKY=;
 b=HzT7Vkt+BGu1mQXfxBdUVSrz+mJqXVkCEz4X0aRbBoui3F4UAYielTbN0DMZ+eiRtG
 djgqrTYg68XDTIZXOWiy2wox0ovi1bs06Z6s1yERGw8lCgyfGFEXfvZJPRXMtQJ+ok5b
 VhfSelNMSJQsExydkG7BmP1XCF/deuBidV5xV4M2494/7SHgm2KX8uIu6BQ+UGOAy5ES
 6PqB3ZI7TTtUhVYbyq7huAQeNdGNziUdtaWs95es5Cr4J/WVB4a1S4c/ww2ECZxDbSlS
 55DaNqItgwPfzcm4JIip6NNehHHIUbf/LhnsjYNRhgd2E9aJoLCYEuuE6ePOCL0oKETK
 b2Cw==
X-Gm-Message-State: AJcUukfUe6YJIXCQKa21pAKvMR34OzeopaN/a7HuQKUmBcqOEpEuqG+w
 BBzTgVErPdQEtn71oad3XoQGHw==
X-Google-Smtp-Source: ALg8bN4wHddVIFoJHInYz7PaSeIFeBkHjI/6p6ArC9mXmlLxlIMC76qUHvHhjQzryfR9Vvb6eZNbXA==
X-Received: by 2002:a25:2f88:: with SMTP id v130mr2493374ybv.455.1546968314963; 
 Tue, 08 Jan 2019 09:25:14 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id v9sm34914192ywh.2.2019.01.08.09.25.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 09:25:13 -0800 (PST)
Subject: Re: [PATCH 0/8] Add IPROC I2C slave mode and NIC I2C support
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
 Michael Cheng <ccheng@broadcom.com>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com
References: <1546938997-13798-1-git-send-email-rayagonda.kokatanur@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <6a5380e3-1e15-31e3-bbaa-134856a0c2dc@broadcom.com>
Date: Tue, 8 Jan 2019 09:25:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546938997-13798-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_092517_602481_037C5A6E 
X-CRM114-Status: GOOD (  16.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

You sent out the same patch series 3 times without any explanation. Very
confusing.

Is this the latest one that should be reviewed?

Thanks,

Ray

On 1/8/2019 1:16 AM, Rayagonda Kokatanur wrote:
> Hi,
> This patchset contains support for IPROC I2C slave and NIC I2C support.
> Following are the brief changes done inorder to support both IPROC I2C
> slave mode and NIC I2C,
> 
> a. Add support to allow I2C rx transfer upto 255 bytes
> b. Add polling mode support to the iProc I2C driver. Polling mode is used
>    in certain SoCs where interrupt is not connected from the I2C block.
> c. Add warpper read/write access for register to support indirect register
>    access. This is required in certain SoCs with this iProc I2C
>    block registered.
> 
> 
> Ray Jui (1):
>   dt-bindings: i2c: iproc: make 'interrupts' optional
> 
> Rayagonda Kokatanur (5):
>   i2c: iproc: add polling support
>   i2c: iproc: use wrapper for read/write access
>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>   i2c: iproc: add NIC I2C support
>   arm64: dts: Stingray: Add NIC i2c device node
> 
> Shreesha Rajashekar (2):
>   i2c: iproc: I2C read up to 255 bytes support
>   i2c: iproc: Add Slave mode support
> 
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>  drivers/i2c/busses/Kconfig                         |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c                 | 767 +++++++++++++++++----
>  4 files changed, 669 insertions(+), 131 deletions(-)
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
