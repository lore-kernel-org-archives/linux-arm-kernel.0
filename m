Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8EEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:20:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7876F2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iXpDXkdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7876F2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rbzom7Cv2TZFAX+/IQ/CouMBgk8QgEBTEC2/FHdmaOA=; b=iXpDXkdunqCiDb
	DOnb13/LCTHnbtlszg1Ey7NEUtVSD7xuGPp0XGocpAhKLTLe2uRCzmiT/ETNsTAQ0NSxQrPHXaBK/
	tsdWy418cEZHPF+oSgydBj5Fy3NGYNYX+1W3gofiCgivr6fXTArLr0+ej8ReZh2oOORjujMk5kVfl
	BTkEwgYkbAtenzbsenvgjQWKdOxT0z0C2FzxOUFCaAgMMWy/MYcZVQhKQP6wggU0wBZzrViKpC2AX
	51bzaUZVkcdJUyhuWQ1VWFN3ZMT95ujgQSQZjSgzdF5hsd/6G9AnE0I43nrj6yumAL/WcCJwdR6AE
	k8pjvu7j2NGtSK/ZA9Yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd7yV-0002yJ-MA; Sat, 29 Dec 2018 06:19:55 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd7yR-0002vR-Mm
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 06:19:53 +0000
X-IronPort-AV: E=Sophos;i="5.56,412,1539640800"; d="scan'208";a="362048899"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Dec 2018 07:19:35 +0100
Date: Sat, 29 Dec 2018 07:19:35 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 00/20] drop useless LIST_HEAD
In-Reply-To: <20181229052504.GA16315@magnolia>
Message-ID: <alpine.DEB.2.21.1812290717010.2673@hadrien>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAKR_QVJefW1vxYb7-qiU8=0YdbFghYo15SK2eGjOC-dntRfyYA@mail.gmail.com>
 <alpine.DEB.2.21.1812232304130.2940@hadrien>
 <CAKR_QVLeZBL43W4x1mzcfcakSZyyh9L81vgUMxfnSccKawEfdg@mail.gmail.com>
 <20181227134055.GA2272@kadam> <20181229052504.GA16315@magnolia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_221952_010304_AFA66784 
X-CRM114-Status: GOOD (  17.62  )
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
Cc: linux-wireless@vger.kernel.org, linux-nfs@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org, xen-devel@lists.xenproject.org,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Psyborg <pozega.tomislav@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On Fri, 28 Dec 2018, Darrick J. Wong wrote:

> On Thu, Dec 27, 2018 at 04:40:55PM +0300, Dan Carpenter wrote:
> > On Tue, Dec 25, 2018 at 11:12:20PM +0100, Tom Psyborg wrote:
> > > there was discussion about this just some days ago. CC 4-5 lists is
> > > more than enough
> > >
> >
> > I don't know who you were discussing this with...
> >
> > You should CC the 0th patch to all the mailinglists.  That much is a
> > clear rule.
> >
> > For the rest, Julia's position is the more conservative one.  I was in
> > a conversation in RL and they were like, "CC everyone for all the
> > patches".  It depends on the context, of course.  If the patches are
> > dependent on each other then you *have* to CC everyone for everything.
>
> Agreed.  Ms. Lawall, sending "Cover letter + all relevant XFS patches"
> (as you did) was exactly the right thing for us xfs types. :)
>
> For that matter, we prefer to receive through linux-xfs more patches
> than necessary (one can send the entire series if one is unsure) than to
> go wanting for more context.

Thanks for the confirmation.  I was planning to ignore the 4-5 advice,
because there is no way in this case to make a meaningful 4-5 list
suggestion - it's either all or nothing.  But 20 patches at once is
perhaps a lot as well.  In this case, I just wanted to get rid of the
whole issue at once.

julia

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
