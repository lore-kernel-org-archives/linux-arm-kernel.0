Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D009C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F512214DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fjHzb3Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F512214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sa4CDMZpZgTpz/OX/HqgwKTC4Er5TTE6CgizWY0vovg=; b=fjHzb3Y/UVj4ue
	x+r7k4kONKCDt5Y+f6mvcKDWbOdiTMI8LHjFN0oXN/pSomuCDSMMu4IcDnpIWEDFTni1AoCeDohKa
	EBCRVsplfAGhObIy84BopeBq0Nmk5VEDZi0yQHph6u3yLG3UY8dMskhe/azv0vboHAfdxLf8BFesW
	y7NRYFIsZoDjqEsBluWFAmSke51EpYNjLN2168SGVDVUsVAum1aw8Bg49Yo3GQ3TP0yWlcdz1QP13
	OxPzlZPEqEFGz16UgnSesl3kucVDE8MU1fViwNrpIuDOrNF3T6iTg908b8VhB0UfGQLEo3qO1JzqV
	gU2ZY0JEpA6HCIuwp32Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUzAU-0004Aw-FS; Thu, 06 Dec 2018 19:18:38 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUzAS-00049z-3b
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 19:18:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63072EBD;
 Thu,  6 Dec 2018 11:18:30 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33C293F59C;
 Thu,  6 Dec 2018 11:18:30 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 56E061AE0BAD; Thu,  6 Dec 2018 19:18:51 +0000 (GMT)
Date: Thu, 6 Dec 2018 19:18:51 +0000
From: Will Deacon <will.deacon@arm.com>
To: Alexander Van Brunt <avanbrunt@nvidia.com>
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Message-ID: <20181206191850.GC20796@arm.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
 <20181029105515.GD14127@arm.com>
 <BN7PR12MB2708B742FD3448589AD0F259CFF30@BN7PR12MB2708.namprd12.prod.outlook.com>
 <BYAPR12MB27129A4EE7BBF57B1CAB5094CFAE0@BYAPR12MB2712.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB27129A4EE7BBF57B1CAB5094CFAE0@BYAPR12MB2712.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_111836_155073_D457F4E9 
X-CRM114-Status: GOOD (  12.39  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sachin Nikam <Snikam@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Ashish Mhetre <amhetre@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Alex,

Thanks for running these tests and providing the in-depth analysis.

On Mon, Dec 03, 2018 at 09:20:25PM +0000, Alexander Van Brunt wrote:
> >=A0If we roll a TLB invalidation routine without the trailing DSB, what =
sort of
> >=A0performance does that get you?
> =

> It is not as good. In some cases, it is really bad. Skipping the invalida=
te was
> the most consistent and fast implementation.

My problem with that is it's not really much different to just skipping the
page table update entirely. Skipping the DSB is closer to what is done on
x86, where we bound the stale entry time to the next context-switch.

Given that I already queued the version without the DSB, we have the choice
to either continue with that or to revert it and go back to the previous
behaviour. Which would you prefer?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
