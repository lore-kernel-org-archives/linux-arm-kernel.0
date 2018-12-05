Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151B6C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E222D20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s6VWVq3o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HODZEPsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E222D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=55UXLTuOQnzBAkIR3D8tElejGnW8K0IcZMfE4dq8uNM=; b=s6VWVq3o1vSL5+
	78mBKCXORQFe29NX1rh+qQzc24AWMaxrPwATR1ZdTJxcaGZdyd6NameFOlac9FrxT+XI9pvfi1p/t
	SrI3ocTDFNNGpm2hx2QsdOViCmEMAMgo8ROPIC8vNT1wnXuPWy5V7SNHDdJwfV1k+QEA2tHRu4Huf
	pTO4OKH7gKHGQ/wvBwGCpamuVV9QC6sk61tIPCeYx3MOwd1YtLL+/wr1wzldWBkHncPD84lPRAJ4t
	nr1nfp3/a/I0OkNcsssO0rjnEQ32pyAably5X6LCLrPwMCYQPSpuAEwbP7oCoPm7ZYVwjNsQmq0Qu
	vsAD/SII5VUEqPt2hz4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbxW-0002R7-Ma; Wed, 05 Dec 2018 18:31:42 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbxS-0002On-NX
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:31:40 +0000
Received: by mail-ot1-x342.google.com with SMTP id a11so19537570otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KjQ36aVOOBWevKPNYjYvYEZ3HkAGFCzYyc8+nitudjg=;
 b=HODZEPsJ2mBlftE+QcwCw0nZvVzc51kOFVZBWsGKgvVZM/Wf37V4EEWJvwO9JktX5v
 tMNAF+vO3otnGV/CwrK71a2M1bGHDgviX97ple1P2LaZ10h007uY8X3vgG+3RQ5Sh6NU
 jV+09eLwY2HYYcxQm8coOal9AmpKqbciK/inM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KjQ36aVOOBWevKPNYjYvYEZ3HkAGFCzYyc8+nitudjg=;
 b=aTm5NRfRojjJetEOdqXYXsuj1gCryhE5cow6OrFkmFVhEIzFD9wVpG7LQD1MCRMKfk
 KpPjoprvbmY3s1lLFEGIDMfcmqV6qgED3LFJPRU8Lh/+QNK8c06PKpMZiOSkPxOFcKPi
 61PrDoCFX4ZzHIFNfgCOSMX0+FOD7yHem6XNFgCE0odi8fAw7iHC76aZ19fDrgu9/wvq
 QfPgdlV9sayHSbPh3sDJ6gV5F55iJgsvq5xuH2nFXleV3iDRwkBQQhTQxxXm9qjJOmw5
 gOkQC+iOrq13gwSFLzdfLYQWZbaN+dC58UkaBAEKh6svZ7yM1PhmIbVPJx1zqnD+QUVX
 CrEg==
X-Gm-Message-State: AA+aEWb/acPCB3uO1+GEQ6nv1MvSU278FK/rDXR4ESc3zpl6dLafRr0f
 5jXPyfL390ctR4tSNsqRnjq6zg==
X-Google-Smtp-Source: AFSGD/W0PEg+UScYa9ARunJVtqWLgGPe7FMOhDRUMPVP/U6OOSGnXTHRUvDUF0xRvQvjMrPLh1SROg==
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr17155795otl.319.1544034687190; 
 Wed, 05 Dec 2018 10:31:27 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:545d:d91f:9ae0:9fd8])
 by smtp.gmail.com with ESMTPSA id l108sm8155569otc.23.2018.12.05.10.31.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 10:31:26 -0800 (PST)
Date: Wed, 5 Dec 2018 12:31:25 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 22/34] dt-bindings: arm: Convert QCom board/soc
 bindings to json-schema
Message-ID: <20181205183125.GA5497@hector.attlocal.net>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-23-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-23-robh@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_103138_768606_ED9D1FB6 
X-CRM114-Status: UNSURE (   9.57  )
X-CRM114-Notice: Please train this message.
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
 arm@kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 03:32:11PM -0600, Rob Herring wrote:
> Convert QCom SoC bindings to DT schema format using json-schema.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Andy Gross <andy.gross@linaro.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
