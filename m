Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1541CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:27:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B732054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RyuZEEgt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Z+YAU/lY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B732054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pkIqIkh/UalWnrGHeG7o1ykhuh3qRpRkY9v2M4aqGHE=; b=RyuZEEgt7WwI1T
	P9lC/eqMHIeJGuh8whH/4KaSByNRwpY70Bm4eytEvPgjMMPHR0xXcPdOzaMpppAYAp7mvCJNYrpMV
	T/p+8o6lXIeSZkTSV7JhRexfqkrjNHdcMGp41aO2Ent+oBBQBOy90nJwsNz8/YRPUcz4bEIboFPux
	/Fk88qakBIaEtRZ9ZgTsIFpuG1lp0QFiXaA9+J7a+U3ubB7PPC6paoXKTj3RMXQsfy60UNTQEjdat
	nEE4sftpi4wzCedyTMSc/E6fI8sSpGpPJooIGkj/htuly+OUuUz0/Qc0gL3IBH0jin6XEHVnI4sZP
	IULKMAJjw8QgGXpI334A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk5pi-0002QW-2n; Thu, 17 Jan 2019 11:27:38 +0000
Received: from onstation.org ([52.200.56.107])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk5pe-0002PV-N2
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 11:27:36 +0000
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net
 [98.239.145.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: masneyb)
 by onstation.org (Postfix) with ESMTPSA id DED1617F;
 Thu, 17 Jan 2019 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
 s=default; t=1547724451;
 bh=fYkbefJ+qXthGu5ibucFnH4X+A77wMucqnhEdZHrBAg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z+YAU/lYSKbHMVxho3dOOtEqr9FG8mV1siUGrjYqfsLEW+FsJBgn9VzJvpVZUGyUw
 kqeuHH085rO+JcOj/QnXRtd0rMPpImvxeYCiQxdpf410Du4QgzkYFTMtTwibmn+PUA
 c1nEtODaBhAX0n8lcuwKnmLfwEX5F8qhdfiAJTCU=
Date: Thu, 17 Jan 2019 06:27:30 -0500
From: Brian Masney <masneyb@onstation.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
Message-ID: <20190117112730.GA25198@basecamp>
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
 <20190117093113.GA23389@basecamp>
 <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_032734_826525_5FE6F4EF 
X-CRM114-Status: GOOD (  17.03  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 04:08:52PM +0530, Sai Prakash Ranjan wrote:
> On 1/17/2019 3:01 PM, Brian Masney wrote:
> > 
> > You can use the __maybe_unused attribute to remove the #ifdef:
> > 
> > static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> > 
> 
> Thanks for looking into this.
> 
> As for __maybe_unused, I think it's better to keep #ifdef rather than
> this attribute which seems to be meaning unused when actually its possible
> that it's used often(PM_SLEEP is def y). It's like saying unused when you
> are actually using it. The attribute seems like a
> hack to avoid compilation error. Please correct me if I am wrong.

That attribute suppresses a warning from the compiler if the function is
unused when PM_SLEEP is disabled.  I don't consider it hackish since the
function name no longer appears outside the #ifdef. For example:

	#ifdef CONFIG_PM_SLEEP
	static int qcom_wdt_suspend(struct device *dev)
	{
		...
	}
	#endif /* CONFIG_PM_SLEEP */

	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);

SIMPLE_DEV_PM_OPS (actually SET_SYSTEM_SLEEP_PM_OP) includes the check
for PM_SLEEP and its a noop if PM_SLEEP is disabled so this works.

Now here's the code with __maybe_unused:

	static int __maybe_unused qcom_wdt_suspend(struct device *dev)
	{
		...
	}

	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);

This will still be a NOOP when power management is disabled, but have
the benefit of increased compile-time test coverage in that situation.
The symbols won't be included in the final executable. I personally
think the code a is cleaner with __maybe_unused.

This pattern is already in use across various subsystems in the kernel
for suspend and resume functions:

$ git grep __maybe_unused | egrep "_suspend|_resume"  | wc -l
767

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
