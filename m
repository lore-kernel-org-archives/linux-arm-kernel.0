Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4E6C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:45:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4DB2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A0udDcJK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="yRDAgGEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4DB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cGtEQrdeCpD1vETvaq+ZcOt1cw/cGZsYeUqA8TI77r4=; b=A0udDcJKWsjcwSkkmMsrmeu73
	Z5ThFZ0r/Yqn6SfXxyHiVXZY+9MvoHQ9gQtQRMs95SFdJBZ5kDtrRPFay+iMvSQXyWbNmgwoKZ63C
	nhnavmz79sZcwYANlSbtuUgF6Ry6F5EQ8iHlaAezuj65aaC+2Uy+WTR2CY84Uhp5k0DzD8nSU10IO
	BrvY4op5XzSMQEeHYJ/zW+rMUAJjXWmHoykDWAYJhuDwXOaYOmWsAsU3ZzE2LbyeLEyoL/QhkR4wf
	hhWC8p5eOwXxCvflgdw0tVBfjVQBoUiWZBcS/jVM2Htbwxy6E0XnzAczMfkZ2PuzLdEDBFmTW/PUZ
	amJmxAf0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmwBW-0003sF-0m; Fri, 25 Jan 2019 07:45:54 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmwBR-0003r4-M0
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:45:51 +0000
Received: by mail-lj1-x244.google.com with SMTP id s5-v6so7526891ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 23:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L0lEpHFLUwZmc696tCbiA8DFSiVWc0cPrLdAUUT72so=;
 b=yRDAgGEX4MZXJ9xsugpkN5oXil1gMBARSbvV0bYpgKEkzVIdi+xYDJt88NlPWSvpVc
 R35XLX+9UkY7DPDyP8/+VB4SH35BS2WOnBtp0SUwdFNkAUsBV0WFZG1OroJ9XInp7dgw
 5LqlpsH+aUYOy8AZEJ+T3RbyivyvMpYPqNQ3nIHUpyq51FeTq2TrbSrFaHg1GvzgTCrd
 tNBL8ajVX0hhSSyiDq5P0XZKXQpSqK296T1X/JHtekKify4CX+AcfFg/7Ognu6HjL1zB
 WY6VuRrDJpGLuTK0wUF3DE2Q8wjSM0GuvtZOfQlOe/KHbOwaUy25jzYchn29QgFIKy3W
 Q3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L0lEpHFLUwZmc696tCbiA8DFSiVWc0cPrLdAUUT72so=;
 b=AgpJhdw/2vNs3Izrk/S/NVdAtq2jXPvVaDmsUPo5IOANX6xM/u3QWi/N6ahaCCAKsU
 2xfoB1ZRPgjt1u0AZKCzW/scU0cGflx5/nI+bT4BjyMtUkgCCQhSDUhUrJl+IBm64oKM
 ypcBzEw302Fa6DKfvAaajoiopkuDAgLLR8e0I/H3CrdsWBBo71OBYaKYj4HMQmusleb/
 YJjAi/UfWx6iqzBTl/yrKFjBwMzJxDe2Ry9enwexxAbo6yr5p8ONQzCGABUHDXNed6l3
 MM6E0v7lj1+1AABOhig6+fFcTzs49ynFNxwiFZowkspdelvOZInQw1tM6kigSVTbTESh
 4r3w==
X-Gm-Message-State: AJcUukduySVp7Q8yWZzTk04CFM6io6jLqHZmGrqFAztskDNegEAicOrC
 0viHxWSTyJjhw8UVUTVKaKwl5Q==
X-Google-Smtp-Source: ALg8bN7UJkt4hsqlHF4Y4QRPrZubEPmH5pskXbqZ+ZuothJGHreE7chU7qYKeZCaLyejb1TbOhBvCQ==
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr8627818ljg.64.1548402346650; 
 Thu, 24 Jan 2019 23:45:46 -0800 (PST)
Received: from [192.168.0.199] ([31.173.83.7])
 by smtp.gmail.com with ESMTPSA id z6sm1327304lfa.87.2019.01.24.23.45.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 23:45:45 -0800 (PST)
Subject: Re: [v4] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to the
 list
To: Peng Ma <peng.ma@nxp.com>, shawnguo@kernel.org, axboe@kernel.dk
References: <20190125033221.30333-1-peng.ma@nxp.com>
 <20190125033221.30333-2-peng.ma@nxp.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7c0ed8e1-7d41-8594-fd9d-9e220cbb2ab1@cogentembedded.com>
Date: Fri, 25 Jan 2019 10:45:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125033221.30333-2-peng.ma@nxp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_234549_869662_1ABF1543 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, andy.tang@nxp.com,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, linux-ide@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

On 25.01.2019 6:32, Peng Ma wrote:

> Add lxx2160a compatible to bindings documentation.

    lx2160a?

> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V4:
> 	- add lx2160a compatible to bindings doc
> 
>   .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> index 7c3ca0e..9ecc019 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> @@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
>   Required properties:
>     - reg: Physical base address and size of the controller's register area.
>     - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
> -    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a etc.
> +    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a, lx2160a, etc.
>     - clocks: Input clock specifier. Refer to common clock bindings.
>     - interrupts: Interrupt specifier. Refer to interrupt binding.
>   

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
