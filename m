Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AC8C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:37:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D297520883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qous/lqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D297520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GHKdXlmo5dnK3+m4gaKXuHt2MOM0K/DcgQ/KjKPX5eE=; b=qous/lqftuN8pq
	voHAd8R3njMDjPQ1Ipn9ioCL47ArXVi3SvyR5J8Izu0YJBSEXLt1JkjJkf3NW95eHRjf/OD9n4jLT
	03aQ2frOWgMiSau7AcQM29M/fUsm/2bsH8LB8bd0cYy3EXkuEuPL6/danwlAqFyLys0Eef+KPNvVf
	5hanCarLPJBvcE2i88aij7UdAElYDEHDbghGRGPKHHxrf5V0d1Mh3WEDDSuZgp3doJjR/R+DWW26m
	auBskh4wtzywh3yp1zBIzu0oUHLI0fBZrOcnWiPNPQYcipBUljovC+PEMi//R6x3ri+Dr6XWjwCS1
	8FL18B2fWTy/921Z3arA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggz4J-0005Uz-Hm; Tue, 08 Jan 2019 21:37:51 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggz4F-0005UE-Jd
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 21:37:49 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 4CEBD8080;
 Tue,  8 Jan 2019 21:37:52 +0000 (UTC)
Date: Tue, 8 Jan 2019 13:37:43 -0800
From: Tony Lindgren <tony@atomide.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190108213743.GN5544@atomide.com>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_133747_690177_8CA8C3B2 
X-CRM114-Status: UNSURE (   8.19  )
X-CRM114-Notice: Please train this message.
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Vincent Guittot <vincent.guittot@linaro.org> [190108 16:42]:
> On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.com> wrote:
> > Hmm so could it be that we now rely on timers that that may
> > not be capable of waking up the system from idle states with
> > hrtimer?
> 
> With nohz and hrtimer enabled,  timer relies on hrtimer to generate
> the tick so you should use the same interrupt.

OK yeah looks like that part is working just fine.

Adding some printks and debugging over ssh, looks like
omap8250_runtime_resume() gets called just fine based on a wakeirq,
but then omap8250_runtime_suspend() runs immediately instead of
waiting for the three second timeout.

Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
Anything higher than 2200 ms seems to somehow time out immediately
now :)

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
