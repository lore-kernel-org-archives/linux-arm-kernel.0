Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAE6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:39:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126B3217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h/eE2KmL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i4hWbnn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126B3217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SmLIoy4JyB1SzeyGMX00jW0xEic/9Lp7epKFHyesd0w=; b=h/eE2KmLSyH5oY
	ypWdwI2qBfi3N1tHuxKU7hTUgepcmCfTKDRqWDMS4HZ7kdsJkuF1OmMxsSzSdQ+tNcuQRvMqKK29d
	CLYuPTQNrrnspcJWGb2fO9CUxQ+eHA0tOKr9k9H/pjfqvXfTYkOU0nL5edQblsbC/TBrCkuHfzu2W
	CKA3QS9ddiDKKi0aV5kJJ8FWv2MAxZP+TACn4PLWxeKHRoFkVcKPZrOtu7+hN0fanEjv0cBVrzH+k
	AollSRnCjA3MjAHVhFRLm3NJT1OyZVzAi3ZdWJG9LjXdRS+i+wagaROCvvT6v/oRJBxMY1wvlcBIG
	whrC4PJXjj7e67EIt1AQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtRjH-0005mq-04; Tue, 12 Feb 2019 06:39:39 +0000
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtRjC-0005mE-MU
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 06:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLb6Mu0utcaaQnsldY2/uqTyYhEktHsN6JKRO3Bs7lM=;
 b=i4hWbnn30SC8C2eORVWXuscpzccC/mih00dg7oy29Puzl5Cmxy9L8m82MdmP8b9vcz0EtSeF/V65LgQZCyqSYLjQdY0+MeH2/mrbR6W4zQTkuRLdrDq/nSbTOHuEo+3l8Z8WSeNsOVW+UTsSpHXY3GvQw93ed7zdYOnHSX04tLM=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5775.eurprd04.prod.outlook.com (20.178.127.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 06:39:30 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::958f:1823:dcd4:4f49]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::958f:1823:dcd4:4f49%2]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 06:39:30 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: =?utf-8?B?UGV0ciDFoHRldGlhcg==?= <ynezz@true.cz>, Vinod Koul
 <vkoul@kernel.org>
Subject: RE: imx-uart DMA transaction error leading to OOPS on 4.14.95
Thread-Topic: imx-uart DMA transaction error leading to OOPS on 4.14.95
Thread-Index: AQHUwgI4Iq4P2RBHr0ywDNm8KpGj2aXaVDwAgAExGGCAADGbgA==
Date: Tue, 12 Feb 2019 06:39:30 +0000
Message-ID: <VI1PR04MB4543B9D3A40D6BCD3E83959B89650@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <20190206081310.GP26426@meh.true.cz>
 <20190211120616.GT4296@vkoul-mobl> <20190211092820.GS26426@meh.true.cz>
 <VI1PR04MB454392326A1394AA678090F289650@VI1PR04MB4543.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB454392326A1394AA678090F289650@VI1PR04MB4543.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5775;
 6:yVf2dke8sBLldhkwtRTKin+S0aP2+aO7Jou7trrDGaUHpq68KUs+BB/wPhqTu1BRHSoIi15qr8EgO3ZQ1MVm/A6rVAWAC/ivKVQvjysTr3gQLQ4qe4kOo5n1OezdVrHP/9VwYAlJIC1+iOIApT+cDa5Z/AkIlbP4cGK3t/hqJRi5Om2P0i4gE9kL/zsjfPFJKs0fJPW5aZaAGhlua5KGrl+4D2vh0nPYC6cdzESDdsI7aQ3TRA2ofFBWo3z5wIC23WjslKUgA/1deLZS6X9Tccl+Td9Ri2jva1fPhVxmJALocaiRS3mv6TP8+CkQExDhit1FABoPtiV9kqlxgMap009BtP96vt1WnqJvHCmxwVEFaaK0O6t4yQn420pvdTW2OWn1TnMIl+sNqQ7GHt7dSO6/r9lI7Kn+cTgUvI4FPsdtaiU3KGVaWrA5Y/pSx2k6VuzgqFZraDBaH6RrsL0EvA==;
 5:crHsz7GVgCbH8tSUFEeTT+o3anKDtun2qtLY0EN+GNSu72W8Ho0K1ydR45xV0GKEqBE/AeRMC8SRa9X6Ign06PcaqEMGgdUsPIbQhyKVlR9qcdAtOqNoVzT/C5hXeGs5YceKU28UQKnzbfmK5zn5d9TVgUlc/QBYuID+o1q1GFrKg+XqV+dzjm8f1DcwK82sjGlAXjkMdyUzvKtqr49Pyw==;
 7:6j5Kbskuc9f9+kIOozuSJc3eFvMEwLAqzRu2RHkFGxB+LvVEUe9gBCNtU9R1aHpex94rogOJcfKN1E20j01VK2/JxyLCtcyFw09Fq06g1s9ONdzW/z+LNFJ1cadY/fkmf7gvawwG0C5ho1P/0m7+qw==
x-ms-office365-filtering-correlation-id: eba01351-ac9c-4dea-b1a3-08d690b4d7de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5775; 
x-ms-traffictypediagnostic: VI1PR04MB5775:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB57757154DC6207F9A235F2FE89650@VI1PR04MB5775.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(13464003)(476003)(66066001)(486006)(53546011)(6436002)(86362001)(186003)(446003)(105586002)(25786009)(6506007)(11346002)(55016002)(106356001)(102836004)(4326008)(6116002)(3846002)(99286004)(26005)(229853002)(256004)(2940100002)(8936002)(71200400001)(14454004)(81166006)(81156014)(7736002)(8676002)(305945005)(33656002)(6246003)(97736004)(93156006)(14444005)(2906002)(93886005)(316002)(478600001)(68736007)(6306002)(54906003)(9686003)(66574012)(110136005)(7696005)(74316002)(53936002)(76176011)(966005)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5775;
 H:VI1PR04MB4543.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iczyOgvYZXZgeuRzLbkJ/ieMZDqPOlmgklxOvWt/Wy3l+RngVAtfEr5ZT69VuGxwUWEV8HFUdvyCyj2EB8yH9VTIy2c0mtFbINZjURVZvDIAhCyrwHF8oCncFAKn+UQVHkpKkqLjufvuiNb8LbSxiiEI/wABKnpUvowFkWuf5n1lLNh7SMQKwIy2my9sRjMQjSeE+X0by/SbNOyJMCQa+4RRHgqhsgU5NG7yYIYNl00mi8WvAyv454SDY+VgNHzixnbPb9MhksAUtwEu1YlxllFTNNCq+cGxtE4QwZoBw2rv9MB9rRaNa8UyMsDH0YcUsyv1kInLSA7qLVpthkdvrVrb7qg2/sUtSEE68HCYLUNvMNq0ft20tMJN6Gh0AI5nM7wjxrCMt2FOI4BO3L6vQp39alvx78fRVnWSnAS5meE=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba01351-ac9c-4dea-b1a3-08d690b4d7de
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 06:39:30.8461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5775
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_223934_791226_BF8D5F04 
X-CRM114-Status: GOOD (  23.08  )
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
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

U29ycnksIHBsZWFzZSBpZ25vcmUgbXkgaW5mb3JtYXRpb24sIHNkbWEgZGlkbid0IHVzZSB2aXJ0
LWRtYSBvbiA0LjE0Li4uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFJvYmluIEdvbmcNCj4gU2VudDogMjAxOeW5tDLmnIgxMuaXpSAxMTo0Mg0KPiBUbzogJ1BldHIg
xaB0ZXRpYXInIDx5bmV6ekB0cnVlLmN6PjsgVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4N
Cj4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IEx1Y2FzIFN0YWNoDQo+
IDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPjsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJFOiBpbXgt
dWFydCBETUEgdHJhbnNhY3Rpb24gZXJyb3IgbGVhZGluZyB0byBPT1BTIG9uIDQuMTQuOTUNCj4g
DQo+IEhpIFBldHIsDQo+IAlDb3VsZCB5b3UgY2hlY2sgdGhlIGJlbG93IHBhdGNoIHNldCB3aGlj
aCBpcyBub3QgaW4gdjQuMTQuOTg/DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0
Y2gvMTAwNTc3OTEvDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJv
bTogUGV0ciDFoHRldGlhciA8eW5lenpAdHJ1ZS5jej4NCj4gPiBTZW50OiAyMDE55bm0MuaciDEx
5pelIDE3OjI4DQo+ID4gVG86IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+ID4gQ2M6
IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IEx1Y2FzIFN0YWNoDQo+ID4gPGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU+OyBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+Ow0K
PiA+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBpbXgtdWFydCBETUEgdHJhbnNhY3Rpb24gZXJy
b3IgbGVhZGluZyB0byBPT1BTIG9uIDQuMTQuOTUNCj4gPg0KPiA+IFZpbm9kIEtvdWwgPHZrb3Vs
QGtlcm5lbC5vcmc+IFsyMDE5LTAyLTExIDE3OjM2OjE2XToNCj4gPg0KPiA+IEhpLA0KPiA+DQo+
ID4gPiA+IEkndmUganVzdCBlbmNvdW50ZXJlZCBmb2xsb3dpbmcgT09QUyBvbiA0LjE0Ljk1Og0K
PiA+ID4gPg0KPiA+ID4gPiAgIGlteC11YXJ0IDIxZjAwMDAuc2VyaWFsOiBETUEgdHJhbnNhY3Rp
b24gZXJyb3IuDQo+ID4gPg0KPiA+ID4gRG8geW91IHNlZSB0aGlzIG9uIG1haW5saW5lIGFzIHdl
bGwsIGJpdCBvZiBmaXhlcyB3ZW50IGludG8gdGhpcw0KPiA+ID4gZHJpdmVyIHJlY2VudGx5Li4u
DQo+ID4NCj4gPiBJJ3ZlIGhpdCBpdCBvbmx5IG9uY2Ugb24gNC4xNCBzbyBmYXIsIGl0J3MgcXVp
dGUgaGFyZCB0byByZXByb2R1Y2UgaXQsDQo+ID4gc28gbm8gYmlnIGRlYWwsIGJ1dCBJJ3ZlIGp1
c3QgdGhvdWdodCwgdGhhdCBzb21lb25lIG1pZ2h0IGJlDQo+ID4gaW50ZXJlc3RlZC4gT25jZSBJ
IGZpbmQgc29tZSB3YXkgdG8gcmVwcm9kdWNlIGl0LCBJJ2xsIHRyeSB0byB0ZXN0IGl0IG9uIHNv
bWUNCj4gcmVjZW50IGtlcm5lbC4NCj4gPg0KPiA+IEJUVywgYW55IGlkZWEgd2hpY2ggb2YgdGhv
c2UgZml4ZXMgbWlnaHQgYmUgcmVsYXRlZCB0byB0aGlzIE9vcHMgYW5kDQo+ID4gbWlnaHQgYmUg
d29ydGggYmFja3BvcnRpbmcgdG8gNC4xND8NCj4gPg0KPiA+ID4gPiAgIFVuYWJsZSB0byBoYW5k
bGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyBhMGVlNTAxYQ0KPiA+
ID4gPiAgIHBnZCA9IDlkN2Q0MDAwDQo+ID4gPiA+ICAgW2EwZWU1MDFhXSAqcGdkPTJkOGQxODEx
LCAqcHRlPTAwMDAwMDAwLCAqcHB0ZT0wMDAwMDAwMA0KPiA+ID4gPiAgIEludGVybmFsIGVycm9y
OiBPb3BzOiA3IFsjMV0gU01QIEFSTQ0KPiA+IC4uLg0KPiA+ID4gPiAgIENQVTogMCBQSUQ6IDI1
MzYgQ29tbTogc2ggTm90IHRhaW50ZWQgNC4xNC45NSAjMA0KPiA+ID4gPiAgIEhhcmR3YXJlIG5h
bWU6IEZyZWVzY2FsZSBpLk1YNiBRdWFkL0R1YWxMaXRlIChEZXZpY2UgVHJlZSkNCj4gPiA+ID4g
ICB0YXNrOiA5ZjY3Y2EwMCB0YXNrLnN0YWNrOiA5YjY0MjAwMA0KPiA+ID4gPiAgIFBDIGlzIGF0
IHNkbWFfaW50X2hhbmRsZXIrMHg3Yy8weDE3Yw0KPiA+ID4NCj4gPiA+IFNvIHdlIGdldCBhbiBp
bnRlcnJ1cHQgd2hpbGUgZG9pbmcgc2h1dGRvd24uLiBUaGF0IGlzIGludGVyZXN0aW5nLi4NCj4g
Pg0KPiA+IEknbSB1c2luZyBzZXJpYWwgY29uc29sZSBvbiB0dHlteGMwICgxMTUyMDAsOG4xKSBh
bmQgVUhGIFJGSUQgcmVhZGVyDQo+ID4gb24NCj4gPiB0dHlteGMzKDkyMTYwMCw4bjEpIHdoaWNo
IGlzIHNlbmRpbmcgcmVwb3J0cyBhc3luY2hyb25vdXNseSBhbmQgaXQgd2FzDQo+ID4gYWN0aXZl
IGR1cmluZyB0aGUgc2h1dGRvd24gYXMgSSB3YXMgdGVzdGluZyBuZXcgaGFyZHdhcmUgcmV2aXNp
b24gZHVyaW5nDQo+IHRoYXQgdGltZS4NCj4gPg0KPiA+ID4gPiAgIFBDIGlzIGF0IHNkbWFfaW50
X2hhbmRsZXIrMHg3Yy8weDE3Yw0KPiA+ID4gPiAgIExSIGlzIGF0IGNvbnNvbGVfdW5sb2NrKzB4
NDgwLzB4NGVjDQo+ID4NCj4gPiBJJ20gbm90IHN1cmUgaG93IHRvIGludGVycHJldCB0aGlzLCBi
dXQgaXMgaXQgcG9zc2libGUsIHRoYXQgdGhlcmUNCj4gPiBtaWdodCBiZSBzb21lIHJhY2Ugd2hp
bGUgc2RtYV9pbnRfaGFuZGxlciBjb3VsZCBiZSBwcm9jZXNzaW5nDQo+ID4gaW50ZXJydXB0IG9u
IHR0eW14YzMgd2hpbGUgdGhlIHN5c3RlbSBpcyBkb2luZyBzb21lIGNvbnNvbGUgb3V0cHV0IG9u
DQo+ID4gdHR5bXhjMD8gSSBqdXN0IHVzZSB0aGUgY29uc29sZSBmb3Igb2JzZXJ2YXRpb24sIHNv
IEkgd2Fzbid0IHR5cGluZyBvcg0KPiA+IG90aGVyd2lzZSB1dGlsaXppbmcgaXQsIHNvIHByb2Jh
Ymx5IG5vIHJlYXNvbiBmb3IgaW50ZXJydXB0IGZyb20gdHR5bXhjMC4NCj4gPg0KPiA+IC0tIHlu
ZXp6DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
