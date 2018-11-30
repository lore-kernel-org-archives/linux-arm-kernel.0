Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C98C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:30:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B60B2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bl1hPEZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B60B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jKkp9L3TOEblq8BMRrQFXSA3cJpueRFUlgowYgD5vds=; b=Bl1hPEZOfIcTLM
	EXk2P81h/COR5BZjQAIWVQeyHdIV2JmMMhh6GBVNmYtFHEpmh1Xprh6fTZodARDhldN8Waw7x9xnq
	6gLXsyWPiIC/qxJX1I2VJF22FVnvxGE9h+BqvXvFleNyKioRh8BLy30xL+9CKzVpgmVVwEt0A1EXF
	9lnudMgLr9LFKlGMkfhsEIyu7i1Ey77OVsm5b4KRWieT1+iyWawSHjXVrvK617bbT8cVvi54iw1R/
	VVJidubTQFqdrsUPs0/Iqq9EmbptLUAW852mkjvgMuG5zG3zjj+kxmtC5Et+K47ReLMDk2jdjLHSg
	GGVqjSWzp84vjPAfcu7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSeBj-0007R3-Ie; Fri, 30 Nov 2018 08:30:15 +0000
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]
 helo=mail.osadl.at)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSeBg-00068o-8A
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:30:13 +0000
Received: by mail.osadl.at (Postfix, from userid 1001)
 id 459705C09BF; Fri, 30 Nov 2018 08:29:26 +0000 (UTC)
Date: Fri, 30 Nov 2018 09:29:26 +0100
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V2] clk: zynq: do not allow kmalloc failure
Message-ID: <20181130082926.GA6517@osadl.at>
References: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
 <154353512315.88331.4548631955021366823@swboyd.mtv.corp.google.com>
 <20181130075453.GB2456@osadl.at>
 <154356537055.88331.12823387821854167503@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154356537055.88331.12823387821854167503@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_003012_495470_35DD60BF 
X-CRM114-Status: GOOD (  21.88  )
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
Cc: Rob Herring <robh@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
 Nicholas Mc Guire <hofrat@osadl.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 12:09:30AM -0800, Stephen Boyd wrote:
> Quoting Nicholas Mc Guire (2018-11-29 23:54:53)
> > On Thu, Nov 29, 2018 at 03:45:23PM -0800, Stephen Boyd wrote:
> > > Quoting Nicholas Mc Guire (2018-11-21 04:28:30)
> > > > The kmalloc here is small (< 16 bytes) and occurs during initializa=
tion
> > > > during system startup here (can not be built as module) thus if this
> > > > kmalloc failed it is an indication of something more serious going =
on
> > > > and it is fine to hang the system here rather than cause some harder
> > > > to understand error by dereferencing NULL.
> > > > =

> > > > Explicitly checking would not make that much sense here as the only
> > > > possible reaction would be would BUG() here anyway.
> > > > =

> > > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > > Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > > ---
> > > =

> > > Nak. We don't have any __GFP_NOFAIL in drivers/clk and I don't see a
> > > reason why we would want it here either. Just handle the failure, or
> > > don't care if this is so critical to system boot.
> > >
> > It was not motivated by the criticality but by the low probability
> > and cluttering the code for this case did not seem good to me.
> > Effectively handling it here means BUG() - so more or less
> > the same result that hanging it on __GFP_NOFAIL if allocation
> > was not possible would cause.
> > =

> > Not clear what the objection to __GFP_NOFAIL here is - my understanding
> > was that it is intended precisely for cases like this - but
> > I=B4ll send a V2 handling it with BUG_ON(!clk_name) if that is prefered.
> > =

> =

> Or just WARN() and return. Maybe something else can get far enough to be
> helpful.
> =

> I would also appreciate if this sort of problem could be caught earlier
> in code review and/or with some automated scripting. Debating BUG_ON()
> and allocation failures is not what I look forward to doing so please
> try to make this exact sort of patch never make it to the list in the
> first place.
>
well it was found by a experimental coccinelle script
I=B4m trying to write up semi-formal specifications for
APIs so that this can be tested automatically and cought early.

If you put in a WARN() here it would still allow for the
NULL pointer to be passt on potentially corupting memory in the following =

snprintf()->vsnprintf() which does not seem to check for !buf =



thx!
hofrat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
