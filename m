Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC8C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940112080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NA205rWq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kmZU98/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940112080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VxmuB8quC96sImJLIv5NyV6eRliuuXEcQDDVTF5EjZ0=; b=NA205rWqTHSLiN
	tXazDk8qp8B+ff5fqEcjJCl7yStw7mSpyUM76n/VuTPVz7ArP+vOygQREB/xFP1fkupxseiIrOlap
	gyWdBvHWu13gQxFv25EdPZrpjr0WGDH1NS09zGAdGswR+umjyoVDkur3eqfgU+egtIevCdGWwbelm
	CPDeYxmS/CzjPYFmc6taukdVIxCQDyyLb0Xm4Pr27kttsF3fIqNQEk6Av5NMg+gIbIEv1KZYa5v76
	U/Hj2+lQVnR1C3jnbWd9gshWJbYVB6/cI5FQC1GnnCl14gTVuiAriZYmnspopm6fhonsKLWBjIgvP
	RRdig2cLodqB0FQF2FnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqjdm-0001Cs-IC; Mon, 04 Feb 2019 19:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjdj-0001Cg-Ns
 for linux-arm-kernel@bombadil.infradead.org; Mon, 04 Feb 2019 19:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PW8NE1XlxaD8bb+HrEb57cabhnfMb51RRzYHY6aqY2E=; b=kmZU98/yBgPvdnKTMiTnu0SRm
 ANsKopcUZbsqOdPtZ1sE26Kbtt6d74wdDlvp5aqvAwys3CyB94gEHap3YLrimNee7HsRlKzZ5jFLn
 WXy7xdG8z1fZPU0nym/kyWdp13mtzHu09KAokSbuCWL93LLxU0jlVzK9P/2ugP5QIbez39h/+b0/Z
 6EN5tV32B0k/tsch6+THEnway9mMTaYPu9S8lkaGFS/O7IYc0qMMjSTC4cTcsonYmWkn4OnXD1pMw
 Kl1hbGN1fx+Zw8oe6z8JV8SG+sWkE2W/5HnuKPSEXmgEcSVoAmjUqC3Rm3+YTWHRrTp2tQUz4nB3U
 lkpDPa6SQ==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqisV-00055F-TD
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 18:21:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FF57EBD;
 Mon,  4 Feb 2019 10:21:52 -0800 (PST)
Received: from queper01-ThinkPad-T460s (unknown [10.37.10.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2429E3F71E;
 Mon,  4 Feb 2019 10:21:49 -0800 (PST)
Date: Mon, 4 Feb 2019 18:21:48 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190204182145.wgl3a72s2cwargdk@queper01-ThinkPad-T460s>
References: <20190204110952.16025-1-quentin.perret@arm.com>
 <20190204110952.16025-2-quentin.perret@arm.com>
 <20190204180303.GD117604@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204180303.GD117604@google.com>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_132156_041774_847B6B75 
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
Cc: nm@ti.com, linux-pm@vger.kernel.org, sboyd@kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 sudeep.holla@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Monday 04 Feb 2019 at 10:03:03 (-0800), Matthias Kaehlcke wrote:
> There is the option to remove the OPP check from the cpufreq drivers
> and instead return an error from dev_pm_opp_of_register_em(), but with
> the more complex error handling it might be more hassle than it's
> worth.

Agreed. And that would make the API a bit weird I guess, so I preferred
the simple solution.

> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks !
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
