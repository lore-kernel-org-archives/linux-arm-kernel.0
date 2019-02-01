Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D5AC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:50:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC19720870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dhau8xzt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPjqHtBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC19720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BOBJ4JBCZ1k7fCA0lF1iHTJtdcM2JFhRVQi/5gQ1KSM=; b=dhau8xztVYn9Hf
	zKy1zRIsNFvQkg1hZgrnzJjTVpcHvlWjIbQ1PorJgv4lRd01hgP+r2vRx6WqEs394pdyDCj1ZvFyi
	HXKoRYaAL2zhInz+sJ6FHWaCR0Ypat5C9g4f0yvetu8Clyl496QuLRC7CtgUdUziV2yoxGIjzOO6S
	sJiZTBxkw1ubjKUZlwC8Wo9+XtEomUcvpsY2u1kydLvVW7o01qlYw5Mdy7goUuHUABl63xs3Y3EGj
	hgW+qAePyURYxVSsoz0B6+7BTRSKzG1WpRt8pGw9lWLaWctSpZ/LNZjC5+rK43MZOEbtdh9fRR3Ml
	54iMRhpy5oYnjAwRCN2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPqj-0004BX-E8; Fri, 01 Feb 2019 03:50:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPqd-00049S-SY
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:50:37 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 462D120869;
 Fri,  1 Feb 2019 03:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548993035;
 bh=BEEXVkvfSwtjHAFI7HFv5LIsGc91UieFcvYdXcyrJcg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oPjqHtBy16vwYBddQLCjikciGc2QGKSoo+QrQid/iT6wOE3XqigwAZ6D3BYg/TE9d
 q7n4zUhVCpf/5tNEbmz6I2jsxcJQPLeV9d7y7nNDBT6pUVeHV0CAwO12iuNa+XN1aF
 l8wv/z7CoBZiykwEI0Xkyvug3zjIXp0JhRqSSvrI=
Date: Fri, 1 Feb 2019 11:50:23 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Fix boot from eMMC
Message-ID: <20190201035022.GF19882@dragon>
References: <20190125135558.3451-1-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125135558.3451-1-ccaione@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_195035_935848_01A905AF 
X-CRM114-Status: GOOD (  10.86  )
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
Cc: mark.rutland@arm.com, aisheng.dong@nxp.com, spencercw@gmail.com,
 s.hauer@pengutronix.de, robh+dt@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org, abailon@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 01:55:58PM +0000, Carlo Caione wrote:
> The boot from eMMC is currently broken on the NXP i.MX8MQ EVK board.
> When trying to boot from eMMC it fails with:
> 
> ...
> [    1.271938] mmc1: Tuning failed, falling back to fixed sampling clock
> [    1.287429] print_req_error: I/O error, dev mmcblk1, sector 1 flags 0
> [    1.306833] mmc1: Tuning failed, falling back to fixed sampling clock
> [    1.322325] print_req_error: I/O error, dev mmcblk1, sector 2 flags 0
> [    1.329559] Buffer I/O error on dev mmcblk1, logical block 0, async page read
> [    1.336714]  mmcblk1: unable to read partition table
> ...
> 
> The problem is the result of a partial misconfiguration of the pins and
> the missing assigned clock rate.
> 
> Fixes: 9079aca4aacd ("arm64: add support for i.MX8M EVK board")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
