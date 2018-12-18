Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6C7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F16021873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rq3mmTdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F16021873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a6OGFq8MkYzDtiKnZ0M15dSMG13jH/0v8MusYtZMz1A=; b=rq3mmTdXoWLVDt
	NwCMTrcKiggXH4GRNiHqqDXmq8LaNaTWXw1o1W3xIWjk/EETJAE7Ao+uk1oUgt7znj+LhxBVnGhRr
	6L7DaRHLrmYjDeAfNT+bEPmxNpSgwS8kN5Ztz/hUhFPlAGrsFLnRE8OLxoF+VeVdZtpPfEZKI5STm
	z5QG5pOM4IVULxYeyKl5NchldjNurQPxmC+wLiOZKex8gleJzMRTE/0oW4pnBTFaBQaD8p+2L9DQ+
	mdidALPHWtTGJIHKAATcFZFuF3EMYpXe3hLTBeQZPTBiXP4KCagmd9RiGjRH17A4ievW64jKjwiXr
	rx1Qe9IGgUcrRVNbYJyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZIv4-0005w0-Mb; Tue, 18 Dec 2018 17:12:34 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZIv1-0005rf-Lc
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 17:12:33 +0000
Received: by mail-ot1-f66.google.com with SMTP id 81so16367326otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 09:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KBkFXO7YRi0BzUDvdPfXCxza792mvEiWPj8RaAYEA9s=;
 b=s0cCcKGceGfWfhy0QZ0L2LKNZVp3HFGp6wQYBeCR2U/i5i4QPAhOTDnor0pHrUBx1T
 XjFlSjlAM6nOSObUzP82FezueeCsodzmQaZmDqtxbgcIPP3lftOpFE4RWKVferjPJLX6
 DOO/M+2BN/3Xi+sFz8NtJshUvA6yzvOG0+Mbmrs6pwQaM6IM50GQKZl0oRHc67RBqWgS
 +rU73Vdd3R7iZhG9Ka9w6DHU5wt3vR7YQtxnrJQdcdpoZ7I/6DZhZOS/o0Wi352tBgaI
 0cvMmbvXULG5yzxuvzebMJ5+r3pxGxm15e0veFffKVvtBplByGGpLAQjLyEZWQ5FDEPF
 ShEw==
X-Gm-Message-State: AA+aEWa+91fPc79IcT8YWtqDprn454CwtU4vs9BCGZ3SQwXYnVokpPj2
 6l0SPrj4Hy7OIJtWTrQsWA==
X-Google-Smtp-Source: AFSGD/W0RbkhQE/hbR2ucUC5FLqh2omYCjayYQThSOC+2/XIkt3VxfOMEbKGUOKyxIvQBk2Jrtrygg==
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr13640993otg.74.1545153140609; 
 Tue, 18 Dec 2018 09:12:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id h24sm9612983otm.72.2018.12.18.09.12.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 09:12:19 -0800 (PST)
Date: Tue, 18 Dec 2018 11:12:19 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: stm32: syscon: add clock support
Message-ID: <20181218171219.GA2223@bogus>
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544604495-4082-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_091231_699918_480AD676 
X-CRM114-Status: GOOD (  12.00  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, robh+dt@kernel.org,
 mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, lee.jones@linaro.org,
 gabriel.fernandez@st.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 12 Dec 2018 09:48:13 +0100, Fabrice Gasnier wrote:
> STM32 system configuration controller registers needs to be clocked.
> Document clock support on stm32-syscon.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - move clocks to specific bindings using syscon as per Rob's comment
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
