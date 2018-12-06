Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C61FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:21:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1917E2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HoFpTw0o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOYha52g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1917E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QDxlggqXyU9tjWr2I0HWx3MhGbzlgJL6TwwGPqMV3+4=; b=HoFpTw0oVfAOvx
	IbpQfbHybn26muDILObkl9i+PsSbWuNe6ZMxLjGWGeNkO6J/62cOF8oAv+Wtkzko7d66SXfjB+jqP
	l9Xq3gJyZR8JMkShmeM79Ytd3uTCuYaEUv28jsMk8kQreM8T8VVUk4Sg5P2FwzGIbxFpu1XXGR8U2
	klVKXyHuBd8zx0NviHv2UAH1RrC4Sg/sSUXkhXtjmfDQXkSQ6C/lCbZSVWiuHvvKA1a3AQL264tfQ
	8moE34mAP9zjOXPazDes9R54lECO7jGeQokRqSHQ8d21iyyZZhalhlSqFGukfIgzjl4Dh1bVggzIp
	oZOTqUyBjsGmBZ0kt98g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkEA-0007h1-5q; Thu, 06 Dec 2018 03:21:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkE4-0007gF-F7
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:21:24 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB39F2146D;
 Thu,  6 Dec 2018 03:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544066470;
 bh=pNWi19ABRax4DXZa/p/28SXtUV6P7E2SCcemtsXcP80=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SOYha52gZg3SzaAQTSZDzDI12PIIOAp/yzQh6w4qYCGtsUmz3XjeWeVY4v1eaN1qb
 pqvrm+PQZwOdqk58yrR+08tEVssUaKdoVL+Y1TzGaHaksWdRjsjtWfCYICLxk59a1w
 eNn0Wfso4aKSNNifLHSDv6bRSVZikZTV9JPe0dZY=
Date: Thu, 6 Dec 2018 11:20:30 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: ls1088a: Move fsl-mc node
Message-ID: <20181206032028.GF3987@dragon>
References: <1543941180-5147-1-git-send-email-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543941180-5147-1-git-send-email-ruxandra.radulescu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_192120_522875_30A956EC 
X-CRM114-Status: UNSURE (   8.56  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 04:33:06PM +0000, Ioana Ciocoi Radulescu wrote:
> The fsl-mc node should sit under the soc node, so move it to
> its proper location.
> 
> Fixes: ac7c9ff741fb ("arm64: dts: ls1088a: add fsl-mc hardware resource manager node")
> 
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Applied both, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
