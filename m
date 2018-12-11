Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F6C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:44:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157022086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LwI8GNTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157022086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5FweudcV4AttqPT/Vhds6FRrLm+h3R6MDxxtrI3DfM4=; b=LwI8GNTZfxlA6Y
	jLjtys7uCClOD9ZiwN+4BYfxuNbRs3CvCUQVTQ0kYYC0WMDGyzVyqOM65eozj0i2L6QsE5tykmyU7
	Ycagh2Iu4qPqFq7hujiLWw/AE0m0kDL3eO1rNdp+s9EpBvTtfJZmGhdSamRtkCw0ho6MyLxLWCkQl
	rDm9u1MW25ChPmE9bC0nOes4kruMASKmNOHHJoNLTjCpH2RgNTJvB3Ul1cLjQ7TS2v5mKpNplUSoB
	90ZpBMECONzszccYOxSFusiV55mhgAGGA0r2i0eNK6j9nQ5/JwaYQvsyVfM+kvAqXwPMYl2U4jjdN
	L35rBqqvknLxVrSbR0bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWppf-0007JK-Sd; Tue, 11 Dec 2018 21:44:47 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWppd-0007IA-4o
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 21:44:46 +0000
Received: by mail-ot1-f66.google.com with SMTP id 40so15619032oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 13:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SxewEjABoL2XL2a2ZAoCry0dufPCPnX8qdtg/EJq7Bo=;
 b=o1NMbVDD1YoYs4Hss6FRN4sPEKEMqzldIOUC29poAiOKFWa9drYqk5vF54wAhMoi4Y
 WKz47n9flnOJGjDQ2kd183M4j6ytTzs6E4227oJRfnbVh3UWKiaamtWB2rQ0wVbMtNLN
 QJrxc9w2qLuzzws0rffVsUcRdCNLtDOshgH/m06X03TLenFjh8qAWhMhLFeAYK7ipnGy
 okQvB6RFHpmmCIrWIzFwsrU1r2YzPyaYazelBlz53vG6CNomvOOcy7EFdKOaDM9jMldz
 OGwVe2glfbw3W4G4BSmHmkJ/bVwcMoXEBNTiRHj6ygYA/8TzaB/+RLjf6c4uM/68mVa3
 7Xbg==
X-Gm-Message-State: AA+aEWaari9td3wC+r7UYoADPHhO4M37rCQbQdeEiU400UPIY3kWehN2
 HykUhr7Ehc4Q2/UV7Yp0Vw==
X-Google-Smtp-Source: AFSGD/VBCjXFYmCrK2wzcW/UGw3/9X3g0VcnojV8THfikCQvw0ngBqBtCoyVrnWbWrkiRwEYS7QZGA==
X-Received: by 2002:a9d:23e5:: with SMTP id t92mr12917058otb.159.1544564673901; 
 Tue, 11 Dec 2018 13:44:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s186sm7272392oif.0.2018.12.11.13.44.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 13:44:33 -0800 (PST)
Date: Tue, 11 Dec 2018 15:44:32 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 06/12] dt-bindings: PCI: aardvark: describe the
 reset-gpios property
Message-ID: <20181211214432.GA30246@bogus>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123141831.8214-7-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_134445_180958_2DD0E186 
X-CRM114-Status: GOOD (  13.67  )
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

On Fri, 23 Nov 2018 15:18:25 +0100, Miquel Raynal wrote:
> A GPIO might be used to reset the PCI IP. Describe the property needed
> in this case.
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
