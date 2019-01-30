Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2805AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:22:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE55218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WP7ZU07Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE55218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t6e+M45lekTVP8231sG0nHRADRW9n3m7PKs4v4aNFWM=; b=WP7ZU07YYnPAhT
	zFtUjw7+KokCMUizuB3/hSmLuU6WlRtW2fZTfkGk2+RA+7K0tkSI/nVnU+rkCXJaMoiZqni8pXiTS
	AMvJTf3IQp0/UlxnQ1bnJbon2Jnw3/qdeuQHCfsDTbq3Pg7T/s0ZheocvDypFnPQ9nu9S0cDIvBoE
	mdttsUaoD0TSpJHmHXu2aQVQyb0R+KT8hp0HWBxq69MA/0mSnLNbDXHp29iXfORo/vfkl60pSjtEF
	4GHuQYE70nEJxrruaoRWJLxqwNas/UCgKtN1DHt5hCpNYR4H5KBu0Lg/I/cgeZVQHH7CJv1vg7Wvd
	Hl+Lw41DsKdVQyKU9a3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosdZ-0004eV-Bl; Wed, 30 Jan 2019 16:22:53 +0000
Received: from mail-ot1-f48.google.com ([209.85.210.48])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosdW-0004e9-CA
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:22:51 +0000
Received: by mail-ot1-f48.google.com with SMTP id s13so105190otq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fU3YTEP/2Tjt+O1XM/zfybg9MT3B3iPPfCLdvguDSQY=;
 b=WKEerAtS+afGTltdgXh7wXoK4Sm8VoGxbuuhpKr6cTHIPZa63+PgXTO1cymLatwnWc
 f3rpY/y75n58lnYhnTkZHGn7bBuiPmTDAJEaFUGGMg7xh21TtkUfyzp+0ZbOKwi9FNH/
 Y0QA2MNjU84O/ieKXilaSe+Rj+nNX2qIQtSEFHcq+qtKeONf8txNnQjscEyy3gMHq/5d
 Gh92VQr+m4PWzrFD/783hwDdp1U9m9QKSR0XMFsHNRsl/gzJU3z4teMUHherf7tu6dux
 pFHL8kGLcSqr0DPPA4sy0moM+6UuWd8JiSd/nAP2+sjGklJW8QAuDur1tPRD2zYL7Y6Z
 DELA==
X-Gm-Message-State: AJcUukfDs2OImgQlvzNe7Odtkz66bhynJH+tJPMyX0zrnz2ynBQSP9RW
 EZQreit3EtyuB5bSZN8C4A==
X-Google-Smtp-Source: ALg8bN64Mlz8E4JpZTCWJT8D1JGVTf0eCWEALMjfkTw2fu9nBHwyxM/xGRxvN+KTPgrGiVNu0xVyWw==
X-Received: by 2002:a05:6830:110f:: with SMTP id
 w15mr22588176otq.222.1548865369344; 
 Wed, 30 Jan 2019 08:22:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n8sm687013otl.40.2019.01.30.08.22.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 08:22:48 -0800 (PST)
Date: Wed, 30 Jan 2019 10:22:48 -0600
From: Rob Herring <robh@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [v5 1/2] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to
 the list
Message-ID: <20190130162248.GA8669@bogus>
References: <20190125081013.21663-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125081013.21663-1-peng.ma@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_082250_407812_F79EF3D3 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: axboe@kernel.dk, mark.rutland@arm.com, andy.tang@nxp.com,
 devicetree@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, linux-ide@vger.kernel.org,
 robh+dt@kernel.org, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 25 Jan 2019 08:10:12 +0000, Peng Ma wrote:
> Add lx2160a compatible to bindings documentation.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V5:
> 	- change the lxx2160a to lx2160a
> 
>  .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
