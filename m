Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A2FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:35:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E879320675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dX2l8HEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E879320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EHasnIB5WNRsFoNPbw3/JdcCfXnazgnGEDj1fwH0xtg=; b=dX2l8HEhs9V3wX
	Avp1mO3iCVD2uK18Ekv7dYTHpS2+nP3+u5KtUmpEJCi4ch7CuUL84tZ3s4DwvAXERUgA9Jwca3nR8
	RapsCNLRcpoy3UYGsr6GjE8FgpqS0nMeU/JmOiLPhchuqfKEQD8nOBlq3tQUhZc56Doynn2vtCmqJ
	cVYiZ3JfrzMMRDogNw2SRYk5ngwY84BBzpnWJ5u7ospa3/bO8PMO9Lw/rLii3vp1mDtZAlpdr6FYE
	OiLPuYcV2CRwGyVEr+LV3Gh3pWqa5Asn7k/sYnBkeXSjvkO5A3canGJGQwJIuyJEKbA1V/T+iVde/
	o45QraBeSdwYK4UhuVSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYxjF-0006Fv-Jt; Mon, 17 Dec 2018 18:34:57 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYxjC-0006EU-6j
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 18:34:55 +0000
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.89)
 (envelope-from <logang@deltatee.com>)
 id 1gYxj0-0002I4-Hj; Mon, 17 Dec 2018 11:34:43 -0700
To: Bjorn Helgaas <helgaas@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
 <20181214131055.52253-3-Jonathan.Cameron@huawei.com>
 <20181214235505.GI20725@google.com> <20181217110906.0000003f@huawei.com>
 <20181217181915.GL20725@google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5bbd3740-0a25-a5a8-bd88-9e29dffdc4d3@deltatee.com>
Date: Mon, 17 Dec 2018 11:34:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181217181915.GL20725@google.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Eric.Wehage@huawei.com, alex.umansky@huawei.com,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org,
 rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
 mika.westerberg@linux.intel.com, wangzhou1@hisilicon.com,
 keith.busch@intel.com, linuxarm@huawei.com, will.deacon@arm.com,
 zhangshaokun@hisilicon.com, mark.rutland@arm.com, linux-pci@vger.kernel.org,
 jonathan.cameron@huawei.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 2/2] PCI/portdrv Hisilicon PCIe transport layer Port
 PMU driver.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_103454_583499_46D1D59D 
X-CRM114-Status: UNSURE (   9.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 linux-acpi@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
 alex.umansky@huawei.com, Eric.Wehage@huawei.com,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2018-12-17 11:19 a.m., Bjorn Helgaas wrote:
> I *think* drivers/pci/switch/switchtec.c is for a type 0 endpoint that
> happens to be built into the switch, e.g., the type 1 bridge is
> function 0 and the type 0 management endpoint is function 1.  Logan,
> can you confirm/deny?

Yes, that's correct. The upstream port has multiple functions: one for
the bridge and one for the management/NTB endpoint. In the driver, we
have absolutely no reason to touch, or even know about, the bridge
endpoint. This is all very configurable and you can disable either of
the endpoints in the switch's configuration. And the NTB endpoint can
have all the BARS configured with any reasonable amount of BAR space for
memory windows. In the NTB world, there are never enough BARs or address
space within them.

The upstream device, with both functions, looks like this on my system:

02:00.0 PCI bridge: PMC-Sierra Inc. Device 8543 (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, NUMA node 0
	Bus: primary=02, secondary=03, subordinate=0c, sec-latency=0
	I/O behind bridge: 00002000-00006fff
	Memory behind bridge: f7100000-f78fffff
	Prefetchable memory behind bridge: 0000381f80000000-0000381fc3ffffff
	Capabilities: [40] Express Upstream Port, MSI 00
	Capabilities: [7c] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [8c] Power Management version 3
	Capabilities: [94] Subsystem: PMC-Sierra Inc. Device beef
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [138] Power Budgeting <?>
	Capabilities: [148] #12
	Capabilities: [178] #19
	Capabilities: [1a4] Device Serial Number 50-0e-00-4a-00-00-00-01
	Capabilities: [1b0] Latency Tolerance Reporting
	Capabilities: [1b8] Access Control Services
	Capabilities: [7f8] Vendor Specific Information: ID=ffff Rev=1 Len=808 <?>
	Kernel driver in use: pcieport

02:00.1 Memory controller: PMC-Sierra Inc. Device 8543
	Subsystem: PMC-Sierra Inc. Device 8543
	Flags: bus master, fast devsel, latency 0, NUMA node 0
	Memory at 381fc4000000 (64-bit, prefetchable) [size=4M]
	Capabilities: [40] MSI: Enable- Count=1/4 Maskable- 64bit+
	Capabilities: [50] MSI-X: Enable+ Count=4 Masked-
	Capabilities: [5c] Power Management version 3
	Capabilities: [64] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [138] Device Serial Number 50-0e-00-4a-00-00-00-01
	Capabilities: [144] Access Control Services
	Kernel driver in use: switchtec
	Kernel modules: switchtec


Logan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
