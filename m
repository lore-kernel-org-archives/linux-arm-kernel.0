Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041EFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:08:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E2021B24
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FFO3dzdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E2021B24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JcKIx9k4u0BT3zY3InrX2xxX+F+5RMQpNTnD07e5q1U=; b=FFO3dzdD4IQUG3
	JEOLluXyjONoyq26VkJK6irrFr3V/ERIAYIXjzOQr5H/pBPMiMPv7JvFS5oXYsj2OQZEdffCtLBeK
	7rXC8ubvtIt3d/Y2mgTdzZqM1/wkO6Gr0DHM3nmrjEofKcz/6OY3317+gWazijLhIZv2mL+FWvl3g
	kjYhefJ4L78nhjHlPXiOOPgWuZDA+wZ9HbzdX37JfHR7Y5gOUgEDDwc+BrFLf2HrK3dKiQ6XpwucS
	NpBEMf/BjDJny94wXzA1cAYBdNhXxOvniVci/z4KAPG3n0lZOIrVyJOBnHqJae0FOaYNUgpttxMbn
	S6wS95iT9a83u9aWIEVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMMo-0003II-48; Thu, 14 Feb 2019 19:08:14 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMMg-0003Hu-An; Thu, 14 Feb 2019 19:08:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id BD3D020268335; Thu, 14 Feb 2019 20:08:03 +0100 (CET)
Date: Thu, 14 Feb 2019 20:08:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v8 03/14] mm, x86: Add support for eXclusive Page
 Frame Ownership (XPFO)
Message-ID: <20190214190803.GQ32477@hirez.programming.kicks-ass.net>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <8275de2a7e6b72d19b1cd2ec5d71a42c2c7dd6c5.1550088114.git.khalid.aziz@oracle.com>
 <20190214105631.GJ32494@hirez.programming.kicks-ass.net>
 <e157e274-1bdf-0987-bfe9-21c9301578ab@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e157e274-1bdf-0987-bfe9-21c9301578ab@oracle.com>
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
Cc: mhocko@suse.com, Tycho Andersen <tycho@docker.com>,
 kernel-hardening@lists.openwall.com, catalin.marinas@arm.com,
 will.deacon@arm.com, dave.hansen@intel.com, deepa.srinivasan@oracle.com,
 steven.sistare@oracle.com, tglx@linutronix.de, tycho@tycho.ws,
 ak@linux.intel.com, kirill.shutemov@linux.intel.com, x86@kernel.org,
 jmorris@namei.org, hch@lst.de, kanth.ghatraju@oracle.com, jsteckli@amazon.de,
 labbott@redhat.com, pradeep.vincent@oracle.com, konrad.wilk@oracle.com,
 jcm@redhat.com, liran.alon@oracle.com, luto@kernel.org,
 boris.ostrovsky@oracle.com, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com,
 Marco Benatto <marco.antonio.780@gmail.com>, linux-mm@kvack.org,
 juergh@gmail.com, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
 tyhicks@canonical.com, john.haxby@oracle.com,
 Juerg Haefliger <juerg.haefliger@canonical.com>, oao.m.martins@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, torvalds@linux-foundation.org,
 dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 10:13:54AM -0700, Khalid Aziz wrote:

> Patch 11 ("xpfo, mm: remove dependency on CONFIG_PAGE_EXTENSION") cleans
> all this up. If the original authors of these two patches, Juerg
> Haefliger and Julian Stecklina, are ok with it, I would like to combine
> the two patches in one.

Don't preserve broken patches because of different authorship or
whatever.

If you care you can say things like:

 Based-on-code-from:
 Co-developed-by:
 Originally-from:

or whatever other things there are. But individual patches should be
correct and complete.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
