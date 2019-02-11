Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70604C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:38:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E57320449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BozZ3BkE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QugwUPgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E57320449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C/jy587rA2gPt26G3FB6nIMvQeSYpERoHOabxTGbiHU=; b=BozZ3BkERVAAq6
	VQkQICMxX3UD8WruJfaGwr7Kw2OsSRmTZpQTing7hpTWFunNGu50YyArQkO7NDBaXDWwkIP8WuAoG
	Kir9AFflZ14rMwsNWP4DSao741MsgbBnbNuapmjcGcUMxu0aiUUXM7Sr+cmIWf1qPNi5xSFDO8pQ3
	jNBgABZsHS9ldwVyNw91RtTHOeFLlDqW1FI49r3Q07evIhV2WDbcapbNOKKukUEsD6/Fmf1oBK4QC
	NKgYMBzIG0VSo0dLVP3jeJWGZ/RNmPdbIwX/cYAolPelVZifMSs3D1o/89I0OANDQYONN0LtKcAsl
	JMWT9eBNjxpfsxT/yYhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt6Ar-00015r-R7; Mon, 11 Feb 2019 07:38:41 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt6Al-00014I-RX
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 07:38:39 +0000
Received: by mail-wm1-x330.google.com with SMTP id d15so15504857wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 23:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=j1zWKIlZsVjo0SP2EC7fZlyHxeWBFLCgtgW8EIbDbOE=;
 b=QugwUPgcpfU3+Tm9+uRiY+VeoOW1hrVgrzjfbonMin4cw7g0zWY7xW+3Mit8PQfprX
 QPeCFmub2fnVz6mKV4rLOkZE0BJ3RX4AxWW5dSA6I9alAM9EnEpQiM5EEJg/Q3NN25w9
 Sksw1pfELw9mSjghnPIG5gPaKrMz49anPYySUg6RzUppp3MHsd4BR4WQQvy0BL7EGBb7
 5u2uvV7tKrN/HdTBi8u8Dg7tWUi+LHlqKfAZr49t/fMVgzjMfVmRex+57Sckpoalu05B
 LM6RFLVkUPg8iY5FadJ7YAkqHe/N9pHEV2ZD69QaiIh0ha2DBdykzx8mHYbwRQfeh8E0
 OszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=j1zWKIlZsVjo0SP2EC7fZlyHxeWBFLCgtgW8EIbDbOE=;
 b=VGECw3BXInsh0L13oiS3b1vvDv+3qsGDJVORdqf4E294DDmjW8XjS60392Q2C3yqLw
 PYGLWO7ARaTXHShuTuspkZ6cjAk1jPXg5mvHI8Yo+tehnXYu7bDfpiau1JuDb0mEHHab
 fb5sxhWJDH6YEd9BcqOmmrdcsIdWPb94dxNC2csd7kxHB6ZBXS0hv4VMy1L75OWAluWv
 KnfrUqq2a50KJ2gMeFXYxsQKTrmVD/U9vDp7N0dxy+zYmIvlVviZ2vJjQKPAaoreu5hb
 ubmut2Aphha29kmP8ZacCMefGbFhVWOVrMV1Ku9xKGS71mLZNRjlDZY6c+PdQkev4R/N
 6VmQ==
X-Gm-Message-State: AHQUAua8xY1ZMpz3tgaVuPBPkJUAIxdvZrHa9ip5L/6WHQ9xTNtnXrn4
 LmCT+Elznr9IEz+d9ZL6DH0=
X-Google-Smtp-Source: AHgI3IabznfRCQX4qyQonoc9mGE4Iu1ZLqbFlbxiVnApqa0fDXIc+az+/yufddL5FoyENYBy8lVfbg==
X-Received: by 2002:adf:e290:: with SMTP id v16mr12077501wri.100.1549870711601; 
 Sun, 10 Feb 2019 23:38:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id x3sm12933033wrd.19.2019.02.10.23.38.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 23:38:30 -0800 (PST)
Date: Mon, 11 Feb 2019 08:38:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Message-ID: <20190211073828.GB106308@gmail.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190207195119.lglz4lb7cnf4ndn2@linux-r8p5>
 <45b7bbb8-c953-9951-ae6f-e2c3202e5cf2@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <45b7bbb8-c953-9951-ae6f-e2c3202e5cf2@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_233837_930653_785054EB 
X-CRM114-Status: GOOD (  12.90  )
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

> On 02/07/2019 02:51 PM, Davidlohr Bueso wrote:
> > On Thu, 07 Feb 2019, Waiman Long wrote:
> >> 30 files changed, 1197 insertions(+), 1594 deletions(-)
> >
> > Performance numbers on numerous workloads, pretty please.
> >
> > I'll go and throw this at my mmap_sem intensive workloads
> > I've collected.
> >
> > Thanks,
> > Davidlohr
> 
> Thanks for getting some of the performance numbers. This is the initial
> draft after more than 1 years of hibernation. I will also get other
> performance numbers in subsequent revision of the patch.

If you could sort all the invariant preparatory patches to the head of 
the series I can merge them to reduce overall complexity and simplify 
performance testing and review of the rest.

Thanks,

	Ingo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
