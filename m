Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB98FC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:34:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB2820839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gHlzCIb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB2820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LRJ1nld7JqlUaTl2xJCC05vNMAlgn8dXxehRscN/SoY=; b=gHlzCIb/XKg0NP
	pjP/d2mG5eLGGq8jShO89BDYsY6rgu3m9wiT6325qkFl5T3ArbxusXFDaYV5Bem/tFqCVRW64rINo
	mnHNaqABs8KjQVPfst2U5gSgf8ppBBtuLnr/Sz0XK4/sLfhr7zi+MuGvB7f5T7u12CiI07NVqjcp4
	1bTcP6n+xFgdzIrYgnsY8LHNa4jAL5Np4IJlBj9fyEUKF7DLymayvHUtaHXoQie5uLRK5KN459ANM
	dtHpK4SyccnamlWsIXowTx94RqhUW1y8I5f96hDwx15WW+QohhsUil0QzpIHp3kCXY/sdMpoyYCQ9
	YGathlxbw4ojvo8jUwTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWuLj-0004eW-0W; Wed, 12 Dec 2018 02:34:11 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWuLf-0004dV-Cs
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 02:34:08 +0000
Received: by mail-oi1-f195.google.com with SMTP id m6so13803720oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 18:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9hQxpSJGUHcHaTjiGWXZ6kTkt2yNEbevsOId/dKgcb8=;
 b=UsbEu+6csycH0k6x/FIJNMMQyVv/lLhjTI04b2P0adPrvi1cFIUsSzzbrR/mqtn1C/
 I+NFcSIkxDyTDLbqDacrYhoKP0QeHABzGBz86fkBNKgvndWBiLs1ZjyxoqnDoepgHoZ+
 AXNqBImUxCViCjfBWujz2eBSWHz/nIM/wzpX9iaL2288PMwakybzVrc1WQJvMHu2xFQA
 gYkvWk/3Nlx+BdoiIFJFL5jAtiYA6hv4BG++fQ2yL27/UbI8lwqZHiUz8WLvMY2TuZ8x
 CfWFRGz9QnM01F4RbjsIgLykCZF6qrPI7Wy6NJwSLJm4ILJ2CgnLMXTkdAVhzxBftCvx
 99Jw==
X-Gm-Message-State: AA+aEWbl2I3ZZzeKJ6gp8Riz/327q5rst/VfkaVfp9B5aytKxflX6iEd
 WSASnARXubpvzIAvTE1uMg==
X-Google-Smtp-Source: AFSGD/Vuk7UYOiVgN4AyuPuZ+BiDamViqRblq7y66LleVIlxCS6PFGp2AhlzCkZw3Z2lJddg9WnP7g==
X-Received: by 2002:aca:5c05:: with SMTP id q5mr192476oib.146.1544582036686;
 Tue, 11 Dec 2018 18:33:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id e6sm7135003otp.68.2018.12.11.18.33.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 18:33:56 -0800 (PST)
Date: Tue, 11 Dec 2018 20:33:55 -0600
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/6] media: dt-bindings: media: sun6i: Separate H3
 compatible from A31
Message-ID: <20181212023355.GA7324@bogus>
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-2-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130075849.16941-2-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_183407_438742_4F3BC5FC 
X-CRM114-Status: GOOD (  15.82  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 30 Nov 2018 15:58:44 +0800, Chen-Yu Tsai wrote:
> The CSI controller found on the H3 (and H5) is a reduced version of the
> one found on the A31. It only has 1 channel, instead of 4 channels for
> time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> "fallback" to a compatible that implements more features than it
> supports.
> 
> Split out the H3 compatible as a separate entry, with no fallback.
> 
> Fixes: b7eadaa3a02a ("media: dt-bindings: media: sun6i: Add A31 and H3
> 		      compatibles")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/media/sun6i-csi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
