Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0443C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:35:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2ABD208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="coGiDY6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ABD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jrXIlEcQE3Q9FYO9waRRdo1QtKr3668+c4gq+veW3EA=; b=coGiDY6i2eKCpj
	qOrgf3XyAwFLrJe/SR41j6KroqwZ8cth68AakHyWI1xWpvWYICZOqaJIyK0l+E3v3l2vqzpQeIsmV
	4kBoonkoCo2MQQG3eFasghyhLnDam7leBshPYeRu7ulwhZZcbv2IbYj/FjKyjNLXvjMpIBgzx4PkB
	Oxez7U0M0Uz1EZfq55yuA6gx2tVue59O0iMUVLG0nIWA8jpbkAtGLQAX8HmhuTMssTfFP+aiImVLR
	6Sq8D75Y3IR9ajDQpLKtolnU6K4JHYYmfLc4NOJwm7NeQqQTeZLidgUd8p+ResGKdjHnpinZRyemA
	NR86lV/AdJcBM4+Ic3/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsrs-0005DW-Rw; Thu, 06 Dec 2018 12:35:00 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsrg-000572-RB; Thu, 06 Dec 2018 12:34:50 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB6CXt9E038715;
 Thu, 6 Dec 2018 06:33:55 -0600
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB6CXtQc093290
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Dec 2018 06:33:55 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 6
 Dec 2018 06:33:55 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 6 Dec 2018 06:33:55 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB6CXlCP025926;
 Thu, 6 Dec 2018 06:33:48 -0600
Subject: Re: [PATCH v2 00/25] at24: remove
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris
 Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 "David S . Miller" <davem@davemloft.net>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Wolfram Sang
 <wsa@the-dreams.de>
References: <20181113140133.17385-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <e4f83c17-d033-22a4-aedc-08af9558fdf5@ti.com>
Date: Thu, 6 Dec 2018 18:03:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_043448_959345_36B558C3 
X-CRM114-Status: GOOD (  25.36  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/11/18 7:31 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Now that nvmem has gained support for defining cells from board files and
> looking them up from relevant drivers[1], it's time for a respin of the
> previous series[2] that aims at removing struct at24_platform_data from
> the tree.
> 
> Since I took over maintainership of the at24 driver I've been working
> towards removing at24_platform_data in favor for device properties.
> 
> DaVinci is the only platform that's still using it - all other users
> have already been converted.
> 
> One of the obstacles in case of DaVinci is removing the setup() callback
> from the pdata struct, the only user of which are some davinci boards.
> 
> First we add support for nvmem to MTD in a way previously discussed with
> Boris Brezillon and Srinivas Kandagatla.
> 
> Then, since most boards use the EEPROM to store the MAC address, we register
> relevant cells for all users, implement a function that allows to read
> the MAC address from nvmem (and also replaces the previous DT-specific
> variant) and make davinci_emac aware of it.
> 
> Next we switch all davinci users to using at24 device properties instead
> of platform data. While we're at it: we remove all other traces of the
> setup callback and platform data from davinci.
> 
> Finally we remove the at24 platform data structure.
> 
> I kept the review tags in patches that haven't changed from the last
> submission.
> 
> As far as merging of this series goes: I'd like to avoid dragging it over
> four releases. The series is logically split into five groups:
> 
> patches 1-2: nvmem and mtd changes
> patches 3-9: davinci arch-specific changes

Applied patches 3-9 to davinci tree for v4.21

> patches 10-13: networking changes
> patches 14-24: davinci specific again
> patch 25: final at24 change
> 
> With that I believe we can do the following: Greg KH could pick up the
> first two patches into his char-misc tree. Sekhar would take the second
> group and the third would go through the networking tree since the first
> three sets are not linked in any way. This would be merged for 4.21. Then
> for the next release Sekhar would pick up 14-24, provide an immutable
> branch for me and I'd merge the final patch for at24 and send it upstream
> through Wolfram's i2c tree (maybe we could even delay the i2c PR in the
> merge window to avoid the immutable branch altogether).
> 
> [1] https://lkml.org/lkml/2018/9/21/293
> [2] https://lkml.org/lkml/2018/8/8/528

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
