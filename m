Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CD8C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A8D218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DibBLU5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A8D218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=svuLp1qNJ+l0ZEdnxMRDyZn4wYousPQmPSU1JQfXatw=; b=DibBLU5p0+GnfX
	y+tguGk6rW+yQY2oQq7lhezo7HdIW4rnhFLwt/mXD6674sf/YvhWEd7+dRSZcgeDBeKn/DKDUuIwS
	E2nNspHg1OKfEX+01HI1FO1+Qpa8QV36uXYdz856eTnopcTGiv8s/sLIxPh/j3lvKgkxHu3nXhCGL
	obrHpGVyzLdNtjW34oaXVOxMiVttcQokYSa+hGulc5Dh56HpCk3rf2OghihsxxNuvP96/NDr6VZxT
	kmZNxh9sUhjkiMxtEONHQHD8nXYx34HaRYxl4x/SF6gq0wimzLJW2GmukrRTZv7LXYdD91RrePyX0
	B+5Blg77LBWwzpcjV+QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0Fa-0001dQ-8J; Fri, 25 Jan 2019 12:06:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0FX-0001V1-IZ
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:06:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CFC4EBD;
 Fri, 25 Jan 2019 04:06:18 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0C93F5AF;
 Fri, 25 Jan 2019 04:06:17 -0800 (PST)
Date: Fri, 25 Jan 2019 13:06:16 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/3] KVM: arm/arm64: trivial header path sanitization
Message-ID: <20190125120616.GB18654@e113682-lin.lund.arm.com>
References: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_040619_616971_4AF396B5 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 04:57:27PM +0900, Masahiro Yamada wrote:
> My main motivation is to get rid of crappy header search path manipulation
> from Kbuild core.
> 
> Before that, I want to finish as many cleanup works as possible.
> 
> If you are interested in the big picture of this work,
> the full patch set is available at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test

Changes appear fine to me:

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
