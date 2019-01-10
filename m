Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A603CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:05:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6991B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVWCjxks";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x/MJ23j7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6991B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KX0p9DFLJwxVLKEe8gifiWUBdk0oZuhUKg18gbIOYCI=; b=kVWCjxksH0yEPh
	xabISm8putQPPcJ/BgLrypUXd0OCiEba/CffnZrnKFWvr9rsTbPETp3uiuz5yC7JwzS+SeXpPM61c
	M0dIJi7Om+bpiwWI+NeiaF3KlGSFv3pUlZPWM5qWfSGUnXGYwCLj+oAJdqYyqkG97JiHvcMyebj5F
	d/bOPYp5EymHNzfoSrTzCc5NTaYhw09jkt1ykFMh6EogY6AM6yJSh8F62m7JlFz1SUNupZFR8TmR/
	/20PTfXxCPfH9+MdNG+KxF8JTvytzDvosVeTxkLHRNwinE04hEIy8vKEvByQlfB+fuYOJB5D9CHY2
	8SJfLe0lSFdkLHGX1S/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghSXC-0007mU-V1; Thu, 10 Jan 2019 05:05:38 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghSX9-0007lm-AB; Thu, 10 Jan 2019 05:05:36 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0A55POb069779;
 Wed, 9 Jan 2019 23:05:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547096725;
 bh=W/zRbojufLf1d/jOTblk09RhR0/gwepqMYhy3lCVlZ8=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=x/MJ23j7mvl+W1t588zFYCKCWqOK/kg6zCQZ7JT0cGhHqDZ/IgN3CD1+FxfTwBbIJ
 S1ldvEQkefKGJQcQpm07c9tX40N2hIdPgU7ylGIl0GUCRDrRQoLu2QytYMmY3FDaCQ
 xdcWcBKaPrbEC0Q3hS9Z2dPBciqcPtsk5Qww1T5E=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0A55PMO060796
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Jan 2019 23:05:25 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 23:05:24 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 23:05:24 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0A55KHB023335;
 Wed, 9 Jan 2019 23:05:21 -0600
Subject: Re: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
To: Heiko Stuebner <heiko@sntech.de>
References: <20190107064148.10152-1-kishon@ti.com> <1936135.agpnLP3rXd@phil>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ce1e4bab-5c7c-5593-d28f-2187a04baef6@ti.com>
Date: Thu, 10 Jan 2019 10:35:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1936135.agpnLP3rXd@phil>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_210535_495387_E15FB157 
X-CRM114-Status: GOOD (  17.01  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Alan Douglas <adouglas@cadence.com>, Jia-Ju Bai <baijiaju1990@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Heiko,

On 07/01/19 8:05 PM, Heiko Stuebner wrote:
> Am Montag, 7. Januar 2019, 07:41:33 CET schrieb Kishon Vijay Abraham I:
>> Hi Lorenzo,
>>
>> The Endpoint controller driver uses features member in 'struct pci_epc'
>> to advertise the list of supported features to the endpoint function
>> driver.
>>
>> There are a few shortcomings with this approach.
>>   *) Certain endpoint controllers support fixed size BAR (e.g. TI's
>>      AM654 uses Designware configuration with fixed size BAR). The
>>      size of each BARs cannot be passed to the endpoint function
>>      driver.
>>   *) Too many macros for handling EPC features.
>>      (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
>>       EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
>>       EPC_FEATURE_GET_BAR)
>>   *) Endpoint controllers are directly modifying struct pci_epc
>>      members. (I have plans to move struct pci_epc to
>>      drivers/pci/endpoint so that pci_epc members are referenced
>>      only by endpoint core).
>>
>> To overcome the above shortcomings, introduced pci_epc_get_features()
>> API, pci_epc_features structure and a ->get_features() callback.
>>
>> Also added a patch to set BAR flags in pci_epf_alloc_space and
>> remove it from pci-epf-test function driver.
>>
>> Tested on TI's DRA7xx platform.
> 
> While I don't have that much PCI experience and hence cannot judge
> this cleanup as a whole, I can at least say, that my Rockchip rk3399
> still does find its PCIE-connected wifi card, so this series on rk3399
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Thank you for testing this series with PCIe controller configured in RC mode.
It would be great if it could be tested with EP mode too.

Thanks for the help.

Cheers
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
