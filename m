Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36635C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:10:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059F420821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IJz8RYxV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLKDn+VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059F420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MnX6Tr8aN7RGlVc6oE8lnt9NrRSV/O1y1HiRoFF3JaU=; b=IJz8RYxVraaKNt
	Km3zBds353XJEogyDL5654T3C62jOz6bkDViX0boJ5a48wrXdjZZWc9dWz6TXPLVnKgcu40R0Xf7A
	AHz5uh77qNJvOp5kJzdBxN4RnmIIzzhC4V3MEUFl+Bc9YtL2QqW5TtDqBIhEYQQhPqae7nPu5yaTi
	K3SnXxg/NIZTNxy+yLQyscGhaP2p7x7Aomn3E5jyk7RKWL6URQIFNC8XgPPc1IBkZ7Xcs9gYtad/7
	AIznr8hbkpEgp+82dAvIxd+PqHawrMNVZvcmfR9e2do/J5GPSkjBoM0srVWKJhG7ybZAjcDfwC8gz
	xLINmsH0uhdl+N3hIQWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtU54-0005S3-SU; Tue, 12 Feb 2019 09:10:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtU4x-0005RF-7j
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:10:17 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A608020836;
 Tue, 12 Feb 2019 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549962610;
 bh=juo7FCnQMIuEyX8VOz5Vmyjk9rOLVg1YY8bxa+Cl9kU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vLKDn+VHO+xsxtWtvy8MYUwC7LnwBNyL6S/BIeQMpUi3OgURalWwQ/cpf7/JIRdqO
 efKZDPisvP4iAKzbWJlaH+t9tWKICrBvcNj3mCFNRj5gwWfDHCt4eg8jnvpqsMycvl
 hVy4hF9VqFJLUegG1P51zPik/j3vXKxuz8epTP2U=
Date: Tue, 12 Feb 2019 17:09:56 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH 0/2] Adding DTS to support STMPE811 ADC on Toradex Boards
Message-ID: <20190212090954.GP22487@dragon>
References: <20190122132135.5012-1-dev@pschenker.ch>
 <20190201033633.GE19882@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201033633.GE19882@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_011011_295415_C5673C69 
X-CRM114-Status: UNSURE (   8.92  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
 s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, stefan@agner.ch,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Rob Herring <robh+dt@kernel.org>, thierry.reding@gmail.com,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-tegra@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 11:36:34AM +0800, Shawn Guo wrote:
> On Tue, Jan 22, 2019 at 02:21:33PM +0100, Philippe Schenker wrote:
> > Philippe Schenker (2):
> >   ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
> >   ARM: dts: Add stmpe-adc DT node to Toradex T30 modules
> 
> Applied both, thanks.

Sorry, the T30 one shouldn't be applied by me.  Dropped from my tree.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
