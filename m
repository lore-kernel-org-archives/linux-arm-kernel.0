Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3827AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:26:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0772089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jkYt5RrZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mmS7eIIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0772089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=al2Jf7zGwIWJdQWq3CbW10vs4yoPfW2WjDF+JQqi9HA=; b=jkYt5RrZZJ1XIc
	8jXTLnRiLhy4ZYi020HgEatR4qLG4Af10uuK6BFTxcY12POYTTELEVfmZCS3Gd5DiZsGwi13L8DMo
	b3RdpmmYKKL8D8dybVWmB+dg2x4SYckBhfvEIKuAt3S+zij0yiBhvAQs98davx6CWvTgpdpKQfSdS
	jL/JdOSzycbVJ4yOYdou59F8qLBnC7QlDRtZbi3Ns+RcZAAbfTQaJ/AtI8+MCbbVSDtz4CpskyVRM
	wxSrUVLvLjHeTI57hMQ7BrbNGe6s4IAbEmnWOxyhnZOf7vK5XVaYSFphihk6U5tU1qtNKMs3sSvOZ
	PY0EK3J9wuNvQ1h7NzmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnes-0006np-MM; Tue, 08 Jan 2019 09:26:50 +0000
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggndB-0003pQ-R0; Tue, 08 Jan 2019 09:25:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khjTNWcq60NHCduUi0cSrAzHk9+9M8FKcjYCTWpCYGs=;
 b=mmS7eIIuc2+D4oUo7xUWn+llsu1+WNuaUAAR1LysRVShuQhi9Z0kNp3/Befku5y09ajl4/sLPMbQTkP1CNoDOG/U1ka18paDzo0gVMI0tQEkPmTXMMfEs6F9gHr3LPbxvNVQTSyd8f3khnQSN6db5Xra1D6O+vtNwntxTsfqHsw=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4494.eurprd04.prod.outlook.com (20.177.54.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 09:25:01 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:25:01 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: [PATCH v6 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Topic: [PATCH v6 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Index: AQHUpzQH1NNStjmgu02VmZnQnbAwNQ==
Date: Tue, 8 Jan 2019 09:25:01 +0000
Message-ID: <1546939346-20181-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4494;
 6:RwOafhR+y/qW0I04cx2XOjTF6JhcclARwi4TJuKOkO3cZ677pzf9Pqo3gj8UaJbGH0ZSZLJxly2Vay4FPQNGU5QWy4Qp23tOPkyke3FtFcwBHG7SQRCpm9ffCHuPPbUj4ZgP3/+PwEgzYzmCa2gcWA8i6EG6EyC6UaMwD1VLe65K9LQIcB9iIyFzgGdVHbv8N0MQeoeSE6dP06Xivtb3X6yq/erd4NOOyXPXO3YO0fhbnjqtb+xnVbzptIq37o/70z8y6O+YvbzKlHRcTFgGV6iaS8R1Nk5wa9FeXRKMhsiSqRk+wKz/7BIjfD6dYadRUEuJAYbrVi6zagzemInS4xJwUn0UmCs/p1tsHQBffaGHtulp8z0piG5ObM2qMT7OPBJX6mlUveyuJiKN1FLPqFlewyBQ5CDT/mIZYruMlO8ABMpGn8mBJWZhf6ZvtJhwJmPjrSsEMiZeFURSDFDmYQ==;
 5:X4AiOvL0bnPxP+o0uNMTbDznt2KB4TRV/S29HWK06s1JZKlw6mGot2GcOnH9YOsMdTs/asurc5ypHq/SFfNUDqg0lEHHrDYPhBEPHhHlDnnbg+bhy4ILCvt5S/jAv0VgzPZ3fPJ37mVn4VCY2FXuaUTXTvdvBSqPdWu5LmBC6cxEfXq1OcnJ91b/cqcudz5frUWTdU6+DD5gWUSrj5OZng==;
 7:pcA/amLTcsYUPIKQPqm9JQ9EcuN0w/dZOoaL+zHxC3kLgiCDC+hnxgg3Y31Md+zzmtXvPbBO1j94F1gzXV2TjNFLp0cmyt5/VG79O/pCYm4Z1h/S335bqe6rpEbw5KOnobxqjsVDzIACztGF9zYxtg==
x-ms-office365-filtering-correlation-id: c4e7dc22-e9a8-410a-4192-08d6754b2a0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4494; 
x-ms-traffictypediagnostic: VI1PR04MB4494:
x-microsoft-antispam-prvs: <VI1PR04MB4494B4F4462959EC601A6EC2998A0@VI1PR04MB4494.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4494; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4494; 
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(71200400001)(71190400001)(6486002)(78486014)(2501003)(76176011)(105586002)(106356001)(7416002)(6512007)(7736002)(6436002)(52116002)(486006)(5660300001)(53936002)(305945005)(66066001)(97736004)(8676002)(8936002)(81166006)(81156014)(54906003)(50226002)(14454004)(110136005)(36756003)(99286004)(68736007)(316002)(3846002)(6116002)(2906002)(186003)(86362001)(386003)(256004)(6506007)(39060400002)(2201001)(11346002)(446003)(26005)(476003)(55236004)(102836004)(25786009)(4326008)(2616005)(478600001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4494;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YSoeZwUjYBb+WWhRS7Ni1ZNFhBfI09nSv7i40lS5vxvLZJ9e636SrBBavq6xhCsRHVNQGAeu/k1ArvEPunz7XhDcgOB4oVJsSzriczuocX5Vgt0jsgFseDt2KXv3IrtQd+ZjUkBFnM9RJnwLGJktJ6CvP0GhQVQj60d+NxqzgD4lDC7uVZNxMn4kHHtoK6SnwKX/n6x0h9FHYzukvVTUhhSCV56SEzj2WAiddIIAqqrIu3vIRTzcGlkhVmtmBksa0nJxVYDSLMBiwPXk1AIkogDgKjcZkosgxs4hPpgpFk4hKQC4+L117xZCEN4txb8d
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e7dc22-e9a8-410a-4192-08d6754b2a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:24:55.1876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4494
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_012506_331655_2125CFE0 
X-CRM114-Status: GOOD (  10.41  )
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
 "robh@kernel.org" <robh@kernel.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ef443cfbab6..fe7f35824a79 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -362,6 +362,7 @@ CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_QUP=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
+CONFIG_SPI_NXP_FLEXSPI=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
