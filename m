Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99144C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:45:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685792086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TJ7kGEtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685792086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IyivlSfvtvlW9s6e0Hf+b5emIduDxJ+ksgZXn38gvbg=; b=TJ7kGEtCoBpigY
	Ag8B9wubwGhlUcoUyGn4vJzANA0GwcugZ32lfWMwGQuORhe7G+R7JKKq5nG6bsNOe1jJ2VcgHeEM3
	kSJd3IbskGL6nexEqYenpwReriJP4R4HJUH43lzvEEtYJTdk9iDc9Hq1Q6vqGoLm5c/W0DSpU/UMS
	ymdVgg0SdLZvAqHEB9VPfisbhA9AcWLyIVm77xepT/3h0IxhQo0oz+ermOKxAi3t4fGPJespvmdhO
	V1epz+ZzdIgH4j5OOPO3ZxDHX6UP1QFEqIJ9QWtjLmgezSXjv61uoGotEYUH0KM3hFHDtxKGXiZHt
	sjFDtwszcHG24daohcIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWpqF-0000So-VY; Tue, 11 Dec 2018 21:45:24 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWpq0-0007Uu-DH
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 21:45:13 +0000
Received: by mail-ot1-f66.google.com with SMTP id w25so15565074otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 13:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nh/++tBFztfnpJVOC/AWMVD202Om0iilmb3m9BACEZw=;
 b=VOwb29vV4RD9HBkV4FMnRbI6B0N88nBHpSbUAQ1fjrnwWRLYE7yQIES++dV6Kj01Jd
 cLndOwiH/z6UWOSBKX2ZTIT7BkcoPYNNmhvUfnORdGhrqOLKzYzoMQngD0Ixt/z7fmSG
 agxsRWky7alz02MR+wMqkpll9qT943WSxLf/8FBNCQDiqaBub6xf9osaamBD0yXDAAz8
 2AxPi1uK7WUjvwJ727aG7oOyaa30kyNkcBbC6d8IMFhIA38VCGA93xxm/GxDs4mGLiTC
 G+OIUK0Vc+Y8nGMSTPhCRERDiMeHeF4/F7c6WhoGuFZP0hTIQPvgugFTAHN2ZIXyrI/z
 1jng==
X-Gm-Message-State: AA+aEWaqb7snlt8Gxh7dNNUaOj+zj63OpLicUhNnV7eXZbo2uKmCgTj2
 vaz5It9kbWo3/LgmaXexjA==
X-Google-Smtp-Source: AFSGD/WtRoQtvwhUSlWxKLYTclL1Yv1bZ69wP4YYExVM+8uUZOFh4UaOPcZZO65DFEGk+KplvhPl1w==
X-Received: by 2002:a9d:282:: with SMTP id 2mr12296543otl.287.1544564697644;
 Tue, 11 Dec 2018 13:44:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id c19sm8473015otl.16.2018.12.11.13.44.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 13:44:57 -0800 (PST)
Date: Tue, 11 Dec 2018 15:44:56 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 08/12] dt-bindings: PCI: aardvark: describe the PHY
 property
Message-ID: <20181211214456.GA31214@bogus>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-9-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123141831.8214-9-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_134508_799641_0221D911 
X-CRM114-Status: GOOD (  12.70  )
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

On Fri, 23 Nov 2018 15:18:27 +0100, Miquel Raynal wrote:
> Document the possibility to reference a PHY.
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
