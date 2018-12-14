Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C20C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:30:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364E920645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f0TDAFqW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yg6RXeJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364E920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EA3pEdjfKZouhULn+pWEfHk136xSD7dPbXEs8334bj4=; b=f0TDAFqWawIOSUN2aRnF4B61A4
	Kwf/KuzQzbRel0sZ6TNOougdV0xEpw83+8UwF4inh+UbgvIEh013hDHE1DLYwznhbUJOuRGTWqb4x
	0O9o4EEzszrOsZMw7YMkcPe50gabkFQnq0u3cjoxzkzq02rFAcURrOotEPu97e5LjA/Wbk+/PPC5Y
	J4W6eWfsQ/+8IRJkftdruhIqDrCtjzNsCJQkDdj4UNwh+cbsW1XF4q5Bfz7RgJdAgYvnqQS2BUlcA
	5DbNepMmn3bpfoJHRA5+pu2BO1Bhrhh78KG3V6MURcEvKd4rkdt/dQ3W9vOTbJgNPVKv9IrmJcoXE
	ZJRIRvYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXjns-00024R-Qu; Fri, 14 Dec 2018 09:30:40 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXjnp-00023G-4p
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 09:30:38 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBE9UKtQ083019;
 Fri, 14 Dec 2018 03:30:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544779820;
 bh=XlE5TEN4/aS9kbiHGtibaM+5fNuYSrymFi4sroFDVvc=;
 h=To:CC:From:Subject:Date;
 b=Yg6RXeJjc7pqB/jsn+61Xa3FPOKf+NlYzH+hOret378KcLwkQ4NoAv3AgPnB/QU3A
 Cfp8ncSCKlHSL+T1sia0quQX/+co5Hc18BxbCMsOEcYg9H2mky6Kz+Yh2eZePvIBN4
 rxiuLEXEZVjjzyEhyudlGtLV++o0qZc0InB/fMKg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBE9UKgF007502
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Dec 2018 03:30:20 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 14
 Dec 2018 03:30:20 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 14 Dec 2018 03:30:20 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBE9UHLW019715;
 Fri, 14 Dec 2018 03:30:18 -0600
To: <arm@kernel.org>
From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] arm64: dts: TI AM65x changes for v4.21
Message-ID: <e4ac6f8c-66f4-08bb-65f8-5c1123264837@ti.com>
Date: Fri, 14 Dec 2018 11:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_013037_328919_92B9A0A4 
X-CRM114-Status: GOOD (  17.94  )
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
Cc: Nishanth Menon <nm@ti.com>, "tony@atomide.com" <tony@atomide.com>,
 Vignesh R <vigneshr@ti.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello arm-soc maintainers,

Please pull these DT changes for Texas Instruments AM65x SoC for v4.21 
merge window. These are based on top of my earlier pull-request against 
4.20-rc1, just to avoid any conflicts.

Thanks,
Tero

---

The following changes since commit 8588eac3ff66e77fb681591714fd76da3a4da80d:

   arm64: dts: ti: k3-am654: Fix wakeup_uart reg address (2018-11-09 
18:26:52 +0200)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux 
tags/am654-for-v4.21

for you to fetch changes up to 5da94b50475acaa728560e8c1d3f7291e1062eb3:

   arm64: dts: ti: k3-am654: Enable main domain McSPI0 (2018-12-14 
09:57:11 +0200)

----------------------------------------------------------------
AM65x DT changes for 4.21. Includes:

- Pinctrl support
- I2C support
- ECAP PWM support
- Power domain handling for UARTs
- McSPI support

----------------------------------------------------------------
Tero Kristo (1):
       arm64: dts: ti: k3-am65: Add pinctrl regions

Vignesh R (8):
       dt-bindings: pinctrl: k3: Introduce pinmux definitions
       arm64: dts: ti: am654-base-board: Add pinmux for main uart0
       arm64: dts: ti: k3-am654-base-board: Add I2C nodes
       arm64: dts: ti: k3-am65-main: Add ECAP PWM node
       arm64: dts: ti: k3-am654-base-board: Enable ECAP PWM
       arm64: dts: ti: k3-am654: Populate power-domain property for UART 
nodes
       arm64: dts: ti: k3-am654: Add McSPI DT nodes
       arm64: dts: ti: k3-am654: Enable main domain McSPI0

  MAINTAINERS                                    |   1 +
  arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 126 
++++++++++++++++++++++++-
  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        |  42 +++++++++
  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi     |  20 ++++
  arch/arm64/boot/dts/ti/k3-am65.dtsi            |   7 ++
  arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 124 
++++++++++++++++++++++++
  include/dt-bindings/pinctrl/k3.h               |  35 +++++++
  7 files changed, 353 insertions(+), 2 deletions(-)
  create mode 100644 include/dt-bindings/pinctrl/k3.h
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
