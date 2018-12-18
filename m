Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:08:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5B0214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LDcUx1ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5B0214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jj3EIOYYV21KMNcm3KpH6Q3wtWmf8+uTKAP/HvJihTI=; b=LDcUx1zeKbxPYH
	dp0aaEKt5KEfZNSpBhotWUTsJwnrusY4QBD630FgMxn9mi6BL365PnG5NdN8qoWNefjBVedlMssc5
	At+AuuPphlHB/71JZ5GJD7mzDixEoDxt1ub549mco42MHkh5Y+ZgRtONYtNfyJo+giYxh+5tc+3V7
	dQ6cXjmsRxzxw0Ck+99cY07Wg6/IHxAQSNU9skrsimFlqBWIp1hcOtHN52O2JbvDv2wOni8lcOp+C
	KQqCP7hTfyPic8S9a8GtMhDD1wzr3qlawRg9gKfRuCz2BbxhSZ8rzkwX3jEwbOa0tKG+BsDNwm+9I
	OpVgbwLQ3Mb07e2JpFkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ2vn-0001Ur-5M; Tue, 18 Dec 2018 00:08:15 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ2vj-0001TX-Tm
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 00:08:13 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2018 16:08:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; d="scan'208";a="99489609"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
 by orsmga007.jf.intel.com with ESMTP; 17 Dec 2018 16:08:00 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
 id 9A836300B49; Mon, 17 Dec 2018 16:08:00 -0800 (PST)
Date: Mon, 17 Dec 2018 16:08:00 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
Message-ID: <20181218000800.GB25620@tassilo.jf.intel.com>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20181217225020.GA16520@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217225020.GA16520@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_160812_010374_155F821E 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 11:50:20PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 20, 2018 at 10:59:47PM +0100, Arnd Bergmann wrote:
> > Hi Nico, all,
> > 
> > I was playing with ARM link-time optimization handling earlier this
> > month, and eventually got it to build cleanly with randconfig kernels,
> > but ended up with a lot of ugly hacks to actually pull it off.
> 
> How are we dealing with the fact that LTO can break RCU in very subtle
> and scary ways?
> 
> Do we have a compiler guy on board that has given us a compiler switch
> that kills that optimization (and thereby guarantees that behaviour for
> future compilers etc..) ?

Can you actually define what optimization you are worred about?

If there are optimizations that cause problems they likely happen
even without LTO inside files. The only difference with LTO is that it
does them between files too.

-Andi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
