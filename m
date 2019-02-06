Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A34BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:14:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A102175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SN5iW1R/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fMFqb9qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A102175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rT6LXTW6XwDA8mrhxhz0gOdie60BNNzn6Y+KjHYpoGA=; b=SN5iW1R//YSqUFkj/GAwWJb6k7
	hhMgn+6EorTiFylccBFJPFXgdIHAS0Rym2MTUI0NY5iEcHEaHtX0YsKZ/gTt3HIKdLpUoa+Br5dHN
	9Sx1byju7M0ZL1TMQrT8nG8e9/2oTxvY2ak5gDKeeSnB6KWwIS5/w24nQVUtXND1IwxhYDAfC1uU5
	H8aAFeiOrgxXvohkIsksuuEjzapedgYMGmWab8g+6+PidcAHcDINFWSihclVHlxiBbREj2efIdY65
	PxIF8Yknc5YZsoxS9y8J21QxkpItUx3vC7XVqAoGf5FaN+C8ZNTMl/WWWeikRqvbFpot5bGvVmXSZ
	RQSKqQwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grM5a-0006PL-34; Wed, 06 Feb 2019 12:14:02 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grM5V-0006OK-Az
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 12:13:59 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16CDlGg099473;
 Wed, 6 Feb 2019 06:13:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549455227;
 bh=OkmxFCqvSMN/H6H9Jc2o7POV727/QGELQx/IqXK1Qyg=;
 h=Subject:To:References:From:Date:In-Reply-To;
 b=fMFqb9qPFoxtYdfmVAvwgSRxLH+VcCWmCrvLgxfwabPaOJxBM/c5VNSZ2UQjlAQKP
 or7BjxkXWs8QNrYE2KRvMD6LCKbLxAuNHJdqoco1RGPfZ7w+JKz/5SNKGIaXAilNTn
 jHoVVUz9XpPMaJdzj8k9TMusLi5kLAhd0OAuPKsM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16CDkmf038845
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Feb 2019 06:13:47 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 06:13:46 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 06:13:46 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16CDgdo027632;
 Wed, 6 Feb 2019 06:13:43 -0600
Subject: Re: [PATCH v5 0/9] phy: Add configuration interface for MIPI D-PHY
 devices
To: Maxime Ripard <maxime.ripard@bootlin.com>, Rafal Ciepiela
 <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>
References: <cover.fbf0776c70c0cfb7b7fd88ce6a96b4597d620cac.1548085432.git-series.maxime.ripard@bootlin.com>
 <fc5427d3-674e-cebc-99b9-11493f976a20@ti.com>
 <20190205084620.GW3271@phenom.ffwll.local>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4177fba5-279d-3283-88f0-c681f72e5951@ti.com>
Date: Wed, 6 Feb 2019 17:43:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205084620.GW3271@phenom.ffwll.local>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_041357_459560_11799CE3 
X-CRM114-Status: GOOD (  28.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 05/02/19 2:16 PM, Daniel Vetter wrote:
> On Mon, Feb 04, 2019 at 03:33:31PM +0530, Kishon Vijay Abraham I wrote:
>>
>>
>> On 21/01/19 9:15 PM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> Here is a set of patches to allow the phy framework consumers to test and
>>> apply runtime configurations.
>>>
>>> This is needed to support more phy classes that require tuning based on
>>> parameters depending on the current use case of the device, in addition to
>>> the power state management already provided by the current functions.
>>>
>>> A first test bed for that API are the MIPI D-PHY devices. There's a number
>>> of solutions that have been used so far to support these phy, most of the
>>> time being an ad-hoc driver in the consumer.
>>>
>>> That approach has a big shortcoming though, which is that this is quite
>>> difficult to deal with consumers integrated with multiple variants of phy,
>>> of multiple consumers integrated with the same phy.
>>>
>>> The latter case can be found in the Cadence DSI bridge, and the CSI
>>> transceiver and receivers. All of them are integrated with the same phy, or
>>> can be integrated with different phy, depending on the implementation.
>>>
>>> I've looked at all the MIPI DSI drivers I could find, and gathered all the
>>> parameters I could find. The interface should be complete, and most of the
>>> drivers can be converted in the future. The current set converts two of
>>> them: the above mentionned Cadence DSI driver so that the v4l2 drivers can
>>> use them, and the Allwinner MIPI-DSI driver.
>>
>> Can the PHY changes go independently of the consumer drivers? or else I'll need
>> ACKs from the GPU MAINTAINER.
> 
> Maxime is a gpu maintainer, so you're all good :-)

cool.. I've merged all the patches except drm/bridge.

Please see if everything looks okay once it shows up in phy -next (give a day)

Thanks
Kishon
> -Daniel
> 
>>
>> Thanks
>> Kishon
>>
>>>
>>> Let me know what you think,
>>> Maxime
>>>
>>> Changes from v4:
>>>   - Removed regression on the variable calculation
>>>   - Fixed the wakeup unit
>>>   - Collected Sean Acked-by on the last patch
>>>   - Collected Sakari Reviewed-by on the first patch
>>>
>>> Changes from v3
>>>   - Rebased on 5.0-rc1
>>>   - Added the fixes suggested by Sakari
>>>
>>> Changes from v2:
>>>   - Rebased on next
>>>   - Changed the interface to accomodate for the new submodes
>>>   - Changed the timings units from nanoseconds to picoseconds
>>>   - Added minimum and maximum boundaries to the documentation
>>>   - Moved the clock enabling to phy_power_on in the Cadence DPHY driver
>>>   - Exported the phy_configure and phy_validate symbols
>>>   - Rework the phy pll divider computation in the cadence dphy driver
>>>
>>> Changes from v1:
>>>   - Rebased on top of 4.20-rc1
>>>   - Removed the bus mode and timings parameters from the MIPI D-PHY
>>>     parameters, since that shouldn't have any impact on the PHY itself.
>>>   - Reworked the Cadence DSI and D-PHY drivers to take this into account.
>>>   - Remove the mode parameter from phy_configure
>>>   - Added phy_configure and phy_validate stubs
>>>   - Return -EOPNOTSUPP in phy_configure and phy_validate when the operation
>>>     is not implemented
>>>
>>> Maxime Ripard (9):
>>>   phy: dphy: Remove unused header
>>>   phy: dphy: Change units of wakeup and init parameters
>>>   phy: dphy: Clarify lanes parameter documentation
>>>   sun6i: dsi: Convert to generic phy handling
>>>   phy: Move Allwinner A31 D-PHY driver to drivers/phy/
>>>   drm/bridge: cdns: Separate DSI and D-PHY configuration
>>>   dt-bindings: phy: Move the Cadence D-PHY bindings
>>>   phy: Add Cadence D-PHY support
>>>   drm/bridge: cdns: Convert to phy framework
>>>
>>>  Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt |  21 +-
>>>  Documentation/devicetree/bindings/phy/cdns,dphy.txt           |  20 +-
>>>  drivers/gpu/drm/bridge/Kconfig                                |   1 +-
>>>  drivers/gpu/drm/bridge/cdns-dsi.c                             | 538 +------
>>>  drivers/gpu/drm/sun4i/Kconfig                                 |   3 +-
>>>  drivers/gpu/drm/sun4i/Makefile                                |   5 +-
>>>  drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c                       | 292 +----
>>>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c                        |  31 +-
>>>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                        |  17 +-
>>>  drivers/phy/allwinner/Kconfig                                 |  12 +-
>>>  drivers/phy/allwinner/Makefile                                |   1 +-
>>>  drivers/phy/allwinner/phy-sun6i-mipi-dphy.c                   | 318 ++++-
>>>  drivers/phy/cadence/Kconfig                                   |  13 +-
>>>  drivers/phy/cadence/Makefile                                  |   1 +-
>>>  drivers/phy/cadence/cdns-dphy.c                               | 389 +++++-
>>>  drivers/phy/phy-core-mipi-dphy.c                              |   8 +-
>>>  include/linux/phy/phy-mipi-dphy.h                             |  13 +-
>>>  17 files changed, 894 insertions(+), 789 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
>>>  delete mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
>>>  create mode 100644 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
>>>  create mode 100644 drivers/phy/cadence/cdns-dphy.c
>>>
>>> base-commit: bfeffd155283772bbe78c6a05dec7c0128ee500c
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
