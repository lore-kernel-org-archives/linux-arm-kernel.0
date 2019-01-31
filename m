Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DB2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:34:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244A6218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RqmhlSDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244A6218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S03FBufIu6GIV5vJM5TbC7LC6VPhMLg3HR0pF8EnHIw=; b=RqmhlSDrBrX1Bo
	d5SONtYahi/wWISo9PVzhfLv5UdABT/gItOY02SMMnNHs2QjID/R23uVBC6DlUyOE39RO1u7e4oMu
	6xPo3GrnRhcmqhZS4asPXKm+xvN6rtcE9tQkQTpeH7AkR8OKxV1oAjej3dFLV59JYFRvavJHucnG7
	iyUyRPC2ebIaQEV6QFyp5gS0CqREzTpI9iK6Rok6Cw0xnV33/DSOrzaXscofXR4ELB3Gai1VR6krH
	2mM+w9k5gIqvcLTx2eM8KZFaUrJOvDlV2bUXqgw/RPJaI9WGtguknKdoS9w+uu1gc7/3I//oG0LGl
	sMmXFyPtXIRSFtlxYZjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8jx-00034K-S7; Thu, 31 Jan 2019 09:34:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8ju-00033z-2l
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:34:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A5D1A78;
 Thu, 31 Jan 2019 01:34:28 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C6933F71E;
 Thu, 31 Jan 2019 01:34:26 -0800 (PST)
Date: Thu, 31 Jan 2019 09:34:21 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131093418.umsbh4eevgod42sh@queper01-lin>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190130190703.GM81583@google.com>
 <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_013430_121511_9F156C5A 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: nm@ti.com, linux-pm@vger.kernel.org, sboyd@kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
 sudeep.holla@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thursday 31 Jan 2019 at 12:52:09 (+0530), Viresh Kumar wrote:
> On 30-01-19, 11:07, Matthias Kaehlcke wrote:
> > On Wed, Jan 30, 2019 at 05:05:02PM +0000, Quentin Perret wrote:
> > > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > > +					 int cpu)
> > 
> > why __maybe_unused?
> 
> Yeah, it isn't required I think. He probably added it for the case
> where CONFIG_ENERGY_MODEL=n, but even then an inline routine is
> defined which will accept it as argument and wouldn't do anything with
> it. Had it been a macro, we would have required __maybe_unused but not
> now.

The thing is, the EM_DATA_CB() macro _is_ stubbed for
CONFIG_ENERGY_MODEL=n:

https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L165

So, without __maybe_unused you get do get a compiler warning.

Thanks,
Quentin

> 
> -- 
> viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
