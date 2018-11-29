Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31CCC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF88320673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lD8Kb5Mn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYyr349l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF88320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4SfBvbyTv+wJ5RXtK2H36Ir2FLCYCE+F/CvHPJy82HU=; b=lD8Kb5MnBmxolx
	MkRKOztZ6P4hCZ/NWAln/hkLCGWc5XwooR17d7heOXOQkcdKglyK/V2UjMYViw2m7/IqjRLT19U4g
	/YOw/a1GNpTio75t8ekjg5pKQTnhg0Dq7ZeehOxqgq+UUfiPXxaSwHqn/C3SduHFQWA0z++ycxsPS
	p48YwQWIFaDKZmYhPta8vcKvxz4TWOywcaRLmZyIahQQQM/9kMFLqcvtHrz3hXArpjSXUtHxPLPMb
	Lx8ELePqttHZ9skCMZy/YXfLdquRmbkqfM8/yFITs6VKabazWceuW/y0uKTxoa9U9PmszVOgeMtdj
	4drWAzY+EhYkU9Md8wew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSVRA-0006hq-Pp; Thu, 29 Nov 2018 23:09:36 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVR7-0006g3-AS
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 23:09:34 +0000
Received: by mail-pf1-x443.google.com with SMTP id 64so1770930pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 15:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OlpdAZygJoxwQGARbrL3JAIAtknNPIQhWF26Eev2Vjg=;
 b=QYyr349lxsFdAJumj01VJUpYixpUl9GkbvlbM/0Jp+jtSBxZWUjwKH138E+YMHqtTE
 x299smk6ZoFWnHpYZyQIWUr0X1AHvGQxH5lxAxI2d6xHD25bOJxsOCg364c+q0EwqI6c
 /QadlUak/BVsUJhib5zBC8xBk2RZxHthHp5z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OlpdAZygJoxwQGARbrL3JAIAtknNPIQhWF26Eev2Vjg=;
 b=AR5Lkxad0uihSXjY7CF12UIktADR/X17FYZJzK6T8pkrrJVXT6wVJVDzMS0i+7cpzo
 4ml/7abFjyJk4PPbXLXjj9MfLPZV6FSjKLRf7RocxG0YokJY1LN1gOEgV/418bUtdL6W
 Hjbbec7K0Kc1E77NqAcPpn5w8xLrN5RLqCoRSpvANOvLC5ZwUpI8u5CgxOnFBnvfV5py
 8lGBU2NVQyIl3HELCdT0b4f0IHCwsIZ7ENbbv9n9D8ZxTnLTvqGwArkz2v3gPatejwjr
 MtvaWNhY88SPvpBlB8UKeeU6i0KYjsLchB6yyInO2/KywOAIbsf0x2cILNJ12iSsCyl6
 TwCQ==
X-Gm-Message-State: AA+aEWZ+L+aGptnBycK6l7s4+Zm79W9SOpLe9AyPneMqy9kGuVpy+tVb
 uCMGxwlDgDxicOMkI865D+8BSw==
X-Google-Smtp-Source: AFSGD/VkSEO0kPQ2oCqhRSY8s2oVgMYxe9Jm7gwdfcnEnpWWKFlBVkgNLbiLorBqJapvrVu/gRr6qw==
X-Received: by 2002:a62:4851:: with SMTP id v78mr3330119pfa.97.1543532958570; 
 Thu, 29 Nov 2018 15:09:18 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id e123sm3670195pgc.58.2018.11.29.15.09.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 15:09:18 -0800 (PST)
Date: Thu, 29 Nov 2018 16:09:15 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/6] coresight: Use PMU driver configuration for sink
 selection
Message-ID: <20181129230915.GA8881@xps15>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
 <20181129074936.GE12347@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129074936.GE12347@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_150933_365439_A71D0196 
X-CRM114-Status: GOOD (  15.93  )
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

Hi Greg,

On Thu, Nov 29, 2018 at 08:49:36AM +0100, Greg KH wrote:
> On Wed, Nov 28, 2018 at 03:01:16PM -0700, Mathieu Poirier wrote:
> > This patch uses the PMU driver configuration held in event::hw::drv_config
> > to select a sink for each event that is created (the old sysFS way of
> > working is kept around for backward compatibility).
> 
> It is "sysfs", no InterCaps please, I've never called it that in the
> past.
> 
> And just use sysfs, if that does not work properly, then fix that, don't
> create yet-another-way-to-configure-this-thing to just confuse people.

Thanks for the review, you've provided usefull comments.

Regarding the "char *" argument for the ioctl, I followed an example that
currently exist but I can proceed differently.  

My goal with this patchset was specifically to fix what is wrong with sysfs and
completely take it out of the equation.  The only reason to keep the kernel 
interface alive was to prevent braking older user space perf tools currently
using it.  

I chose to use an ioctl() because it is flexible and well suited for the dynamic
nature of perf events.  It is also currently used to set various event specific 
configuration so doing the same adds to the established pattern and avoids
creating a new way of doing things, something the perf crew would have been
quick to point out.

Was my approach wrong?

Regards,
Mathieu

> 
> thanks,
> 
> greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
