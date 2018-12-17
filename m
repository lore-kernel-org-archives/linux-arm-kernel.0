Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:59:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3252145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R2H7YvxC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="edYPBro5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3252145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3w+caJ2/FCFfb8bpNz5IYO9QoD2onCqShqRB3dZw+Rg=; b=R2H7YvxCN1B13H
	aCTru1DoH/cGgYf8V1VSz6kQ2kHHTYKn/dOF+Uss4Y/xgErD1OMOSGYzZa1y/OYxMvIoUyPDOYCSm
	KU7kCp7f//WxCwdzuGibnK+AOY4NtnW17f/xaH1SR+a6yF1mDVdfIY4z4uxWzoH2+860Z/fqQ4EvV
	EfF61QU/1kZipDXKMCSRBMgsFHfaJ9kVuxbm8Ij3eXEV0b5zKQJ0tcH/GLFTcboJ1LLCTjOQ2YeLB
	MlqmMzoNw5ZdEtkXooyM3dO1gBiVUwH4KqNkxUbG+XAeENht3Q1ADvplzctNVx9d3cps/KfgudTrh
	CseSEp0Mjr+utx3mzRcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtQP-0006Ix-KI; Mon, 17 Dec 2018 13:59:13 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtQL-00068z-8k
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 13:59:11 +0000
Received: by mail-wm1-x344.google.com with SMTP id y1so12403429wmi.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 05:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EFwU6j1ZKPA6YrvWcaC1xiIPl5gf0Ek5GTKWMai6D60=;
 b=edYPBro5ALtSxtXjLp8IE8ecA+k5QKCj7P+NO2GKYOAHnEbFxMVDOEmIKz1o+ecoCZ
 db4Xi256QAD8JpwBQWmNZe9MKzMXUOw/Ma6eVkkQPnV4+EYwH1qbNxBJKqmQ8C6BKB8O
 lUE/rVgCu8BL+6fkcs2ThVG9zj+/7OEXpU+5+A4dh1SzcclzBtaFrxrbsN4ehuY6t2/v
 vcUSDNO7c3QiTC9/BNJQyY5qUBNf5EmrjoWZFWs/OfiUVnAa1jr6K4vtdj/u9dvqqh9q
 P1RBJtaQ89fC4LxrUjbobPAEsqDvSJiIAuPiJW8i0UfjFvpdVpuZ+/G6ZXXgokYD53fb
 y0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EFwU6j1ZKPA6YrvWcaC1xiIPl5gf0Ek5GTKWMai6D60=;
 b=ZfPjkV6UcoSac5l6CXClIX8Y0uM2WX4yE8E+mXochydpQij83QBP3UaQlzVVZO/sYJ
 VtudC1rfyrOTo4VOScKqC98mug3x+Lxs9s//uGjNtyccySPa4UZWKpstnIUBd1wi4XTt
 wQJ+0ve+iLpO3jgwOlyriqGwwFZQQEaA942ZDoseMqmeWC1ul3KLxRl3APn02uJTaFwE
 +OWEhpp538sTavMKe2R2p8SV48q1cqDFykHad7v71JpPnT3OqgvQ98Jy7uKYA/nyXOkn
 B6XE1F+2fJ7m5Nt4rYYAhM24+QWyLM/BHPDlLFQdbJdPRn2EU4ms2f3SfDu/9klPqJBv
 4WPg==
X-Gm-Message-State: AA+aEWaEvTLVBbUgzWvYCnLjl9GbznPUKZ1hY70OrlQagTGD3Cs3SjsW
 9SV6pKsr6E8Xry19G72I8DPNCQ==
X-Google-Smtp-Source: AFSGD/XEnNzVk61rVpA3Fs7dvNin5vo6fFLvu+2JO/G6GFUZ1r8V9ePZwD6CEPOtSFnHcPRMZerGfQ==
X-Received: by 2002:a1c:8cd0:: with SMTP id o199mr11023930wmd.56.1545055135358; 
 Mon, 17 Dec 2018 05:58:55 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
 by smtp.gmail.com with ESMTPSA id z206sm10726374wmc.18.2018.12.17.05.58.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 05:58:54 -0800 (PST)
Date: Mon, 17 Dec 2018 14:51:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: Re: [PATCH v5 0/6] net: lorawan: Add LoRaWAN soft MAC module
Message-ID: <20181217135119.GF2096@nanopsycho>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181216101858.9585-1-starnight@g.ncu.edu.tw>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_055909_314436_C6335CC5 
X-CRM114-Status: GOOD (  10.98  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 linux-lpwan@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan@vger.kernel.org,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sun, Dec 16, 2018 at 11:18:53AM CET, starnight@g.ncu.edu.tw wrote:
>LoRaWAN(TM) is the MAC layer defined by LoRa Alliance(TM) over LoRa
>devices.  LoRa is one of Low-Power Wide-Area Network (LPWAN) technology.
>
>LoRaWAN networks typically are laid out in a star-of-stars topology in
>which gateways relay messages between end-devices and a central network
>server at the backend.  Gateways are connected to the network server via
>standard IP connections while end-devices use single hop LoRa(TM) or FSK
>communication to one or many gateways.
>
>A LoRa network distinguishes between a basic LoRaWAN (named Class A) and
>optional features (Class B, Class C ...):
>* Bi-directional end-devices (Class A)
>* Bi-directional end-devices with scheduled receive slots (Class B)
>* Bi-directional end-devices with maximal receive slots (Class C)
>
>This patch set add LoRaWAN class module implementing the stack,
>especially the soft MAC, between socket APIs and LoRa device drivers.
>
>socket APIs:
>send and receive the data
>------------------------------------------------------------------------
>LoRaWAN class module implements soft MAC:
>append the header/footer, encryption/decryption, timing slot and MAC
>commands
>------------------------------------------------------------------------
>LoRa device drivers:
>send and receive the messages for MAC layer
>------------------------------------------------------------------------
>LoRa devices
>
>This module starts from simple and implements partial Class A
>end-devices features defined in LoRaWAN(TM) Specification Ver. 1.0.2.
>More features and complexity, for example regional parameters, confirmed
>data messages, join request/accept messages for Over-The-Air Activation,
>MAC commands ... will be added in the future.

Could you please send new patchset versions as separate patchsets? It is
messy to have all versions in one thread. Also, please send it so the
patches are in-reply-to the cover letter (git-send-email default).

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
