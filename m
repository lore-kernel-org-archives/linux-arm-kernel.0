Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A054EC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:23:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710E3218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tv1CsWVc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fYpwcxzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710E3218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yFjB2UGHLXe6m8DzvIr4Ir5tCFROR+y5FJ/Y13645h4=; b=tv1CsWVcOPZ7Kj
	s+RfNNHjDapxpZtYgqfk2/0v78ChGc1OfEF6R9+Bn7RDIIvA9djBFothykyLU5Sj2sVOky7zmtlhp
	lHl/AM+68+3s9Aa+G+z2tcE7Ci4CxJcJfR6Gvk3ZbrHJjhfFJbokHXK0TujZp5lqFKqg4OMwO5JPN
	jDwAfOcNELvoXOMxGhitfA4Tq4nAL2VnFuAHHVX/+KAR1UODg6SXvtjfso3+ydyObBcbjRPNl5D9C
	OXYEW6Rtgrm801kQtGqVTaJNoydNGLrpf87znfRxX3D5jPkxCzc8NeXbbmwTnzU+NoLwttHSWTSit
	ripSvtT0rzTFR04EC/QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2NY-0004O3-6w; Fri, 08 Feb 2019 09:23:24 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2NV-0004Ni-BJ
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:23:22 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x189N3VO082505;
 Fri, 8 Feb 2019 03:23:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549617783;
 bh=X/lGZNH3s/0L7uZkitokagWbtF0cFHSOQuQygwXIy+A=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=fYpwcxzAAXZKbtIbasmTIVsTU20vKtEMdixvw3lCzuwaLVLBBvl/OqBoOx37VtIHG
 hAELPoY8qHrx3HbcfEWdpiAWBKFT0nFzBp0Ncu0qXvL/3IVoSsjlLyK6DQ0kY8+jrk
 FnoPzskjYGt67nkYUkyrcsLeuhWqVn2PYvFwxo2Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x189N2gV099195
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Feb 2019 03:23:03 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 03:23:02 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 03:23:02 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x189Mwil016204;
 Fri, 8 Feb 2019 03:22:58 -0600
Subject: Re: [PATCH net-next v2 0/6] Add comphy support for Armada 38x
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, David Miller
 <davem@davemloft.net>
References: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
 <20190207.181049.1229639710283404215.davem@davemloft.net>
 <20190208085821.7556a18d@windsurf>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <295924f0-1007-4b39-189b-1b21e4bf1b86@ti.com>
Date: Fri, 8 Feb 2019 14:52:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208085821.7556a18d@windsurf>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_012321_467652_8ABD160D 
X-CRM114-Status: GOOD (  19.53  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, jason@lakedaemon.net,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, linux@armlinux.org.uk, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, sebastian.hesselbarth@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 08/02/19 1:28 PM, Thomas Petazzoni wrote:
> Hello David,
> 
> On Thu, 07 Feb 2019 18:10:49 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
>> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
>> Date: Thu, 7 Feb 2019 16:18:25 +0000
>>
>>> This series adds support for the comphy for Armada 38x, which allows
>>> these SoCs to use 2500BASE-X mode with appropriate SFP modules.
>>>
>>> Tested on SolidRun Clearfog after updating for the 5.0 merge window
>>> changes.  
>>
>> Series applied, thanks Russell.
> 
> This series contained:
> 
>  - Device Tree bindings that had not been ACKed by the DT bindings
>    maintainers, one of which should have been merged through the
>    drivers/phy maintainer tree.
> 
>  - A brand new drivers/phy driver that had not been ACKed by the
>    drivers/phy maintainer.

The PHY driver looks good to me. But I think it might still be better to take
it via PHY tree since there are other Marvell drivers that are getting merged
and will result in conflicts in Kconfig and Makefile.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
