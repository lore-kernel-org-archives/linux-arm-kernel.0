Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378CEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:28:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03305206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fwSE6mqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03305206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d+feBjq1TWOral2CHiKYtjlQJqLe6pkzV8xfE+9KYdE=; b=fwSE6mqDMkOorE
	desa3PMBBSa7XuAkiKCg5MDi1emYtHOBvcQ5VmtCJiGwKbRNpdnI02hsrVKd/SGBVqF22e+IhwLrB
	wQ8eAjcks47Ijp4KgLiDd+7pROHA5r9CJcJIiOl/oK+0Kv6RaMzyRLFc2aAAMCw3X5kRTPA8N5XOj
	JLjF/H1C/6Vbpj7piRNBeU6FjRc5Yj5u/05Fy4RClA7SM05Yq5LEQqllOqGpi7zXzj72Zd9yiiIe1
	vvF0eEnp5/hBBsq/QFgcpHkEGScEuR+boaVzOei+lZ0v9mELAiAkLR3+ByowexE2PEyhgpEBj0TAw
	1iyx1OaJY7vveBxAGXQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKRk-000767-HL; Wed, 06 Feb 2019 10:28:48 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKRg-00075l-Ql
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:28:46 +0000
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 6dbad86b720669ba; Wed, 6 Feb 2019 11:28:42 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/2] PM-runtime: fix and clean up of time accounting
Date: Wed, 06 Feb 2019 11:27:30 +0100
Message-ID: <30395680.vVXis5MGQY@aspire.rjw.lan>
In-Reply-To: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_022845_027962_055ECE8F 
X-CRM114-Status: UNSURE (   5.98  )
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
Cc: ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, thara.gopinath@linaro.org,
 biju.das@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
 geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Monday, February 4, 2019 5:25:51 PM CET Vincent Guittot wrote:
> Fix time accounting which has the same lock contraint as for using hrtimer
> and update accounting_timestamp only when useful.
> 
> Vincent Guittot (2):
>   PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
>   PM-runtime: update time accounting only when enabled
> 
>  drivers/base/power/runtime.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> 

Both applied, thanks!



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
