Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A1DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:13:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3B320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e9mfq7+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3B320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LK6UIeca1e6iZEjxLs++mwA5iibKgJ+90RbjktBHpT0=; b=e9mfq7+FdFowfL
	oWFx9k7Jol/pOQNXSVJ3KzN/WoYrCt2GHiRvZ+MsvlM4dJJzwUQr4NVAuLqXqtNc2dLnWtxImNGsB
	bcgcaBVvdAqZ+ewPDm76d9EvDGBswpZhW1yAp8uuWMn457JIU9vjct2e93k+q4g37aFBOHGPVnSSB
	EVZ5LbHpE/PBTXm9g5zINq66rCw1j58M1XIYq4aBrw8wcpsobLw7IGwEuTf6mi2OUd+0Jt1z0p+zH
	f30HqJ643+DCSpc1rrWH2JNqR2PUQJ3SS0uzbqYOiKDvUMYDQPZN9XofoohwSjbuejk8b22fL5ReF
	LqgjEvmA/axu+B9G+8/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjV5Y-0008V1-9x; Tue, 15 Jan 2019 20:13:32 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjV5V-0008Ug-IB
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 20:13:30 +0000
Received: by mail-ot1-f65.google.com with SMTP id 81so3761779otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 12:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ntKjFpByjGj36qZvDhl/OOUnSo1d4VZ4QJeEdynsDEY=;
 b=JXikHxsRBoqXA8OjNrByU5wHKUEdk7qSw3DeHGFjZ4YpH4zMqNYV2Zb0pzXsUs/tL4
 x2mnY3zAgS60WEIuJZ4Vw0OVNlLHOjO0yl1X1s8uUtf2GG2te7Snuv02z+EviK0KU+oI
 ChBiD0PpKXWgaB5u4L94b9gnEkCQdT0lKCprKdYbE06IFOJadhk4U4CicJv/T94p3TLH
 2LyU3CNYnjJprshryhezr4vWtlLntnjIyi+jjs4lg2dRrHZWFa6ObqICeslzmdlBnxrk
 dLlDE6iYjgs2CjusmX7wKKyPBAIKihQl9yG8Su5vL3yRMp2dpD9KhI+kz4sxUtCz2lc0
 9AMw==
X-Gm-Message-State: AJcUukd9ij5udR2If/RSUDu/KESU9orya2JpBzSqvfMcqeoThmvCXsA6
 rtNBUJGzo3N+tG3WlLNZmg==
X-Google-Smtp-Source: ALg8bN7t3Lz/eQkN7CMD4yoZQfY2i1duDgD5LmYSYmSakPfABj157uRkN4uPI64Eg9VbMp8XK2PFSA==
X-Received: by 2002:a05:6830:140e:: with SMTP id
 v14mr3502286otp.10.1547583208512; 
 Tue, 15 Jan 2019 12:13:28 -0800 (PST)
Received: from localhost ([70.231.7.113])
 by smtp.gmail.com with ESMTPSA id y2sm1715646oto.49.2019.01.15.12.13.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Jan 2019 12:13:27 -0800 (PST)
Date: Tue, 15 Jan 2019 14:13:26 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 10/15] dt-bindings: PCI: aardvark: Describe the PCIe
 endpoint card reset pins
Message-ID: <20190115201326.GA2362@bogus>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
 <20190108162441.5278-11-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108162441.5278-11-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_121329_595255_C9326B5D 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue,  8 Jan 2019 17:24:35 +0100, Miquel Raynal wrote:
> A line might be used by the PCIe IP to reset the endpoint card upon:
>   - platform reset,
>   - hot reset,
>   - link failure.
> 
> Describe the properties needed in this case (optional).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/pci/aardvark-pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
