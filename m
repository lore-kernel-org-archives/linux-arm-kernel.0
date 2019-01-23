Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F49C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:03:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CA221855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iZNCdIkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CA221855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jI1+uCeYDwZ11AP05cFt0cYdr6u+hqcFlvJ3+Yed+b4=; b=iZNCdIkDfGobJ3
	FhdB801ZWUwcDm8CwUkfvJlRsM6B/heCkktx8Y6qdIMY//WBu8NRDZizpd2o6BPD9u1XGTHrYBWL9
	+CMfc6otBxFwayCy2Jy76weWYcyDCkb7kxH+z+nnup3CF6aZLLrmedZAxE0deHRKVlyj8g29J4dKK
	fotTdB5rHaxoVMxDyLfXugryVv0to5XlzHcU06is3qxCTkYsBSxXzpEGDPLgJhZshEsPVZj97OnIn
	pD0t8msquUmtcH3RaDJDvL64mLTFf9T/TwnPxY/JhWYn6xED1T9H0apg1OeiFIFIoPs2agx/44cMO
	DCGMPPGvF2N0NCCe/1Wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPgP-0006YX-7k; Wed, 23 Jan 2019 21:03:37 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPgN-0006Xq-BA; Wed, 23 Jan 2019 21:03:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id B22C920F51B1C; Wed, 23 Jan 2019 22:03:33 +0100 (CET)
Date: Wed, 23 Jan 2019 22:03:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 3/7] coresight: Use event attributes for sink selection
Message-ID: <20190123210333.GZ27931@hirez.programming.kicks-ass.net>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-4-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115230742.13730-4-mathieu.poirier@linaro.org>
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

On Tue, Jan 15, 2019 at 04:07:38PM -0700, Mathieu Poirier wrote:
> +	/* First get the selected sink from user space. */
> +	sink = coresight_get_sink_by_id(event->attr.config2);

(I know there's a new version out, I'll go look there shortly)

should this patch not also have something like:

PMU_FORMAT_ATTR(sinkid, "config2:0-63");

> +	if (!sink)
> +		sink = coresight_get_enabled_sink(true);
>  	if (!sink || !sink_ops(sink)->alloc_buffer)
>  		goto err;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
