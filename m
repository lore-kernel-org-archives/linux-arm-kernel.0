Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48405C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:12:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1775320836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V0LFd8xi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLc0oI6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1775320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RimGaA0mpU8nLIJwlqtC5s5AGC7ZrUR4bFTZAyICjZA=; b=V0LFd8xi1ezqRu
	3LMGNFgq2Wj/Tlz1WqZ3LSBN0nDJlLSd1bD0CpIP6Qq2MGEUKGow2rHXIdRZV+K0+FE7I1OGuSqHZ
	VEJ14OC5AK1rJFYwJvDTOsSssI3gYRFNottdP97Wn9fO7S2XiQjuX+rohEnBX3UIQP2pu4CbGCczm
	sbMsn9WMqZlVwoMbfp0K01rtICRFv4Fa3wrCfttiIQeyhD5xqUfUBXSxkv4gN6TYr+jXHnvQnBjBO
	p23nzmwwjDt2O+tJu4vDOL46UH3zL8wKphASaV/QkO9aIn2VQ1fOiWOJInla+RQPwkmjmHVNVX8Ph
	yLpIkLQHL+0sMUzWMOog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt5lB-0007LW-Ag; Mon, 11 Feb 2019 07:12:09 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt5l7-0007Jh-54
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 07:12:06 +0000
Received: by mail-wm1-x342.google.com with SMTP id h22so13573573wmb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 23:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BK4Sm1vYAP/cUQnaGA8IV1A1wXMg4Z4Mq4IDBe+5Fz0=;
 b=iLc0oI6v6Cc382OU0fdlNtw/4hwzwv60nfBQ5KbKbVaS4A61E93cSWC8jo2x/WEl1a
 /7iNgiNDbixuFiTPVQxi8pc+/7fGx7pcuID+pMESwbpBB58ja3pRwNYGtoteTRn6cyHX
 VckXzbs5q4+RkIKdXXafDtC0IPMQNYgZCtrdvLgHeBBkHD9tEw/VRJq1p441jPtIqSIQ
 IJ/q1mwZcAvFB2yG85C6ntvl+UYgPG+r8dkD4WtUr93nSoN1GOE9cAmp6aCYRXO1Q3Ue
 sMgUko0pVzP2JoCJuinZBMQqE+COBfHkCMgJfh+JRAGW8JHu+EFVr4Ml2wOSRNsdda4K
 M0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=BK4Sm1vYAP/cUQnaGA8IV1A1wXMg4Z4Mq4IDBe+5Fz0=;
 b=jmmbSvY5KaCC5FrJZqN9YSBLzNlyFxkBqvyGhoEFuaiMS1+d698nniwuZkBmFL8F1R
 O21Ww2SPzv2qCRWwUdN0lLhrXZadpIWdGZgici/JLvZ+dy8UsUnESTilDv0iPytiMXh2
 ZUKqxqunU/znUGJknK0FKzTtrk7Y2tmmi/LYcybqldNvVbHbx4oTdOf+5TnzVNte03S+
 5M8rSVRtnYWMeFYtMxd8MxFjF/slC3AeTaSbbKhWrqJrDibN3YtQHc7JbAQoTDXCCF8V
 19rGHj8bvqwP9ajXdH4kYDIREWajPGVKpxpiY3Ae0WkCYFPB7LzFxLN0xWeS2qCUnA5C
 c9CQ==
X-Gm-Message-State: AHQUAubI9IwKpWQRg1at1//9ZvqWZdr8FcQ399Gnn7H8qA9TFfOScruM
 4sLWpE8V1Q7vkSmuPKySzxQ=
X-Google-Smtp-Source: AHgI3IYKyZH/baZMa5ziJeeQ06x4xxi+rhZ/xrB3f4ycB4qyp+lAO8FS4iZNzqjB6VFbBo/ZmJWgew==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr24796464wrj.91.1549869123278; 
 Sun, 10 Feb 2019 23:12:03 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id a184sm9956832wmh.37.2019.02.10.23.12.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 23:12:02 -0800 (PST)
Date: Mon, 11 Feb 2019 08:11:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211071159.GA55579@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_231205_190915_205BF52F 
X-CRM114-Status: GOOD (  23.25  )
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 linux-hexagon@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


* Waiman Long <longman@redhat.com> wrote:

> On 02/10/2019 09:00 PM, Waiman Long wrote:
> > As the generic rwsem-xadd code is using the appropriate acquire and
> > release versions of the atomic operations, the arch specific rwsem.h
> > files will not be that much faster than the generic code as long as the
> > atomic functions are properly implemented. So we can remove those arch
> > specific rwsem.h and stop building asm/rwsem.h to reduce maintenance
> > effort.
> >
> > Currently, only x86, alpha and ia64 have implemented architecture
> > specific fast paths. I don't have access to alpha and ia64 systems for
> > testing, but they are legacy systems that are not likely to be updated
> > to the latest kernel anyway.
> >
> > By using a rwsem microbenchmark, the total locking rates on a 4-socket
> > 56-core 112-thread x86-64 system before and after the patch were as
> > follows (mixed means equal # of read and write locks):
> >
> >                       Before Patch              After Patch
> >    # of Threads  wlock   rlock   mixed     wlock   rlock   mixed
> >    ------------  -----   -----   -----     -----   -----   -----
> >         1        27,373  29,409  28,170    28,773  30,164  29,276
> >         2         7,697  14,922   1,703     7,435  15,167   1,729
> >         4         6,987  14,285   1,490     7,181  14,438   1,330
> >         8         6,650  13,652     761     6,918  13,796     718
> >        16         6,434  15,729     713     6,554  16,030     625
> >        32         5,590  15,312     552     6,124  15,344     471
> >        64         5,980  15,478      61     5,668  15,509      58
> >
> > There were some run-to-run variations for the multi-thread tests. For
> > x86-64, using the generic C code fast path seems to be a liitle bit
> > faster than the assembly version especially for read-lock and when lock
> > contention is low.  Looking at the assembly version of the fast paths,
> > there are assembly to/from C code wrappers that save and restore all
> > the callee-clobbered registers (7 registers on x86-64). The assembly
> > generated from the generic C code doesn't need to do that. That may
> > explain the slight performance gain here.
> >
> > The generic asm rwsem.h can also be merged into kernel/locking/rwsem.h
> > as no other code other than those under kernel/locking needs to access
> > the internal rwsem macros and functions.
> >
> > Signed-off-by: Waiman Long <longman@redhat.com>
> 
> I have decided to break the rwsem patchset that I sent out on last
> Thursday into 3 parts. This patch is part 0 as it touches a number of
> arch specific files and so have the widest distribution. I would like to
> get it merged first. Part 1 will be patches 1-10 (except 4) of my
> original rwsem patchset. This part moves things around, adds more
> debugging capability and lays the ground work for the next part. Part 2
> will contains the remaining patches which are the real beef of the whole
> patchset.

Sounds good to me - I've merged this patch, will push it out after 
testing.

Thanks,

	Ingo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
