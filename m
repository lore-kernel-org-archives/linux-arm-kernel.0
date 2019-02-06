Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB367C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:31:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F1D218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pNC4S/zK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kXG4I1gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F1D218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NT1GFrADsFDkigQRpmo03t19FKCzLpCOSBySGOE4Oa8=; b=pNC4S/zK7pojWu
	kCVuCLzxZBOVsv0BXJDaK1iENYhgiRnD+FRa08BXlqdfrbBWz6FeqroxfwAn/JQpM3nQO3nSGUolO
	yr2rhcAnds2xlpxf4TbZstoX/vG/t+k3bgHdZ8wZxZXT4FeAqh1PpIZQcLbVLD5YjeA+EzQcknWRk
	IaRxgTyzyykiVzd6fgKzLpEgf3zN6uH0umLvkWvaiHbZ5ERH6MZINlV44yivzzRHa4sBAlvnlvKsb
	XUEiwoGTc9kS7i9wxvZZ46hfEFUTsmEuowfH87jln6wSIsidD4Q1fi4xGRO3LZ/wB+7s26P48yhRk
	tnMPin67au3ZrO/pdxAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grMM9-0007KG-HP; Wed, 06 Feb 2019 12:31:09 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grMM4-0007Ju-Uv
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 12:31:07 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16CUsWa112683;
 Wed, 6 Feb 2019 06:30:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549456254;
 bh=nfcU7k8TYeiDCdUMfCPF6U7955+D8uZttty0YIAt5s0=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=kXG4I1guGwbWFc2uawtu9Wg2Fqk9SPHdiCSDN7UbOjauvIajnIPFnoAPy43PQZnEu
 Rq64nqZO9rPURDMxeaL1iX15C8C9HNq3oV4YlczJBeSZwKH86kcMxbcoMBCpMhStBB
 nkfQvISk4t9+5JH31rt50ZQlcyH2MFwkG24n+3uk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16CUsrv054112
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Feb 2019 06:30:54 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 06:30:53 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 06:30:53 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16CUoF7005639;
 Wed, 6 Feb 2019 06:30:50 -0600
Subject: Re: [PATCH v5 0/9] phy: Add configuration interface for MIPI D-PHY
 devices
To: Maxime Ripard <maxime.ripard@bootlin.com>
References: <cover.fbf0776c70c0cfb7b7fd88ce6a96b4597d620cac.1548085432.git-series.maxime.ripard@bootlin.com>
 <fc5427d3-674e-cebc-99b9-11493f976a20@ti.com>
 <20190205084620.GW3271@phenom.ffwll.local>
 <4177fba5-279d-3283-88f0-c681f72e5951@ti.com>
 <20190206122546.7zucalixgcm4ph36@flea>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f3a70714-5538-d6fa-201f-16b70e9d062c@ti.com>
Date: Wed, 6 Feb 2019 18:00:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206122546.7zucalixgcm4ph36@flea>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_043105_073378_82B06680 
X-CRM114-Status: GOOD (  23.41  )
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
Cc: Rafal Ciepiela <rafalc@cadence.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Krzysztof Witos <kwitos@cadence.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 06/02/19 5:55 PM, Maxime Ripard wrote:
> Hi Kishon,
> 
> On Wed, Feb 06, 2019 at 05:43:12PM +0530, Kishon Vijay Abraham I wrote:
>> On 05/02/19 2:16 PM, Daniel Vetter wrote:
>>> On Mon, Feb 04, 2019 at 03:33:31PM +0530, Kishon Vijay Abraham I wrote:
>>>>
>>>>
>>>> On 21/01/19 9:15 PM, Maxime Ripard wrote:
>>>>> Hi,
>>>>>
>>>>> Here is a set of patches to allow the phy framework consumers to test and
>>>>> apply runtime configurations.
>>>>>
>>>>> This is needed to support more phy classes that require tuning based on
>>>>> parameters depending on the current use case of the device, in addition to
>>>>> the power state management already provided by the current functions.
>>>>>
>>>>> A first test bed for that API are the MIPI D-PHY devices. There's a number
>>>>> of solutions that have been used so far to support these phy, most of the
>>>>> time being an ad-hoc driver in the consumer.
>>>>>
>>>>> That approach has a big shortcoming though, which is that this is quite
>>>>> difficult to deal with consumers integrated with multiple variants of phy,
>>>>> of multiple consumers integrated with the same phy.
>>>>>
>>>>> The latter case can be found in the Cadence DSI bridge, and the CSI
>>>>> transceiver and receivers. All of them are integrated with the same phy, or
>>>>> can be integrated with different phy, depending on the implementation.
>>>>>
>>>>> I've looked at all the MIPI DSI drivers I could find, and gathered all the
>>>>> parameters I could find. The interface should be complete, and most of the
>>>>> drivers can be converted in the future. The current set converts two of
>>>>> them: the above mentionned Cadence DSI driver so that the v4l2 drivers can
>>>>> use them, and the Allwinner MIPI-DSI driver.
>>>>
>>>> Can the PHY changes go independently of the consumer drivers? or else I'll need
>>>> ACKs from the GPU MAINTAINER.
>>>
>>> Maxime is a gpu maintainer, so you're all good :-)
>>
>> cool.. I've merged all the patches except drm/bridge.
>>
>> Please see if everything looks okay once it shows up in phy -next (give a day)
> 
> Thanks!
> 
> If possible (and if that's still an option), it would be better if the
> sun6i related patches (patches 4 and 5) would go through the DRM tree
> (with your Acked-by of course).
> 
> We have a number of patches in flight that have a decent chance to
> conflict with patch 4.

Sure. Dropped patches 4 and 5 from my tree.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
