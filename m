Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E700C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A50720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AYHULFeV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bp3WrXgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A50720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q9BlZONbLX6pH6iBTYdhwKa3H/zhu0KG5ls20Qki2Hg=; b=AYHULFeVKIxRHq
	kSovaLoN+g/Ba3TuCACOcfmMX9bikJhM56dQnEWPGzHbIan+sWnm6mG4vOtmsFaAPpBn3D7udFbr+
	KgQf1l7gHbo0cRpa9eYEHoJhQsAzC9DI+9hhbkoE97TF4uE5d+UfI8PAKOn4d/fROIUHobWF/cpmK
	6b2W/+tXSD2oYDQd2R/z7yMz2PMFVyMk2mqRhaSDvbpaahbitfABj7XT8n7n2Sal4qkHpsy/YKPLW
	Kth/mXvr2xc5grkCl17s2WIu7Nj1MC9gROBGbgKTWDieHTTTlwLSvCIeL8b9GF+eqn0tXcX0sUhyR
	MxFC/25wCGF7K0/phFgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOm5-00020V-7i; Mon, 10 Dec 2018 16:51:17 +0000
Received: from mail-ve1eur02on0625.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::625]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOlQ-0001Dg-Ei
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eekk/hODSmEyVFTefw+PC/EebCzi+MUBuWJqXlCBTkM=;
 b=Bp3WrXgbSaiJccX1BFdOSAlVGEFG4MQhJ6LZpK5+0V/CpyXg4KwSRQc5EODIkgd9UHF1HSdj0NG+U6DgPDeMaMvuzKz2WMKCXcUObosaTHBNKNa6jP6uaCcu1OX7g6g4mwssFaVtgXh9gDaLO7oOaHuK0UULF24g0+k4rwT40C8=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3904.eurprd04.prod.outlook.com (52.134.17.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 16:50:20 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%11]) with mapi id 15.20.1404.026; Mon, 10 Dec
 2018 16:50:20 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: [PATCH 5/5] bus: fsl-mc: automatically add a device_link on
 fsl_mc_[portal,object]_allocate
Thread-Topic: [PATCH 5/5] bus: fsl-mc: automatically add a device_link on
 fsl_mc_[portal,object]_allocate
Thread-Index: AQHUkKhvHkf6CgsRQ0WduTjo1m5H8A==
Date: Mon, 10 Dec 2018 16:50:19 +0000
Message-ID: <1544460591-14888-6-git-send-email-ioana.ciornei@nxp.com>
References: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0145.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::23) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3904;
 6:ybVO453he2/cOv+/69YpAvHjoqrZWhjXIpwA8iQKkI/j8+KBoms1fnMuEm53MCE5VY/m3JFpe3MxoAAs5AqhXdwSt46vGsjsG5XXnQsa0HgDHxr6A7VZqV9nKcI6lgeNexkb6ieF+R3kzQXmLA+cBS6odceW3I8ubNcaCufuYR6eR0JD/j/gFivFpZALgq7/nOH2RwFQlXVHjVMPryiAikwLMDgQXwNACDOedJqnDql7omdzg5o7LilLC1ZHE7jAntyW4RIBzT1FefL3vh5b83LTGrbbsQZgkaKgD9N4DmFdHQTpD5QhbudoYaE9PvG2FODY6K14Ni3XaEONi0kIJWrR4qMzFsnIMxxa5lrsQyx7qFeVPWIsboVzyyAsoo6bI31wg75Ij8srJwgEjgpGlWjbl/E11SO7loAEX9Op2swlBse5vkoIlxQSASDR7MJuJxVBNPGRoeQZ4+aobf1H0w==;
 5:jMG4fStHCyN8I8e5m20J/5QHa4rQn0L0VaZN/BRkbepInrwMYYRYR7iyDrQ7YbPo2HLuT9QIDyHC9vE0X+xxvBGLvbDZwjxWKc82sAbXVBhhSfIBQ54T+z+NfzKhggcNzYjFTtQJQazlbqE4Qf/X2TAEi777bnZgSaXd+O0GL8o=;
 7:oIQIVmbwez5dMQ7zCPI3X5pTr2G3cvjjy8HFRzDqhUI3IKVKEDZbr1cEvKtFsdhBUgTRZIj14eoiABjHu2N/nScwkE8XqMqWS2qA+U5J8qDgPAtTV9WFTpaF8OPiQiJE1pkYVdPUmatr2fW8S4X5uA==
x-ms-office365-filtering-correlation-id: b3a6d845-1591-4b4f-dc1e-08d65ebf9195
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3904; 
x-ms-traffictypediagnostic: VI1PR0402MB3904:
x-microsoft-antispam-prvs: <VI1PR0402MB3904FAFC4C685D205C9DFE47E0A50@VI1PR0402MB3904.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB3904; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3904; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(6486002)(4326008)(14444005)(44832011)(386003)(6506007)(486006)(316002)(68736007)(256004)(446003)(11346002)(52116002)(6436002)(2616005)(186003)(8676002)(8936002)(2906002)(26005)(81156014)(81166006)(97736004)(5660300001)(3846002)(478600001)(36756003)(14454004)(6116002)(2501003)(2201001)(25786009)(71190400001)(71200400001)(106356001)(105586002)(53936002)(305945005)(6512007)(76176011)(476003)(102836004)(54906003)(99286004)(7736002)(86362001)(110136005)(66066001)(142933001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3904;
 H:VI1PR0402MB2800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /wj2eVPb4Rv5/sd/8SXCfzVhp9Nn7IPB76ivDQmAJuEq3bP3njQ7tUOxC9QeIaloiVkHF0w9jAQfEmgWJEbCQzAamsBGEp6GlCQlkr4aE01Wbjpe+GvQnnY5jaQNS7IwY0GWOv1C1bsvvAsvweKPVWm6RvY6QE94vVtFu5iH3aNzCYtVqP9AsAZVFeOq7aRuaT+LwZSWuRWwZmswPiTnY4lUyvr12muWnfY/0UtfLZ/1KHGJshp2s01ZlMkiSppe4aZ9atj6gO2sfqxhwYw+j+menepRVOsR/5UB/nzglmeLPf0zrJLR/6frq7I5um8O
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a6d845-1591-4b4f-dc1e-08d65ebf9195
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:50:19.7118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3904
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_085036_709159_6F2B126E 
X-CRM114-Status: GOOD (  15.03  )
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
Cc: Roy Pledge <roy.pledge@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Horia Geanta <horia.geanta@nxp.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allocatable devices can be acquired by drivers on the fsl-mc bus using
the fsl_mc_portal_allocate or fsl_mc_object_allocate functions. Add a
device link between the consumer device and the supplier device so that
proper resource management is achieved.
Also, adding a link between these devices ensures that a proper unbind
order is respected (ie before the supplier device is unbound from its
respective driver all consumer devices will be notified and unbound
first).

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 11 +++++++++++
 drivers/bus/fsl-mc/mc-io.c            | 13 +++++++++++++
 include/linux/fsl/mc.h                |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index e906ecfe..8ad7724 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -295,6 +295,14 @@ int __must_check fsl_mc_object_allocate(struct fsl_mc_device *mc_dev,
 	if (!mc_adev)
 		goto error;
 
+	mc_adev->consumer_link = device_link_add(&mc_dev->dev,
+						 &mc_adev->dev,
+						 DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!mc_adev->consumer_link) {
+		error = -EINVAL;
+		goto error;
+	}
+
 	*new_mc_adev = mc_adev;
 	return 0;
 error:
@@ -321,6 +329,9 @@ void fsl_mc_object_free(struct fsl_mc_device *mc_adev)
 		return;
 
 	fsl_mc_resource_free(resource);
+
+	device_link_del(mc_adev->consumer_link);
+	mc_adev->consumer_link = NULL;
 }
 EXPORT_SYMBOL_GPL(fsl_mc_object_free);
 
diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 7226cfc..3ae574a 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -209,9 +209,19 @@ int __must_check fsl_mc_portal_allocate(struct fsl_mc_device *mc_dev,
 	if (error < 0)
 		goto error_cleanup_resource;
 
+	dpmcp_dev->consumer_link = device_link_add(&mc_dev->dev,
+						   &dpmcp_dev->dev,
+						   DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!dpmcp_dev->consumer_link) {
+		error = -EINVAL;
+		goto error_cleanup_mc_io;
+	}
+
 	*new_mc_io = mc_io;
 	return 0;
 
+error_cleanup_mc_io:
+	fsl_destroy_mc_io(mc_io);
 error_cleanup_resource:
 	fsl_mc_resource_free(resource);
 	return error;
@@ -244,6 +254,9 @@ void fsl_mc_portal_free(struct fsl_mc_io *mc_io)
 
 	fsl_destroy_mc_io(mc_io);
 	fsl_mc_resource_free(resource);
+
+	device_link_del(dpmcp_dev->consumer_link);
+	dpmcp_dev->consumer_link = NULL;
 }
 EXPORT_SYMBOL_GPL(fsl_mc_portal_free);
 
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 9d3f668..0c4f9805 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -193,6 +193,7 @@ struct fsl_mc_device {
 	struct resource *regions;
 	struct fsl_mc_device_irq **irqs;
 	struct fsl_mc_resource *resource;
+	struct device_link *consumer_link;
 };
 
 #define to_fsl_mc_device(_dev) \
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
