Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B740C2F43D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:44:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDE020870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DqiwlX9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDE020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sqEjLHMygR9cuNr3h4gKo1xTcA4H2VFEvCWB7DPKCNA=; b=DqiwlX9L8zcj3H
	nqjUOF+4WvDHUrfpJshtkycL1y2Mab/ZauWuEpdjsjIboFBdiKYLhafhxeVnbASimk2TAKpq0ztM0
	Tce/pdIuP+7m9dBV3xgFWh36uRgQ78fgf+86MTvvxAFZKAocPgm2VhhXDuh/qdhTrFdodGdIsmbs6
	u4n2W140SgLrmqsk3GUTY/zJUvH0eviO4R8SaGW8GAEMSFu3PI/e2AfvvIcjZqNO7aDetTs3RjsFw
	YTcCr6NFQ6lFBMNrrCtJ45emGGyOG8ReGHHl02wzqEMkS0lYdobWwnZpKqJj7p+WUW6lvfwgoAjhJ
	HWcEvjcTxm6+asbRuLsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbkt-0007t6-IE; Mon, 21 Jan 2019 15:44:55 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbkr-0007sl-Dq
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:44:54 +0000
Received: by mail-oi1-f196.google.com with SMTP id y23so14869475oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xoi61SFg8YIGW8m4PCB7hi/Eq++xOYWlHwpUM+Dysak=;
 b=f3FQYHeLaU0pEC6jeHBVf1V7fr1ZeFbXnKWRTmDbx9bBpYgAaAVlwmLiK2LjHQ1QDz
 esuezursC+tTYWBuFn+A50OY7x2UoW24e5ubMCo1uMSgCKvMW3J51e1VDlt0ChqPbVfz
 2qNmR0LnYIBood7KbbMEzT7HMbfAvVqIyRSrM0iBpNfKpThCB8LF1dsTre5ZSADIUhnM
 cmmpqZpoq49P7D5BwRiAooK8srMoA2VFmQ725mCHzIYQLFig9MXDDZ4v5LWypcCtS3jq
 Z+RsPRf2cGNcZfmHHkzYDZ4BUzw6FQOlM9meBfpYa77q/7kou/1lcCwM7Lm4+nnyxvWu
 1luQ==
X-Gm-Message-State: AJcUukfHbK4WfGvyY0XJS4QhfXFLXEZYaxzMJPKXEkC/aR7NHGfIr1j5
 bnoqrZ6SbQa6yQzooNOuHhPyOdE=
X-Google-Smtp-Source: ALg8bN5BTdQyFi3aiGQq0/rDoI2jYtrnYAmJyY76qEO252/zb1JV4xk913LcAKAP5Nr6Rx4iHqGcZQ==
X-Received: by 2002:aca:fdd0:: with SMTP id b199mr5650064oii.178.1548085492436; 
 Mon, 21 Jan 2019 07:44:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t8sm5384629otp.69.2019.01.21.07.44.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:44:51 -0800 (PST)
Date: Mon, 21 Jan 2019 09:44:51 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY
 bindings
Message-ID: <20190121154451.GA28183@bogus>
References: <20190121112336.23489-1-miquel.raynal@bootlin.com>
 <20190121112336.23489-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121112336.23489-7-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074453_462037_FD666D7A 
X-CRM114-Status: GOOD (  13.86  )
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
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 12:23:32 +0100, Miquel Raynal wrote:
> Add bindings for Marvell Armada 3700 USB2 UTMI+ PHY.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/phy/phy-mvebu-utmi.txt           | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
