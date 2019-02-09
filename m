Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1216C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:41:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F59218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UZzxz1MR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PBvBW16C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F59218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XKsKCyMuhZ2hPL1Jzi3GbxEP7lTW8OMpdYZS8Vo/Vuk=; b=UZzxz1MR5+ky3y
	kg4TVW0q3hqRB0U2sSCYM+g9+IK5Fu6ajnpmXqUYbWMavAyWDMSuG97q8Amyc7A9arict5HvA2Vvr
	9JGeAiApGwWQH9iR36GGaQ2iyskQm6pX0v6BTlwl/SBHnKTXowKxxPE930Ueuq3GAItsn0m8NyTrY
	33Zdu+xxn9f20BuwjdYD6BHn9WQYLX2HEltPKjI6LnpcajxHY3c36lXDhUQCKo3eWelURxUQftm0c
	6990IKvs2HPPcOw+DLBim8vXRC0wr4SLO9tYSzwlTHpW0soMl9zO7+0q3y23Hh5bG8E9lePRWKYg0
	s9rc3KLj8Zf/eJV2GA2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsQ4b-00023y-B6; Sat, 09 Feb 2019 10:41:25 +0000
Received: from mail-oln040092254064.outbound.protection.outlook.com
 ([40.92.254.64] helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsQ4U-00023P-Mf
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 10:41:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiEOs/xkP9wLeqqFPeWG3V6VPzylxuJ0ZRqDlDQbStg=;
 b=PBvBW16CsfvfXR65r+VMMU0KjAjXxxj1SSuZ3g/24i5CeqvGlSxx7B4yVpcFinVMklnIpttAuxJO3su3MZKEapdb08mR+ksmWhyVhEEcM583jfgdP6njT536awvAycdGtbAwmWXHdYP/gGJ61C2g0O2vU9ggwROM4UeAspfb44j2xlgMvv2OA8HAzQPOITiGfccgvQBheVCOQ+qXB37+r9Ld8lIg+nZ44fQTIrDpbiMX596ZqeOPM3e3/oQ0kMsIcvYSX9ixNG9lHNW8ooUr/ZEtlj9E4mklaUEo4H5Uh/LNbfzgNsBPZKM20GLuj2W9ggKGH5lpgw5XA6DLSTXePQ==
Received: from HK2APC01FT050.eop-APC01.prod.protection.outlook.com
 (10.152.248.52) by HK2APC01HT080.eop-APC01.prod.protection.outlook.com
 (10.152.248.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sat, 9 Feb
 2019 10:41:09 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.52) by
 HK2APC01FT050.mail.protection.outlook.com (10.152.249.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 9 Feb 2019 10:41:09 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1601.016; Sat, 9 Feb 2019
 10:41:09 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: Olivier Moysan <olivier.moysan@st.com>, Arnaud Pouliquen
 <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@st.com>
Subject: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Topic: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Index: AQHUwGP3BFaM6L9X70mSmjxl1QacOQ==
Date: Sat, 9 Feb 2019 10:41:09 +0000
Message-ID: <HK0PR02MB36348FCAF73000463738C017B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:7B37FA94378D0AB4EAA93A1D8F65916BBF078320F215C370CFFCE78BC9CF5621;
 UpperCasedChecksum:537F9B0B33B2C120E5E6AC5CF5CEB1E179ECD997FDCBF133CC284247FFFF0D86;
 SizeAsReceived:9005; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [oJzL2gpxU+WXTi74rbET6FFeNLLSIPKF]
x-microsoft-original-message-id: <1549708811-22685-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT080;
 6:GECrVGQpANjV1fA5LpRha1Uz0nRaI1SH1zAvfdBf89GFCqb9SXhFcR0lAsNZYSvBRbLr0e0UCZNsn1LAqbfdHYKjSrX9GmzsCxVJSp08wKGoTdXnH0U6DiicsT98HB/TH4XGDb1QwFEPfcAcf/BZ8XBiaY09/FbIkBOWTzmPHpLNo6g+UmDiTgTuIB2FXIwLzqCMCydIdXJN++IaBK2CT+N7Ur0RPnL3vACZGhGfWu/HDcjPGC7Ve+wCTp9HH1jycW7ZSwWgcHyJDD6V9t6jB0h/MrCNuSFsgpq4fOFJm/24QkaALXtJgKooZkQfp1wRlYepmTAq4xMFNR4QJhFuPw9droXAfxLoXVrMgvSr7AdoO5mFj4k3O4kdl8mxpM+vLQUPFXY9vnmdlcTW6YrDWLIV6u9BS+2TFomblNMjcTV6JSWgR1B5tbBqe3a2FSPAJavGdh6qCcZPLfgSL8n/kQ==;
 5:Ze+Bn4HKo7tPrQMkI39/4nrIKXh/cMjoOVHKUJi5xUS8fKEKd+/MJS4BAwp1TjkRt0UReGzU+Vp/jb1KPqhwCo8jWQlttK4u2Z8pzeX1Ka/++z4aaT9W92BZvPVqUZEZXKU5oNKbZKtzwxuruZLxazOzfxbs2V+z/DraYh2y9PpuyL5qp6DMJXf3XR9R+G7x2hIWJyd1r66JliCXieMEag==;
 7:UhFJIOOj7WbVfIweOgJYoB+PV2iApbdbsXg9MWDu0n+/MP64jaxUbQtPAKQhZVKR7zigwDemQ1vmU7iijmvtAnaa2bkI4CEFhlkGMwI+HHLJfBjg7ojH9DPRfnKMESKk72P9McqrU++LDjp6fNCD+g==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBRmoEB1kyLZIPUDhDw0Z3bfE4/ohWtWI5WwGr5xEb/HkaZu6TNx2TJ5nc54MnG3SZWjtv+cU4m9fBnWuCtknltkMpAULMhIX8jL4O5PwmDh95IIVvn5zwPgcRPuzPw7HfDTy4z15+zAt60AhtEZHHEMKGweidkrQRuxOi6ieLqoa5nVcHcGXH/gvuO8kGJmIKaiOJvVFXcWFB4GoMBloMKVgcmPiLo5S+1NANIeV4jchyP61fIgpbdRsbCxWDr6FlR2EvVviecebSx+mufW4tKBQAq/vzRUxMER/I6J0cOADQ5AMthh0gnBvPUfeA66cSLuv15if0jye36VeYFcGm0BIgFGxpP317wfPpsFSIFt9DKs8z+IN4YRhvdtIJpPjnCABL8beUKU0Je7qtFJ/Sw411Maw/EyoPiwxLXsnYGAIXYRftxXcxFD/PGOIUV8ScITdT58LQU0oPq9VUja34wzfg8rnsYi1QP8cYJl7S8yw4rT9SeOwBmJwZ8zaXDHUEq0KJQk2LhrQfvmF3mvuGw8/iRU5/NC4EFXZuyHjrjTn2DeZCVpwJH+Nich9MDfk9mO7JrCJaTWwElE2jjmdV+RZB7jAz7WJfz+9xVu5rXpj6AxFU5wl+wH2ThTAKM3Rhd4RTmPyMkuL6XWSgkF3UaeqrpUSMESUA0s+uovpeqX4rQsgjzxUxxFbPiPlBbiZWAjqIetzHvSu1uktH7s/wS47XDtULanCpMbAla18lB4JZZ+wJE3XR4Iqz2EYsNbKAG+C2wKUjM=
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT080; 
x-ms-traffictypediagnostic: HK2APC01HT080:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT080; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT080; 
x-microsoft-antispam-message-info: uordCzEDKtK9EgWveYZPXlgDl97sVKKL9KikLE+4TfvuoxcK2LWBFXJvYgY+mv7u
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 297a944a-657e-4730-5c43-08d68e7b1a38
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2019 10:41:08.3491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_024121_863922_69E9BF0C 
X-CRM114-Status: GOOD (  11.23  )
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
Cc: Wen Yang <yellowriver2010@hotmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Fixes: 7dd0d835582f ("ASoC: stm32: sai: simplify sync modes management")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
---
 sound/soc/stm/stm32_sai.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index bcb35ca..14c9591 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -112,16 +112,21 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!sai_provider) {
 		dev_err(&sai_client->pdev->dev,
 			"SAI sync provider data not found\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_put_dev;
 	}
 
 	/* Configure sync client */
 	ret = stm32_sai_sync_conf_client(sai_client, synci);
 	if (ret < 0)
-		return ret;
+		goto out_put_dev;
 
 	/* Configure sync provider */
-	return stm32_sai_sync_conf_provider(sai_provider, synco);
+	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
+
+out_put_dev:
+	put_device(&pdev->dev);
+	return ret;
 }
 
 static int stm32_sai_probe(struct platform_device *pdev)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
