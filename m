Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DE4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:11:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4736E21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gw5lbJ91";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="RO2l4PhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4736E21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1vAQQvMaBgkxtUbKDAQ0Q3ANFxOBE/ECgxFV6GPGidc=; b=Gw5lbJ919xNORs
	yTp9eGFnHgHXwLpVXX97WtGE+XIhLlQqWAvG/dRz09R34odf+9UiR+tuHxz/rR2hLXnySexmRGTo3
	w1d+nlY22MLJe2rE9IL1ToTLNKliZKBYif3A7+G8WBKuMbDI7u4VJDBo1ri5GFrRJ0UYGkCofX0n7
	wqhG5CgPgMS2ZDhTkmzCJHuBetgkfXQ3die4Tr8lcvkraQ01MhttUN39T0EFB8cj94peV97yDbLAU
	3zu3XZ+9UEGsNfpC4weYsqsAUNjVSgGflFAeZlI3WIfq0ZWHijcYc8XDtHW0BtnWbbDOahulRjd+U
	cfjswnAYsxyHSi5Ruz+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdVm-0000eo-Qj; Wed, 19 Dec 2018 15:11:50 +0000
Received: from mail-eopbgr20100.outbound.protection.outlook.com
 ([40.107.2.100] helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdVj-0000dc-Lr
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/vO9mgShZenUz1A9N7XTadlOHd/TpKKmGtTuD2TTuY=;
 b=RO2l4PhLUz7rsilteQ1UcmOGG12T6Mq5kgqoYRtfZPjNfEgH+5TNv+ng2W+JjALt65/WNE7SYQ5v6uemE5/5s9mVUvDQk3LgfDFmOrdmAQfUTzSVyhev10cSI5RybS1jwNfGIvrB+LZZyIxEZ6ej86p4OUsrIUSSgsUJZZnYgSU=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2109.eurprd05.prod.outlook.com (10.167.196.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 15:11:33 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5808:701d:d1ac:9df8]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5808:701d:d1ac:9df8%5]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 15:11:33 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "festevam@gmail.com" <festevam@gmail.com>, "robh@kernel.org"
 <robh@kernel.org>, "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>
Subject: Re: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Topic: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Index: AQHUl5hS3YQwM2HAUkyF1f0Av+JOLaWGCwaAgAAEEoCAAA2lgIAADlIA
Date: Wed, 19 Dec 2018 15:11:33 +0000
Message-ID: <de72ae0470f02d34833a3f2bd0521a94ae83b3eb.camel@toradex.com>
References: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
 <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com>
 <CAEnQRZAHE77GsaES--LtWs3F4uHP2ePp3-KmP4xmZDh7NM4njw@mail.gmail.com>
 <CAOMZO5AmaQgz+X_dYgafVYHooY649CBBP6ERbX6B+Gt_A-1s5A@mail.gmail.com>
In-Reply-To: <CAOMZO5AmaQgz+X_dYgafVYHooY649CBBP6ERbX6B+Gt_A-1s5A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0501MB2109;
 6:mwfrJP+cVGqD5q34Vka4Or1MtYoZWkiV0SozxTzgOsYItLnYjTgbXYfPyElVpXtd1oym0EWLIVSqlxetOgwoRV/fUj9U6inMzq2L/06tA24ExHl09eEuUU4bF8q8kZwuuWx5eSqb29qyJE1EYquRukbce7ik+lfX85jbPdIGaNOzccquCh80MbtnxW5vmiL7wQY4jpO5MbpRxyGfO3JLyvetuGyvMlnMr6IwFwpN4AvmB+EevV9zfQ6/GSJtFL67RjXeykNJhihKzruvRrAjfULps4XGh4CoMqcCMOG7VYJo8KhU2APvrPTIlJ0m3LfaCupwVDpwPNnz/M2SBP7zh8V/8ygUOAUxJ+oOJ8UK+2kZ4yeeZFWE9dW50ccerY6x/8Yk85V9wzPHbkIlYnSPaLulVolpyh+De31QuWW2KKAHT/Z80epyS9pq7FxqF2PJ88ITXShlFohMVJh7jZkuhQ==;
 5:+uBEnmcJ4EvzEzWVzs7KkB6VtIIqNe1KfAu/i2UPi3qhFBOEbFer9axFSVTBohulAmE0lN12KHQVAvn0/Ao/0pPoUR7jrNu6yGsZ7PFDYfVJMHDQbqFIzIYxMgAejUI6IURXvqOeydaifZNTi49py0I9NOJXoz3M63M7PEW+J/Y=;
 7:XClMoOBTLqe+YsE7+G2XWR1eG5NbkhlFWhQf+yAEJgqMK+gb5P3n6hI6Ebb/oBUGTQgkcblIkN7fxFNnjEnwtexzPjETnnBefojVanI2OE7uFldxMgPP0bMSaINNbJHdaW2Y0HmdavTYvZPgaCiQmA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3789cbfb-f3eb-4131-2b73-08d665c44347
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0501MB2109; 
x-ms-traffictypediagnostic: VI1PR0501MB2109:
x-microsoft-antispam-prvs: <VI1PR0501MB210941A04EC6BC8EA74B0CD7FBBE0@VI1PR0501MB2109.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0501MB2109; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0501MB2109; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(136003)(346002)(396003)(366004)(199004)(189003)(186003)(7736002)(71200400001)(71190400001)(8936002)(8676002)(3846002)(6116002)(81156014)(81166006)(2201001)(25786009)(6486002)(86362001)(6306002)(6512007)(2906002)(105586002)(106356001)(5660300001)(76176011)(68736007)(53936002)(118296001)(256004)(14444005)(6436002)(102836004)(26005)(6246003)(4326008)(36756003)(39060400002)(6506007)(53546011)(97736004)(508600001)(2616005)(110136005)(4001150100001)(316002)(476003)(99286004)(66066001)(54906003)(14454004)(11346002)(446003)(44832011)(93886005)(2501003)(305945005)(966005)(486006)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR0501MB2109;
 H:VI1PR0501MB2590.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xI+MlgkBHuN4OwPiet3fT+xFngHqFgbM9HHD5CXjTcR/Ev+FmpxseTSidlIPmZj0oN1G1G3r7PdY1Hi0UVvdI4OtB7N5t/mz0PEfZplQBU647AWRyC2nk26vQ8MZeUQs2oEI1xgkG0/U+UEr3Zv3U5EF6iR4pYoyHwfBUF6oWYP2mOS1I3KjdDGUnSEYAbK5mxnGUXWlc7bGxhLqLiUOYzjqbS+UXc5n6sKARLnpPI/1tvsqeUeRILUUEihcMxjOM60bZmu5KB7PohVQ+vJ0NWLtxaayul68H+Gvmtaihra0fFqAijcmvj76zQX2rP41
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <9EF404B5E1FD664F9BAEE9EE6D1A5F40@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3789cbfb-f3eb-4131-2b73-08d665c44347
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:11:33.4986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_071147_877437_D8771BD9 
X-CRM114-Status: GOOD (  18.68  )
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
Cc: "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2018-12-19 at 12:20 -0200, Fabio Estevam wrote:
> Hi Daniel,
> 
> On Wed, Dec 19, 2018 at 11:32 AM Daniel Baluta <
> daniel.baluta@gmail.com> wrote:
> > On Wed, Dec 19, 2018 at 3:17 PM Daniel Baluta <
> > daniel.baluta@nxp.com> wrote:
> > > 
> > > On Wed, 2018-12-19 at 12:42 +0000, Marcel Ziswiler wrote:
> > > > Hi there
> > > > 
> > > > I noticed that at least today's and yesterdays -next won't
> > > > build with
> > > > the imx_v6_v7_defconfig giving the following error:
> > > > 
> > > >   LD      arch/arm/boot/compressed/vmlinux
> > > > arch/arm/boot/compressed/head.o: In function `restart':
> > > > (.text+0xa8): undefined reference to `__hyp_stub_vectors'
> > > > (.text+0xac): undefined reference to `__hyp_stub_vectors'
> > > > 
> > > > Has anybody seen that as well and knows what is going on?
> > > 
> > > Hmm, works for me.
> 
> Yes, I haven't seen build failures reported by the autobuilders:
> http://kisskb.ellerman.id.au/kisskb/target/7464/

Hm, strange. A clean re-build using ARM's latest gcc 8.2.1 now worked
fine as well. Sorry, for the noise.

> > On the other hand I'm getting this warning:
> > 
> > arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning
> > (spi_bus_bridge):
> > /soc/aips-bus@40080000/spi@400ad000: incorrect #address-cells for
> > SPI
> > bus
> >   also defined at arch/arm/boot/dts/vf610-bk4.dts:107.8-119.3
> > arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
> > prerequisite 'spi_bus_bridge'
> > 
> > 
> > Maybe Rob can jump in?
> 
> Yes, I have already reported this warning to Rob and Lukasz.
> Hopefully
> they could help fixing it.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
