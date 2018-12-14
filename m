Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1048CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:13:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4427C206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JIBbLzSl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jUa8sDPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4427C206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KeGJ3wxzM+Fe1zbeGe1aR1cuArE/xG2KY43mWyaWha4=; b=JIBbLzSl6wjpod
	Esnej8AMcG1IvpBaqO75EfNvFxEb5xye0evRn5s693qMRcM73+Xdz/5xErU3WG5imDPMAtw9qHWDr
	1NxuV5x1b0n7v8lrUVbBuwKdjJcGr0/tKE1iAey+CSxEYwspupuhJFA9Dh545b4lmk280CZZoAiMH
	cvp6MhCe3Xfv0P2h4gmfib04BRCVvj3EGryTRCWzoVqooCdUmhBCbskz/q3m4HGKOthpjy9DjS5vl
	EHgJL6hFgyI4by8yi15MPoXjbwH9BgjpMUhj99Nl+hFoVG0K0jeOlwJdtouMMYNbTiJoQe7nB03rj
	ufDC+DEx5uqEGZtYOa9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXryC-00084W-Kw; Fri, 14 Dec 2018 18:13:52 +0000
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXry9-00082m-JE
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 18:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I36r68iRC0VdrEEy8uo+FfYZd7G+d07ZzE69C8Q6zCY=;
 b=jUa8sDPHzGv0OV52v7dYGW2ksDXl39DD9gAPxgiAKD4BALR9Sc4ZxJ9CuuQhnCdSCmhiO9zmXGzmgyt+lddTAd3LsJgnPcyF3qob0U50gOv+oCzCtDxar5zgI5w/5zVuHXOOswHJlUDpCV/yWy6BCL0V48k9yOs6T4hYKOX7sg0=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB1166.eurprd08.prod.outlook.com (10.166.45.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 18:13:33 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b%4]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 18:13:33 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Dave P Martin <Dave.Martin@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Topic: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Index: AQHUkYd5TQtknm9R4kqjkh+b7I8GJaV+jmIA
Date: Fri, 14 Dec 2018 18:13:33 +0000
Message-ID: <2abbbd29-cc87-a0ad-80b7-e2a1d039235e@arm.com>
References: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWXP265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::22) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR08MB1166;
 6:giNZeqXKpYI610PozUq2Fp12YZPRjuTWCcoQSi05RHac7JdRZIyO1r/MX8ed1xN1rzTd2xo/ZboONxufhSgSoBi6UqqXwbohEvFjNGe3C335BVWIoMeWjthVrtpkCzJCFNvS1CGZWajKOmSwkVwx7hgG/dSTgS6G1PM+5qJYlMx1BYE2Mg+Ntam+67IWs1aSgwIYT6eHjSOBExXMPAsJWNpZ5DoFkQ32V/PRS8ZaQuzEmXRhD1fjdKE/ZIBjNz0YFbdY0kPh/Ou1hKLVHb9KI5hNi9tfahpulzhvtxVq2+EZY19fHzi/9abDkubFl8fNB+ZNoKB0a4tX3NcZdX4VSDE4+dtbF+KRsjzJR6nz8UVRI0Vw0WdEg4wgASyzqJm24NJuL7VMVoQdWrPPgxci7+ZaIsGoP7+QpwaiEdTPKWsIf1Mu2q/2sx4SKtRRCE4Vf0L0K6+Osfyd2Gaem5IRMA==;
 5:L9yRDQhvBTjFvArFGFoxkperyQFR1kN3weAVhyDlCGfwG1QAIIM6yDkDN6Z4t2MnK9yPTmycMCCvaeKfVmZJk2G3+pVpGqnE3Dp867iZl765jte+qefwsYnIAexmhFMpz9JuGDQq/D3+Lbwvch5JhJHR5vllmKTKJLwdvdlEKoU=;
 7:kIFtba4+H2L+Ie1N09f3vLqUQdSJ7y8Xa888FMT8KncwIDmrzhxmBv3Nf24VTrQtwZcusnplpBbVze9SNonFlc2z/ykQ7U1kpz1+wdlF1r4l8SYsyXIEmXdg2Gp3CtgSXbjpFCQbn3pkAL4hlD2JeQ==
x-ms-office365-filtering-correlation-id: 02535d37-92bb-46c1-7ea1-08d661efdbcf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB1166; 
x-ms-traffictypediagnostic: VI1PR08MB1166:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB1166D212206CC9316022DAA9EDA10@VI1PR08MB1166.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR08MB1166; BCL:0; PCL:0; RULEID:; SRVR:VI1PR08MB1166; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39850400004)(396003)(136003)(366004)(199004)(189003)(229853002)(99286004)(256004)(66066001)(6436002)(4326008)(478600001)(2501003)(316002)(31686004)(6306002)(31696002)(71200400001)(6512007)(6116002)(71190400001)(64126003)(3846002)(86362001)(97736004)(6246003)(68736007)(53936002)(386003)(76176011)(486006)(2906002)(44832011)(52116002)(14454004)(53546011)(186003)(102836004)(6506007)(476003)(7736002)(5660300001)(26005)(65826007)(110136005)(72206003)(54906003)(6486002)(58126008)(81156014)(81166006)(305945005)(25786009)(106356001)(36756003)(446003)(11346002)(2616005)(105586002)(966005)(65956001)(8676002)(65806001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB1166;
 H:VI1PR08MB4223.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GKag8AprYZRIVTqCYP3KGWdlvCHygZI9lMV1VKgnz+lSeTBCEnC7BObwoKWwbDhQ7OW+OIJHKOHVk5bY6kKFuDDyeg8e/gGKsDiMGQqWyXXnzJkRESUtqQGKsaiVlDmyzU+WenOIOtTnFfYQIrXc2am5R7pEoi7Y3pAoX02xNZi8H6XvGYOEV+sgDZTKbslc85bKpPkTdbwH4NfPEZNRVeq5Tzeh2xNGlF7qpftdTlvawpentU4lMkSu8pFHCL8CABGkjaLhfS7NpvgQVjlLOpR64JBDNLf+noK2l7qLkq1J7jFv3GhfFDnbcx16hqE5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <33BB7223C491A2468BFCF54FDCEA69A2@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02535d37-92bb-46c1-7ea1-08d661efdbcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 18:13:33.5472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB1166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_101349_629797_A32D0574 
X-CRM114-Status: GOOD (  16.70  )
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
Cc: nd <nd@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alan Hayward <Alan.Hayward@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/12/2018 19:26, Dave Martin wrote:
> This patch refactors the UAPI header definitions for the Arm SVE
> extension to avoid multiple-definition problems when userspace mixes its
> own sigcontext.h definitions with the kernel's ptrace.h (which is
> apparently routine).
> 
> A common backend header is created to hold common definitions, suitably
> namespaced, and with an appropriate header guard.
> 
> See the commit message in patch 3 for further explanation of why this
> is needed.
> 
> Because of the non-trivial header guard in the new sve_context.h, patch
> 1 adds support to headers_install.sh to munge #if defined(_UAPI_FOO) in
> a similar way to the current handling of #ifndef _UAPI_FOO.
> 

thanks for doing this.

the patches fix the gdb build issue on musl libc with an
additional gdb patch:
https://sourceware.org/ml/gdb-patches/2018-12/msg00152.html
(in userspace i'd expect users relying on signal.h providing
whatever is in asm/sigcontext.h.)

i think sve_context.h could be made to work with direct include,
even if that's not useful because there is no public api there.
(and then you dont need the first patch)

> Dave Martin (3):
>   kbuild: install_headers.sh: Strip _UAPI from #if-defined() guards
>   arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
>   arm64/sve: Disentangle <uapi/asm/ptrace.h> from
>     <uapi/asm/sigcontext.h>
> 
>  arch/arm64/include/uapi/asm/ptrace.h      | 39 ++++++++++-----------
>  arch/arm64/include/uapi/asm/sigcontext.h  | 56 +++++++++++++++----------------
>  arch/arm64/include/uapi/asm/sve_context.h | 50 +++++++++++++++++++++++++++
>  scripts/headers_install.sh                |  1 +
>  4 files changed, 97 insertions(+), 49 deletions(-)
>  create mode 100644 arch/arm64/include/uapi/asm/sve_context.h
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
