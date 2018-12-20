Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C5DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:03:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAC021741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uq8Ev+8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAC021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mvdMd0/ZpYelMcknIO7pyAC8RjE/4Ndk1oR+ha4kCuo=; b=Uq8Ev+8dUbbmR1
	Eut9ei+bwVVqRiAF5mhDuaCcbcs9ojfTxX90dwIqgV7bewlvLXU1FjI9fq1wnRfL50MPEknj25+iK
	DiR+Jzslg6OQ7Hy3NhgDuwXgpYWSDSwmbGGWufETTzD+6TnnU3swr8B95ywfWO9ZT8P+GYVcC06p0
	41HWSXEhuk4tv4IURROI9Q3so/wC/xqJ0YCQzQuGyz2nebe/M2kurnIW9otA/M/18ebpXWrFosNzz
	2O+Lp+9SM6xh52epJc3uk4gqZZgiZ37c7YKhEfhrqGQ/UGvlTGNzEeuGazk5I9/z3b1yG76PpP0gp
	jMKQ7Si3d8++iTT0VuHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0n9-00036O-44; Thu, 20 Dec 2018 16:03:19 +0000
Received: from skedge03.snt-world.com ([91.208.41.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0n4-00032m-Py; Thu, 20 Dec 2018 16:03:17 +0000
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge03.snt-world.com (Postfix) with ESMTPS id 1562767B8D3;
 Thu, 20 Dec 2018 17:03:01 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 20 Dec
 2018 17:03:00 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Thu, 20 Dec 2018 17:03:00 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL] FSL QSPI device tree cleanup for 4.21
Thread-Topic: [GIT PULL] FSL QSPI device tree cleanup for 4.21
Thread-Index: AQHUlRxYOYzlGNgdW0mdz5FUtpvtHaWHvJKAgAADZwA=
Date: Thu, 20 Dec 2018 16:03:00 +0000
Message-ID: <a73f86ff-15ce-9512-bbf0-be852cf39a35@kontron.de>
References: <20181216084854.GJ13243@dragon>
 <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
In-Reply-To: <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <81C3C2577D791D4FA423DF89163C052B@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 1562767B8D3.A133E
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: arm@kernel.org, arnd@arndb.de, fabio.estevam@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, shawnguo@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_080315_573817_5706AE45 
X-CRM114-Status: GOOD (  11.53  )
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
Cc: linux-spi <linux-spi@vger.kernel.org>, arm-soc <arm@kernel.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>, Sascha
 Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On 20.12.18 16:50, Arnd Bergmann wrote:
> On Sun, Dec 16, 2018 at 9:50 AM Shawn Guo <shawnguo@kernel.org> wrote:
>>
>> Hi,
>>
>> As the series cleans up both i.MX/Freescale arm32 and arm64 device
>> trees, the pull request is based on a merge of tag imx-dt-4.21 and
>> imx-dt64-4.21 that have already been pulled into arm-soc next/dt branch.
>> This comes a bit late, and we appreciate it if you can pull it for 4.21,
>> as it paves the way for new QSPI driver under SPI framework to land in
>> the next release cycle.  Thanks.
> 
> Pulled into next/dt. For my understanding, what is going to happen
> with the fsl-quadspi mtd driver? Will it remain as part of the kernel
> to support old DTB files, or will that transitions mean those stop
> working with new kernels and have to be updated the same way?

Thanks for pulling these late changes. The old SPI NOR driver 
(fsl-quadspi.c) will be replaced by the new SPI driver. Old dtb files 
will work with the new driver if they already have the reg properties 
set up correctly (which should be the case, but who knows what setups 
exist out-of-tree).
There will be a performance penalty though if you do not set 
spi-[tx/rx]-bus-width to 4.

For reference here is the latest set of patches: 
https://patchwork.ozlabs.org/cover/1007641/

Thanks,
Frieder
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
