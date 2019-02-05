Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB1AC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:25:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4E4207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ISyxPhdr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVtLQpYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4E4207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uix6uMGZ6s3f/aTlQTvNzOUaHYTot1nU2GHVc0iq/Ks=; b=ISyxPhdrSAZwfGbmM04pYB+rL
	wlkZ3VMSfYiUZwOT32NBCgbmQU5/Ri/wyu6EgCnw1WC0SzQOw/DkZJULNwuT0W9yHwE/iVY2x/jRr
	C6oqg7UM/MyJ4OEFPI7XaZA9fIpjRx+9Zqk6kmkdLVebmbnjrUcTiRotTUQ6AfTTljKgLJprCpVcX
	qO6NrT1EWn+uoznfEcXFgQABgz2TXqqGyXnxV6WPaViJcTesrHIQbOsGK4IRirSklW9iulm6POOTb
	VNeyNnJrgr3O0d4VGV3HowtzWi4di+8WPAJoWU6lnvpx8TeBt3Yu7pXclRPpbXqzqaWIzUqSDe9ws
	hGZFOnM8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqyqu-0007e3-Fb; Tue, 05 Feb 2019 11:25:20 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqyqk-0006r0-Db
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 11:25:14 +0000
Received: by mail-wm1-x341.google.com with SMTP id m22so3226237wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 03:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=H81CsTKITV3FWmJzwgJ/ocfDDsIlt6Hj5sCGX2qZsdQ=;
 b=FVtLQpYiKhhtGgbVmKdAWTNylIBNZDP5uAQJVop9FwT0856pJ9q/mp/ebaiGnP5aFi
 LNULZdwShLjh5yLcJc0VO0qpjxcCrYjXno3+Vv2aCfBC8l2F4EcdFeNEbjTPrjLMT5G+
 yiXpsLB0tNsIcl3ytFD0wKgVT24Gej7+cQpF2zH3TrE0iY2kQ+VS/eKPdjUSYNeUx28E
 eHmU8PgtQ48HGQ4521wOPmFvDygmNJDx6W260N+2XLlqMol2ml5FdmasiKD3iBnWlCZj
 blZM4F/wBLrS5V0LCAspdY8Kye7Nz6zskitL494dZVlwuaKcEhJaSziRB/GVnnF9n+a1
 NVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H81CsTKITV3FWmJzwgJ/ocfDDsIlt6Hj5sCGX2qZsdQ=;
 b=FKsgcgs9fYnppSLUATkuPHY/C1ysM3o/3XyiTB04ECz/RxoZMBNnd44Iwm+p2epDj5
 JmIVEymsl+lz7liCJMhAR38gF+lcy8aulEjG2x1wfTrO/5z2I6a6ja11NtNrekElQa6t
 Ej/XO39giwxrWIwyHKba7VW4vNestIbvYwRowQ5LnJAiOT8nEkd26D9uNVjQjUAwShDC
 HbkWN6+ZMyXMgj2cD1bdJbzAXS2f/5uzQUbbW78dI1hNRh2V6df4nXVfsJkig3sxqzpW
 hACeuuEY+LecU+4dCFCfPTptOjXkodAcwHpKq3sYCX8t3ICQNyyND+3AzgLavi8mDpjF
 CF/Q==
X-Gm-Message-State: AHQUAua/adecRzfcRiFuK4eol4SWMX77uy9ANSMDLHvi6ri0R8jvLQRu
 O9wdanHX7O3hUZsTVw6EBJFiYg==
X-Google-Smtp-Source: AHgI3IZXL9szj2pFBhr/gC5EwYldeMfF46/MYbL4LqoUaqtlfz3kJ4DvU+c9Rry9XjubUXFtgzX13Q==
X-Received: by 2002:a1c:c7:: with SMTP id 190mr3501108wma.74.1549365908643;
 Tue, 05 Feb 2019 03:25:08 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id a62sm16056424wmf.47.2019.02.05.03.25.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 03:25:08 -0800 (PST)
Subject: Re: [PATCH v3 2/3] dt-bindings: nvmem: Add bindings for ZynqMP nvmem
 driver
To: Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
 mark.rutland@arm.com, michal.simek@xilinx.com, jollys@xilinx.com,
 rajanv@xilinx.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
References: <20190206110721.27765-1-nava.manne@xilinx.com>
 <20190206110721.27765-3-nava.manne@xilinx.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3fdea48b-a3dc-a4d2-2fa6-b1128576ffcd@linaro.org>
Date: Tue, 5 Feb 2019 11:25:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206110721.27765-3-nava.manne@xilinx.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_032510_912338_A3162C28 
X-CRM114-Status: GOOD (  10.97  )
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



On 06/02/2019 11:07, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP nvmem driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
