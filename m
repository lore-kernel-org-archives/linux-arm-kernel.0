Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71923C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:45:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1C42086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCiQm2Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1C42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JKYUytsiCHeHkUKOP3pbeU696w5f4iAgMHHjGNfEsOw=; b=uCiQm2WzlXntoT
	wWKnQkNy2vnY9hONsOErympmqA6xdxSme+Ix94emo4Cfg1nZ8+D8hAKE1/v91h6aYDMeadG8CwHos
	cBJxPwKgdCtEOc9Wh8iPjnntjA+d/RcKLpYw7D+xyT14rc/AfDR/cLbg5UTijyyVYT23YoR8szy1i
	pdQo+jSmR39btR6uVD8O/PhRjVAuL2Crd4BFFH0pjljsYYVI/F5CMHRAmOne+f/dEuXq7dNmRkFOM
	Z0HT0Fo+5sP2jJW0T826slLgWv4DtbTuxB4vPdVgGtPmK4qc9klHGXaUNaKnS/O+dBuupCXLPZbEx
	zJ9xynrLvbr7xI+Ek9SA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWppv-0007Xl-6m; Tue, 11 Dec 2018 21:45:03 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWppq-0007JJ-0H
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 21:44:59 +0000
Received: by mail-oi1-f196.google.com with SMTP id w13so13316353oiw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 13:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Y9EAWa1IC7qMF4Th+r9/Z//SfIrnlUcSsuJ4gReQCrg=;
 b=XbdQxGyDhK4fh03FAngRcjRV7UEAS2GegpIhyFslvzSeEdNsZg1HdluDE7ff/lelro
 MuA5Bb6F52WOhUZnof2SUTdPLE8bJ7yIb0SQeUsgKGGL0Y7r5YVjWf1v01PM+oq0vH/O
 1DpxiDv3OEC293AwFtCZBrXcBgmsc4Iml52pHsCrzZMlXWF42SUIijrE/j+wufCIuf3/
 rjsxq47jxICbqDI3aQwke4mRci/8djz6tYl2r5Ax2f2RMbS4Fwk8Jg3BdXPJLZdRaZgF
 S3M+cQE1WwLKNEEJTLBjkcJcOqfzEu1uyAMuQLtq5IsYGx2d3DHtMBADE3nNBmhrGbj+
 AmoA==
X-Gm-Message-State: AA+aEWawS24vI4STp1ApseTtYr3+vZc7U516OmvdcZEbQCEe/2brsLIV
 inpIIO1wtZAABcnO2y18Ag==
X-Google-Smtp-Source: AFSGD/UQFWfU1+x0TLFTIcWSuYESGa08TLRfjF45GGRlXNpbcpQ2JeZNjccZAa/FzkD8DzfsY3Z0aA==
X-Received: by 2002:aca:dd57:: with SMTP id u84mr2354970oig.216.1544564686974; 
 Tue, 11 Dec 2018 13:44:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d66sm7788086oia.29.2018.12.11.13.44.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 13:44:46 -0800 (PST)
Date: Tue, 11 Dec 2018 15:44:46 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 07/12] dt-bindings: PCI: aardvark: describe the clocks
 property
Message-ID: <20181211214446.GA30791@bogus>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-8-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123141831.8214-8-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_134458_060137_D62AE3FF 
X-CRM114-Status: GOOD (  12.58  )
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

On Fri, 23 Nov 2018 15:18:26 +0100, Miquel Raynal wrote:
> Describe the missing gated clock feeding the PCIe IP.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/pci/aardvark-pci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
