Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDA6C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:31:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB2B20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zsb+LVIf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBRg1DX4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pAiS25Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB2B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YlsPFxLtMOhmxywuWQU4dMkqDdiWtn3dhL9DNIb08yc=; b=Zsb+LVIf3X5B8X
	x5oSb+VTCVjmptl2mMxS1zxNMc5VgHGXAzfF4GTWJr3+FLTPmk5j8NQRJ+b8EgXd8xh7kWY4DnO0W
	jdklJx9Pq8kDTpUW2jDHJsD5I0Jj2iankE4/PzldjWFmZjiJeunZp7hFnkdyZaniVMyQGRf9H3OJt
	qVfDJ6x7ZJgekHoyr1MFZDxIv8vGKkuXLjkV1aLOlMMNRDmI62zUKmQx6hD0pmfpxcQJNBBykeQn5
	6bnBUfVb5xyDvv8Id6bImFFX0Ys6q0QIetjh84FBS/fGAcgjXBt8pOxfU5jbQYd72xWKfQmP+XdUU
	LDC1fzS3c7QelBXCOdxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU0V0-0002vJ-I1; Tue, 04 Dec 2018 02:31:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU0Up-0002kS-3x
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 02:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/y0uyFptNbUHRIVDSJhISjL/4/7kUDXxZNAepkrL0Cc=; b=iBRg1DX43tNF8lUolJlqRmNXqd
 TUz/19NY/PpA1L4NerfsxQef4Dvy/3R8/T107HWiTpqwdH1O67gp1sliNYwEySwzQ1iib1B1HnvhT
 MdECI3JYSY+ysqN8pO/nkv80koep+/N3oV9qyBE0Vqzkt4WQLrdf7ljB7xPWjWPMW/Xa9XXDsDbll
 8ySmE/kKIpn5NHtt0IiGyaW/o/MrqXnV9dwHFIobP8US5tBUauB8CWEVF4+7afTgkP6ni/Z4WGpWo
 oy4Hy06EDqTCeDD1sctPuImLWPTUqiAdZnYliTZrLTlwYWbrxKljVmH8cKmtlFFV/dYjvUdUg0eCr
 4anVFXXg==;
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTzuO-0004zv-5y
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 01:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y0uyFptNbUHRIVDSJhISjL/4/7kUDXxZNAepkrL0Cc=;
 b=pAiS25NfgseOstzPHYbEnb/8uCcLg1ZPy37DeJLTR2INcWbTjlJwKfJNDSVuBaz+9JtOjXE03nDmVAfP3jLCa+O46/KojsYwZrCOVhNkSee0CzXWdBZdpBQpULIAUIiYVL9Q+PyfprxSTWgwzKSILszUnlG55UdAmhGCSXCyxWc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4035.eurprd04.prod.outlook.com (52.134.125.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Tue, 4 Dec 2018 01:53:39 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 01:53:39 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V8 0/7] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V8 0/7] clk: imx: add imx8qxp clock support
Thread-Index: AQHUgaQ07UOrlEn65UOyxxVfjCE+w6VleWoQgAfyF4CAAHjrwA==
Date: Tue, 4 Dec 2018 01:53:39 +0000
Message-ID: <AM0PR04MB4211EC7E0BCF9AA0FCE57A2B80AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB42110579601320F59219CB9E80D10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154386231357.88331.6991254616792618686@swboyd.mtv.corp.google.com>
In-Reply-To: <154386231357.88331.6991254616792618686@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4035;
 6:VS3doNxQyShffn4elUPBBXh3sEuDkLkNjMklaxBHqp37NeYNVczJItl5zjQ/6DUB484ymMpiC+rF4NiSTYNkGXt7fDIWpdIseFAukTZ7cf8TFdYAdV7zzbZ3Vxe5AygGWlXCnjyzeWNv50cfrYm3kZg40OjwIk9f6YB8/t7oSjd40MhR8pLbHzhRdwmbtGDvxImUHIAqOp0lxQUg5cld63HaWo203RXPZfH4M4xTGY0Bhudbn0qWkLoRGelwTK8XsCKnTxPwphzVMtiXVPlAHGUuRHOQw4rUEy+VHKFCNrf4iCBxzs/w5gVTzvtJXPQAD9vaxK7jXPvoFdaOu1roux4wYunB16Xhi16kK9j+TVcpTE7URfsTo7wU0FfPUBMnfxEsU5wRUZ/zpxgepuFf8onWxblHQoS+l94+kkxrqlJj+/IRp9p+WdYyYqpSmOhjjmYPDos/B8R2Ki4n/czD/g==;
 5:F7l0Fmr4a/ICIR1fWsG5/EB3YV5BS5ll/B8BmIRJoe8HqFnkn4I58E42Q98RXnL47b4ku5xBFZ1sW4YZYb/0jm2iIzUnghVlG18lLIVEJ+gB1sYoqCIt+qg/i6PesXWKYD+28blzOlm0FA3prnNMgJZA41TF1iMl7RmY3ZKpg3M=;
 7:J10A+Q/rEQ2JYTo9YBk4S3OpAwJ64sLfLK6QplfOhsS3EXWVWSGCQ5EoIf3I+pMeFtBdF4itPwWwvzIBSdBZxPOE2NqrlQiOfmGSzLrwIvSK+Khjh5xjDGHT2S5MU+GeE6H4IxNhUZSUM3I1trgeRQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 34433717-e420-4923-aae0-08d6598b5024
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4035; 
x-ms-traffictypediagnostic: AM0PR04MB4035:
x-microsoft-antispam-prvs: <AM0PR04MB40354CA60E7893CC2C72E38080AF0@AM0PR04MB4035.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501493)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4035; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4035; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(366004)(346002)(39860400002)(376002)(199004)(189003)(69234005)(13464003)(5660300001)(8936002)(256004)(81166006)(81156014)(8676002)(97736004)(2906002)(6436002)(71200400001)(6246003)(71190400001)(229853002)(486006)(25786009)(11346002)(4001150100001)(68736007)(26005)(478600001)(186003)(102836004)(53546011)(6506007)(54906003)(316002)(55016002)(110136005)(4326008)(476003)(2501003)(7696005)(53936002)(9686003)(3846002)(6116002)(99286004)(86362001)(105586002)(106356001)(66066001)(33656002)(305945005)(7736002)(76176011)(446003)(74316002)(14454004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4035;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AZ92WCsHois7SF9+94M9D2aBJonNvsGcSakeLARY9cCLC2MUh0I8JCPtnjBJef1oKIHt7tkAxKV3KoH+HE1QzhXpWuTkeuxbbRW9iIx8Fd5TpyJCM/T1ihXm5JhS9ZqUFx+Yn7eJR3iwj5QTfUF6yu1sQ9909F8zi/Pf7dO/FLrYbnslT1G0cKO4ibIKU4J4v9xknASEtolifxZQK2HtIC5Hu1ArMp92DV0ACLrP8SvayGnVi2nESnEay7jfb47JxY5NN5oycxnj/MCbErVPRK7zetlc1y2M0VCCLzl9B7a1vc3n7HeYvSqn0LsetOr4qhj8HggC22bd3FmBb4dA5kW65SIuvpvzv89vAsj2lSQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34433717-e420-4923-aae0-08d6598b5024
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 01:53:39.8289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_205356_334220_7997D93C 
X-CRM114-Status: GOOD (  15.01  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Tuesday, December 4, 2018 2:39 AM
> To: linux-clk@vger.kernel.org; Aisheng DONG <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> shawnguo@kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de
> Subject: RE: [PATCH V8 0/7] clk: imx: add imx8qxp clock support
> 
> Quoting Aisheng DONG (2018-11-28 09:18:47)
> > Gently Ping...
> >
> 
> FYI, when you ping the thread, it floats to the end of the queue for me, and
> then I don't review it for some time. Sorry, this is how it mostly works. The
> bigger topics come to the front queue and then I try to get to those sooner and
> let the stuff churning as newest in the queue become lower priority because
> "someone else is doing something". I do sweeps over the new stuff every day
> or two to pick out the easy one liners and simple things because they may be
> critical, etc.

I fully understood. Thanks for your effort and help.

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
