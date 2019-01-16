Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4906C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:26:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8284220657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ebLgVQko";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="d4E+okoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8284220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PImPZeRnis8WN4zWqsRYCwTeVJHROKpEl24Yyd/jH5I=; b=ebLgVQkonqa1Ij
	m7pL5wHqivH9SmynlckIDy0321g1RVZnvbhYCHKAhHHjSPxp09GIc+jp+yShAsKlcsVHL3hPwiDoY
	m5+BxXvfYQz1zxbp9FYJYUDoWhuFxGKp7bUO2m6BGyPPE0hWTeN1T3Z4g1YdCcxdsgidCGcI6Eqq0
	IfPXb54z6OpTecjJBsqaU5Xld9Y8ssIIpsMFkK6Hn9vjkL+HxaCmYeMNeiCqqWmVKWPReU69m/xut
	6TmDkh/etY10vYlWzpvr2KSFMxgj7lGYPWUBOMcekglexDxI8NX9uYyMR6TwU6sn0i1+Rw+bi7uGq
	e1NgcymZn9rG1R5m1W6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkGb-0001is-Nl; Wed, 16 Jan 2019 12:25:57 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkGX-0000Nk-LZ
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:25:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=azyjXd4RO9qFZyIBZ05httfV8jISNgIefpZ0zL7n5RU=; b=d4E+okoh+9TfKJATmBBvp3bva
 A9loThAOto+N5xG+WxfOee22IPVrhA5DnmtduXL10OOvzKU+T82KXn+CI0JVjGK+dnMe7EGS5K2ML
 CNm+UvNpPERjgt8IzD1zcqD5Q7HF/fABLcSW7C52UexXUzd4SVzUQqQUG2RXSKgcKhx6U=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36912 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gjkEP-0003PG-1j; Wed, 16 Jan 2019 12:23:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gjkEO-00069o-EN; Wed, 16 Jan 2019 12:23:40 +0000
Date: Wed, 16 Jan 2019 12:23:40 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] ARM: Implement pgprot_device()
Message-ID: <20190116122340.3qmwi35ulxerrc6v@e5254000004ec.dyn.armlinux.org.uk>
References: <20190114135638.13520-1-vincent.whitchurch@axis.com>
 <20190115102428.yji6viia4lfhecqz@e5254000004ec.dyn.armlinux.org.uk>
 <20190115150816.352ujzjaszj2pbch@axis.com>
 <20190115170415.hkt2kllktxseypdw@e5254000004ec.dyn.armlinux.org.uk>
 <20190116102223.afiok444j7fghukc@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116102223.afiok444j7fghukc@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_042553_862796_759A0EBA 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 11:22:23AM +0100, Vincent Whitchurch wrote:
> On Tue, Jan 15, 2019 at 05:04:15PM +0000, Russell King - ARM Linux admin wrote:
> > Argh, soo many problems!  Okay, should be resolved, and I hope I got
> > all the places where <unprintable> PHP has changed. ;)  Sorry about
> > that.
> 
> Thanks, the website now works, but the mail server seems to always fail
> to deliver email to patches@armlinux.org.uk.  I'm using the same setup
> which I've successfully used to send patches to the patch system before.

Thanks for persisting and sorry for the ongoing hassle.  Looks like a
typo in the SQL grant tables for the new host name, which caused the
script to error out.  That should now be fixed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
