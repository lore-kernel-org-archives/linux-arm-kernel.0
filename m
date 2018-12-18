Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65848C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:09:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B58B217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F5k9zGj1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hI9BOk64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B58B217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=itJ9OpnKNO9ADgOmmeHAtc/0fq+gnbzaq2NxEJYFUY4=; b=F5k9zGj1+vpxPW
	SUWPBknSOAVBaQKdRq28IBI1EIAGotjNaPK3AROQjT+thb+U/Q7RAJ/IiRL8Bs3nqTb58f+7BDHNa
	tkbT55CldQ1e9DhnXxh1WpaLOQTPk6ihT3UIIQU0IlpFbwWtIN6XTwQIIBKFCeEP2nB13zjcnIbIe
	FHjpK8qnL9EVEWUikhsYy7+3ZoJxCey8N7WhyazGOs+mDJ8evAe5PtmedvsbKIAips2rPqK+wRITD
	sPXYltfs3/ANEw0IUsW+dSJ3zVLlC8YHtvjpA324x6Fk89y18S3SAgWeXq0H5jYA480fLxXOVeU+z
	pOVAkV7fhqvx5yB3XfaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCJw-0003dI-5c; Tue, 18 Dec 2018 10:09:48 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCJo-0003cj-Fj
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:09:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EM5/yTbAWu+OgEPFkQtVFJMmmXdtJiDbsm85sBw+wWg=; b=hI9BOk64uDP/xAZaLL6eMBpm8
 d5RlRUqI4+X9qOSKNpCDMSZ/Q8iyBHvSbWtZMWkFslTOqI1uncu8pTmSsaSY6gZ0RXn6mpiV7aWgO
 zAZFVHY5R15PIP9v4YzuqACd5AlclsKXA+4a+6GoNf+I3uAYCMXGsUaGpZj1zdtijhzXM=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:55925)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gZCJU-0005VE-Hk; Tue, 18 Dec 2018 10:09:20 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gZCJN-0005p9-0i; Tue, 18 Dec 2018 10:09:13 +0000
Date: Tue, 18 Dec 2018 10:09:09 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Helmut Grohne <helmut.grohne@intenta.de>
Subject: Re: ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko]
 undefined!
Message-ID: <20181218100908.GL26090@n2100.armlinux.org.uk>
References: <20181218093630.io6p4ovl36hnxalk@laureti-dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218093630.io6p4ovl36hnxalk@laureti-dev>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_020940_526012_F1D31677 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: Juergen Gross <jgross@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Paul Durrant <paul.durrant@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Ben Hutchings <ben@decadent.org.uk>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 10:36:32AM +0100, Helmut Grohne wrote:
> Hi,
> 
> During a compile test of v4.20-rc7 for armhf (cross build), I
> encountered:
> 
> ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> 
> Some searching brought up c5157101e77 ("arm64: mm: Export
> __sync_icache_dcache() for xen-privcmd"), which fixes a very similar
> problem for arm64. Is that commit maybe also needed for arm?

I would rather not export that function for drivers to abuse.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
