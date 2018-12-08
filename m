Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB720C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:26:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704F520850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pPv8oX8E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="D9380jHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704F520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=utRbMfsylwVTvng6peW+oGutOjPVfxU5jLG800jvC0Y=; b=pPv8oX8ECiX6qJ
	XdiYak0FE//tOXe1IC3Rzxi/CpDr6dyliYbuuk+N3jQPomm4sGgIggPRz9ybX0THIbpxycoZgPlPw
	e2yBTN1OoxWZHhwR0SP+Zy5d5zfK19XWBNIeHptdx7fWgmZXdPjQN5fV5mH+lvKRidcI6BMBJzMcU
	Ih51KhauPtb3wmrgVnVqLy6Sjz7XVcY7+NAhluBN6rQL87VAqeWEnm8dKIr3/Ttp2r5VSsgYUcl2W
	PAUmB0q9RvWiHfDp2G+OmPRMSFD1L9u1QRCGILFtAjynqNik6wWNFjL64NNTl716Ql8pPWpiId1Kx
	qu0wHraCwDd5Juu5UqdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVk6x-0002uV-Uy; Sat, 08 Dec 2018 21:26:07 +0000
Received: from mail-it1-x135.google.com ([2607:f8b0:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVk6u-0002te-CG
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 21:26:05 +0000
Received: by mail-it1-x135.google.com with SMTP id a6so12375712itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 13:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rbiTe4h7U7Nc5NSaVYiFL9PxC/17RdYPm7MyBNEP2LE=;
 b=D9380jHaWcNVn8Dp2uqmy0bFWYjNQiSxr4k1yez/cR+h4K0NFXgpRX3CCc4fB2yW/b
 MGp0zV6OldM+KcH6wOWLefNcJqiZalULwYeN0qgOZVi6YDPk/ffY8Vju97p/GY5MdVGQ
 wIYPPwfIBWNga8psRT5agqG2081RyuAHmWxxCnqF/dV/nd2IbB34T66qfm8gvxtobeRm
 x4WFF95tZJk4Hr0PNzK46h+VSP4pcj+VemT2SHWPkrRNvNR6ha3zr4+EN+QfDY577Dgr
 UNWml98ixWhpoobUTIx1w6MceSknIyecvY7mItMKqLWzilGZLuEE18GZeaefcPHXhvL+
 iIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rbiTe4h7U7Nc5NSaVYiFL9PxC/17RdYPm7MyBNEP2LE=;
 b=DD1MDLBeJaa79dW6rWfdJy0bjDCAlr3wHVtuD2nlqMyLKqjUBHKprDlydVV1SiCjnP
 0f5/t8Wx89HEl509qfWZBzh4BJg3oA9NUZ3YsRMz29flbH8tEIbOujylnPhyGNrHtVL5
 8RsuvvNiuKzc2k8O1+k7U7m7Lf73lVtQb7CvQ0ck2AyXtNpLmTnr2Mn4LhK9sjTSq9fZ
 UTBiYMp8eg4oe4cOCMrWc61h71DcAh8IFN/PczNBQx7YjdupuMw+d2M8EC5gWgOoipri
 X4yW1PbomG84P9IfGmHmcstEIgtiWVrrDszga1ibK4+6yBRiHy4HRXa/9ZDN4mP07iLC
 RnLQ==
X-Gm-Message-State: AA+aEWZqcD1hIJMxtjfV1GB+ScxPo3OKhGiwgXaFlne/zqC1eA9y0Cd/
 pDpLs0AFpxgDUgNMviuZKGkB6Q==
X-Google-Smtp-Source: AFSGD/Xcpwx9+9X65WcnjcY6JySmATA58+riFe4encWLv4U4SkGm7eWFHUrcOo0X23lox6V6nHI6ow==
X-Received: by 2002:a05:660c:281:: with SMTP id
 s1mr1039511itl.36.1544304352864; 
 Sat, 08 Dec 2018 13:25:52 -0800 (PST)
Received: from [192.168.43.100] ([172.58.142.236])
 by smtp.googlemail.com with ESMTPSA id e16sm3196079iob.43.2018.12.08.13.25.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 13:25:52 -0800 (PST)
Subject: Re: dma_declare_coherent_memory on main memory
To: Christoph Hellwig <hch@lst.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
References: <20181207153432.GA24917@lst.de>
From: Rob Landley <rob@landley.net>
Message-ID: <994d5106-8f7b-bfb3-4cd5-e190c0035722@landley.net>
Date: Sat, 8 Dec 2018 15:25:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207153432.GA24917@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_132604_582368_DA58452B 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org,
 linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/18 9:34 AM, Christoph Hellwig wrote:
> Hi all,
> 
> the ARM imx27/31 ports and various sh boards use
> dma_declare_coherent_memory on main memory taken from the memblock
> allocator.
> 
> Is there any good reason these couldn't be switched to CMA areas?
> Getting rid of these magic dma_declare_coherent_memory area would
> help making the dma allocator a lot simpler.

Not that I know of?

Rob


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
