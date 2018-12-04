Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD99C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:50:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE26B208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p5hPdeAE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eX3Z2FAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE26B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9ssencaQgIwRqkI2AqGE0rtqrs4ku5kvvwaFSunEW/I=; b=p5hPdeAE9C4hCL
	HEuFqT+DSUWbHK79ySfpybZgj7eKOhTXiRkvJIw1Eobv3E8VWhuKECnbGnTe2eQ/rJa3hdIcrk/7p
	yQfqA0M5ZIKGSRUvA1crX15lDn4Hajs8xdoid+vpt7hQsUp4fZ5EABFaa8GC4dOpBgvGdoNS1xY4X
	iLjc04hUF5wMq5I+NV6ySNwND3sdHfFIPgwP454kXimHLQTL5v++wvlEe25eiQdmSbDmarJT528Oy
	wYSp4F3yTH1n2E3hYjFa+Nym22E2MZdatHg+OSOntrdb/pK4T5D8nSCCPSt8DiRZcXyN3JBTynG/6
	9KevwHxr3MNZRkeGRIyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU2fH-0007Bd-C3; Tue, 04 Dec 2018 04:50:31 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU2fD-0007Aw-VS
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 04:50:29 +0000
Received: by mail-pf1-x442.google.com with SMTP id q1so7570269pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 20:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aYO/z386VNta4UctSXviaV0eojIktFtruslaGj5T1jA=;
 b=eX3Z2FAPyiFwfJg39MtL+iaSaMbHj5OFaKHUeBBI8VONTld5bQeEl+26bNkGxuU51S
 XgvuDbL7HxBHD4gIz7si8AJ1OMQaQrIlKubdmm3qn0v/MscqixrDa2z8djLd5QBXT61F
 ApycqKdmLQDS/PHpC7Epk0rLYyUaBd9M++tcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aYO/z386VNta4UctSXviaV0eojIktFtruslaGj5T1jA=;
 b=i/CHgfk7X9t5RW58ImKPl/pCgAUnYXAjNZuPH9fB6kVVioVO4RnQdwnm8qZNA1XXms
 reCRNbHHwJx3PGuHPx3l3Qnxw9GSSRCvaHVf0eS3hEWGJqW8JuPvq6gcS5/1w0Sb/2mw
 3b+YzPCq7wEdIR1fEZexZrHlJPpeRaawMVB3UOX7VlanYrNraQzu41739+bTRA3/EbBy
 LLH4fyD9FBLCC4GKFb+xIfjWMf1U20iVII74CMIkCi0s1+Aax5akt8DUui5H4aiq4V8e
 qTAk5IEmZWrNgtIb+fe7K1K4+W7ByjneOlRfecowF7n6Gq1piafh03UKldm37uogfTI2
 v9Ig==
X-Gm-Message-State: AA+aEWbcraBITTeqjLuYoqyZeVI/SVcEoxjHmXKCp5JZP5YkhgNAQu+Z
 eORMP2bzlOJMjbi2yUFbgUp+Bw==
X-Google-Smtp-Source: AFSGD/UAX0MAs8RNeAxBsaKCfBK/eDrOFZA8RfH7eX2u6cmuW/MmsP/VKckyuTCgd4W1+CBAkzYiDA==
X-Received: by 2002:a63:df50:: with SMTP id h16mr15715043pgj.421.1543899016897; 
 Mon, 03 Dec 2018 20:50:16 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id v184sm19346547pfb.182.2018.12.03.20.50.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 20:50:15 -0800 (PST)
Date: Tue, 4 Dec 2018 10:20:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 28/34] dt-bindings: arm: Convert SPEAr board/soc
 bindings to json-schema
Message-ID: <20181204045012.gy6xs7nggtcurdu5@vireshk-i7>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-29-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-29-robh@kernel.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_205028_016903_BC4209D9 
X-CRM114-Status: GOOD (  11.23  )
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
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
 Viresh Kumar <vireshk@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03-12-18, 15:32, Rob Herring wrote:
> Convert SPEAr SoC bindings to DT schema format using json-schema.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/spear.txt         | 26 -------------------
>  .../devicetree/bindings/arm/spear.yaml        | 25 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/spear.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/spear.yaml

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
