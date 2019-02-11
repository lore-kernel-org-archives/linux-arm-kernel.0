Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D32C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:27:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABE721B24
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j3yXB9ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABE721B24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NUVS+qxEjyKN4kSKcnUiZRJREohtTIn9jXOkt5RHfe8=; b=j3yXB9ac9yPN7Z
	OkPXn2Hoemez/1SPHO8q+BCoMZW6EHGb2VwCRYfvzhD+ewoJtjI2DQS7CL9MujOcTSCNHlaXnT65O
	GyZNjKeH7HIbgesiK1gp/gRaiftvZB8U+/aXDfQh1eVXXH+5Yhx4ZtviorHzr4ivTFN2L1yheiaFN
	SnBL89U050BWT8+2N0T8j7d37DDCIT0tgtZ/kBvUxAAVPnKjB3Lkyf5s2nePw6CaA/PrzI0E1IeL+
	L4ND2lznIEmckEImzuw643zxGmQiJ5QiO6zk3MYfE2uhVU+pYR5BEJ/f5GMlxoH311hKUlRa0K++Y
	RBmPrHY1s5eaxvgyFzHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtGIQ-0005qX-Mh; Mon, 11 Feb 2019 18:27:10 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtGIL-0005ph-LI
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:27:07 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2019 10:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; d="scan'208";a="125619107"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by orsmga003.jf.intel.com with ESMTP; 11 Feb 2019 10:27:03 -0800
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 10:27:03 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.48]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.80]) with mapi id 14.03.0415.000;
 Mon, 11 Feb 2019 10:27:02 -0800
From: "Schmauss, Erik" <erik.schmauss@intel.com>
To: Jeremy Linton <jeremy.linton@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
Thread-Topic: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
Thread-Index: AQHUwBELRUotvo/++EOsz9jPMtTFnaXa7fTQ
Date: Mon, 11 Feb 2019 18:27:02 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C57BD14@ORSMSX122.amr.corp.intel.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
 <20190209004718.3292087-2-jeremy.linton@arm.com>
In-Reply-To: <20190209004718.3292087-2-jeremy.linton@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_102706_194141_11C51725 
X-CRM114-Status: GOOD (  14.36  )
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
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "Wysocki, 
 Rafael J" <rafael.j.wysocki@intel.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Moore,
 Robert" <robert.moore@intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "devel@acpica.org" <devel@acpica.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Jeremy Linton [mailto:jeremy.linton@arm.com]
> Sent: Friday, February 8, 2019 4:47 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> devel@acpica.org; catalin.marinas@arm.com; will.deacon@arm.com;
> mark.rutland@arm.com; Moore, Robert <robert.moore@intel.com>;
> Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; lenb@kernel.org; Jeremy Linton
> <jeremy.linton@arm.com>
> Subject: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
> 
Hi Jeremy,

> [Placeholder patch for upstream ACPICA commit]

FYI: we are planning on releasing ACPICA patches by the end of this week at the latest.

Erik
> 
> Add just ACPI 6.3 changes associated with the arm64 SPE.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  include/acpi/actbl2.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> c50ef7e6b942..4b58eb6cf64e 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -623,7 +623,7 @@ struct acpi_madt_local_x2apic_nmi {
>  	u8 reserved[3];		/* reserved - must be zero */
>  };
> 
> -/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
> +/* 11: Generic Interrupt (ACPI 5.0 + 6.0 + 6.3 changes) */
> 
>  struct acpi_madt_generic_interrupt {
>  	struct acpi_subtable_header header;
> @@ -641,7 +641,8 @@ struct acpi_madt_generic_interrupt {
>  	u64 gicr_base_address;
>  	u64 arm_mpidr;
>  	u8 efficiency_class;
> -	u8 reserved2[3];
> +	u8 reserved2;
> +	u16 spe_overflow_interrupt;
>  };
> 
>  /* Masks for Flags field above */
> --
> 2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
