Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11D4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:20:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EF3214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HpmgH9rw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jOUoVPLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EF3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v04Gig5K5XQ66OvkpsJjoNFUmJkni866Fby7otXyayw=; b=HpmgH9rwsCBJF4
	hivxq1abAbdw9MlSSYg16Gymv9usgcFHHQJle62NnPYpUOHmBtlgVG+j1UVn0TOFdHcfTzx8Q1Cpq
	QpyhlEQ6MH+VlMatJQ0S0/yG8JEVn/DSedAF3cHt5nLiLkEjRCAC3ciJE6OyCfub9zoBwioTSj94r
	0zJrJughmA1jhMTI92vZkyrOZmx9HKTQje42ki0iZ3n5swT/PZJJy3GEcayzAjFwyKNsvKITeVr41
	tpx+usA/4WEZ2yBiiHqLC9jPOKVfR4XC8XmQBpGolz/0N0OCbHneQKOJmgDGnYbnRdfbkviXWAtO6
	jx9UD0cgxiGHDjvaN62A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guWr0-00069j-Um; Fri, 15 Feb 2019 06:20:06 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guWqw-0005Oz-CP; Fri, 15 Feb 2019 06:20:04 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F6JrfR083423;
 Fri, 15 Feb 2019 00:19:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550211593;
 bh=VvYosYLXTZE6Xwyjczf/0uYinaS7PQPeE6ljLNmbDgc=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=jOUoVPLQmKbqsitdkvRyRrmkqcoziJBqhVj5Yly5QTX34OkliiQz7JLrH+TLKJJfZ
 wySnQRfSzYfmG6N8uHg7HmiWzdzmkReLIULgEzALzo4+zsD8uxDqnGHvmh4w2Z3qPP
 8GPt5BpMLSRurtmpD0Xjkb24LD4c4M+jI0F9BALg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F6JrKR015573
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 00:19:53 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 00:19:52 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 00:19:52 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F6JmOD016900;
 Fri, 15 Feb 2019 00:19:49 -0600
Subject: Re: [PATCH v2 08/15] PCI: endpoint: Fix pci_epf_alloc_space to set
 correct MEM TYPE flags
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190114111513.21618-1-kishon@ti.com>
 <20190114111513.21618-9-kishon@ti.com>
 <20190211173723.GA31035@e107981-ln.cambridge.arm.com>
 <ebadc615-f633-e84e-041a-99b7936a123b@ti.com>
 <20190214162928.GA32523@e107981-ln.cambridge.arm.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <edc76e9b-bdd4-80bb-3dff-1d44a100c153@ti.com>
Date: Fri, 15 Feb 2019 11:49:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214162928.GA32523@e107981-ln.cambridge.arm.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_222002_543477_CF244516 
X-CRM114-Status: GOOD (  18.96  )
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
Cc: Heiko Stuebner <heiko@sntech.de>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Alan Douglas <adouglas@cadence.com>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lorenzo,

On 14/02/19 9:59 PM, Lorenzo Pieralisi wrote:
> On Wed, Feb 13, 2019 at 07:17:14PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 11/02/19 11:07 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Jan 14, 2019 at 04:45:06PM +0530, Kishon Vijay Abraham I wrote:
>>>> pci_epf_alloc_space() sets the MEM TYPE flags to indicate a 32-bit
>>>> Base Address Register irrespective of the size. Fix it here to indicate
>>>> 64-bit BAR if the size is > 2GB.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/pci/endpoint/pci-epf-core.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> This looks like a fix and should me marked as such. Does it work
>>> as as standalone patch if it gets backported ?
>>
>> Yeah, it should work. But the current users doesn't allocate > 2GB and some
>> EPC drivers configure their registers based on size. So nothing is broken
>> without this patch as such.
> 
> I suspect you mean 4GB (here and the commit log), right ? I am checking
> the commit logs, aiming at merging the patches.

A 32bit BAR register can support a 'size' of only up to 2GB. Though it can hold
a memory address of up to 4GB.

This is also mentioned in the PCI Local Bus Specification.
"A 32-bit register can be implemented to support a single memory size that is a
power of 2 from 16 bytes to 2 GB"

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
