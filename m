Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18164C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:59:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C789720839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AzET1u/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C789720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lc4rdnTwsT1vTKYB9VrMQtEpAKjKjPA9EBAOpd8PeSU=; b=AzET1u/JFsuLK3
	Rb3KNM3CPgW8F7OxfBfMF/dKTXyFbzmqvTqXZ7uxjm8qJMSa+mG9X4UaynTMdBE5bwWfDXIi3qTQJ
	c7titcdTq+lNXgx+HaXHuFKBWipgucOqtb8+T6Q8JzxoXEFaI6zqJNv1+9Mtp9hSH1Sp7JhnCPa3V
	FMo9TSpEC0RSXGee7KFHQpDAO2OGu0liRolmGXpkGAyXr75liC8etAJVDS6RpPGSawoAO9F6wVYDV
	kft1IiZJ+anmr791kBxyBcod5thoHSE8TSY1kK6hYdxqozsZCB2UgIJMVRbptPdz1N5VU58iC2aoA
	EPO889e/SpYmHan9yMMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX5ym-0004YK-CB; Wed, 12 Dec 2018 14:59:16 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX5yk-0004Wz-09
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 14:59:15 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id B0B57809F;
 Wed, 12 Dec 2018 14:59:06 +0000 (UTC)
Date: Wed, 12 Dec 2018 06:59:00 -0800
From: Tony Lindgren <tony@atomide.com>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: Regression in next-20181211 with fsverity changes
Message-ID: <20181212145900.GD6707@atomide.com>
References: <20181211191220.GW6707@atomide.com>
 <3171217.2PqYythArb@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3171217.2PqYythArb@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_065914_075568_A683C288 
X-CRM114-Status: UNSURE (   7.53  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Chandan Rajendra <chandan@linux.vnet.ibm.com> [181212 04:16]:
> On Wednesday, December 12, 2018 12:42:20 AM IST Tony Lindgren wrote:
> > Hi,
> > 
> > Looks like commit 4de97efb578a ("fsverity: Move verity status check
> > to fsverity_file_open") causes a boot regression for me with root
> > on ext4 SDIO card, see below.
> > 
> 
> fsverity_file_open() used to incorrectly return -EOPNOTSUPP for non-fsverity
> files on kernels built without fsverity support. This bug has been fixed in
> the V4 patchset <https://marc.info/?l=linux-ext4&m=154458767124953&w=2>.

Yes thanks for the update.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
