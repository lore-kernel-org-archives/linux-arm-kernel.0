Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC346C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:01:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B336820836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i+bASd5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B336820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pNex1VkOZpMyN1vqyenmWDIKOc86hW9nzpwtPowgnKE=; b=i+bASd5xBjlh7I
	ISy7Kkv8c+PPiDBl7PN3V8U+1b2BfZXKCTRVSG96EFM2sgupWLV+y8mXsl+TRfnHtocLeL5ofE87o
	RhzXeOw6vCJBqWvUA8wc0saw+OQM2spXDPjzASb2VGNcvq6tWfoQGPRE+m0bYbhejZ2iUhqsB3bby
	PlAP/mHN2c/rwXViu7LCTcjJbDn/VAIvw3Gqv764tFJLHwuUp0YOdtseatGXIWeQtpBoXy02rHBx5
	9jTZcN+zCvTi72ibbICMSvp7eJENk3QAx5u09Lzc7++VvcpR6SjwD8f9vywMoci2o7nN77KJWn3p9
	qTxHk9lUCUSuOrtY/blg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghwRL-0001g3-Kx; Fri, 11 Jan 2019 13:01:35 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghwRJ-0001fN-8m; Fri, 11 Jan 2019 13:01:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id CF3F8202A6058; Fri, 11 Jan 2019 14:01:30 +0100 (CET)
Date: Fri, 11 Jan 2019 14:01:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 0/2] System-wide mute of hotplug lockdep during init
Message-ID: <20190111130130.GA12917@hirez.programming.kicks-ass.net>
References: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
 <0f2b6cc8-ad2f-bd0b-fe51-c333a8033452@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f2b6cc8-ad2f-bd0b-fe51-c333a8033452@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, cai@gmx.us, marc.zyngier@arm.com,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 dietmar.eggemann@arm.com, longman@redhat.com, tglx@linutronix.de,
 mingo@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 09:53:58AM +0000, Valentin Schneider wrote:
> Hi,
> 
> On 19/12/2018 18:23, Valentin Schneider wrote:
> > In [1] Peter had a suggestion to broadly mute hotplug lockdep warnings during
> > init instead of going after every single warning and wrapping them with
> > cpus_read_{lock, unlock}(). This is implemented in [PATCH 1/2].
> > 
> > [PATCH 2/2] is a logical follow-up as [PATCH 1/2] is the generalized version
> > of the reverted patch.
> > 
> > [1]: https://lore.kernel.org/lkml/1543877121-4098-1-git-send-email-cai@gmx.us/#t
> > 
> 
> Gentle ping - I suppose this flew under the holidays radar.

Indeed so... got them now. Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
