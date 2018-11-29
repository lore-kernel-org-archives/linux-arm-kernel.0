Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F15CC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:24:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E328521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h4EjrvlY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SLo34w0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E328521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N8mpksK+mxzIaiKF+H/l+CmoWh+JhRACD/a2r/pkTrw=; b=h4EjrvlY2uTAsl
	h2hmZrnLuXv1kR5BAVyA7tSUcsTiDhCasI0zMKSyHA1vZgSy8/KKdYp4HQk2ijyBZfIqBq4Pn6rqI
	yZgLS3Bb/iYsZcw/JM1f9X+EWhrwHhzN6ajbleu6TDLttCUE+YHYmxAttHmvGqPUcKc98bjGxkqeJ
	xWaj6y0Iz5hOzsSkkDV2oV4vcR2qX7ajBCTGEkEuweBycmrHwqfDrBYNZCco0hN7N+7zo2F9Nm1VS
	BE4X8a3BM3tnqUKUG6UxveI/i0UqrOSTYe1uTX7inaZozKqUjK02/uXqU2Jjnf2gzSIlheaTEFHOd
	ElmUyBFRk2tWZfnD+Mlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOBK-0003eZ-7c; Thu, 29 Nov 2018 15:24:46 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOBG-0003e5-HE
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:24:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gQxuYkneTVbBa9j6geLN2qrbu7nY/KJ+AQBWafAFzM4=; b=SLo34w0ic+IpTeXSJ82o3ZTDh
 M3lkNo9dn1qT6ZwyYkYl4lLZZ1PZCfXuksgpFAuIFY42U+E5DSutFTza5t0C6OcJzVDklrLE39ib/
 0V1Dmsea9vsqambcZUE0erVv440DcPIwKt3woELZiJW0s4ocmcFVMcXK7qyo0NDGt2RGs=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:55791)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gSOAw-00031x-G3; Thu, 29 Nov 2018 15:24:22 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gSOAp-0001li-8l; Thu, 29 Nov 2018 15:24:15 +0000
Date: Thu, 29 Nov 2018 15:24:08 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Nathan Jones <nathanj439@gmail.com>
Subject: Re: [PATCH v2] ARM: dma-mapping: fix potential uninitialized return
Message-ID: <20181129152408.GX30658@n2100.armlinux.org.uk>
References: <20181128173929.3050-1-nathanj439@gmail.com>
 <20181128185910.5778-1-nathanj439@gmail.com>
 <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
 <CACTmSTzQeJiR8S57zYcu+YWbnMdo9Eb9Bei4gfmHyFOrzoWiZw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACTmSTzQeJiR8S57zYcu+YWbnMdo9Eb9Bei4gfmHyFOrzoWiZw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_072442_576664_9EE9B25B 
X-CRM114-Status: GOOD (  16.10  )
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
Cc: vladimir.murzin@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 09:58:46AM -0500, Nathan Jones wrote:
> No, I had some bad code which was passing a wrong length and receiving the
> strange error code.

While adding some networking documentation, I tripped over the comments
at the bottom of Documentation/networking/netdev-FAQ.rst which seem
very good at guiding what should be in the commit message, specifically:

  If your change is a bug fix, make sure your commit log indicates the
  end-user visible symptom, the underlying reason as to why it happens,
  and then if necessary, explain why the fix proposed is the best way to
  get things done.

This is actually rather important, as we may need to look back at a
commit, and end up wondering what it was about.  A case in point is the
patch that added the /proc/<PID>/syscall interface:

    /proc/PID/syscall

    This adds /proc/PID/syscall and /proc/PID/task/TID/syscall magic files.
    These use task_current_syscall() to show the task's current system call
    number and argument registers, stack pointer and PC.  For a task blocked
    but not in a syscall, the file shows "-1" in place of the syscall number,
    followed by only the SP and PC.  For a task that's not blocked, it shows
    "running".

This doesn't say what the purpose of this new user interface is, why it
is needed, nor is there documentation describing its behaviour (such as
what happens if the thread is being traced.)  The covering message for
the series omitted to talk about this new interface.  So we're now at
the position where we have a bug reported against this interface, and
no one knows what the right behaviour is really supposed to be.

The commit message describes mostly what we can gather from reading the
patch, and some of the behaviour but is entirely insufficient - we're
left scratching our heads as to what the behaviour should be for
restarted syscalls.

So, augmenting your commit message with something like:

"While trying to use the dma_mmap_*() interface, it was noticed that
 this interface returns strange values when passed an incorrect
 length."

would be nice.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
