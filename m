Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F97C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:27:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B072146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZNuvj3Mw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="iuv3GjWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B072146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2hUJHMmoQZ8FoB7qw8BELeo0F2Z/X8SCGZhOhuBKbSo=; b=ZNuvj3MwORhPFD
	hEhq+6opRxmwpgcg2Xjz0bImE7TT8gjFTtv8UEhrBXbYFgFzkqBJV9ufVGER2mZnL2ZJAkN2IkvjH
	KvatVNNAHHYhs0ZXS0G+nGAQgDsMnf32XMz6oFw4hFps3rQYCWMVJd1JIJevz7V67PbvWifkiFD+v
	RyQC+/xYzRYGLRlWstgljZi31B0Ji0mwp2ym4wy8eDDHwtnYTcPr7hwEteeH8Bnu8takRiy2fKgXi
	9WZBlduC9v9IsbPeftYMrNrPwc6XxXTDb1eGSzrNKLn+wNalpUELhn2zqwga7qfBReoowAMxHKEr8
	ChV9R0lS9zPGrteu5pqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs83O-0003pS-GQ; Fri, 08 Feb 2019 15:26:58 +0000
Received: from mail-eopbgr1410125.outbound.protection.outlook.com
 ([40.107.141.125] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs83K-0003oZ-PP
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:26:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F10PqaUW9EyNWKLsy/pVHU5bzaqQlP2i9nIATVSBEuk=;
 b=iuv3GjWoh2K4IQIOFO+w/YQ+8NbuaGpQ9c21R2FF0MciO2Zr34j5tLHBQ6wbnYm/EIx8qzjLs1N/sflaCSPlDr2Z0s7Z/mNUanKvzsgsHbSp95wjnjvy5YUS0sL3DHtX9UTzYzL7EzOl2c6EZ4m1Dq1YObo9tNcshwucXEZ0Uro=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1641.jpnprd01.prod.outlook.com (52.133.162.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 15:26:50 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 15:26:50 +0000
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman
 <horms+renesas@verge.net.au>
Subject: RE: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for
 cpu devices
Thread-Topic: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for
 cpu devices
Thread-Index: AQHUv59UWIs1mWv1SE6wnM13RZEGXaXV2xMAgAAqdKA=
Date: Fri, 8 Feb 2019 15:26:49 +0000
Message-ID: <TY1PR01MB1770FAE6E7C26615134B8E0AC0690@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <cover.1549623801.git.horms+renesas@verge.net.au>
 <231d8908a66fa98f09553d31ad8cd5f382b29959.1549623801.git.horms+renesas@verge.net.au>
 <7d60ebf5-c245-f48d-47db-ce63f4f3690b@cogentembedded.com>
In-Reply-To: <7d60ebf5-c245-f48d-47db-ce63f4f3690b@cogentembedded.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; TY1PR01MB1641;
 20:Pvb5gFIm1XuSH5eVyYwc4Z6atwSxYwzUjYnH0RFMIEqJj+GXehFxj61QlqoypRp3HXSwoFVQ6PmB8JQeVPTjzaZxPBja2bTcI1B4C93YaVI15E7ZxzO/L6bavX0ynyUCFlASs1yHkWHuDPfPs1sUGmY85RixE4ZsSArkTC7pPj0=
x-ms-office365-filtering-correlation-id: 2dc76061-923f-434d-d42c-08d68dd9d8ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:TY1PR01MB1641; 
x-ms-traffictypediagnostic: TY1PR01MB1641:
x-microsoft-antispam-prvs: <TY1PR01MB1641330E6DF856C066022B30C0690@TY1PR01MB1641.jpnprd01.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39860400002)(366004)(396003)(136003)(346002)(13464003)(199004)(189003)(25786009)(6116002)(3846002)(4326008)(7736002)(6506007)(99286004)(53546011)(53936002)(66066001)(6246003)(33656002)(54906003)(110136005)(316002)(74316002)(305945005)(14454004)(478600001)(106356001)(105586002)(8676002)(81156014)(81166006)(8936002)(97736004)(55016002)(68736007)(2906002)(256004)(71200400001)(76176011)(71190400001)(186003)(229853002)(6436002)(26005)(102836004)(486006)(476003)(86362001)(9686003)(7696005)(44832011)(446003)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1641;
 H:TY1PR01MB1770.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HeVvPlyJlaY8ZcFhHiuP1W+4sAPJ3lpNmEhNvJPUz65DOyovu2MQDzoLt53S2z3Np13hQzDlxGZeVTu4eLaHyE252zIMVMtqSehNNKIW6kus93FKPJkoN7UeSVfaZIhooMn8b/Bs12/MDOa/84tU1K95nPZmzAPYnaCcdaL2GZpSkZenh4mrAPkoIMpr3DaYvNAsTo1BHsPBdmlAg0LPt6HHRsK/JLnymjvjeYqslJPamzWLPyoMzjFlAdGlx6j1XSJTwkdY1BUK+h5ZIE5EAxrsU4P7juqjZueSR4xBDeXdnQvc50rMiTQJuzvv0v/08WTatbUz3DbLItVtPB8sye23OyZzp78GE+zk2g/GZf5I9WD8Rdq2JhdQ5Rw9WAyyzlUJOJJkMJu0tZiR7KTTTE3oizNY6Z2QV+SNj9Vr/04=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc76061-923f-434d-d42c-08d68dd9d8ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:26:49.9326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1641
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_072654_873884_06B91684 
X-CRM114-Status: GOOD (  18.28  )
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
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Sergei,

Thank you for your feedback!

> -----Original Message-----
> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Sent: 08 February 2019 12:53
> To: Simon Horman <horms+renesas@verge.net.au>; linux-renesas-soc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; Magnus Damm <magnus.damm@gmail.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for cpu devices
>
> Hello!
>
> On 02/08/2019 02:13 PM, Simon Horman wrote:
>
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > This patch defines OOP tables for all CPUs, similarly to
> > what done by Takeshi Kihara and Yoshihiro Kaneko for the
> > R8A77990.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> [...]
> > @@ -55,6 +76,8 @@
> >  power-domains = <&sysc R8A774C0_PD_CA53_CPU0>;
> >  next-level-cache = <&L2_CA53>;
> >  enable-method = "psci";
> > +clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;
>
>    Need space after =...

Doh! Simon, do you want me to send another version to fix both spacing issues?

Thanks,
Fab

>
> > +operating-points-v2 = <&cluster1_opp>;
> >  };
> >
> >  a53_1: cpu@1 {
> > @@ -64,6 +87,8 @@
> >  power-domains = <&sysc R8A774C0_PD_CA53_CPU1>;
> >  next-level-cache = <&L2_CA53>;
> >  enable-method = "psci";
> > +clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;
>
>
>    Here as well...
>
> > +operating-points-v2 = <&cluster1_opp>;
> >  };
> >
> >  L2_CA53: cache-controller-0 {
>
> MBR, Sergei


Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hannawald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
