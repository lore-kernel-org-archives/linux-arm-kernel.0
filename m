Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86145C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:41:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5438320815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LH7jMtlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5438320815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hFnTKB//L1beLL1QH4NuJ1Y19A/4ObEF47EDiveSVeg=; b=LH7jMtlbB6B1uF
	SkB8OEy7ipO6BGyFf4DH2DTFBPCdjwRJgWBaYGtmM/NB98AgTsVJ6Dqrne+FV7Illsl/he08MAh5O
	9IZfObQ7/Nom5gH0o56geyosLwOQRiAbSyTwiy6zr2laEJrH8fUERZxPK+4TckOnOIJaJSsZcX364
	zPVuSa9RxGz+ji74m+pmuyoBEwTdnFj/octIXFghwZ0Y59w7LY7abcpfg9z7yAEUMTbT5Kzst+Rrb
	QjitUohzPhTIifoj0XS4EwMV1YTkjCSjLU0WmtwRlFgWriBoKLZ04dC3IlHRSFbCaLYTZIWlzgKts
	rQjziIreqJeeCqmScRkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf0Ra-0007ZO-TR; Thu, 03 Jan 2019 10:41:42 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf0RS-0007Yd-7W
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:41:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DB4F80D;
 Thu,  3 Jan 2019 02:41:32 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 276323F5D4;
 Thu,  3 Jan 2019 02:41:30 -0800 (PST)
Date: Thu, 3 Jan 2019 10:41:27 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] dev_pm_opp refcount issue on Arm Juno r0
Message-ID: <20190103104127.GB23511@e107155-lin>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
 <20190103103318.GA23511@e107155-lin>
 <20190103103829.2bqxhkpihp4r7x22@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103103829.2bqxhkpihp4r7x22@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_024134_274787_FF580673 
X-CRM114-Status: GOOD (  13.30  )
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
Cc: nm@ti.com, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Quentin Perret <quentin.perret@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Douglas Raillard <Douglas.Raillard@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 04:08:29PM +0530, Viresh Kumar wrote:
> On 03-01-19, 10:33, Sudeep Holla wrote:
> > As you already state the checks are unnecessary, if we drop them we don't need
> > to add any firmware specific callbacks. I am thinking if it makes sense to
> > add a generic helper function to remove the OPPs from a device. If we have
> > that any driver needing that can use it. The main reason I think helper is
> > useful is that we need exactly same fix for SCMI driver too.
> >
> > Thoughts ?
>
> Okay, will do that and fix both the drivers as well.
>

Thanks, happy to test here.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
