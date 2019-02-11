Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A66C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:37:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759F32083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ihAVW16z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCmUwJhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759F32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0HrswhOm/xOgo3UfBCOMg0WrorE5J8Z7EHy80whNzeM=; b=ihAVW16ze7AafH
	yj5M56eJrNFJkVB3DOuqtxlA98F/CuxAtq5yLdRWgTWk48HQuDZvr5Nk87XAtYeXP2tkceFuE3rDG
	2fKtcrrTzA6wQ9t9dxw5K3k//A285hVByHO7CMsRfOJQcjc5rkzjZdKMtmUTItv2nNrv2mDh9PLPr
	uaZ/e6Jk2wTFH01xDsv0tpemFhXsYUswXSpXU8oZJ6bCxg3Ijt7hOt6obTxDu7gMD+3ZuexhXnJ/V
	YKVqnNLQjwGYLeU4MX1kS0bQdqF7JDC1epfrJSI/kNsWuGT20qha5eL+NB6emQujkCe0sAfZNL1cS
	YM/nn+hILcrQugz3E3QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt1Sp-0005PN-Nn; Mon, 11 Feb 2019 02:36:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt1Sm-0005Oq-Ff
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 02:36:53 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10A8C2083B;
 Mon, 11 Feb 2019 02:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549852612;
 bh=2yBpgdo0Oz+tj4swbvHeUuGBYi1l1EVhMhrcheheBAA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nCmUwJhJqS7lwCQR9JVV+vEwCVlUtbS1molJIz0OtV7wEGinjIBcduMyS+AxfSV17
 3br6gAHjeiXFgYCpzAsuw6Wjlopery5XIPrFcPZSGvbu/5wShjN1aimq+U7U5QvA7F
 LNJ5ntvN1zI5e8WTswWS7mlIkaYP9qKbrT9u4GAA=
Date: Mon, 11 Feb 2019 10:36:40 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: pfla02: add ksz9031 clock skew values
Message-ID: <20190211023639.GG22487@dragon>
References: <20190204152956.13471-1-m.felsch@pengutronix.de>
 <20190204152956.13471-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204152956.13471-2-m.felsch@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_183652_538071_BAB31FD4 
X-CRM114-Status: GOOD (  12.54  )
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
Cc: devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, c.hemp@phytec.de,
 fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 04:29:56PM +0100, Marco Felsch wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> The pfla02 SoM has a Micrel KSZ9031RNX ethernet phy connected to the FEC,
> which needs RX and TX clock skew settings to compensate for differences
> in line length. The skew values are taken from barebox commit
> 4c65c20f1071 ("ARM: pfla02: Set new ethernet phy tx timings"), which
> is based on patches originally provided by Phytec:
> 
>     TX_CLK line is approx. 54mm longer than other TX lines which adds
>     a delay of 0.36ns. RGMII need a delay of min. 1.0ns. This mean we
>     have to add a delay of 0.64ns. We choose 0.78 to have a little gap.
>     This can be done by setting GTX pad skew value to 11100
>     Also add a delay for the RX delay lines, needed for the Duallite
>     variant.  => Set register 2.8 (RGMII Clock Pad Skew) to 0x039F.
> 
> Cc: Christian Hemp <c.hemp@phytec.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
