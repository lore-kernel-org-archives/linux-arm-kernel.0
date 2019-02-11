Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAFAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:55:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97DF20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gc576dwA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDtcr3wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97DF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DXUqUgK6D2vhPik/sOk/vkPBPAbAOpvVz3BrkICMvjw=; b=Gc576dwAk4KLWf
	j48yoogbz0aktkbX5uC+PIjCZKLPolvCYshZ2ryt8cMGHRyiwP9D+u2dQJrzcToILusId0neTfMRS
	k1rM6iDcmXU2UotjyHY7aEPIaZQvMMC6yrrY5SYybcAwVEhtQhmp5dVrx+M2iD9J95NBIA4Mv0ULo
	R1smVlF3fwV3iOAi6YgMvwpirh3jXjUYKPFRZz36gEJsLSMBRndEzONlxGlLuITeYVYY1BTnH/Yy2
	cJxu9nHl+YJNCscVI0W/IOzI9S3eZuyDEsDXBP3m6ZCVVrrAxWFIC20igDuT6OcL/feGHAgxtcxhq
	+9mgQfCv9hnxIyw1f/bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9Fa-0007tH-DW; Mon, 11 Feb 2019 10:55:46 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9FW-0007sd-8e
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:55:44 +0000
Received: by mail-wm1-x343.google.com with SMTP id a62so16934695wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KMN64kOtJBFkKLD7eH5E1tsIkp4xo4LmSrCHlHm3ADQ=;
 b=QDtcr3wyAWwC1Feiwyp3X/8YTfaIdNpEWSGZejYjQTG/rj0trYk0vC6rQn4y2cNbXv
 il1Avd23/d1Hd8k+uTbZBtAoIRuLEkjW3uPerX4NcbTux104Th18LvFAtlUMw0zOO1LL
 tLmqEa0y4zRbQ5L3wXHA0BYGnh9on2hBdn58O1L8DaUmAwdWpiMdKB6WiTyS7C6wf6Bh
 MC78xcq2N19Sr8d1ee6X2SFh4BhB3mZOszFFAIe2XAVy/T1Xcb8vx1blQzxEH3d3ygOa
 1lUqargunUNH4IWUAEw1tmMjRZ4VOjSK4lFppReznME5P372JKKIbFQpvePfCELqMthw
 iSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=KMN64kOtJBFkKLD7eH5E1tsIkp4xo4LmSrCHlHm3ADQ=;
 b=DKEoaJAcno7WYQXsTTIf4+Szb+ixwtEzZNLC06opAMGzO0oxkY6s3TYA6QMTtK6be+
 M9RaKdMNouIDABkNI+wNU4UKUZ3oEQzcsc4iQtcuQ69Vzz/Os1Pnu58VFUWfwlSNw3/S
 S7h56D9Xx8WdqSituvppTVmFrSngayqdALhUis9Hwbtjrer8+LG4j9HPEySDmwlOFFi1
 1YV+HPT1PWYgNbg9WBpHpLOr6QfCQGmVufBpsgJwl12ZzUXiGJQ5zv9dVtylBefJMOu6
 lXh7Aw3B6DGpElp+xZ1iYJNLKh8N5HO4LPcKkl1ehCnRT3UEMtzzbecBnLMOaKaqeGzX
 dWBA==
X-Gm-Message-State: AHQUAuZrvS0WlTRJwcCCXhGCxBpNxtFvi8QDZOZCiHPUVlyxf351PPge
 SvRYh1qV0sFIGTV2bb0XqItTeqD1
X-Google-Smtp-Source: AHgI3IYfCwXm72SvHpZjHfYZL/JOp3IzO2HnfloWBghOcIo+EQ24FCA5PhxAIN+bIRKZbXHjD7QYjw==
X-Received: by 2002:a1c:a6c9:: with SMTP id p192mr2919879wme.58.1549882540793; 
 Mon, 11 Feb 2019 02:55:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id s8sm22757121wrn.44.2019.02.11.02.55.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 02:55:40 -0800 (PST)
Date: Mon, 11 Feb 2019 11:55:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211105537.GA59133@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
 <20190211071159.GA55579@gmail.com>
 <20190211103927.GA118071@gmail.com>
 <20190211105214.GA30880@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211105214.GA30880@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_025542_450274_FE1DC132 
X-CRM114-Status: GOOD (  12.53  )
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
 Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


* Will Deacon <will.deacon@arm.com> wrote:

> On Mon, Feb 11, 2019 at 11:39:27AM +0100, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > Sounds good to me - I've merged this patch, will push it out after 
> > > testing.
> > 
> > Based on Peter's feedback I'm delaying this - performance testing on at 
> > least one key ll/sc arch would be nice indeed.
> 
> Once Waiman has posted a new version, I can take it for a spin on some
> arm64 boxen if he shares his workload.

Cool, thanks!

	Ingo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
