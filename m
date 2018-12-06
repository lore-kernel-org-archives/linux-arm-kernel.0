Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0651AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89D220892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvlAGfbe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+CKNSNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89D220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U2WpFePNwY6BZpD17Kwg/fOu/+614DICpVvjmzp0KNA=; b=cvlAGfbeWODbcS
	BqjikmPI3+1N7QU1eGS0aeuXHjbCxBXYj/x6Mei41lGGtvw0IB3iYRUafKk2ntfscPqjikEDUIkr1
	jan3ion/raRApm4SZys1KXNoA1QFyV5Z/1vQCe0yH7eprNTH5o3USy+U14IpJ6V7snVBZEhBinCVj
	f2c350TyNcN4wrL84KaH6FEjUTG55OcYYWesTdZ/ZP4Il6A42aslT0eqDb1FOgxNWunbiB7nzWEr2
	6V/hX2nXX2nyplhV2+UdMFEpC1dXA+F/I4KYjVvYmpUY2CbDd3ih2+0r81HeMFYtMtjbEH0F1o93c
	0M7jVdBr4nYAucoHncrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtdN-0004lr-0e; Thu, 06 Dec 2018 13:24:05 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtcu-0004Jc-Ko
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 13:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bx3+wJx8C8WykstWYS4tsHbLBkUM+4DvgzxwwdmmHIM=; b=X+CKNSNiF5g6PHd9RYyOGKUcB
 xI0801MdvvqmaWivt4hb3J0h5uRfAbh/3kAcIPDdyhDrK6+kNNhGettQs53TuwmvO+XHrwLotBVlS
 j7goA5Ep2aMqduwVESN+pmn0akmRwPW5b0Pfe7YPKPJJD28qZmaYh42UF21UfRo5JAjdywKvEty5O
 6WlnzGL8nLn1yhoVP4N3ac4UhSaq130wgif+c5y6Pz4YvFqnXnpg4VeGlW9AaUihqi7f96G6aDcv1
 ml+BXAUCbLbcxw1h0VE4HmgQWU71vmYjG6uKI6Znal1E51UlaBc7Cd1C0YUwNda2uk3/GkFfyc2h0
 v2qyizj2A==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsrB-0006gH-77
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:34:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF78A78;
 Thu,  6 Dec 2018 04:33:59 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA6D43F575;
 Thu,  6 Dec 2018 04:33:59 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id C9B881AE0BAD; Thu,  6 Dec 2018 12:34:20 +0000 (GMT)
Date: Thu, 6 Dec 2018 12:34:20 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
Subject: Re: [PATCH v11 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
Message-ID: <20181206123420.GA26473@arm.com>
References: <20181206115053.7665-1-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206115053.7665-1-ganapatrao.kulkarni@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_073417_625590_22F83462 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "Nair,
 Jayachandran" <Jayachandran.Nair@cavium.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "gklkml16@gmail.com" <gklkml16@gmail.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Richter,
 Robert" <Robert.Richter@cavium.com>, "Lomovtsev,
 Vadim" <Vadim.Lomovtsev@cavium.com>, Jan Glauber <Jan.Glauber@cavium.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ganapat,

On Thu, Dec 06, 2018 at 11:51:24AM +0000, Kulkarni, Ganapatrao wrote:
> This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
> The SoC has PMU support in L3 cache controller (L3C) and in the
> DDR4 Memory Controller (DMC).
> 
> 
> v11:
> 	Updated Patch 2 with minor comments.

Thanks. I've pushed this out on my perf/updates branch:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=perf/updates

but note that I did make some spelling and formatting changes to the
Documentation patch, as well as removal of the event descriptions (they
should be part of the perf tool, as is done for the other system PMUs).

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
