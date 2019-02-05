Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD83C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:33:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCF52080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EUIvYAtT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkpe4GaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCF52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WsByF+/qu2FeVjGhCmU6/4KwT3RmWAiKpwUmKJOJHMY=; b=EUIvYAtT0BGx3jD1NXKbQQFlA
	jEr/3dflEnxq+cPL82NEkkPgY1O91gj4TEFfqhUXVSxHjyc4r/w+o66/3FdehajSmo520S7M5KPHL
	cfvC+ROpleck5Zv39XjxC0g4T9oPQFhBFuH5noizLiYNvKD0AZ5Z+smWBrbokl6/mTnw5/sACX2cx
	vhOGalKIbYMRWUt8som2fLi1yJ7ZVPk5XJmbiD3H7U//OMVaqQyL/qlsJQiCTvjmdOYTJ158nj8pC
	5kzs1+shwviZHRPKwrZt4Md+s1Ixk9/et7X2Z6GfFhBUjakfBDla7lbcEyyrWO2vt/Dz7VW+HIz75
	IHKkA3GFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqy2x-0002iB-5B; Tue, 05 Feb 2019 10:33:43 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqy2t-0002hl-FS
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:33:40 +0000
Received: by mail-wm1-x344.google.com with SMTP id f188so3001410wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=5iYPoJKIWzATmc5t08fYys7G4ZVYqTJ0FmD9tPhO/Qw=;
 b=gkpe4GaFTNEp5N/MiEnhcto4J9ob2MYucmY5GPBeLza0MHVzhaPQopMvzCwLBuLvVX
 Ua7jHkVbh8MI74MjtLnXdw5KsST/3xm64JNzoa0V6oot8CcRzt+C4r58LIVQey5fjZvT
 yLIzpK+FbzHHS5FO1Jwkd937rEn/I1l95/pqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5iYPoJKIWzATmc5t08fYys7G4ZVYqTJ0FmD9tPhO/Qw=;
 b=Imzvu2LzkFEC/OPp82l07btY+HYvEC8jbExB8LkseyGTvnKWebiD3jXCLURLpobEdt
 RFATVhB9mrvXWIFGIp9bnK2o37enpQZTBxU4HR5uu6FTHzU0U4DQk2TGLjlQDaogEysz
 KcEa44/Y27xdTF4hgm04PT96kSvUJVr7PgJw62OIEGLdHHIs8LTFQQTSebs0WtOK8hAW
 sONfC5OLFsEcx/EgXR+2rHrzs4hiTdZvDW3XH/FNNoapyNMhjvcnkpDGv4lFOYcwydhf
 3+9ShRz5x4Yfoe/DPucxGQEyLwG+0bAfTpBmnz/V4FnTkvA2qaGrxCb2tyE3acHQNgxu
 ixZg==
X-Gm-Message-State: AHQUAuZiF3hbfDSsRPI/RqsN4ioZ7uDxaAWWuRago3MKMb/VwWkfAc1v
 KZxyEO7UyKHyy7eQPmdc2sN4m2Hz2OU=
X-Google-Smtp-Source: AHgI3IbHv8LsZ8FNKnaf7MGhzsNV/FKIPIfoqWTsMHrTrKg1pucYBNUT004qx0jkB8fewApPQoSP2Q==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr3229446wmi.10.1549362817408;
 Tue, 05 Feb 2019 02:33:37 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id x81sm12296320wmg.17.2019.02.05.02.33.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 02:33:36 -0800 (PST)
Subject: Re: [PATCH v2 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
To: Michal Simek <michal.simek@xilinx.com>,
 Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
 mark.rutland@arm.com, jollys@xilinx.com, rajanv@xilinx.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20190204070951.6933-1-nava.manne@xilinx.com>
 <20190204070951.6933-2-nava.manne@xilinx.com>
 <d949520b-452f-9e66-42ae-263959a8c549@linaro.org>
 <f317c341-9706-3a24-6faf-711f2627bcce@xilinx.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bf3f2ab4-f355-c862-f2bb-2bd579b0cafa@linaro.org>
Date: Tue, 5 Feb 2019 10:33:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f317c341-9706-3a24-6faf-711f2627bcce@xilinx.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_023339_524450_0F6D7E62 
X-CRM114-Status: GOOD (  13.78  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 05/02/2019 10:29, Michal Simek wrote:
> Hi,
> 
> On 03. 02. 19 9:50, Srinivas Kandagatla wrote:
>> Hi Kishore,
>>
>> I need ack for this patch from Michal Simek to take this via nvmem tree.
> 
> not sure if my reaction went through. Just for a record. There is high
> chance that there is collision in firmware interface. It means if you
> can ack/review that patches then I would take them via arm-soc trees.
> 

I got the message! There are outstanding comments on the nvmem patch!

--srini
> Thanks,
> Michal
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
