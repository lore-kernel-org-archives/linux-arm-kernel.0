Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BEBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:32:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA85206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M0DZZhZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA85206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zdrSqMzdpB/0BSuBRmzhByFtC6BJtDhyYX9WG7RRl0A=; b=M0DZZhZnjEQzqD
	VCglZUgAeaNlvvjPv7VL2E+C/HGY9E88f6lPKUm+P/4nMi+dZZSxxHBgEfrRXKKiawvzt4AR72VZA
	CRLw1KGImMdUhGVJasOiMfNbsdU7Ojm0imd4ufmDDz3fWGEWTVTmMon0d1yyBtRCQLyYYYMXb9CaS
	UzwkdTrZ5ZmE6Ws2RTxwix6Pfj6ZWxt/CvFekJF2kPdOU1pmHXR/3dptrReJceGB+VtGQEh0dpcNX
	vqzT/XkyfC3RWL9Boc0j1RxAIOuC487V3TEir6bLKp3TEkHt9zp7JHUfvsaAs583Hc3jsgUZxIZQL
	a0cJR/SC2ycRH68s3uJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUb1p-00089F-Ke; Wed, 05 Dec 2018 17:32:05 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gUb1l-00088G-HT; Wed, 05 Dec 2018 17:32:01 +0000
Date: Wed, 5 Dec 2018 09:32:01 -0800
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 7/7] mm: better document PG_reserved
Message-ID: <20181205173201.GA11646@bombadil.infradead.org>
References: <20181205122851.5891-1-david@redhat.com>
 <20181205122851.5891-8-david@redhat.com>
 <20181205143510.GA17232@bombadil.infradead.org>
 <46d0e90f-f0bb-815e-7a5b-4429de1c502a@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46d0e90f-f0bb-815e-7a5b-4429de1c502a@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 yi.z.zhang@linux.intel.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 Miles Chen <miles.chen@mediatek.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 04:05:12PM +0100, David Hildenbrand wrote:
> On 05.12.18 15:35, Matthew Wilcox wrote:
> > On Wed, Dec 05, 2018 at 01:28:51PM +0100, David Hildenbrand wrote:
> >> I don't see a reason why we have to document "Some of them might not even
> >> exist". If there is a user, we should document it. E.g. for balloon
> >> drivers we now use PG_offline to indicate that a page might currently
> >> not be backed by memory in the hypervisor. And that is independent from
> >> PG_reserved.
> > 
> > I think you're confused by the meaning of "some of them might not even
> > exist".  What this means is that there might not be memory there; maybe
> > writes to that memory will be discarded, or maybe they'll cause a machine
> > check.  Maybe reads will return ~0, or 0, or cause a machine check.
> > We just don't know what's there, and we shouldn't try touching the memory.
> 
> If there are users, let's document it. And I need more details for that :)
> 
> 1. machine check: if there is a HW error, we set PG_hwpoison (except
> ia64 MCA, see the list)
> 
> 2. Writes to that memory will be discarded
> 
> Who is the user of that? When will we have such pages right now?
> 
> 3. Reads will return ~0, / 0?
> 
> I think this is a special case of e.g. x86? But where do we have that,
> are there any user?

When there are gaps in the physical memory.  As in, if you put that
physical address on the bus (or in a packet), no device will respond
to it.  Look:

00000000-00000fff : Reserved
00001000-00057fff : System RAM
00058000-00058fff : Reserved
00059000-0009dfff : System RAM
0009e000-000fffff : Reserved

Those examples I gave are examples of how various different architectures
respond to "no device responded to this memory access".


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
