Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378D7C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:24:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEA32086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FJXN1UZx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="p0PAGvnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEA32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xXgb7MgJrJN3UAZoPuHNPFaMCZjfiDTx/QHSsev13DY=; b=FJXN1UZxtOans2
	1E1AcF2LSnlkK5BagB1JZ+nMbQKZvhcdo7poSZ5trJXEYRLqMAmMpOjB0E0mW7oEOeQAGpQOSfIox
	Aeiqmru6SjvZWGibeTmtJYeRmNZxrKEjiDd/3pw8Z3QFOAOJOOxQClzXYIAjQ4u5oe5qHs+CNSOU8
	m38m7eFWGAdB5QzRoRzqgvXEcm2njpacQ7I1ytVUyGx8fAlk4YdQg9S+dfP4UeOt2JfOKOrDF9Zub
	giY+b2KsJPINkNpDgbT1PS1pUaviumv8ptnADH8wrFKBtEUa/oyx8mpShHtxZw+j2suBblVM9HfVN
	09tN/yV4toe1fkQgCKOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCv6-0006BZ-5Y; Wed, 12 Dec 2018 22:23:56 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCtV-0004i7-PW
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:22:19 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so26899ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ha/6nYYyxrWFfNOlkGv7rMk6K4Qe54ZF/d5C86lLn30=;
 b=p0PAGvnOrrmFrRvc4XFDTK+THgL3r/oXwYqX9F9/raCYmpbT0JQPAqpTKYP7915XM5
 QAmKDPxdJD+zgnWx6FLYmpq2BZZWGRophPW1qoi5nx33V8agkQmsJg5kWqpSntdJJRo4
 hcFc5w1tEMLW1/pR0GcJ9RoKZ46ZgXvAhwOZx2Oav1NkCvxN2/1a0kuML0j7g1jS7Uce
 xED49xkeu/VayQKPt1B2qdnLMZ0zM/VPmXwp6a/4KYFk6782Ipnipqc8n7Y97yBu56FK
 jKpsucQOsoGOLazVbnE09WDSpk9HdyKaKIajme8jRdFv7ZpwEJOHjhLg3qlQ5W/BeaLz
 bjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ha/6nYYyxrWFfNOlkGv7rMk6K4Qe54ZF/d5C86lLn30=;
 b=i+61jyBBK9K8X9mjNAF5a6yRLUBFrOWF//NA19HrNpp4HatmIk1npRfpbZzHfyyUIV
 9dGZC1PKPEC3wuOD6Sdmj8b1FuWRZuraisP9nGkktXdqF97FOVFOK9v3/9WuSXsoje4i
 tv7zs9OWxfS62TJiAn+/18iQVZ8LF3JigA2n0Lh/aJhGPpz/zibOVMHKG9YrvpctkLKx
 /qOct+5OgBolrnx4Ayeo67zI3TPM6PiJtNTiQvk3MHHpSgSgYS2K2NfOAx97nJGuXi+E
 tHA++nowgJbAOwd2juD0NrZAtxmff7ka1+wtLUP85CGN88N42vQl/Iu5fbZZa0FU8Lfx
 fPZA==
X-Gm-Message-State: AA+aEWaB3cSOkDODZJbANU3ui0Pu7Egp7xJ/1oiMPoT2lT7K0X6nvmgx
 ML8EqwU3W9be26OSoOHPyG9Ulw==
X-Google-Smtp-Source: AFSGD/VCoS/CVIgv3K9tBMRBJJca5Pth6cDRMSOn1WgtFjfhXKV6PAfKwWZ6nIBk0JngyD1hdwDbyg==
X-Received: by 2002:a2e:6109:: with SMTP id
 v9-v6mr13125003ljb.126.1544653326148; 
 Wed, 12 Dec 2018 14:22:06 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id e14-v6sm4093ljl.43.2018.12.12.14.22.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:22:04 -0800 (PST)
Date: Wed, 12 Dec 2018 14:21:04 -0800
From: Olof Johansson <olof@lixom.net>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] few omap driver fixes for v4.21
Message-ID: <20181212222104.yww344h66ql5lg4s@localhost>
References: <pull-1544638438-182658@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pull-1544638438-182658@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_142217_826016_CBAE5BA7 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 10:14:33AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 3be5e10daf1fc063ec5cff3cd785c4a59814af0b:
> 
>   Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver (2018-11-29 11:39:23 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/driver-part2-signed
> 
> for you to fetch changes up to c2ade654dbf7d02f09ad491f5621fc321d4af96b:
> 
>   memory: omap-gpmc: Use of_node_name_eq for node name comparisons (2018-12-11 08:30:29 -0800)
> 
> ----------------------------------------------------------------
> Few more omap driver fixes and improvments for v4.21 merge window
> 
> This series of changes improves the TI module flag handling to allow
> booting with older dts files until the module flags have been moved
> to the interconnect target module level. And there's a of_node_name_eq()
> clean-up patch from Rob Herring for the GPMC driver.

Merged into next/drivers. Thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
