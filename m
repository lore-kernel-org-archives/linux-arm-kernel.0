Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABE7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:49:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306A72087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G/4bjmJH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uVnlZiqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306A72087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+qlKHdplP5fDdj0EMCgnsNMKi1R62iq8ijuX+R8IM+U=; b=G/4bjmJHvsJ+CH
	igZdVtdoR90wHszqCUVQqxe81Nonrf71iepqbfxm0TedsRvhZ/E9dnbcKVWI8ehk4InXlJDHHOpyQ
	SsCtuI9jWUlzTPXRT1JeVuPi7FYlR0LHzaE9GMlfZwHuRGYdwNGkVGFNc6IM+R8JERZH3kHG6YzpU
	M4l7GXi6zdjM6Vrib9MU2k0ZGQeYX87By4G24RkeK2teN8C0nuGDyUhf/+mCFBf4h+8ZqnFO8Wrvh
	u6fPe3e+Gh12a4jajh15mO2ypPY0cD/+oS1bn7HcUMrQpfxcbsszHee3y02QrUx0itYl2byoDWmWb
	+2/jT9GIOQA6V5IIjZIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggox7-0000If-Nq; Tue, 08 Jan 2019 10:49:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggox6-0000IT-AY
 for linux-arm-kernel@bombadil.infradead.org; Tue, 08 Jan 2019 10:49:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OnwtPs5be4ZWFbK8e++4kO+bbmnQAgKMSMIUXwvqZ74=; b=uVnlZiqDJqSeyKFfOli3GPUc1
 iEqVHqOPhWABh6R2Foby075U7DYteAbyFJ0uaSp7vffyX8YZvXaEIMzImbXX5B5CgvBKZLD7B7bJB
 ISqzcSH1vIINbEABvu2tkGXRioetvKjgouy7mUs3dvf0nGtU/QdaQyNJrrUSteo/zYJ70/BgVxbaL
 CHZdEO81Te7so71ZiMNq1OfG7hxdHp9T8D/cHumpAeaq5GCCiB4njv0lwwz9a6j0PFER2rofTxLDt
 O6uVfVvU0HWe6zjKwp/+yUfRjcZ9oq/LUtbxhF5CSHNonNIQdwx8RcMyEn20an2YufILOCtRtM7nT
 m0v42t79g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggox4-0003tQ-3x; Tue, 08 Jan 2019 10:49:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id E1344201BC2AE; Tue,  8 Jan 2019 11:49:40 +0100 (CET)
Date: Tue, 8 Jan 2019 11:49:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v4 11/13] x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Message-ID: <20190108104940.GE6808@hirez.programming.kicks-ass.net>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-12-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546878450-20341-12-git-send-email-andrew.murray@arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 Shawn Guo <shawnguo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 suzuki.poulose@arm.com, Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 04:27:28PM +0000, Andrew Murray wrote:

This patch has the exact same subject as the previous one.. that seems
sub-optimal.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
