Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC7EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:46:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA2220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OiPGxHDe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gHfzXsHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA2220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TEjCT1XrxeTYjByPYxGdNcYxiMVtyQTqeIzYD4TiZEA=; b=OiPGxHDe7RZA61
	rWz7HTdTLiVFi0xhC9+Vi2ejOIzuAnT9DhOqiLu9fVotqV7mTOjIzegu9Yxj02M5fgyZjJDYX8JVL
	Onqr7LMZp1ZUCtpNWVYdwADzOVhNzcCD8WnCXniV0TLJssrQ9ftXIl3AaPxYaIM5C8J6zMFD9ONM7
	O4UOfISA30BjqTvdx6JAXqJ/Fxawz70pEe1M07PeXqpBwDJiRXIYJxrnZL32int0GRqVB+PrTBgnb
	Lj76FxuAQVAdf6xSTTsreTgLTRbuwy0RBAOyaPWdM+qcIhmSxrm2UXSUoDx12KLB+etO6Y1Wwjdwk
	akE6yMKiTxyb2C2LDgWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2vU-0007xv-Lf; Tue, 05 Feb 2019 15:46:20 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2tI-0004g5-V2; Tue, 05 Feb 2019 15:44:26 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="24251488"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Feb 2019 08:44:04 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 5 Feb 2019 08:44:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMrxTQlIqp7ueXe11uHGvCzqFFWlvrWPOrzav7XPXDw=;
 b=gHfzXsHU3FCoqR58tI/MP3I+bp2iCJHf4+VCoZ7ghGNn9xNUuhT1NTYmXOrJLu/CizqOlHU9+rrmWW7IZpVrm/mmKTeILLDWeyomLHaR6P0dJSEcCzUQ5H9eh9Yat2ZGFRJKCgtg3qXM63T2zSZOH962ZGGQIkm7X90b3zKhyys=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1764.namprd11.prod.outlook.com (10.175.98.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 15:44:01 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:44:01 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v5 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH v5 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver
 for Microchip SAM9X60
Thread-Index: AQHUvWmdufq3cgae/E2DopYTP50ObQ==
Date: Tue, 5 Feb 2019 15:44:01 +0000
Message-ID: <20190205154257.29529-13-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1764;
 6:g2hi6SyOuolR4KNaQOB7fzJzDsN3+WmkIbBWyDrB5BwSlGq6WtZcuqfcOIiRekrbZuDZJ0CWedpU+vOTR0KnCIjbrno2qqKhdT841NcZLV2RgL1UoPWfRx0GBpvXbDKk1teTmiep/Amlu5ocCDOk1cKrrkuD36Zeq14CxgHoAPXB/V/awYemu/Gzl4y0lB9CCYfPLMw3gR0EVUje6XF3inSgKYdL0oeTysrziTYqADmPfIawByyLZ0yYW2FsyUWelRSomKddig6vNAxWbfz9MYBSJyOw9UaV+hPu3u6WzQvl+kPBTa7z6J2dtC1Ha1AReJhYyF0cRy26ODCM5h152e8U/gaO5kLn5rE5HVdhjix09+L1m+PFPwMbGGIoU9hLhtnS2QO4EUZaA0+WKQHrWHiIHDalfIFdkzIEk/e4DcBvYIWB6DPgBPtoOHAKXp5nMHVOamDz1qhW0kbK9cln4w==;
 5:zjHkpJqpf7XB/luw3dTYaaz61y+3KT2J3JIS05GUjC0JnblY/EiYgenvTjlYuzfAFXeX87M9cOjDnWDSsYwhupxtQyjkeIxAIgihyn7JzmAktN2SHV2az5w9eaPZwZVUqlO7ah1zJ8uoqPcWzDVZ2fqkFjyPNLY5/iZIub8tIS7bISodtNLBSv54ANi+XoUcyJue2i6DQDuXv7rpbKK0fg==;
 7:TZiR0iBbVvybW7jJepjKAsrhvLRe+m7QEsXgNcKazn5UQcxBl1y8SfRrF+OCx3ERvJ4JEdnb0rS5DNxKftvh2a0pK4N1KbYOpbo6b3gn0tWE+9k5n4rLVOuxCHt2AtAen7s3FGjCbveYyAOURVZa5w==
x-ms-office365-filtering-correlation-id: a055f97d-ca85-4781-7545-08d68b80bffe
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1764; 
x-ms-traffictypediagnostic: BN6PR11MB1764:
x-microsoft-antispam-prvs: <BN6PR11MB176485BC105CA11597567B5DF06E0@BN6PR11MB1764.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(376002)(346002)(39850400004)(366004)(396003)(136003)(199004)(189003)(25786009)(2906002)(4326008)(2501003)(50226002)(8936002)(52116002)(53936002)(36756003)(76176011)(107886003)(7416002)(186003)(26005)(68736007)(97736004)(386003)(6506007)(316002)(54906003)(71200400001)(6116002)(2616005)(105586002)(66066001)(476003)(110136005)(6486002)(486006)(86362001)(11346002)(446003)(3846002)(6512007)(71190400001)(72206003)(478600001)(305945005)(14444005)(1076003)(14454004)(256004)(6436002)(102836004)(99286004)(8676002)(81166006)(81156014)(106356001)(7736002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1764;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UO0FL1J1DHFLJZ8mULFN2HQSeL8MUOTpwBI+emsLheTFd7v1fMyPRKzILTG7BkHDxE0afB5HEwq4aMSh6W6rQ98qkN4SRBkjx7jreA336IeRvDefiQfVgzo6htZ4AXteachDKnfqr98Gi3c16klnlgN4n/B9aQq0moLRPDKasBBNOfP+qPfbi4NB1QfJlZUNKmlhh4QpOiy8d7URMSjuWzsXwJ9ohWDQHaO80ktsBNtya5iX+Xc2ewpO0FRqMl137tm+N3sTk1xoRjxxPm6EwvnsNQeB0vsBiISbO81TDUKIMKvAGT+LWUxsgEdHG9zxsCaEjUie7Med4saVBKQrm95vb/iPQ7P6sox2fGpDkt4sYoC6I8eZiXuzViyPkli+lsdipLIxaw2CwL4wNZgJxq1vcaID+BPgwuebwFZ1ZHs=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a055f97d-ca85-4781-7545-08d68b80bffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:58.7001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1764
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_074405_407754_C9994DF7 
X-CRM114-Status: UNSURE (   8.72  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Tudor.Ambarus@microchip.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v5: no change
v4: collect R-b
v3: "pclk" was made mandatory in previous patch. Reword clock
descriptions.
v2:
- make "pclk" mandatory even for sama5d2. Unnamed clk will be
supported in the driver.
- drop unneeded example

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
index 50bd257e6826..7c40ea694352 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -1,15 +1,19 @@
 * Atmel Quad Serial Peripheral Interface (QSPI)
 
 Required properties:
-- compatible:     Should be "atmel,sama5d2-qspi".
+- compatible:     Should be one of the following:
+		  - "atmel,sama5d2-qspi"
+		  - "microchip,sam9x60-qspi"
 - reg:            Should contain the locations and lengths of the base registers
                   and the mapped memory.
 - reg-names:      Should contain the resource reg names:
                   - qspi_base: configuration register address space
                   - qspi_mmap: memory mapped address space
 - interrupts:     Should contain the interrupt for the device.
-- clocks:         The phandle of the clock needed by the QSPI controller.
-- clock-names:    Should contain "pclk" for the peripheral clock.
+- clocks:         Should reference the peripheral clock and the QSPI system
+                  clock if available.
+- clock-names:    Should contain "pclk" for the peripheral clock and "qspick"
+                  for the system clock when available.
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
