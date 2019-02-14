Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA29C10F05
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:39:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDB42229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YirzTZdO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M4MFfF/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDB42229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kjDylHbOtdbK07nCPfBjywCAhAa7lhaWOvU1vXzpofI=; b=YirzTZdO3XEUge
	HpKLmrUNp4YuDEYhwD0T+RqEKpCg1b2uKDdFfoIt/r4c0pBU+ZyuWXsMyZoDuA1XBKIX2dp1bY184
	DaipzwDzhQEzDZnuMDw0Dhn517dbCd6v54WDpMNU/s4ScxP8U7KqgvSw/WN32/bPsK2lFNYSsQfc0
	/9tzcRh+xGwIevqFDbSfavATqJvyaqUqOBULxAb385RnCfvIdSywPJpdBxX0c+MVsnHBd79v2Fxlb
	d8g1iegra8KBBc+072gZxyuSEsGVSS8yOPU/+mQO8lQLXsvqRT1oO3OOsuMw5OgSze5X2zRsxXWTG
	Pus8ACXIgyTwhq5NVnuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCYZ-0004mY-3T; Thu, 14 Feb 2019 08:39:43 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCYV-0004mC-CS
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:39:41 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E8dG7B092055;
 Thu, 14 Feb 2019 02:39:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550133556;
 bh=aYULI0iXlOgPt2an+UlTIJ6OxjZrdY1jzXjZERo92xY=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=M4MFfF/9frkpywEePNCkvxiOiB9xr6DVCH4+IvvHJpBJQsXulnqOwzq6nMNnKoayn
 Dxlb64c+gUiEZYIitW2ip458K44vZcCqRTl3nlyUSXhFZ69OMO6EV4mpmzaS8kpKix
 tlfmTyE4PJD/csMcpowMtuXnIhN+vdHgSo6odRik=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E8dGCL017296
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Feb 2019 02:39:16 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 02:39:15 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 02:39:15 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E8dBwD024488;
 Thu, 14 Feb 2019 02:39:12 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To: Tony Lindgren <tony@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
 <20190213152620.GS5720@atomide.com>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
Date: Thu, 14 Feb 2019 14:08:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190213152620.GS5720@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_003939_527877_4743159D 
X-CRM114-Status: GOOD (  23.43  )
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
Cc: Nishanth Menon <nm@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>, jason@lakedaemon.net,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, marc.zyngier@arm.com,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tony,

On 13/02/19 8:56 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [190213 04:26]:
>> Hi Tony,
>> 
>> On 12/02/19 9:52 PM, Tony Lindgren wrote:
>>> Hi,
>>> 
>>> * Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
>>>> +Example: +-------- +The following example demonstrates both interrupt 
>>>> router node and the consumer +node(main gpio) on the AM654 SoC: + 
>>>> +main_intr: interrupt-controller0 { +	compatible = "ti,sci-intr"; + 
>>>> interrupt-controller; +	interrupt-parent = <&gic500>; + 
>>>> #interrupt-cells = <4>; +	ti,sci = <&dmsc>; +	ti,sci-dst-id = <56>; + 
>>>> ti,sci-rm-range-girq = <0x1>; +};
>>> 
>>> Can you describe a bit what the "ti,sci-dst-id" is above?
>>> 
>>> These IDs seem to be listed at at [0] below, but is it really a property
>>>  of the hardware? Or is it some enumeration of SoC devices in the 
>>> firmware?
>> 
>> This is the way that sysfw describes the hardware. In this case it is GIC 
>> and it is identified by this ID.
> 
> If this ID is an enumeration in the sysfw rather than an actual hardware 
> property it should not be in the device tree. If so,

Devicetree-specification-v0.2[1] "Section 1.1 Purpose and Scope" mentions that
devicetree specification provides a complete boot program to client program
interface definition. Where boot program here is the sysfw and client program is
Linux. In this case we are describing the id which is the destination interrupt
controller to which the irqs are supposed to be attached.

> the device driver should request the id from the sysfw based on a name. That 
> is, if no struct device or device phandle can

From a scalability perspective using a name to get a device id might worsen
things.  There are hundreds of devices within the SoC and standardizing a name
for each device and making sure using the same name across all future SoCs might
be a bit pain. If there are more than one instance of the same device then name
that should be requested is different with in the same driver.

IMHO, device ids are something which can be used in DT. There are many other
things like the interrupt ranges etc.. which are discoverable from sysfw and we
are implementing it.

> be used.
> > The problem with using enumeration in the dts is that it requires
> maintaining the dts, driver(s) and possibly firmware in sync. And that might

The idea here is device ids are not going to change for a SoC. For new SoCs
within the same architecture ids will change and we will have new dts or this
new SoC.

> change between SoCs variants when new devices get added and removed.
> 

[1]
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf

Thanks and regards,
Lokesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
