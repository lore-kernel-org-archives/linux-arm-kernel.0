Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C67FC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D83218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FRYL+w2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D83218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Ksd9fFb6nEfKIk5cVoFMrt/QgT2gvprgzjkaUamJJE=; b=FRYL+w2oz7nE95
	zQzRGL+7xplVdh4izil8YKpitG7KMWdZsU7RTNhfOKLq8vm9MyQr4UqYZ5+AujjDNK35Bst4Kiuvs
	OWt9jjFpRNxeUnoS6BKJpFdWVbRQw4biOLKnWLct4kME5MmISzfZ7a08NV5f0xcKNOsMamPAc0Q4l
	3TtmmYRFwNeV6U3E8NTEuoOp6rZR/UDIydlpPNZZmpIFT0O8Eb8h7Y79bObSmCoyjK2sowPcutyXE
	OUJHrajbb+WpbdYw4p5BCCqXSNhZ/ihPo1XmZd+AB8OoTlprnaTwwxoMYjDsciKlI6KCnynOecbTY
	HCoC4QoB0kLrFk/hJAYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpXe5-0000Un-A0; Fri, 01 Feb 2019 12:10:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpXdy-0007yD-3C
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:10:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2A5880D;
 Fri,  1 Feb 2019 04:09:59 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3169A3F59C;
 Fri,  1 Feb 2019 04:09:58 -0800 (PST)
Date: Fri, 1 Feb 2019 12:09:53 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-2-quentin.perret@arm.com>
 <20190201120453.GC10042@e107155-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201120453.GC10042@e107155-lin>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_041002_193780_C587C007 
X-CRM114-Status: GOOD (  13.38  )
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
 mka@chromium.org, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sudeep,

On Friday 01 Feb 2019 at 12:04:53 (+0000), Sudeep Holla wrote:
> On Fri, Feb 01, 2019 at 09:30:57AM +0000, Quentin Perret wrote:
> > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > +{
> > +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> > +	int ret, cpu = cpumask_first(cpus);
> > +	struct device *cpu_dev;
> > +	struct device_node *np;
> > +	u32 cap;
> > +
> > +	cpu_dev = get_cpu_device(cpu);
> > +	if (!cpu_dev)
> > +		return;
> > +
> > +	np = of_node_get(cpu_dev->of_node);
> > +	if (!np)
> > +		return;
> > +
> 
> Does it make sense to add the check for OPP count here. You need not pass
> that as parameter. Just makes one less thing to check in new drivers adding
> this support. Thoughts ?

Yeah Matthias had the same suggestion. I don't mind moving it here TBH.
It's just that some users already do the opp count before calling this
function, so I figured I could as well use that data instead of counting
again.

But yeah, that's one less thing to worry about on the driver side so
I'll move the OPP count in there for v4 and we'll see if people ask me
to move it out to optimize things ;-)

Thanks,
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
