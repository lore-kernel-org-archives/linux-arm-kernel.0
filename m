Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E36C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001C72080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZPnicp+2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="O6yeEAUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001C72080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/xYidc3wratAVokOrnueLr/WyS/tGxQe52CGumTX4K4=; b=ZPnicp+2LvzKC9
	lRFCCMzMBAlCPp8CHrk4k25jNYkxf1K8FAxGVrHyoeIgId7iLP973G4iB1XOF1xw2BBgdqTErK5ot
	ypV0fvShIMPTWT5h5bKb3T5UNzYahpf4jc6d+MrCZGhoPisg4z4NIkrInSgyu9qUEh1/Ulkqsqawy
	Y+ZwOodwm/09xFvC0c5tv9rkaTVft4tcFw9W0To4g/dzbnXbSnWhuAGj747QV11aHNga5uwDx0WmF
	4qz78+w84FnHi8FeQ9cyWeAQy0+1iPKXUj14I1ZMQnOckrtAFni11lTa4wmysHxBOtezPxGrvTDSU
	h1XaSgXQmpTqyyPneujw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKrV-00050y-15; Thu, 13 Dec 2018 06:52:45 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqc-00045j-Li
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:51:53 +0000
Received: by mail-lj1-x243.google.com with SMTP id g11-v6so799354ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=f+dqQ+gQRatgd27zUadLvVLrqMLHrjFK7tPpkgqay+s=;
 b=O6yeEAUp+WcqdsHc4ykm2UDHbBkNKjPjBjiYjedaR18NnVPVJ6DBVWD6ZqRYE+kzSO
 U3DwCUtiSnUc4onCnhwWDIrKHlXTMfmW0U2Qq8j41s7rXhYS6Uq2gX4bEySAeuviIgjj
 CttzfQDQu+8LaeynN+Bq936ZDM46dFDvxBundj4JYc54ZCsUMB5hXu4Ex/oAjZ+aM8wp
 CU5aJSrXZhY251mdsVhegRtrt8GaMKZ7AVi/WawuM/2A91by7VkhagkosA8zHrI8J6iQ
 hy71nq85elB/WyRp+wuVP9B/w7uTIkOJeNbCk6QICx/84fhn44Hdh4+WKt2dZu7Aaidd
 dbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=f+dqQ+gQRatgd27zUadLvVLrqMLHrjFK7tPpkgqay+s=;
 b=O/QMB1pdJEecIC7Zg6w+UMW7FC8j+Sp7HEDx/ZBKoJHJPGjiSblzftTKVU8cqyJTqJ
 1tEYUGxlVR3CtNJcHD04kpmDXCgP5wylmhqMhl+TrEjL2SCe7OH6a0R2OP2Cn+hOWmtU
 0P7mDOYruOetgljiDNAuXDnOPbo5Yxn3vAXsXER40jv+3OqULLfICmXgEolIptYi5gsO
 u4MR7SYxWbNRmeoxjkrl9NTV/oC8xMT713MPf0lLiWUNIRo74xv22oRMxlrjJ6fhsDa8
 VNsYY5OzbVuEeN0PtTxxEFD0MArKtL+ic8NghajMkgT0NyWD10h8jwY4XXBINpT169zR
 28Lg==
X-Gm-Message-State: AA+aEWa0OsZlnpzAw6S8DfV4P9aZXQgKl7UbbHHhgf0xsS8WuJcBIn36
 I+yqnTdgsXyvGeecnLXmC3VWYhtinzZpOw==
X-Google-Smtp-Source: AFSGD/Wi7FFI2BAbqsQFgx1NvN7dDhywGpU2sE+7AMxg/55dvU1CJ72zF1mv+mZG5ADUftP0DutxlA==
X-Received: by 2002:a2e:9e95:: with SMTP id
 f21-v6mr13796777ljk.128.1544683898574; 
 Wed, 12 Dec 2018 22:51:38 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b17sm180280lfc.21.2018.12.12.22.51.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:37 -0800 (PST)
Date: Wed, 12 Dec 2018 22:47:35 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 6/9] arm64: defconfig: Drop redundant
 SND_SOC_ROCKCHIP_I2S
Message-ID: <20181213064735.j3l5luli7hzkwzcv@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <f893ee9c-210e-8dc2-8660-fc9a9b2a567a@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f893ee9c-210e-8dc2-8660-fc9a9b2a567a@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225151_343311_35562CDC 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 09, 2018 at 02:03:55AM +0100, Marc Gonzalez wrote:
> SND_SOC_ROCKCHIP_RT5645 selects SND_SOC_ROCKCHIP_I2S
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)

This one got covered by patch 1 too.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
