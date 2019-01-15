Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCEFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:24:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE9420656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N/INV8Fu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lMWbPaxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE9420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0L/h50T2zlO/XPLAREM8BgisHGcoMEIPWGaZZUjuAXA=; b=N/INV8FuLNrIr2
	QJlfTJacAcz2WvJQsyH5T4uz/WbRMdQfwiZZBs9SfNRDOiEBNdWfF0/D+ZXKx38Z6ooHqastHU0AB
	XwY4npGjtRkEUkUp7pqw1CC7kY5cjWK+jn4/uSjWxdIswQzHnofI7DYHjWoPvX45Wc23se8lC7DKt
	A8zi9i+bzo30fl9D+44Oqk0satSzKuBWTgWWnaj5qHN6IecRZCEeo3A2hiMqU14SDphxQxZfWEC1+
	MQkq5QwIa6YvVLg3suT3pXaV0g9Z9SuHO5kdcpbq4+mD1KzNQedB52gf7w1dWSvRlTedeKzTCdcgP
	5PzEz9Y+sCdYE3IKkzsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLti-000513-Sa; Tue, 15 Jan 2019 10:24:42 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLtf-00050W-9j
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 10:24:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qxmTCWGyazgOFNppuTpN2hUC9+AZKbeztXtlZm5mSew=; b=lMWbPaxjtwd4pdOXjvHridAKp
 8rMgIMCX/7aud8nc2a3terCDqb6Lz42vLKM9ISS2p0o20yHgVNzcjVo9WLzSnAuCuKpX6SYvm2BPQ
 Gygvn6DvilXAPk5snJQgsgaXub5bRw1YBf704Ff2f6s2+L2p00bHzlQ6RITKaGov2Kw50=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:35732 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gjLtV-00053O-PE; Tue, 15 Jan 2019 10:24:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gjLtV-0004qw-66; Tue, 15 Jan 2019 10:24:29 +0000
Date: Tue, 15 Jan 2019 10:24:29 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] ARM: Implement pgprot_device()
Message-ID: <20190115102428.yji6viia4lfhecqz@e5254000004ec.dyn.armlinux.org.uk>
References: <20190114135638.13520-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114135638.13520-1-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_022439_489798_7CE154AA 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: Vincent Whitchurch <rabinv@axis.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 02:56:38PM +0100, Vincent Whitchurch wrote:
> This is used when mmapping the PCI resource* files in sys.  Because ARM
> currently lacks an implementation of pgprot_device(), it falls back to
> pgprot_uncached() (Strongly Ordered), but we should be able to use
> Device memory instead.
> 
> Doing this speeds up large writes to the resource files by about 40% on
> one of my systems.  It also ensures that mmaps on these resources use
> the same memory type as ioremap().
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Please drop this into the patch system, thanks.

(Please also note that stuff here has been undergoing a progressive
major reorganisation and renovation, so I hope that still works!  Note
that the website now supports https as of last night!)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
