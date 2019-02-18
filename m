Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E80C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE20020838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DrYN2hLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE20020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2vcU5ON+U9tYT7bjp+tJbwRgOfJSu4wYp0GQsAPxkkM=; b=DrYN2hLnFl8XZ2
	+AiwpUbd3t1CsD8Ia+UvIhP9szX/+ZAovLRoJmVPHfKLp17gMPRMVg52pGF//LRZUe1MWR25gznlv
	ISClow3INmP9m9kHGKIviybmG4t9EsMRRowKDpWs8INignZA4PlPuK8cto/xJ3Wfsvabdufs9k65p
	FqEJwkWiW1x6YIneIpQekmtRDFb+zJhgiOaozZ9QcTkuhIdEnXakNQIbgskrXupAhlfZg9GnRNi7I
	baYsQ1jq97A5+vysARnxzfHdDCE4pVfhcXQ9wCrgl5PMCPCi1hgMgZEBSfvkvJ9jfwmjj+c2deovJ
	+TRs6TpZcUqiQ+6r99Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfgY-00085U-MF; Mon, 18 Feb 2019 09:58:02 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfgU-00084s-Qn
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:58:00 +0000
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id B13B1C14A11B53AB07AF;
 Mon, 18 Feb 2019 09:57:53 +0000 (GMT)
Received: from LHREML524-MBB.china.huawei.com ([169.254.3.86]) by
 LHREML713-CAH.china.huawei.com ([10.201.108.36]) with mapi id 14.03.0415.000; 
 Mon, 18 Feb 2019 09:57:45 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v6 1/4] acpi: arm64: add iort support for PMCG
Thread-Topic: [PATCH v6 1/4] acpi: arm64: add iort support for PMCG
Thread-Index: AQHUvIOBcTrq4FzrZ0KMa4a+1vXOg6XgzTaAgASYgDA=
Date: Mon, 18 Feb 2019 09:57:44 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8392C2FA3@lhreml524-mbb.china.huawei.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
 <20190204121324.11460-2-shameerali.kolothum.thodi@huawei.com>
 <20190215113933.GB27700@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190215113933.GB27700@e107981-ln.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_015759_011627_D9806078 
X-CRM114-Status: GOOD (  13.41  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
 "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
 "pabba@codeaurora.org" <pabba@codeaurora.org>,
 John Garry <john.garry@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
 Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "andrew.murray@arm.com" <andrew.murray@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: 15 February 2019 11:40
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: robin.murphy@arm.com; andrew.murray@arm.com;
> jean-philippe.brucker@arm.com; will.deacon@arm.com;
> mark.rutland@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> John Garry <john.garry@huawei.com>; pabba@codeaurora.org;
> vkilari@codeaurora.org; rruigrok@codeaurora.org; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Linuxarm
> <linuxarm@huawei.com>; neil.m.leeder@gmail.com
> Subject: Re: [PATCH v6 1/4] acpi: arm64: add iort support for PMCG
> 
[...]

> > +/*
> > + * PMCG model identifiers for use in smmu pmu driver. Please note
> > + * that, this is not part of the IORT specification.
> 
> And it is a Linux internal tag that has nothing to do with HW, it is just fabricated
> for matching a driver, I would like to have this clarified in the comment please.
> 
> I would have avoided adding another hook to differentiate platform data but
> given that it is self-contained in IORT code that should be fine for the sake of
> making progress:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks. I will wait for review of main driver patches and then will sent out a
revised one incorporating your comments on this.

Thanks,
Shameer

> > + */
> > +#define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic
> SMMUv3 PMCG */
> > +
> >  int iort_register_domain_token(int trans_id, phys_addr_t base,
> >  			       struct fwnode_handle *fw_node);  void
> > iort_deregister_domain_token(int trans_id);
> > --
> > 2.7.4
> >
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
