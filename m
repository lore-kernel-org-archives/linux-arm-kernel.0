Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9896EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:55:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6684A20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ejw7VNeX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7UPG6PL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6684A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iy+L5vt9XLAaEaqIsznBMS+Z2dtYpjsBB1WXAdsnQs8=; b=ejw7VNeXBAynq++mFXkuISXSa
	iuJZoThOyGR6Q+W0DQGp8jaQhsjaidcqQc7WLzokYDHDvBqyjBcwipdwkC02KM+sfkEq6P8GAHAej
	ExreFi2Lagldt8PlC44v9SZp88FRyv0vsKnNwfCDtjYtIpS8Kp5F8YUNhIun7M5yDvUqvQcxSnWnj
	qyTa+Sk7seltpCVhZq330ajGUS2aR7/CJ4SUA82YR0IwKNe9jHnD6YNSvsACUCnNOEiuI/aD1hz9H
	+zbJQZe1Viwed3U7b3tkApQI98sfR3TqNYDSiHXnkODLDndqrRSNjCtM+y+eDTnf3FoTVNkOUvIai
	YRVK07dTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonWG-000514-JN; Wed, 30 Jan 2019 10:55:00 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonWC-00050M-FH
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:54:57 +0000
Received: by mail-wm1-x341.google.com with SMTP id m22so21207724wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8sWiLl1F2ySwwXThQumwD88+HU+lGvuWz2LP/AEShew=;
 b=L7UPG6PLGNmPJAHCG8TvmMFub++pEovw0UcqePMWbuuIqVzS4U0S1XwgUvQYENo2VT
 sB4Nv7TnGUXIwI9e3rRKdJBAfGKDHLh+Tm8X4RESwriB0b9gyPXa1H0eHPxIpj70dniB
 X7X9UD8ax68WOZRs2zM9OBMsreXQzk8fu2Y5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8sWiLl1F2ySwwXThQumwD88+HU+lGvuWz2LP/AEShew=;
 b=jrPLT3fJF+R5Qcxw2H4B2N/g9xPVsKLhDzz0MfMlQzOovNakBMlKRMmjbHs2NJXBl2
 YFvq/quwUjn9Oh48dKTcIv7VrakGmHLMzHMoyBNylIY8lGsUuG7vAhbLZSlsdPV6sR8H
 qTuRUAERIUMmX4kRShifqIma9VR8cIA6Glla+FFC6FnAp5PDVj1+1KEHoaaE1OosY04H
 g/nXGWypsxVD0YEpnGvcWR8zHR3g8Z6/8jalxBmKLKyyB88uzwDROoenuvB6jx2Fzcx6
 wzX4/xsRCLv0p4i9gUPBXV/gpeBhg66J7XHy9WL6bkV6M0MPTXTKtOHUhPJurSW3Lyfn
 8XCQ==
X-Gm-Message-State: AJcUuke3lX4DtvOoxvuMqzB9LJmKnYG2noEsC1w8wFGbQjV5Wf1sdlxe
 nLsTQ1EsI7aHUh8xuRXLUQgrOw==
X-Google-Smtp-Source: ALg8bN57PYsj5cVrJh06ZJVX7ex+xJ1bM8G46LAIlpM5dDYSePEFNhRl28NavbEIPL+3yz8qq5kyJw==
X-Received: by 2002:a1c:f909:: with SMTP id x9mr24533816wmh.108.1548845692194; 
 Wed, 30 Jan 2019 02:54:52 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id 133sm4184119wme.9.2019.01.30.02.54.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 02:54:51 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: Add Adreno GPU and GPU smmu definitions
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>
References: <20190129132335.30695-5-srinivas.kandagatla@linaro.org>
 <1548806314-31788-1-git-send-email-jcrouse@codeaurora.org>
 <CAFp+6iHzpZ70_qH9wvu=H_oSxVjoPXRaJ38kR9G73TRZXb5t5g@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e209fc92-50f5-8368-8735-70c56d72e5f1@linaro.org>
Date: Wed, 30 Jan 2019 10:54:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFp+6iHzpZ70_qH9wvu=H_oSxVjoPXRaJ38kR9G73TRZXb5t5g@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_025456_529715_0574883F 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: Andy Gross <andy.gross@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks Vivek,

On 30/01/2019 05:32, Vivek Gautam wrote:
> Hi,
> 
> On Wed, Jan 30, 2019 at 5:29 AM Jordan Crouse<jcrouse@codeaurora.org>  wrote:
>> Add an initial node for the Adreno GPU and it's companion
>> SMMU.
> The SMMU node is in another patch, so may be change the title of this
> patch and update the commit text too?
> 

I will update this and send v2 of the series!

--srini

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
