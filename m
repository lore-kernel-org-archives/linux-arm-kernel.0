Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C1EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:47:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEC12147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iX/+v+OG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tnxUko9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEC12147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PqsPHXOkW1lapR2JDTbsRhmklACBbBM9+PYIWUpTofw=; b=iX/+v+OGrS+Uq4yHgZeJWyVSRM
	HZxDFhcIafaJ7WsQjBcRfHsjKjipa9v37gsbpxtTMSIkCctw/8E1J3n73jDMIbOnBw9iUw5Zkxqdg
	7TcJhqcah3ky9sapV/yZOJeqPGVyLg5p/dNcsL0gNxHI78G7D6cbHO3yN6kpql5hHYuX07g+d0riS
	rnO/7gBNTh4fZj6JzQ/6E/k67Dt0wDjoglsZnHgqTZlYGwBJ1vwrixpLNa3pEbHGb+PxBV9wEkWjJ
	lW9jX6CcVnFjNs24Umk1j4XkjKZmulFKR/aP2Rr6t0likP1s775R+GBICJhArqRxZZcpYUyvwXrjy
	XbBMBgkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZ9E-0003s0-FN; Fri, 15 Feb 2019 08:47:04 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZ9C-0003rg-5P
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:47:03 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F8kROa005514;
 Fri, 15 Feb 2019 02:46:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550220387;
 bh=RYXZoiDclbp/l3pYBUkoRfMEXwkZUkP7u+1vUxF7Yy8=;
 h=To:CC:From:Subject:Date;
 b=tnxUko9x4Sc80VCHeBgT3vhqK6CUf1e+RyjzgbbsqCTHI2BEQnPh6PiUhszuaBNaJ
 5uEarZmvSj+mGAs63/bptSgf0wUlWqi4wdqtumpMf3AQP2WDQGT1SumxxvMA79ZJIN
 SeYZw0f01iduFR9yQZ4eMGa7I/nhowP/esZa13LI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F8kRgN111333
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 02:46:27 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 02:46:26 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 02:46:26 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F8kMHh018896;
 Fri, 15 Feb 2019 02:46:24 -0600
To: <arm@kernel.org>
From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] AM654x SoC changes for v5.1 (part 2)
Message-ID: <dbd59d87-c5dd-b12c-984f-909987a21a7d@ti.com>
Date: Fri, 15 Feb 2019 10:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_004702_286409_6332AC43 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: Nishanth Menon <nm@ti.com>, Vignesh R <vigneshr@ti.com>,
 "tony@atomide.com" <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Roger Quadros <rogerq@ti.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello arm-soc maintainers,

Please pull these DT changes for TI AM65x Soc for v5.1 merge window. 
This is a part 2 of the pull, which has been applied directly on top of 
part 1.

Thanks,
Tero

---

The following changes since commit fd58466a3876ddaed2773556fef616159e5c3844:

   arm64: dts: ti: k3-am654-base-board: Add eMMC Support (2019-02-01 
10:18:33 +0200)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux 
tags/am654-for-v5.1-part2

for you to fetch changes up to aa6eaaa2ffada4a2fc6309e8e1a130e2284aea79:

   arm64: dts: ti: k3-am65-mcu: Add ADC nodes (2019-02-15 10:12:59 +0200)

----------------------------------------------------------------
AM654x SoC updates for v5.1 (part 2)

Contains a few DT updates on top of part 1 of the pull:

- MSMC RAM support (on-chip SRAM)
- Main system control module support
- USB support
- ADC support

There is an extra dt-binding update included, which has been acked
by Rob.

----------------------------------------------------------------
Jyri Sarha (1):
       arm64: dts: ti: am654: Add Main System Control Module node

Roger Quadros (3):
       arm64: dts: ti: k3-am65: Add MSMC RAM node
       arm64: dts: ti: k3-am6: add USB support
       arm64: dts: ti: k3-am654-base-board: enable USB1

Vignesh R (2):
       dt-bindings: input: ti-tsc-adc: Add new compatible for AM654 SoCs
       arm64: dts: ti: k3-am65-mcu: Add ADC nodes

  .../bindings/input/touchscreen/ti-tsc-adc.txt      |   8 ++
  arch/arm64/boot/dts/ti/k3-am65-main.dtsi           | 104 
+++++++++++++++++++++
  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  30 ++++++
  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |  40 ++++++++
  4 files changed, 182 insertions(+)
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
