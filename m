Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5257EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:25:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E364320866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y3y1BpFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E364320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n751B0ibzieiQyZxDMAv0NF0PRSY/5efxwXoVsw57JA=; b=Y3y1BpFFR8/ISe
	7Fb/lXtBKUNhkh+F5rOTA1Dwzm4MQOwJ3Nip9JVN+1LN/YAVywIqDBQBAYxe3Xv4i5GzKwj0APMix
	3rjBS09UMNmAuW1nySWmCUPIjSrIZRj81YeZ0s+eFRvisipbT2CptccOu9nDI8e9s2pzQCz2aDATn
	e60ngyykIwti6qa9YhBRRUTT2gcoz6vaY4z97lXkP3xTQWx3fZq1J/EdW8juPCrRo/ME1sxZCVWMs
	pfZVUwURPZXYWqMNjzVuqJgWmGANP1qpIZw6l3rau0nbVhM4/RT2slyHsliTkFb7HqjUMhQKKPOat
	IXVRUBTqSmC0TR1UsXvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjqo6-0001Mb-48; Wed, 16 Jan 2019 19:24:58 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjqo2-0001M8-R3
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 19:24:56 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id EB30B207B0; Wed, 16 Jan 2019 20:24:52 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
 by mail.bootlin.com (Postfix) with ESMTPSA id 93244206F9;
 Wed, 16 Jan 2019 20:24:42 +0100 (CET)
Date: Wed, 16 Jan 2019 20:24:42 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
Message-ID: <20190116192442.qz4xi2ky6axgiyvg@flea>
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190115094951.e7jnjpibj5tcp5pz@flea>
 <20190116075854.o2kme5nxq5kckwem@plaes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116075854.o2kme5nxq5kckwem@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_112455_008259_6FE0996A 
X-CRM114-Status: GOOD (  17.53  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
 Chen-Yu Tsai <wens@csie.org>, Jonathan Liu <net147@gmail.com>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Priit,

On Wed, Jan 16, 2019 at 07:58:54AM +0000, Priit Laes wrote:
> > On Mon, Jan 14, 2019 at 01:29:34PM +0000, Priit Laes wrote:
> > > I have a somewhat curious case with one HDMI/DVI screen that fails
> > > to initialize properly every 6-7 boots. The display itself is also
> > > somewhat flawed (missing HPD pin and the VSYNC/HSYNC pulse width
> > > is set to 0 in EDID), but I suspect there could be some issues
> > > regarding timing in A20 HDMI driver in Linux.
> > > 
> ...
> 
> > It doesn't look related to the clock rate itself, since it doesn't
> > change between the two cases. However, in one case the DDC clock is
> > enabled and in the other it's disabled.
> > 
> > Was it taken at the same time? Maybe you can try with that patch?
> > http://code.bulix.org/z7jmkm-555344?raw
> 
> Thanks, after doing ~50+ boots I haven't seen a single failure.
> 
> Previously I had following failure cases which are now both fixed:
> 
> a) Linux without u-boot HDMI, where one in every 6-7 boots failed.
> b) u--boot with hdmi enabled switching to simplefb and then switching
> to kms, where previously all boots ended up with garbled screen.

So it's not really a fix, but it really looks like the clock is not
enabled when it should.

Can you describe your test scenario a bit more? What are you doing
exactly, just booting? When do you start using the display? When did
you capture the debugfs output that you pasted?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
