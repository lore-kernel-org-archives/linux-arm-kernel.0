Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07293C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:53:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FDB2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PFDtkAhW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0UjWaAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FDB2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fFbUoTqLjiaIelBCqLEggRkiaRXLclr3XrWjNDFXolw=; b=PFDtkAhW0siXkw
	YBCKdpTpEUFj/h13r/p/ceB4BkV/yDklePsiiT8dnzF8YqK3eXEBoTHKX26OIdTrG02sdwffm/HAn
	NU5xEE6zDF+hJPHmvrvIVHlPZtiJIH0L1ja7oHfzViJhmltGD7FakfTqmBRZnTxE1LhBu3VPXyKyF
	IQo8HJOacP49tJgb2q97cC2asDb/H2rKZA3LSX81vFGQB0nucOYPc4pPzSUvaLK3xqmqWPpTYbstB
	9QzvQnTe8qs+Uv0KiDCoRnVHopz+oeEEWNHG24dU7cwqOWWpqDGwvfBwstBlwyHUTPi3FptwdYyDw
	PM+d/eH8ZyAkHZktdKoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygun-0003tV-I0; Tue, 26 Feb 2019 17:53:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyguk-0003t5-8g; Tue, 26 Feb 2019 17:53:11 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D959A2173C;
 Tue, 26 Feb 2019 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551203590;
 bh=VjJneA/s4eX6456hCNL9/imBB29/UyDasE0Hx0zHNCI=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=d0UjWaAtvIVdH8EDkUxHLXUl2OzRAgrXAPVzsawVpPVJV9G8p2x0qwYeAkuDjOagp
 Oeq+qB6V+E2r9FxCo1lF5aIN+ptBdXgQeVnxUK/kesFdDF+Wnm+tAdFex0KQ66R+j+
 3SVwVZQtAqQXR75kbZMHO5zyhmxd7vZoR5J1ZdhE=
MIME-Version: 1.0
To: Matthias Brugger <matthias.bgg@gmail.com>, kevin-cw.chen@mediatek.com,
 mars.cheng@mediatek.com, matthias.bgg@kernel.org, mturquette@baylibre.com
References: <20190214163026.26073-1-matthias.bgg@kernel.org>
 <f7ed0750-665a-76bc-df1a-95af39fef8ec@gmail.com>
Message-ID: <155120358914.260864.17734674975447226263@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v4 0/3] Mark clocks as critical for MT6797
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <f7ed0750-665a-76bc-df1a-95af39fef8ec@gmail.com>
Date: Tue, 26 Feb 2019 09:53:09 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_095310_324552_FC6FE39F 
X-CRM114-Status: GOOD (  13.15  )
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
Cc: Matthias Brugger <mbrugger@suse.com>, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 jasu@njomotys.info, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matthias Brugger (2019-02-26 04:59:44)
> 
> 
> On 14/02/2019 17:30, matthias.bgg@kernel.org wrote:
> > From: Matthias Brugger <mbrugger@suse.com>
> > 
> > Jasper send this series some month ago. As there was no reaction from
> > his side, I'll do a friendly take-over.
> > I tested the patches on my Helios X20 boards and they fix the issue.
> > I didn't add a Tested-by tag as I added my Signed-off-by.
> > 
> > Changes since v3:
> > - add comments explaining why the clock muxer and gates are marked
> >   as critical
> > 
> > Changes since v2 (https://patchwork.kernel.org/patch/10686759/):
> > - axi_sel is not needed, drop CLK_IS_CRITICAL for it.
> > - update commit message
> > - add Acked-by from Mars
> > 
> > Changes since v1:
> > - add a fixes tag.
> > 
> 
> Steven, Mike any comments on this?
> 

I got patch #1 and #2 in my queue and they're not threaded properly as
replies to each other. I'll have to go dig out the last patch somehow,
but probably I can apply them now.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
