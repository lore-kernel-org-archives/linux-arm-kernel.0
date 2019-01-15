Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F66C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:05:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393E220657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VJg/AO+o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="co9VSJ0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393E220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tK6q8sPJeDry4HN6WBqluZe8xDfrY0mum7mtXhtVUOg=; b=VJg/AO+oUlcXP7
	1zvQt75CjOOAmQY9rXevmwGxRHDjlMcwznsZNhhNnVgOjgeifV3E2AWxy9wYbE7OBjpNtmyBlr7o6
	gC4+NRFMPatfuJRbK7cjy0GGAIpv8vWoUXIQlQmFQvx404ccmHNeKFZnquNyrvqVNI68mxWTLPlb2
	cB+1APz2MWwR4X1yqZKOqtGYuBwXk1XNizYGi1HDC75k0uod8daEts0HaqdSHSkLplZOAUrOiYgRE
	D+X3CbZMYyeF0ufBychv50XybsmBz475QxAbBRbSPQAxQfr7TnjiR79Jofuvr8FVdUcdP3vojqLkO
	CABirEqL3tCM+/T3JNeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPLj-00060M-DN; Tue, 15 Jan 2019 14:05:51 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPLe-0005sT-K4
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:05:48 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FE5Oph002503;
 Tue, 15 Jan 2019 08:05:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547561124;
 bh=peA5Y3S5lzMHrlqAIVzaXCVj5lbvtbwMS+pHxRRHHNM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=co9VSJ0/2RfAijiphs3vwaDY+lkLjJziFoHMT5wFC1Du2LUBFfc4ZnAscGehT/NXN
 SEBoONCcYdU43AfKjz4hngJkVElXcYlVX/jlnLesug44vXvDP0FOD0vob0WTNrYZB1
 Yueu5iNXrM+ZrDSJQf4ohVPH3sLB31GHNe98p7+g=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FE5Ou6038046
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Jan 2019 08:05:24 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:05:24 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:05:24 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FE5ONR022804;
 Tue, 15 Jan 2019 08:05:24 -0600
Date: Tue, 15 Jan 2019 08:04:51 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC PATCH v4 12/13] irqchip: ti-sci-inta: Add support for
 Interrupt Aggregator driver
Message-ID: <20190115140451.fnmvqm5kcfgt7rh2@kahuna>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-12-lokeshvutla@ti.com>
 <9efbb01b-2ef9-13e7-f871-8db2c92844ee@ti.com>
 <50da7038-9b1c-6910-2cf1-78fa98ddc3bd@ti.com>
 <ad43911d-78b2-6ed0-31c2-8361b5f4911f@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad43911d-78b2-6ed0-31c2-8361b5f4911f@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_060546_739828_CFF1A1E1 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>, jason@lakedaemon.net,
 Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 marc.zyngier@arm.com, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14:38-20190115, Tero Kristo wrote:
[...]
> 
> The mentioned failure only happens with a specific .config. Not sure what is
> the actual Kconfig that masks the failure though, but anyway it looks like
> interrupt.h gets included via some indirect path with arm64 defconfig making
> it pass.

I am able to reproduce the build fail as well:
.config: -> Notice that all v8 arch other than K3 is disabled, expert
mode is enabled and few ancillary "optimization" of config
	  https://pastebin.ubuntu.com/p/w5t9Wvp2jJ/
Here is what I did:
 git checkout next-20190115
 wget -O inta.mbox https://lore.kernel.org/patchwork/series/377815/mbox/
 git am inta.mbox
 I put the above .config as my .config
 make oldconfig
 make drivers/irqchip/irq-ti-sci-inta.o

I got the exact failure as well..
 https://pastebin.ubuntu.com/p/JzFXGz7Gh9/

I agree with peter than this should be fixed. randconfig would have
caught this anyways.. I did'nt bother looking further in the config to
figure out why the side effect, but glad it got caught early enough.

Thanks Peter.

Lokesh, I know you are out this week, will appreciate if you could post
a v5 once you are back?

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
