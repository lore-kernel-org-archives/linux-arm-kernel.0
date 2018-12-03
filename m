Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FD5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0465120834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ThtFyZNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0465120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EtC/h1EONpR6NijUmNL93Qk2rKFnyqpyIXLrXeu8Hco=; b=ThtFyZNqWkAXRZ
	GFB/TDd7AH0EXfz5ZsRsQDLlfao6Rgi5xWsFf5Umi7No1cu3+2tZAHuZgMl1cFE4ZdzRaq6j2wvXI
	SBZ0IYLpZ1QOaSd6eY94RRfjMbwme4v8WXDzBeWMWVEpZ8I/Pu2ZBLDy4pvxfy1IpxQWhlAiyKaE+
	jI7j272HPiz5wCjAPH48EzL2KoKS2Tl17CsdPJeZzwKF/HfybFb4sM22cZo0s9VpO7DWBZaZSyZ0D
	8H0Y9PFaXs/nRPQ00rLmVcp5LHlWNl4a+g5IojqJUU2RJhYV8fJ3q5LFRr0ZgNz/c44fG+qzXcwIW
	ieTdl2K7rFwdFfUirxdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpxt-0001Y9-MW; Mon, 03 Dec 2018 15:16:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpxr-0001Xk-34
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:16:52 +0000
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00ADA3001900;
 Mon,  3 Dec 2018 15:16:40 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8855619C7D;
 Mon,  3 Dec 2018 15:16:38 +0000 (UTC)
Date: Mon, 3 Dec 2018 16:16:36 +0100
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 01/12] KVM: arm64: Document PV-time interface
Message-ID: <20181203151636.scziollrzpulbdke@kamzik.brq.redhat.com>
References: <20181128144527.44710-1-steven.price@arm.com>
 <20181128144527.44710-2-steven.price@arm.com>
 <20181203135042.v52wawfz4nc27fna@kamzik.brq.redhat.com>
 <4ec62f53-9c3f-14cb-f1bb-c8b9aadb9bdd@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ec62f53-9c3f-14cb-f1bb-c8b9aadb9bdd@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 03 Dec 2018 15:16:40 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_071651_184890_EF839C6B 
X-CRM114-Status: GOOD (  18.03  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 02:18:25PM +0000, Marc Zyngier wrote:
> On 03/12/2018 13:50, Andrew Jones wrote:
> > On Wed, Nov 28, 2018 at 02:45:16PM +0000, Steven Price wrote:
> >> +The structure pointed to by the PV_TIME_LPT hypercall is as follows:
> >> +
> >> +  Field           | Byte Length | Byte Offset | Description
> >> +  --------------- | ----------- | ----------- | -------------------------------
> >> +  Revision        |      4      |      0      | Must be 0 for this revision
> >> +  Attributes      |      4      |      4      | Must be 0
> >> +  sequence_number |      8      |      8      | Bit 0: reserved
> >> +                  |             |             | Bits 1:63 number of migrations
> >> +  scale_mult      |      8      |      16     | Multiplier to scale from native
> >> +                  |             |             | frequency to PV frequency
> >> +  shift           |      4      |      24     | Shift applied before multiplier
> >> +  Reserved        |      4      |      28     | Must be 0
> >> +  Fn              |      8      |      32     | Native frequency
> >> +  Fpv             |      8      |      40     | Paravirtualized frequency seen
> >> +                  |             |             | by guest
> >> +  div_by_fpv_mult |      8      |      48     | Multiplier to implement fast
> >> +                  |             |             | divide by Fpv
> > 
> > Here's kvmclock's struct
> > 
> >  struct pvclock_vcpu_time_info {
> >         u32   version; 
> >         u32   pad0;
> >         u64   tsc_timestamp;
> >         u64   system_time;
> >         u32   tsc_to_system_mul;
> >         s8    tsc_shift;
> >         u8    flags;
> >         u8    pad[2];
> >  }
> > 
> >  Revision	 =>
> >  Attributes	 =>
> >  sequence_number => version
> >  scale_mult	 => tsc_to_system_mul	(this is reversed, but OK)
> >  shift		 => tsc_shift           (also reversed)
> >  Reserved	 =>
> >  Fn		 => (pvclock doesn't have, but does have system_time)
> >  Fpv		 =>
> >  div_by_fpv_mult =>
> > 
> > I haven't thought about this enough yet to be sure kvmclock's fields
> > are sufficient, but several look close - although the 'tsc' naming
> > isn't nice. Also, the pvclock struct could be extended by adding an
> > 'extended' flag to 'flags', and then appending more fields.
> 
> One important thing is that this is not a KVM PV time implementation.
> This is something generic for the ARM architecture. Any ARM hypervisor
> should be able to implement this.
>

I agree with that, but xen also uses the same pvclock structure on x86.

Thanks,
drew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
