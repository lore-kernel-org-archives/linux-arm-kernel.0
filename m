Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:23:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB0C2082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LHfHgtql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB0C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D0vBCBFgQEmy11VSDGbkuAdgDzx+ciZ7OvbxM+bp7Ok=; b=LHfHgtql6lVybg
	16dHK9zqz3Cro1v6nwQD123KiWByrk5liipo4bDxb2Ez0l4APwcnVBQgiDxhCsHGtAEpoSgcf3pIG
	F+uHjEAY/gIq5uPwOVxcuwtPa3BljUeL2BbKNChz7XT5jWx0QgXhhvWUfQhUzmUwPNm3BztalZZNY
	RwTm0mEDMsH/aNCQdZqZeARRge/fDUvNvKwYPXeYzL+uBUH+ck9HM2dtFsgeI/BeTya3APhubN7kC
	+5phVfhyqnUQoXGP7E3Pq3DeGetakhROvcNxZUOiwgq/CTzJZTN39HJZtKZ3DwQvOgWFTttptltPQ
	z/AhtsfNX25LIIonlDCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqdH5-0006aC-1u; Mon, 04 Feb 2019 12:22:55 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqdH2-0006Zv-JT
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 12:22:53 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 7F06168D93; Mon,  4 Feb 2019 13:22:50 +0100 (CET)
Date: Mon, 4 Feb 2019 13:22:50 +0100
From: Torsten Duwe <duwe@lst.de>
To: Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 0/9] Analogix ANX6345 RGB-(e)DP bridge support
Message-ID: <20190204122250.GB7660@lst.de>
References: <20181018073327.64942-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181018073327.64942-1-icenowy@aosc.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_042252_790648_50236A2F 
X-CRM114-Status: UNSURE (   8.75  )
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
Cc: devicetree@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Oct 18, 2018 at 03:33:18PM +0800, Icenowy Zheng wrote:
> This patchset brings the support for Analogix ANX6345 RGB-(e)DP bridge,
> which is used by some Allwinner A64 laptops, such as Pinebook and Olimex
> TERES-I.
> 

So what's the status here? I'm working on the Teres-I and I find myself
recreating the chunks in this patchset almost verbatim (only DT so far),
one by one, so there must be something right about them ;-)

Whose turn is it?

	Torsten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
