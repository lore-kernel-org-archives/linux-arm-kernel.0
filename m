Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C234C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:43:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9EB2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VHbuXLp1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw7Ry8Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9EB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K9dAH/7L39Ae0VIQeuMmw3X/K+g8ALacRuMSrPir8kc=; b=VHbuXLp1ZeQK5v
	bWXd5qAW428+fRuqh2zW/0k2qF+jxKYoFm2AyZvMYwYPlGp95rLK2/lodJ7gJ/COBCz8cWGlUeyJ3
	nPode4I8mDa83IBhKUY0IX4ONF7XI4ogR5Pl6vb5+JuT8dOS4c7ncUWAB4jiOi6QrZNj+HeakFz8k
	c2XJhcaFZfWJRyzVdVW62dtBX3I6yfB52iT+lVQYluLx/1XYlS5ndU0HOMyDM5Qwk9QEqbaNkO5wo
	WQJgb0Vwq/kpDr205LmMOTWIqMJRzxJip6it9SM9cq4o2XvNXBw3R2uBn8o9iCZ1KfyC62GDnWF0g
	+rABrX7SH1mS/BtI0fYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSdS9-0002vV-UW; Fri, 30 Nov 2018 07:43:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdS6-0002uc-At
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 07:43:07 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFEAB20868;
 Fri, 30 Nov 2018 07:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543563775;
 bh=6mf5NLGJPILHK2ex3/bXGnH1jbYfEcSoI9g1pWcZUNE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uw7Ry8EzTZPVX61RQrfG8FfUbh6S47Yn9k7Fdt2AuG9afQMjmRiEu5GmcglxmMQzV
 1evLjQvHuZWx4TYcbdGiTllY/vKTb6oi3Uw7ldl86TeFdS0wKWzCRCykG41ys5GDac
 mIaQdb2UZK7NFDOtek6/wP03RSZIij3+HRhVkyzw=
Date: Fri, 30 Nov 2018 08:42:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v4 4/6] coresight: Use PMU driver configuration for sink
 selection
Message-ID: <20181130074253.GA3314@kroah.com>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
 <20181129074936.GE12347@kroah.com> <20181129230915.GA8881@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129230915.GA8881@xps15>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_234306_402790_CA537C19 
X-CRM114-Status: GOOD (  20.91  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, peterz@infradead.org,
 will.deacon@arm.com, heiko.carstens@de.ibm.com, adrian.hunter@intel.com,
 acme@kernel.org, ast@kernel.org, alexander.shishkin@linux.intel.com,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com,
 schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 suzuki.poulosi@arm.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 04:09:15PM -0700, Mathieu Poirier wrote:
> Hi Greg,
> 
> On Thu, Nov 29, 2018 at 08:49:36AM +0100, Greg KH wrote:
> > On Wed, Nov 28, 2018 at 03:01:16PM -0700, Mathieu Poirier wrote:
> > > This patch uses the PMU driver configuration held in event::hw::drv_config
> > > to select a sink for each event that is created (the old sysFS way of
> > > working is kept around for backward compatibility).
> > 
> > It is "sysfs", no InterCaps please, I've never called it that in the
> > past.
> > 
> > And just use sysfs, if that does not work properly, then fix that, don't
> > create yet-another-way-to-configure-this-thing to just confuse people.
> 
> Thanks for the review, you've provided usefull comments.
> 
> Regarding the "char *" argument for the ioctl, I followed an example that
> currently exist but I can proceed differently.  

What driver currently uses a char * on an ioctl to parse arbritrary
userspace information to set its configuration?  That should be fixed...

> My goal with this patchset was specifically to fix what is wrong with sysfs and
> completely take it out of the equation.  The only reason to keep the kernel 
> interface alive was to prevent braking older user space perf tools currently
> using it.  

That's fine, just don't create a new syscall that takes arbritrary data
and parses it in the kernel, that's not ok.

> I chose to use an ioctl() because it is flexible and well suited for the dynamic
> nature of perf events.  It is also currently used to set various event specific 
> configuration so doing the same adds to the established pattern and avoids
> creating a new way of doing things, something the perf crew would have been
> quick to point out.
> 
> Was my approach wrong?

I don't know how the perf interface works, so perhaps work with those
developers to sync up and match what they use today?

But step back, what exactly are you trying to do here?  You have an
implementation of a solution but I don't see the problem stated anywhere
here.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
