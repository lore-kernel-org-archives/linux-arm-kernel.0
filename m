Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72816C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:16:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C8221726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RydDyoCU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FlVKo4WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C8221726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p1J1RU+O9fBZ20oXiMWIVkZiWOvbsIwTxYk7mubVTiU=; b=RydDyoCUn8Y/lR
	H0Nz0Ee5TCeUFggNt8trcVMLBtIRJtyZ6hzw04X3MqYZ/qmyE+1sC3vdjuRWmjwjrF7WAJO2TKWsQ
	7/Xs6W1YRxYwSmEMnJA1mHjmOlJ62EGm3SBM3mEcMp7+c/ZF1Frs0hXzKwZf5Pwz8t0LB27NqMtSA
	fq4F7O0q8dfyal/YzdgXXV6u7qdlFsvDd/l+AXn13UAenWVWqPXoA5tQvtti1NrQ6h7u8gSBtOCsX
	ejdS4pHvURBQX1xZRRrx+lDRbHwOEh6AD45XEs34DeFn66KPRiJvR2KitEoZtBUnBuJZ6lGX9LKsJ
	o89sHXrwUcWkxlJwBqCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpdMd-0006XY-06; Fri, 01 Feb 2019 18:16:31 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpdMZ-0006X5-Aq
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 18:16:28 +0000
Received: by mail-pl1-x641.google.com with SMTP id u6so3594136plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=92MOdog3g1rrw+f0J4sSvR6V++80ocs0no7dR7ocrno=;
 b=FlVKo4WP1AXLtLNweC08tJa5XVhzLfJgqqPfED848lSKiTYbhecepqtwhP87iyY8Zt
 6we/5ajnxrzWcT2zPEz1/+m8ngA+204ozijvxDZDtmP4vTJfz6jqeEcTubQmbGQdzYMh
 2qRjfHDEvux4nUnatffG6ZWyZo/cBI4EoCbbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=92MOdog3g1rrw+f0J4sSvR6V++80ocs0no7dR7ocrno=;
 b=k6hLQrlnUdFw1IrpigFE0alSPjrfWhCwR8n32PSd4GQCEZRGkkE5LVUQZOTIrBhpiO
 GLpdh6An2npqkU6Zvw7LhWPUrAAYLvQS/mzKXtCES4GVbNpmbUcn2k8aBCZXCQm6aFbs
 brwk/k3a2LDtE5FOhUw1PXFwmiFo3sPlD9zNlYXG4cGvo5yfJBa/ukpWsYQBPi94Adxz
 NtveCFvxawOk3TeMSQQyXfr3FX14Snee9woS5Q1VovPzGDIerIyeypt+PNC8VykBCNWD
 9nis83K5hcV+BxCZ6S4jLsSV82KP7lNHVJ8eIYNK1skCBeQyzSBS0CkC0AqleQ2R0dfl
 tfeg==
X-Gm-Message-State: AJcUukddNP05+QsJRrX5YYwaR9LmJFSywHcrkyZi8YedG+LmdR5MhuGZ
 jxCwC3GSBT9ebHZ5o2hJDE2h2A==
X-Google-Smtp-Source: ALg8bN4IDqSqlDP2zwoW0jr1vLZp93tJbSIl54f5/UrjpRB7BHhRFbG+L5T2RBbRyAsVRjzDiZZJVg==
X-Received: by 2002:a17:902:20c6:: with SMTP id
 v6mr40982572plg.156.1549044985773; 
 Fri, 01 Feb 2019 10:16:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id v190sm11060784pfv.26.2019.02.01.10.16.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 10:16:24 -0800 (PST)
Date: Fri, 1 Feb 2019 10:16:24 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190201181624.GQ81583@google.com>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-2-quentin.perret@arm.com>
 <20190201120453.GC10042@e107155-lin>
 <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_101627_426851_9386296F 
X-CRM114-Status: GOOD (  20.62  )
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
Cc: nm@ti.com, linux-pm@vger.kernel.org, sboyd@kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 12:09:53PM +0000, Quentin Perret wrote:
> Hi Sudeep,
> 
> On Friday 01 Feb 2019 at 12:04:53 (+0000), Sudeep Holla wrote:
> > On Fri, Feb 01, 2019 at 09:30:57AM +0000, Quentin Perret wrote:
> > > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > > +{
> > > +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> > > +	int ret, cpu = cpumask_first(cpus);
> > > +	struct device *cpu_dev;
> > > +	struct device_node *np;
> > > +	u32 cap;
> > > +
> > > +	cpu_dev = get_cpu_device(cpu);
> > > +	if (!cpu_dev)
> > > +		return;
> > > +
> > > +	np = of_node_get(cpu_dev->of_node);
> > > +	if (!np)
> > > +		return;
> > > +
> > 
> > Does it make sense to add the check for OPP count here. You need not pass
> > that as parameter. Just makes one less thing to check in new drivers adding
> > this support. Thoughts ?
> 
> Yeah Matthias had the same suggestion. I don't mind moving it here TBH.
> It's just that some users already do the opp count before calling this
> function, so I figured I could as well use that data instead of counting
> again.
> 
> But yeah, that's one less thing to worry about on the driver side so
> I'll move the OPP count in there for v4 and we'll see if people ask me
> to move it out to optimize things ;-)

From an API perspective it would be nice to get rid of the nr_opp
parameter, it seems somewhat arbitrary. Moving dev_pm_opp_get_opp_count()
from the drivers into dev_pm_opp_of_register_em() (instead of calling
it twice) also sounds good in general, as long as the error handling
doesn't become too messy. In the current version
dev_pm_opp_of_register_em() doesn't return a value, with the change it
would have to return one to catch an empty OPP table, and it needs
to be distinguished from other cases where the EM registration fails
but the cpufreq driver is still functional (e.g. no
'dynamic-power-coefficient'). Maybe return -ENOTSUPP in those cases?

Well, let's see how it looks like :)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
