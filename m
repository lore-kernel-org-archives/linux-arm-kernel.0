Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9CCC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:05:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313E420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QWFEoGaS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IjqReS6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313E420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6JcZlmwJt1ZZWywg8UVBQq1BAaaJ28CIjh2bhzpn1oQ=; b=QWFEoGaS0BHTwy
	+SZFcChnJx48Hx9rjYgwVk+ykxgoQxYmC/NxH2TSqn2I/UplZd1hYxda04WlBtkd90BiIcaoxaYwM
	mSRdMky1jLyHi2d5v4VLIntKtS3gI2xUwvT4QCgOdzWqSgalb67t5Up1ZlJR1sBbzkGEavAeTVBpj
	rppwEXSuQQzUjUy3Xk81n3Ltpiw3AiD7QGof+dNXO9YunOyUIzDHW0lbODojMr1QI0jmRwPGwobZb
	yAMTPdaqheIpXqAyTZ3I7P1GNUwn50iN9XzipfxSRxgx6daPHJdNS66icPsjAH1ESCRcmrAAEXRkn
	XEPkkUQNoh7vCKjy2KgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPkN-0006kd-Dv; Thu, 13 Dec 2018 12:05:43 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPjz-0005YJ-VT; Thu, 13 Dec 2018 12:05:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YHBAn6Ek+k/h42GjfXZDeFIIgMBUDfxFY1erlttMv0Q=; b=IjqReS6adJfLFbgF+mIu/VEk5
 FvhuWuZyb4TAmJwcz+Ui9z/QXzgvXPUc1JJuKrXjnVK1y/HjKOfLU58JFFBFyEl0/FmzD20S+RzZY
 cKEJxBxNnSk+i143KLkLhO4jGOIkEnaljsqvEJbl9WX1qgYZ6+grPToRKFHfJq+vAN7K0=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:43431)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gXPjh-0002JT-Dk; Thu, 13 Dec 2018 12:05:01 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gXPje-0004hJ-7K; Thu, 13 Dec 2018 12:04:58 +0000
Date: Thu, 13 Dec 2018 12:04:56 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 5/5] ARM: actions: remove boot_lock and pen_release
Message-ID: <20181213120456.GP30658@n2100.armlinux.org.uk>
References: <E1gXPav-00064t-KY@rmk-PC.armlinux.org.uk>
 <20181213120153.GA18173@mani>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213120153.GA18173@mani>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_040520_017016_95C23549 
X-CRM114-Status: GOOD (  13.97  )
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
Cc: linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org,
 linux-actions@lists.infradead.org,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 05:31:53PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Dec 13, 2018 at 11:55:57AM +0000, Russell King wrote:
> > The actions SMP implementation has several issues:
> > 
> > 1. pen_release is only ever read and compared to -1, and is defined in
> >    arch/arm/kernel/smp.c to be -1.  This test will always succeed.
> > 
> > 2. we are already guaranteed to be single threaded while bringing up a
> >    CPU, so the spinlock makes no sense, remove it.
> > 
> > 3. owl_secondary_startup() is not referenced nor defined, the prototype
> >    is redundant, remove it.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Hi Russel,
> 
> Is this patch a superset of https://www.spinics.net/lists/arm-kernel/msg694546.html?

Probably not, I couldn't find which platform Linus had already done in
my mailbox, so I just did those that I could see in the kernel tree.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
