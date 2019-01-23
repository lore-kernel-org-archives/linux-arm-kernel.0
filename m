Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5775BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:09:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246A621855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hFZSqjc6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPSmr92C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A621855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pkNDQZowKlmMmuoT7qjzH7wom6PG8/5+63HV341vu4o=; b=hFZSqjc60aGAVy
	zXsjn67hd5BpSAOJTL3xa3dau76Fr92L8uuBuWYkNpF+N5kivMYqYO7V0mBsjoH7zYG8Z0EnJ6l3j
	8vFUz/A1dpWKu1K8lJTxNBV0rw1jtQ6P+G9kvPSgVm+byMYWo1Qmi2xh+WNuQvJoe1jPrq9McpFdY
	T5JwkYSl8//RYJsLGxUNWsMmNrx0iAIZ6Ea4gpPc95dotk0+WP1aDI6A5kibpciRo1R27s+XKsLeE
	mOO3gqNBrnpvnbU5hiDYY7mEIxdfmPMogGw3qvx/9xOiP6T+IOa73DsNk6oc7GplsFZr9Jc1RfQnZ
	aefTh6qbyduAT8zLG82w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPli-0001Ln-Cw; Wed, 23 Jan 2019 21:09:06 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPlf-0001LH-Sv
 for linux-arm-kernel@bombadil.infradead.org; Wed, 23 Jan 2019 21:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PzEEtvq+ZFIfdohoCxqGSejXKNUndYefJYH09iMapkQ=; b=WPSmr92Ck9WtUCUTlRaOi2o8p
 fvF6N6VxA7TIQSdC7bssukEMNAvkCby4Uusq4sy3rKZYOhx06M1PI6YXpegoXv3rXPvYoJqja1nLc
 qX1xCnEAxiQp6fvbwxjgogBqTP0DBsUFlndLHgxHPYaaXW+ytZ+Cym+iNqKDhVGPQP0m8UAGvzk33
 QZoYkl4l4F3kjud+X2zmJDejvXOinV436PemqURZ+rN0X/hKvvZ2TzCMc4R5i3zIF341fdakfXp57
 gH1MTB86xBNhKMzJCRbdJdg4UVzSm+5RkjO+U2zAj/wq1FigN1hbyJyP3s13epVeyrhNdvaLyPQ4P
 KNje0EWrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPlW-0000bJ-TY; Wed, 23 Jan 2019 21:08:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 59C8520F51B1C; Wed, 23 Jan 2019 22:08:52 +0100 (CET)
Date: Wed, 23 Jan 2019 22:08:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2 0/7] perf: Communicate sink via event::attr:config2
Message-ID: <20190123210852.GA27931@hirez.programming.kicks-ass.net>
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190122181144.26645-1-mathieu.poirier@linaro.org>
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, suzuki.poulose@arm.com,
 alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, acme@kernel.org,
 ast@kernel.org, mingo@redhat.com, will.deacon@arm.com, hpa@zytor.com,
 schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 11:11:37AM -0700, Mathieu Poirier wrote:

> Mathieu Poirier (7):
>   perf/aux: Make perf_event accessible to setup_aux()
>   coresight: perf: Add "sinks" group to PMU directory
>   coresight: Use event attributes for sink selection

Them looks good to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acme, since the majority is (4 of 7) is userspace patches, will you pick
them up once you deem that part good?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
