Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC75C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:54:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B36C21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nwEL59F7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B36C21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rBzRuRyZ99y/zTx6dv6IuIuKryrt7SxAzYGZD2jWMuU=; b=nwEL59F7sGK9If
	1bmmWJn4ySgzXc+CSJeNumPhLjTabAjSjyBYww8y/LPegNCdGmt1euB9M+oBpSVBFO9wLK91GLr66
	ssCcXfNqDMQ3ojUjOHkM1/YpyuRqrqYoYXZuj9F8G5sC1bEm6Nn+p1H3m677EKU3oxCmxi/3e7ivX
	NYtiLMQazTFQc4PXwjgpJVHnwMifh8uott84vHrnMlQVg+TPtdhr0sOYvYQ+PZX/yNksfPp1pkohD
	DZoJ9T9Ak+WLBfeo8puLtSaZJ6BNxxwpPC8yDs+FyoE/1ienJP3/5WgoHI1GyChsk2W7r0aSXY+JU
	YvCP+VkwHQKf3e3J4Vwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHhj-00025J-VE; Tue, 18 Dec 2018 15:54:43 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHhg-00023w-RK
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:54:42 +0000
Received: by mail-ot1-f68.google.com with SMTP id s5so16080465oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pqpQA/tQCpMTJLT+MYI77+ulnJ5pu9lxMggGQ3JFqdE=;
 b=GoEE7jsmZfZANrWgKZAkfDwBw+X6CYLwI+s5lbyiwKuFVtp8P8+HuOqv34JrMnMWu5
 70guSIZyux9ZrkVZ8zv0KdZV1nuOSllXS14bVBEpa7uELQc15xA4UEPM8yupK+Hnbbm8
 nfxLb50ALO4lUWOZWZLd+DOkmnPryOPQcRavGXlAJjmjeDJLNuDdtM57OUf5jNncUL+Z
 aIJsoe2LuV0GDKNvB/v12J2jbA4+/TUNjYoFmW2nH5i/ddhXMv/7Kyt0E0hqg3ghZgH9
 5Oq3VCAc+sTJVnO0xBcZOF5wFBLZidO3VBhHm4g/qRD9zyOiqsG6ZtV1GzCJLpZd8VkK
 OJ1A==
X-Gm-Message-State: AA+aEWZgaPwi0J23tOWDBzXlgUlk8bF64/7wLiyjF30kC+63Hxue1hzw
 nSuLai26mqRVY6u9z1YzQA==
X-Google-Smtp-Source: AFSGD/WNU4wbuPuv7O/eR9LjodatOw/Q60cEovcb3fuzzUJxjNzFlq5rRbK+FcgJjg/bxGwTRQ0KKA==
X-Received: by 2002:a9d:781:: with SMTP id 1mr11735833oto.250.1545148469925;
 Tue, 18 Dec 2018 07:54:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id o189sm7944889oif.23.2018.12.18.07.54.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 07:54:29 -0800 (PST)
Date: Tue, 18 Dec 2018 09:54:28 -0600
From: Rob Herring <robh@kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: sdhci-of-arasan: Add deprecated
 message for am65
Message-ID: <20181218155428.GA7670@bogus>
References: <20181207081119.29162-1-faiz_abbas@ti.com>
 <20181207081119.29162-3-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207081119.29162-3-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_075440_886743_60BB872C 
X-CRM114-Status: GOOD (  14.29  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 adrian.hunter@intel.com, robh+dt@kernel.org, faiz_abbas@ti.com, kishon@ti.com,
 michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 7 Dec 2018 13:41:18 +0530, Faiz Abbas wrote:
> Commit 26a4f38d1316 ("dt-bindings: mmc: sdhci-of-arasan: Add new
> compatible for AM654 MMC PHY") added a new compatible for supporting
> controllers on TI's AM65x SOCs. It turns out that the controller is
> not compatible with the arasan driver's phy and consumer model as it
> requires some phy registers for core sdhci functionality. This calls
> for the binding to branch out to a new driver.
> 
> Therefore, add a deprecated message for the ti,am654-sdhci-5.1 binding.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
