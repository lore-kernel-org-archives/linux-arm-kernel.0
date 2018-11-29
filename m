Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B22FC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:10:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A3F21104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IajDG6zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A3F21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WCedGuXHaDufSRM/ZKm/8AU/i9aAG6/2XW5MEujbzC4=; b=IajDG6zl8qQGxF
	8Va0JKEJCleukVQbsUxt+4oQB1+mzNYHVmHmGGgXPeYyqWmU7sAOsmpMPlfTo2UXgqx5R8c7/4zT/
	+56lbS7OHJShk6VQUialjI6YSGYPf25MNDk7pasrc3l/BOVW1LS1lxZ8yX6D6kT0/BDeOJGG9hd/e
	NY/qipKDZxTFeIlQlMWVTmx5tO/kzyBDXPT97qu8SAWAVD6gQobZScJNx3eYdkFUWyUa0mMXEWXyc
	LJYAb9/9hdbQ/aso+hDzmB//HJgid1nEDjuvjfcui226e7xrh5flx2NGrQEEH0hj+LGhA+KCJrEVF
	3jMU1R/aQD+1Yx9hWzPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSRh9-00022k-8y; Thu, 29 Nov 2018 19:09:51 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSRh5-00022M-G2
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 19:09:48 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 594D780EA;
 Thu, 29 Nov 2018 19:09:39 +0000 (UTC)
Date: Thu, 29 Nov 2018 11:09:34 -0800
From: Tony Lindgren <tony@atomide.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7: Move the ti, no-idle quirk on proper gmac
 node
Message-ID: <20181129190934.GX53235@atomide.com>
References: <1543401907-14751-1-git-send-email-t-kristo@ti.com>
 <1c2e5a69-f0c4-47c6-79d4-a11521b6ecda@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c2e5a69-f0c4-47c6-79d4-a11521b6ecda@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_110947_572440_5332DBB3 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [181128 23:11]:
> 
> 
> On 11/28/18 4:45 AM, Tero Kristo wrote:
> > Hwmod parses the DT hierarchically from root to search for matching
> > ti,hwmod property. With the introduction of L4 data, we have two nodes
> > with the ti,hwmod = "gmac" declaration, and the hwmod core only matches
> > the first one found, which is the target-module one. This node incorrectly
> > dropped the ti,no-idle flag, which causes number of problems, like ignoring
> > errata i877, and also causing an intermittent boot failure on certain dra7
> > boards.
> > 
> > Fix the issue by moving the ti,no-idle flag to the proper node.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > ---
> > FYI: The problem is seen in linux-next.
> 
> Thank you.
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com> 

Thanks for catching it, applying into omap-for-v4.21/dt-ti-sysc.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
