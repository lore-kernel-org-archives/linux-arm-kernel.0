Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EADEC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:57:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CBB2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JzAMwADd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="fEkeERtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CBB2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DUOz1a/4C5H91I1KxDa51nrCQSwWwujhACExzl4oZUw=; b=JzAMwADdce4qOL
	RfuAytrf9Mx8leZ51thototvZB7/e0B+bCF+2XsNCG/0Z8CLrIxM/pJWw4th0VQe2oUbKFNldI0R8
	cYKgO412jfIVg3z5lOmjBSb0m/LomHl5BLDirWC+WfhDGkt03dJ+mZ0aaDPRXa8JjZrUSjJ/v4S1e
	DAiEyrZ67v/oY46vOhIfWaNheg8z7x7mYW0co2k+Mepr+3cd0090LppBUm4ELi+lxtuwhiT8kftmo
	sL/9a79JnJu/l0zPJbuGFogxy+gCxl9tHi3kn9h8P93+HoJhHUBEQ281y0/zRF419wGVzRzGn4/dx
	K0y9oIH3Wc+Du4urjeWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXbnG-0002sI-4F; Fri, 14 Dec 2018 00:57:30 +0000
Received: from mail.nic.cz ([2001:1488:800:400::400])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXbnB-0002rS-JZ
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 00:57:26 +0000
Received: from localhost (unknown [172.20.6.233])
 by mail.nic.cz (Postfix) with ESMTPS id C6AAD62E08;
 Fri, 14 Dec 2018 01:57:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1544749033; bh=g02vyxvx3Z0cJLUK1phCSxH+CVN1v1rPsHLSCbkh02k=;
 h=Date:From:To;
 b=fEkeERtHp995tRVNOqiSSeBk1FCrIhiMG/AI9wjC8q4b3V5wbD0mfiN4Y+nyGESLf
 I55Wi2wcnJfp8THzoPuw0B78ub9Uqo12ncwuV3GniPUCSv59X/aA0VF+5FGoeS+j2F
 0Q9exmTs6q8UiFDcfnHh+6q9w2gp+c7YiAY8olFE=
Date: Fri, 14 Dec 2018 01:57:12 +0100
From: Marek Behun <marek.behun@nic.cz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181214015712.31f749ea@nic.cz>
In-Reply-To: <20181214014701.373b220b@nic.cz>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_165725_825014_4A1C26A5 
X-CRM114-Status: UNSURE (   8.70  )
X-CRM114-Notice: Please train this message.
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
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 14 Dec 2018 01:47:01 +0100
Marek Behun <marek.behun@nic.cz> wrote:

> Hi Miquel,
> are there already patches for the A37xx comphy driver?

Never mind, I found them. I shall test this on Turris Mox.
Is the comphy driver supposed to be able to change eth mode from
1000BASE-X to 2500BASE-X and back without reboot?

This would be cool for our SFP cage module of Turris Mox, just to add
support for comphy into mvneta.

Marek

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
