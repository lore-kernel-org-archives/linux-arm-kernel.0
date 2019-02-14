Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:57:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A86021900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qj85gaED";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="AfqnE8ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A86021900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=thl4zZsWuxydCZdI4YnZ/H+T/8WMT/5SRoNh97PdGiU=; b=qj85gaEDsCZ7z7
	v8ao2smIHeuoReZjPFXg41K/EBBovHAULEqT+wsBiPB/NAo4v5jfdWZHQQ1ui/+EWiKYDwcS27sZV
	qzESpXzB8tU56x1lVwi9MOpKA4q6ATQXVx42zZ//sxRklc2AeFDQKEm3KgyQiLBAII88W+qlsbcUP
	1FNLMtl9kE3VmBygQAOINcjbZht4e7xaJnBKQ42IDpgUV22V31/4wdRqWRftMA15deaDpL28qob5f
	tQWiQBxdzXzXdo3pHAiDuug/ZgteRghfz/6LCPk/wk8Kssziy89wj7oSWgO/kD+Deed7mqnE66r+/
	242f3oUkyK6Cy4gC+nRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGZk-00045r-Rp; Thu, 14 Feb 2019 12:57:12 +0000
Received: from mail-eopbgr1410090.outbound.protection.outlook.com
 ([40.107.141.90] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGZh-000444-Do
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 12:57:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeu7D111lh1db7yhz6EDgEz5yoyq3gCw/ch9fvV6/Dk=;
 b=AfqnE8iebviAFNFPGPwF6LorVEQ16jtmYXvVux2/XW62zIVM8Wwa0yqJyVDRnZ1WSBFR1x0M1yjeZzE3f1mu7ssJz9ZyBNqa3Pf/O4GiGuc60T9ot7j3okLwdl8GridkCmFHyjDwJBADmBE/RiViOvQPNbNcPOzF5FPgxZUIiR4=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.161.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 12:57:04 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 12:57:04 +0000
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Simon Horman <horms@verge.net.au>
Subject: RE: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for
 cpu devices
Thread-Topic: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for
 cpu devices
Thread-Index: AQHUv59UWIs1mWv1SE6wnM13RZEGXaXV2xMAgAAqdKCABFllAIAE6zPQ
Date: Thu, 14 Feb 2019 12:57:03 +0000
Message-ID: <TY1PR01MB1770B6B3FFD6293A66F4A8BAC0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <cover.1549623801.git.horms+renesas@verge.net.au>
 <231d8908a66fa98f09553d31ad8cd5f382b29959.1549623801.git.horms+renesas@verge.net.au>
 <7d60ebf5-c245-f48d-47db-ce63f4f3690b@cogentembedded.com>
 <TY1PR01MB1770FAE6E7C26615134B8E0AC0690@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20190211094927.5bs32a6q7ecvqq5t@verge.net.au>
In-Reply-To: <20190211094927.5bs32a6q7ecvqq5t@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d27a2c04-ca77-4f86-2277-08d6927beb1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:TY1PR01MB1481; 
x-ms-traffictypediagnostic: TY1PR01MB1481:
x-microsoft-exchange-diagnostics: 1; TY1PR01MB1481;
 20:b8GfWlpm2xLP2HqPwmDMWXVnmHwACvmW8vYAbNeHgorwcmT0A/+lxuNQo6kQkuaCOxQ8xo6qby0aF+k/BSnqGEZqFMuig4Fp70Wkt5fqKnjlz+5fNIH1ijCyOgjC+tTjXdJM7h/Nh5Ck61MCYwmqTtUHlZRaKvaVZztKD8NSC80=
x-microsoft-antispam-prvs: <TY1PR01MB14819741D0B685280AE98526C0670@TY1PR01MB1481.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39860400002)(13464003)(189003)(199004)(105586002)(66066001)(54906003)(2906002)(68736007)(106356001)(71190400001)(71200400001)(97736004)(6116002)(305945005)(74316002)(6436002)(14454004)(9686003)(7736002)(33656002)(86362001)(6246003)(229853002)(11346002)(6916009)(4326008)(256004)(14444005)(93886005)(3846002)(81166006)(8936002)(76176011)(478600001)(8676002)(446003)(81156014)(44832011)(486006)(476003)(6506007)(26005)(99286004)(102836004)(53546011)(53936002)(7696005)(186003)(25786009)(316002)(55016002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1481;
 H:TY1PR01MB1770.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BiAevY438qcptH0Crfs89kDCS7br4Ab7rlzNCFmTwbzELlBkNDrsvCOf7JJrMCwlI2TmTBd4RxP2B3yOscgHFwdP+hxYJFgGUTd8ERbXW6QpHKW0Uvgrw4leUy5i7Diy7LFBqoUmTv+1ptnBf0mBHuRIpUeM4tem93rXVirOiW27pq+MEo3usy4kWXal64oQB36h7bFwAGUQg5ZtnBGO9oWEVmM47/gnjZFv7KvVlrE0RLDJLPngzZtN1e4w5Vqw+3x/0ua5Zzai1RDhtDxVUTgilkDwc5Bv6IalDUt/AVbgVnA979XVBe5euZOd7gEpYqbtl5tRUmrdLRGWRV3rAjHpocr2eD1PEj2Sj/FBnfOTaJkZeBJQtvpyYEE45uXNW8ZWkpzoSkDtHwbA7tgoTixgIe+6DyWUIlgQS/o9XK0=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27a2c04-ca77-4f86-2277-08d6927beb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 12:57:03.9963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1481
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_045709_512949_A3B9B568 
X-CRM114-Status: GOOD (  21.79  )
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
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Simon,

> From: Simon Horman <horms@verge.net.au>
> Sent: 11 February 2019 09:50
> Subject: Re: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for cpu devices
>
> On Fri, Feb 08, 2019 at 03:26:49PM +0000, Fabrizio Castro wrote:
> > Hello Sergei,
> >
> > Thank you for your feedback!
> >
> > > -----Original Message-----
> > > From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > Sent: 08 February 2019 12:53
> > > To: Simon Horman <horms+renesas@verge.net.au>; linux-renesas-soc@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org; Magnus Damm <magnus.damm@gmail.com>; Fabrizio Castro
> > > <fabrizio.castro@bp.renesas.com>
> > > Subject: Re: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for cpu devices
> > >
> > > Hello!
> > >
> > > On 02/08/2019 02:13 PM, Simon Horman wrote:
> > >
> > > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > >
> > > > This patch defines OOP tables for all CPUs, similarly to
> > > > what done by Takeshi Kihara and Yoshihiro Kaneko for the
> > > > R8A77990.
> > > >
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > [...]
> > > > @@ -55,6 +76,8 @@
> > > >  power-domains = <&sysc R8A774C0_PD_CA53_CPU0>;
> > > >  next-level-cache = <&L2_CA53>;
> > > >  enable-method = "psci";
> > > > +clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;
> > >
> > >    Need space after =...
> >
> > Doh! Simon, do you want me to send another version to fix both spacing issues?
>
> Likewise, sorry I didn't notice that earlier.
>
> I'd rather not re-send this pull request just to resolve whitespace issues.
> So please send an incremental patch for now.

Thanks, will do.

Cheers,
Fab


Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hannawald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
