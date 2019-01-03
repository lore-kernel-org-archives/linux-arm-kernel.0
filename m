Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:44:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0310C20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l1KssgcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0310C20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iNQZPMq+W46Rm3+qu/C8/XqiT8f05rW2u7kbU+Kle/Q=; b=l1KssgcMLePjnz
	rdr5oOGcaaVniAdIF7jvjUdRim0Fb1wbJECf6uZVxprAf9ph2MQtXylwRD+F4a2uNT79DkYlJHaXo
	4kRP/lrPijj1frsvOStMJIWS9FbWhglmpwrJRme2jKRjf2mlzZC2Gv8ovNfkiNneaDH5nnRuXEONf
	QSyWFymH3J7TbRh/8RBdWKi9gXz/cswHeGXW9irpW0KJaN3KDeKlQ29XDcwm0gdPpoiOcrVtlU5T5
	JFj+ipT5ZIBX9wsrPFpEhyd06JJ0AxwgQH4erPrb8jKgI5xrTS/owQhT050ojOHEouBZEvosH9zIN
	nAvB/uG/l00R3yogoL9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf5Aq-0008RI-QP; Thu, 03 Jan 2019 15:44:44 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf5Ao-0008Qo-M6
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:44:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B3C5A78;
 Thu,  3 Jan 2019 07:44:40 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 286413F575;
 Thu,  3 Jan 2019 07:44:40 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 526771AE0BD1; Thu,  3 Jan 2019 15:44:40 +0000 (GMT)
Date: Thu, 3 Jan 2019 15:44:40 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [RFC PATCH 2/2] PCI/portdrv Hisilicon PCIe transport layer Port
 PMU driver.
Message-ID: <20190103154439.GC16311@edgewater-inn.cambridge.arm.com>
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
 <20181214131055.52253-3-Jonathan.Cameron@huawei.com>
 <20181214235505.GI20725@google.com>
 <20181217110906.0000003f@huawei.com>
 <20181217181915.GL20725@google.com>
 <20181218102127.0000018e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218102127.0000018e@huawei.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_074442_725608_833A899C 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Logan Gunthorpe <logang@deltatee.com>, alex.umansky@huawei.com,
 linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 Keith Busch <keith.busch@intel.com>, linux-acpi@vger.kernel.org,
 Zhou Wang <wangzhou1@hisilicon.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Eric.Wehage@huawei.com, Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 10:21:27AM +0000, Jonathan Cameron wrote:
> On Mon, 17 Dec 2018 12:19:15 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Agreed.  I could imagine a drivers/pci/pmu/ directory sort of like
> > drivers/pci/switch/.
> 
> That might work.  Mark, Will what do you think? As long as you and Bjorn
> agree I don't think it'll really matter which one is chosen.
> 
> driver/pci/pmu/ or drivers/perf/pci ?

I have a slight preference for the latter since the perf interface for
PMU drivers is notoriously subtle and error-prone. Keeping PMU drivers
together can be helpful to spot emerging patterns and makes cross-driver
changes easier to co-ordinate.

However, I'll defer to Bjorn since it's only a minor preference. We'd
obviously loop in linux-pci + Bjorn on any new submissions.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
