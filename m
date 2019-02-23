Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC057C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:44:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D806206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LXnDjWSr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="DliSCpHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D806206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TH41BW4MJ2N8GIYmPaErGOUcRGwa2G4DTu8xTO+f6Uc=; b=LXnDjWSrpijqci
	7ExLEShRJpd0Pq9kqjWTxhC/esJulHzDJ5cOKP7Rzj0MSoa7r6Uj4GT0QU6miBv8K4kXuPAqnXynL
	1lwhmLSnBC1GakuF7lOIv6RmqVVhEq6izBpwPDhwhy/Ru2SWHb8tF6PxvBAS1gjouls5hdXyu2U5l
	iH6uwh8uScSvbHHe9VDL/0PtbxRdKk1FM52+iAE87dhCj4l6m1v4rp3TygwGtd5cGaUjNENy97kdQ
	g2GqoN5OPIxNA1bEjNvevzfFrtHzeem2G1jTvTQee609YS+NucuLZ1RH0NNT7CrQSo9j9JQJzuL5R
	GGE43Y8enSfW3maVmDew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxcHh-0007HM-Uc; Sat, 23 Feb 2019 18:44:25 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxcHZ-00077L-BA
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 18:44:18 +0000
Received: by mail-lf1-x144.google.com with SMTP id h10so4042744lfc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 10:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8d2ksKb0t48p28IFWm7MH/ppMCXWwhhG5AAHRnK8znU=;
 b=DliSCpHVfit7CLu8Cq67dYqtBy93yokwUJ2RmSFkzMETYURa0PMyQikMQQ449CY57j
 XIG9hfUxxIFS5DCY8gUIMf6Y8XZs1A84HZOhRR0NYgg/r3C1+6/55Ey6xD/afr4qcpdX
 AzbHtipFtDntlZsjFmjs87Di5TLo8PZVq+R9rconCaKzaxCYb4EANTuuicXZqS+mbXSO
 fwqHycLkLcIqefEbEg9m12SgtDXfNtFgBcjRQ2yyKP2p/hSxVMiKgyYW9JToCR/5q+kc
 OeTUCWwjfGQapL0g54KulXBw/oEHh746/W9Y4Im3bbN1gj6NSsqxlCM91BA5wTYuBh/9
 hdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8d2ksKb0t48p28IFWm7MH/ppMCXWwhhG5AAHRnK8znU=;
 b=GREqOpcQIYhnS5SAu9N77DhaXYrulO3Zv64dL90gzlBToesouvRDrjXuF/eM0aCKmH
 hU+8KKWVLuKx34+A2JpKHK4qFcrd/CjoRDa+TRhpniMRLMo7m5SOmc798b9CE/yGhZRv
 nxYd4PGoo7H3hXLxsI/vs7UKGlPsIzAqOglIhhclPNUvlgCWT6g4b8MSoH/bFT+u4Y0D
 cHgJekVPWign/btUNtSoczMxHrfSl7DzSk4Wq/0uVxL/mscx6f9Z0hlIunTc4cjBhTNs
 M7U7syi7x6AS8qmKCix4Lq7tKUYTwnTm2Rp3X6J/IqctHsSZXb+EyvAIH7SzbO5QCN6m
 acFA==
X-Gm-Message-State: AHQUAuY83AyWzGg3MJ+vnrZeMyRUdKxAI00m9w9kmphYnTiW8WF+QfVr
 h28E6QHW4YnTETOcxeemPgS2Qwl/e9Q=
X-Google-Smtp-Source: AHgI3IYNjELnXE7aCiWX8XQsNopW4gQTGBnWF28Fqg7i2yzaSbL0HFE3irGg8JQLJP7iIM90aG5vCg==
X-Received: by 2002:a19:f704:: with SMTP id z4mr6052902lfe.10.1550947453439;
 Sat, 23 Feb 2019 10:44:13 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.184])
 by smtp.gmail.com with ESMTPSA id f141sm1594305lfe.64.2019.02.23.10.44.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 10:44:12 -0800 (PST)
Subject: Re: [RFC PATCH 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
To: "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)"
 <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Marek Vasut
 <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Rob Herring <robh+dt@kernel.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-2-vigneshr@ti.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <abff6b0f-af53-b712-c0fd-fe7c9fd83a56@cogentembedded.com>
Date: Sat, 23 Feb 2019 21:44:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-2-vigneshr@ti.com>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_104417_378463_4B773FCE 
X-CRM114-Status: GOOD (  18.96  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 tudor.ambarus@microchip.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> HyperFlash devices are compliant with CFI AMD/Fujitsu Extended Command
> Set(0x0002) for flash operations, therefore drivers/mtd/chips/cfi_cmdset_0002.c
> can be use as is. But these devices do not support DQ polling method of
> determining chip ready/good status. These flashes provide Status
> Register whose bits can be polled to know status of flash operation.
> 
> Cypress HyperFlash datasheet here[1], talks about CFI Amd/Fujitsu
> Extended Query version 1.5. Bit 0 of "Software Features supported" field
> of CFI Primary Vendor-Specific Extended Query table indicates
> presence/absence of status register and Bit 1 indicates whether or not
> DQ polling is supported. Using these bits, its possible to determine
> whether flash supports DQ polling or need to use Status Register.
> 
> Add support for polling status register to know device ready/status of
> erase/write operations when DQ polling is not supported.
> 
> [1] https://www.cypress.com/file/213346/download
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

   Forgot about one thing: tags like S-o-b: need your full name,
cfr. Documentation/process/5.Posting.rst...

[...]

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
