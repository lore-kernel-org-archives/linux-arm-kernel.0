Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEF8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:44:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5BB214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SEqQW5Er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5BB214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZyHQFWg8HoUTVltWWtXpuF3WPuQkRX2HwLvFIm177nI=; b=SEqQW5ErbepUKl
	NvSnmROvOD57m9Bx8K4DrCEzyIgsZ5AORgUK6ORgJn/4WsNVuDZ8YIykEb7/riEQMfbg1IDuXS+gS
	6ZnfSd0TujmAfvq9S4zPcMPTM6zB/7mH1lcIpW/GrgK/RSyUoL50G48qPa+f4Hqf8OjMgUlAi/PnO
	RMaiUMyvzlb0bwMcIMLgbewgTwhUbu8KuBNdfKR95X50DSS/JBffwfhY08PnMIDzQTHlRfCSnJs3k
	u16sC4hHxYaJ5bONEiKYgAkX7RuF0/+VsWeL7eIAeXwod3WyBJwnj7w8TNe5ph0XJkQSaTIlu1PeF
	xwhUOQ7mpEx/PdJjaMDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdRe-00070e-NS; Thu, 10 Jan 2019 16:44:38 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdRb-00070H-Cg
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:44:36 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 23A7680E7;
 Thu, 10 Jan 2019 16:44:41 +0000 (UTC)
Date: Thu, 10 Jan 2019 08:44:31 -0800
From: Tony Lindgren <tony@atomide.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] PM/runtime: Fix autosuspend_delay on 32bits arch
Message-ID: <20190110164431.GA5544@atomide.com>
References: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_084435_463524_B669EACE 
X-CRM114-Status: UNSURE (   7.82  )
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
Cc: ulf.hansson@linaro.org, ladis@linux-mips.org, linux-pm@vger.kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Vincent Guittot <vincent.guittot@linaro.org> [190110 09:00]:
> Cast autosuspend_delay in u64 to make sure that the full computation of
> expires or slack will be done in u64, even on 32bits arch.
> Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
> is used when moving delay from msec to nsec
> 
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> Change since v1:
> - add u64 cast for slack computation

Still works for me.

Thanks,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
