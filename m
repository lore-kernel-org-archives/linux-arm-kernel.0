Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E1C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:05:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C5A20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XEbXhTff";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mMpXGkUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C5A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AHXDRKLuwkYcjfZXbO7hA3rdH67uxtfOOQG84mR4TCw=; b=XEbXhTffzvsV37
	dSp/EbbexWWw/ZOsOoEkL7coGRYr7NZekyu69AQa9oJLIqxFSPTx/rpcSOGqlBX3oUvKsUuCWZBDS
	pgpWKWxW8Q76AwuWXKXcUCi+atAcDFy2io8w5jfpFK6QeaRLNyHZI9pLPaHzj6n64vhFrNuya/X6z
	lx8Dg/YwuSSQpwoXkdr6z4XXdBo+Bgnal4BtNxmEK+2SC0W3Kxum5fxi0NQOFB1WIXHySoPZ+taeO
	J5vEBYfpc9/TCfRtnRx2OvDvTtLuXWe+hQVCqEILaGw4KL4WS19G1Xg5A6HPuM4HmJQ5/qtkk4qdh
	Ae3fbkx94PFxUBdjVwWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFPP-0008E6-Kq; Wed, 23 Jan 2019 10:05:23 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFPJ-0007uI-Bf
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:05:21 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0NA53uE099338;
 Wed, 23 Jan 2019 04:05:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1548237903;
 bh=LIwR+BIZfvM7UkpbXRiq2HxtOBot3cOhlo/4etvby+U=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=mMpXGkUhXlhsKFxov8yQr/bykLN2q9Jnzi9Hcip4j0QMf3e4kKR8mOjIbqVUwAB6/
 mCZd2L7sqOw/xFRqi3OROKrsKMHsHRhLULOdLX90lP/FntqfrQc7/ZTxQKGklKpPSI
 2mroLUY3jgNjC5EiDe/Ow7cNKYuzDYwnMOyU4C+I=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0NA52MW052300
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Jan 2019 04:05:02 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 23
 Jan 2019 04:05:01 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 23 Jan 2019 04:05:01 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0NA4tiL008717;
 Wed, 23 Jan 2019 04:04:57 -0600
Subject: Re: [PATCH 09/24] dt-bindings: PCI: Document "atu" reg-names
To: Rob Herring <robh@kernel.org>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-10-kishon@ti.com> <20190122004806.GA32204@bogus>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5f2fa7cd-b5a3-e466-6cbc-305f15836241@ti.com>
Date: Wed, 23 Jan 2019 15:34:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122004806.GA32204@bogus>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_020517_560950_F1E4CDD8 
X-CRM114-Status: GOOD (  20.59  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 Murali Karicheri <m-karicheri2@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On 22/01/19 6:18 AM, Rob Herring wrote:
> On Mon, Jan 14, 2019 at 06:54:09PM +0530, Kishon Vijay Abraham I wrote:
>> Document "atu" reg-names required to get the register space for ATU in
>> Synopsys designware core version >= 4.80.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index c124f9bc11f3..5561a1c060d0 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -4,8 +4,11 @@ Required properties:
>>  - compatible:
>>  	"snps,dw-pcie" for RC mode;
>>  	"snps,dw-pcie-ep" for EP mode;
>> -- reg: Should contain the configuration address space.
>> -- reg-names: Must be "config" for the PCIe configuration space.
>> +- reg: For designware cores version < 4.80 contains the configuration
>> +       address space. For designware core version >= 4.80, contains
>> +       the configuration and ATU address space
>> +- reg-names: Must be "config" for the PCIe configuration space and "atu" for
>> +	     the ATU address space.
> 
> I'm pretty sure we already have other platforms with an ATU. Those all 
> just represent it with the other ctrl registers? So maybe this is TI 
> specific that it is separate. Or should have some conditional like 'if 
> the ATU space is separate, the reg-name should be atu'.

This is specific to Synopsys Designware version >= 4.80 and not to TI. The
first platform used a fixed offset to get the atu_base which is incorrect.

In the "reg" binding I've noted this dependency.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
