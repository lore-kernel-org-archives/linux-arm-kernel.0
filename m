Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5108FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:14:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAEC20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCwbtuhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAEC20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rlhJmnQx0GHGJ1CK3hGnItpYnDJIBa/b/7N+oh9IPj8=; b=uCwbtuhzxOZbh6
	O1xAM8EY7djO/Znuei9LLXJcnN2Edy0rXQYJHfnPQcPtqvf0yfqQVVXC9VrQv0iVx6ifEaK5pjuVj
	1z8ap+mGddNfMiRJQn/t85VgfHsc9YY3/0vYXSeSHoUi22rR0LGPVQl0ruFwCUkmuuONHohNdHEld
	PMp7pTGixXSsbck6JCUdQiPyxcwWpMmr2SmWJMnt6c5oVFjhm9qySR70oiBfH8rtH6uvXp9iSz4Y8
	KLmg3Gcz2tUQwipHlE60ExaeylpuXfBJnci5Vpd8srIpCD+lZsPIR3sAGhM225+zuR4ECNILjDerm
	QJ/TPr9uiwlEJmFq3jOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUkh-0003s4-A3; Mon, 10 Dec 2018 23:14:15 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUkd-0003rB-KS
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 23:14:13 +0000
Received: by mail-oi1-f195.google.com with SMTP id c206so10516428oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 15:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OQ2NGOdowaEu9JZPmiczBUyABSOTJVXCfejhysEMLL0=;
 b=Y+LHE0gynrc+NBezuosgUE8xYhpEjbIsP+Xpp84Zh/qijGqeW2IXsplLju0tUjkqvT
 MB29yV8O5u18p8c3CesFxb7VJiI0jiMEhhD+xJ2gnU6VJsvyCZ9HwfhEC3iBNoVleUIO
 OZR1M4lx2Bh0RXSGb9sQ5Gz7ElBpJQbp5eXVhdbIt8Dr+Wu7mnYW2uV6tqMerEPtkDl5
 3jAwxzn9DjwzuGnyO8usSACgLk5UWF70uyOXv9snRQnebjPrUn87XLi0ZPg9q28JK01y
 oiDNqt0RkN+izjQ7YDylQ0TJ25SskvYz6xnGrHUt6rJsHGgGkJnw5zrSXmwfcS9NdUK/
 6IZQ==
X-Gm-Message-State: AA+aEWY2LtUGS148qUG66+/91roECKBxqU+m/T7awbBIy6lQhQgwIKa6
 LD3XEFsohcvPWU2+Wp7UDg==
X-Google-Smtp-Source: AFSGD/UChiZfXl+MVC5iJjlgm4QG5S1nM+C0ZbgplcYWvyMBtJaXN7fuymvLlQr/XRGU4qnwSkSxyg==
X-Received: by 2002:aca:3d4:: with SMTP id 203mr5206oid.315.1544483640611;
 Mon, 10 Dec 2018 15:14:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x127sm6048833oia.20.2018.12.10.15.13.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 15:13:59 -0800 (PST)
Date: Mon, 10 Dec 2018 17:13:59 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 5/8] dt-bindings: phy: mvebu-comphy: extend the file
 to describe a3700 bindings
Message-ID: <20181210231359.GA26329@bogus>
References: <20181204191730.11516-1-miquel.raynal@bootlin.com>
 <20181204191730.11516-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204191730.11516-6-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_151411_665355_49E42331 
X-CRM114-Status: GOOD (  18.00  )
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
 Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue,  4 Dec 2018 20:17:27 +0100, Miquel Raynal wrote:
> Current file describe COMPHY bindings for the IP available on the
> CP110 of Armada 7k/8k. Bindings are very close (and serve the same
> purpose) as the new Armada 3700 COMPHY driver so update this file to
> describe both. Also add an example of how to use this second
> compatible (same as for the ESPRESSObin).
> 
> While doing so, enhance a bit the file by adding upper case where
> needed.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/phy/phy-mvebu-comphy.txt         | 65 +++++++++++++++----
>  1 file changed, 53 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
