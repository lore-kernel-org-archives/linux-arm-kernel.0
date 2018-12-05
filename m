Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8989C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:55:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3E92082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EMmTzFWu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wODCqL8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3E92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p81VuFGowl4yuPpLDVfpcB1XpxfHU++wWRgM+TfaCuY=; b=EMmTzFWuAishqe
	dqSsvYZElBo7Arel0hU5xsy0a3yFKqpSubs6EapDjnUfh3SIzlWhCMbxpRECYk36mmmejpmT4SpU8
	zaptVvvBLauuS7UP2neHhiJySXnko5dDaUBtETG9nzGq9RhtR48iWYHfGL1HhCd9aSGbomncpLoKl
	TO9hgFGAy5D+YszuN5sAygis2ycYaDZSdEEmEyh+Nmw76tqTGmYLSC9WlBoHJiWDdicKP6vbMkSzW
	UApX4aH9Mw9rKzvOy9wcR2y2LZtSQe+eHaUH9y6ZyXjnqAsjdqaSqIPjTFRYPHIs1tsdCLIVvUyHl
	Db0OF+uJ2l37FCH2UKcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUVls-0004Uk-42; Wed, 05 Dec 2018 11:55:16 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUVld-0003K1-E1; Wed, 05 Dec 2018 11:55:03 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB5BsdaI022321;
 Wed, 5 Dec 2018 05:54:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544010879;
 bh=zTcwsen6dKsqpjvuZUQeAi9Vv+N6Ocpxs6kGW7Ru/84=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=wODCqL8E3W0FicJHzdXw4PQWiSpXuXk9BNUkKrO97CeslBfizs3PAHxqM1Xy2OYdz
 37KOFTEgJCC+fAlQjB4+9BmJEv2dskEjjaQpgPUPySfcRyjBistrUtad7xoTO9KZC6
 gbwJU3yh/LyytVK5V4BgnHUzzsVPOX3iucCnJ/yU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB5Bsd9R106778
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Dec 2018 05:54:39 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 05:54:39 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 05:54:39 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5BsYgD000992;
 Wed, 5 Dec 2018 05:54:35 -0600
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
To: Boris Brezillon <boris.brezillon@bootlin.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
Date: Wed, 5 Dec 2018 17:25:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203101937.7b01a0ad@bbrezillon>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_035501_570757_E765158D 
X-CRM114-Status: GOOD (  16.63  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

On 03/12/18 2:49 PM, Boris Brezillon wrote:
> Hi Mark,
> 
> On Mon, 3 Dec 2018 08:39:00 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>>
>> Yogesh Gaur (7):
>>   spi: add support for octal mode I/O data transfer
>>   spi: spi-mem: add support for octal mode I/O data transfer
> 
> Can you take those 2 patches in your tree for 4.21/5.0?
> 

>>   mtd: spi-nor: add opcodes for octal Read/Write commands
>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba

Could you consider merging these two patches alone for v4.21?
These can be applied independent of other patches in the series and
would allow supporting OSPI flash at SPI NOR level with Cadence QSPI driver.

>>   mtd: m25p80: add support of octal mode I/O transfer
>>   spi: nxp-fspi: add octal mode flag bit for octal support
> 
> I'll queue these ones after 4.21-rc1/5.0-rc1 is out (which means
> they'll appear in 4.22/5.1).
> 
>>   arm64: dts: lx2160a: update fspi node

-- 
Regards
Vignesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
