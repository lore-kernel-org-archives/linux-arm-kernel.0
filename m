Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5363C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:38:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717A8205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iu7OCSuX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="pi0V2TA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717A8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TbgKIvMrz+iu8dcOAVIc9uMviNb1L/tcj/x6kXU1SsQ=; b=iu7OCSuXx9H8BZ
	wTvTSvH8gWR9x6No5SIJ2CW3eZxSFWHgDuzF9NID0887L+aSs0h7i9y44PEudph3GwcZj0061osZw
	2hGPUkukWr8TytYgXNdtpS92Z8XDES/+wWeHJfo6617MVNSnzJlXpmNlsDlUOxsfvpkrlqvxGzY7X
	SyYsThH1Dz1oN4C5jdO3hRjmBn4LvA5p1IK85AbOyjKHHV+B9ww0shy38S05GWeEtxsTKyZqfAE1I
	O/JbwTI1LWqMgCAmZK6LKUCF05Q9tE7dJ20Z7dRD94MdU1XaIVK9J/Hg4mcnO+3hQ+CKufYkURUSn
	Kak82zNrn1roWsT8xozA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk8op-0005hX-Bx; Thu, 17 Jan 2019 14:38:55 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk8ok-0005fL-D6
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 14:38:52 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 4658F25B760;
 Fri, 18 Jan 2019 01:38:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547735929; bh=D9V2YtdMQzhzMFL09enVQXtZuG3ZCl4MEBpTv2rUSaY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pi0V2TA+ec9AzPcwjEj6XJ9bUSmrn0qOaHgNI43cVW2AQ24Iu/0m46nBggimduJKO
 8f0+mdsGl6PeaasRyitfrsLylKnnM+BQBb0j9IA1wnnC5xEF0Mr2X5y3SYoY3E7RfG
 rMBhG94GloP/a5ftAb/AN05SVVlwMaEvjE81tj7Y=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 6073F940459; Thu, 17 Jan 2019 15:38:47 +0100 (CET)
Date: Thu, 17 Jan 2019 15:38:47 +0100
From: Simon Horman <horms@verge.net.au>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of
 SDHI3
Message-ID: <20190117143846.owmvegwqdlb4bybx@verge.net.au>
References: <20190110142833.31577-1-horms+renesas@verge.net.au>
 <20190117133216.sx7rqao73xy3ne7r@verge.net.au>
 <20190117141812.kvyjeja65r7e26jq@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117141812.kvyjeja65r7e26jq@ninjato>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_063850_819659_BDEF065C 
X-CRM114-Status: GOOD (  12.53  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 03:18:12PM +0100, Wolfram Sang wrote:
> On Thu, Jan 17, 2019 at 02:32:17PM +0100, Simon Horman wrote:
> > [CC Wolfram, Niklas]
> > 
> > On Thu, Jan 10, 2019 at 03:28:33PM +0100, Simon Horman wrote:
> > > Add SDHI3 UHS pin control and use it when enabling HS200 support
> > > for SDHI3.
> > > 
> > > Based on work by Takeshi Kihara.
> > > 
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > > Tested on top of renesas-devel-20190110-v5.0-rc1
> > 
> > I would value a review of this patch.
> 
> Can you resend with the added CCs, please?

Sure, done.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
