Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD1AC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:44:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671C021872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f6qjyAmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671C021872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1TeHuTzdZJVbzca76ObvVnWTo6gt2+o1BKylN7UZjx4=; b=f6qjyAmDlrzOFk
	6s9Bd5f9Zd95bPobdOFBF4CUyEQ/mecoA1AX1z9AseBRxwroorXnnCittJYbDFtQz8t842m6fNwjZ
	QqkqbvtNCtZnxEfZH+ySVKzAYphKBvaI5XWhccqHhBpfnPpzNLpc2Jb0DThC4L8Ovhtpr83x5vcsb
	Viw4Ed862HKNCGnX1ln09AwjNn12LeEbIlAoWmp0P5/H1x0Pvg5wQNB62pvqeOuDy9cWdzhopl0Zb
	RRpfwkJ7EhavvQiOcL8a2a/hCNV37muRDoU4l5Xes8OXiHnmPHFRiDMU9u+GS97xtsYOgsV9KJKla
	5282vngJBomSSFMN7CfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpYBI-0005zO-1t; Fri, 01 Feb 2019 12:44:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpYB7-0005pF-G4
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:44:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3E1D80D;
 Fri,  1 Feb 2019 04:44:16 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 146AB3F59C;
 Fri,  1 Feb 2019 04:44:14 -0800 (PST)
Date: Fri, 1 Feb 2019 12:44:12 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190201124412.GF10042@e107155-lin>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-2-quentin.perret@arm.com>
 <20190201120453.GC10042@e107155-lin>
 <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
 <20190201122745.GE10042@e107155-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201122745.GE10042@e107155-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_044417_538966_772EC07A 
X-CRM114-Status: GOOD (  12.04  )
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

On Fri, Feb 01, 2019 at 12:27:45PM +0000, Sudeep Holla wrote:
> On Fri, Feb 01, 2019 at 12:09:53PM +0000, Quentin Perret wrote:
> > Hi Sudeep,
> >
> > On Friday 01 Feb 2019 at 12:04:53 (+0000), Sudeep Holla wrote:
> > > On Fri, Feb 01, 2019 at 09:30:57AM +0000, Quentin Perret wrote:
> > > > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > > > +{
> > > > +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> > > > +	int ret, cpu = cpumask_first(cpus);
> > > > +	struct device *cpu_dev;
> > > > +	struct device_node *np;
> > > > +	u32 cap;
> > > > +
> > > > +	cpu_dev = get_cpu_device(cpu);
> > > > +	if (!cpu_dev)
> > > > +		return;
> > > > +
> > > > +	np = of_node_get(cpu_dev->of_node);
> > > > +	if (!np)
> > > > +		return;
> > > > +
>
> Forgot earlier, you can use of_cpu_device_node_get to combine the above 2.
>

Scratch it, you need cpu_dev anyways. So ignore that.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
