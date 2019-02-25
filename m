Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682EAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:12:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A00A20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D1gGO4Z5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FGnlZ47F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A00A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XbsXqorzuL3PU4HLPyE64oTFqv7IobQvhu2UIoHsHgg=; b=D1gGO4Z5Digmnv
	gnGstG9g5pLMJ4FhJfOwko3IQmu8ypM00jWVSbOnIDafe8LlGR0Y1lDtGmvNHGgPtPMAva50O+XQj
	q90iWBdn5b/kXBhZqdHlPiNTekco2BExgXm8w2B/ybqvzW+TLARiNUPYZp3vC+VzKhjfYF4qK+k8R
	ET7w9i3FmJRmqYycCYGnLmlwIm3KXXimEHHq+PbMN+6p0/NOKLOh9bBKjrKR+J6edjvKM16Ikh3ED
	e1R0Xixdekl3r9aByXkwKASTaOKWM+KCk3ClqCWgA8T4H5vU22acsvXhTYPzuqi+94xRPgWIfvWry
	PibgY34oijAstEMJCs3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyLfi-00078Y-JR; Mon, 25 Feb 2019 19:12:14 +0000
Received: from mail-eopbgr800051.outbound.protection.outlook.com
 ([40.107.80.51] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyLff-00075M-2g
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 19:12:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMU+oCB2PAMtL5kscTnl0qhkH+DJznTQG3/n3M9paIs=;
 b=FGnlZ47F6jLZPHaBBL7ChNCajW4gkasd5l9isKL4oRKqegCOAhrgPeTeAlYVJtDJirXAF++/6Jk+97Ds7CAzDXyUfm9YRmlrQr+h/O8ktuHDBat8/ggbN24Og2xLk9J8ciMdTc9uu6/FziQUR+uv8wwu1ls60X0P+msuP0u8GwE=
Received: from CY4PR02CA0020.namprd02.prod.outlook.com (2603:10b6:903:18::30)
 by BY2PR02MB1300.namprd02.prod.outlook.com (2a01:111:e400:5854::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.20; Mon, 25 Feb
 2019 19:12:07 +0000
Received: from CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by CY4PR02CA0020.outlook.office365.com
 (2603:10b6:903:18::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.14 via Frontend
 Transport; Mon, 25 Feb 2019 19:12:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT017.mail.protection.outlook.com (10.152.75.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 25 Feb 2019 19:12:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43553
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <hyun.kwon@xilinx.com>)
 id 1gyLfa-00074P-3E; Mon, 25 Feb 2019 11:12:06 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <hyun.kwon@xilinx.com>)
 id 1gyLfU-0005Sl-V8; Mon, 25 Feb 2019 11:12:01 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1PJBuCt005233; 
 Mon, 25 Feb 2019 11:11:56 -0800
Received: from [172.19.2.244] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <hyun.kwon@xilinx.com>)
 id 1gyLfQ-0005RJ-0g; Mon, 25 Feb 2019 11:11:56 -0800
Date: Mon, 25 Feb 2019 11:10:05 -0800
From: Hyun Kwon <hyun.kwon@xilinx.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: soc: xilinx: Add the dt binding for
 Xilinx AI Engine
Message-ID: <20190225191003.GA27978@smtp.xilinx.com>
References: <1548119537-1788-1-git-send-email-hyun.kwon@xilinx.com>
 <20190218211739.GA19490@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218211739.GA19490@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(51914003)(486006)(57986006)(33656002)(44832011)(8936002)(81156014)(81166006)(76176011)(2486003)(23676004)(186003)(9786002)(106466001)(126002)(76506005)(14444005)(5660300002)(63266004)(6916009)(54906003)(77096007)(229853002)(58126008)(26005)(16586007)(6306002)(8676002)(316002)(50466002)(6246003)(478600001)(966005)(11346002)(36386004)(336012)(426003)(356004)(476003)(446003)(2906002)(106002)(4326008)(47776003)(1076003)(305945005)(6666004)(18370500001)(107986001)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR02MB1300; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com; A:1; MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8faf12-4b23-4b02-3c75-08d69b552295
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);
 SRVR:BY2PR02MB1300; 
X-MS-TrafficTypeDiagnostic: BY2PR02MB1300:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1; BY2PR02MB1300;
 20:RruFnoankO2g0TX0YAM4Xv2rVBbpg4GsulABPVTbDNZkk+cP4dJrEYjHfnYBADKoJfcVAvz7d9HUwB8QGVchl6i6H0Hh/mKtwMapieUybYgNNMOjC+Js6Vdo+fAnf4U9KZju3L2Rgn3j9rHTrNiGR5nVcwhqRRb4yhVQyMpgKlKn2Dcl18hx/saGt5TvOo9aSbTG0AQlFYXZveBH8SLYRqj9Dg3dr1PsnR4T8YRwjR1/pW7VCZbyP+g44IUJ31oIElEfzbCHTH0zVHdiSIOAz0A6kdxUJos9BL+uKVWcvwiWvPNiw1TgQU5DfQMzRiQYpHLAbOaA6UBOoEmIOxnOB9H0wTgPe6ZA8UZ+Hqz9rpmwEMcxnNf+bbQSsce/6VU2xlVP3grgVg2OCN/LKgScEmbKRHfzaOJEOATZfjuiuTcUU0j1lpUikySW/gozqX3FaDoGmVGc3mD7lh6b1qUKv7MUmIg1Y6uWyNFBr3KYhhA/Dl5IObK/uMhCGZZXpVH3
X-Microsoft-Antispam-PRVS: <BY2PR02MB1300ABE47B27370E0313A7B7D67A0@BY2PR02MB1300.namprd02.prod.outlook.com>
X-Forefront-PRVS: 095972DF2F
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIxMzAwOzIzOklHbUFXK1VlcG9wRVpUblJ1WVd5d2lYSU5V?=
 =?utf-8?B?WkNGYWtueDhzM09rVHlSVm5oaTJndTFDUWZnZ3FDY1NxWGF4K1VtdWNRL29q?=
 =?utf-8?B?SkpFS3RJeFcxYU5UbmVOOXl5TDdwSFltd01QWThaV2tTK256a2xCbjdFZE83?=
 =?utf-8?B?T1Q3UlMvakFiZTQxd0FMRUZ1VGhRM3ordHMwTWRWMXBUUGJ2Rkt0SFVwMDVP?=
 =?utf-8?B?TWZZUHQ5MmJxTzcxa3g3SmVBM1F2dE82bnBQVHUxUWtkQXdqVXBseWpoR0RE?=
 =?utf-8?B?RXZIOFNQNUJFRmZsNHNka2NtSU9ONFd2NTZodCsrK1FwaFdpUURsOGU0c3Zm?=
 =?utf-8?B?MHBhaEVNbUc2Vi82dG5SQzZwRUhYZ3EvMDlvZDdoN0xVR0h3L2J2aHcvRjZj?=
 =?utf-8?B?Vk9XUjhNRW1mSmhNOTlvZy81NmxVc1U3TFFtS1dVSHZacER2WmRKT1ZraXgr?=
 =?utf-8?B?M3djdVBuKzBqM0FGVmR5ZFFJSFZOTkZxY01XN0lkK0FWa3gyWkNPS2dGQ1lD?=
 =?utf-8?B?OXJnakNRYkNaQnp6V3ZkL2hXYXFYV1JOVTk1b1lmRnJDcnFSalFENGh4TEVN?=
 =?utf-8?B?VHh5QWl2L3IxclplV0p1K0MyYmFRQ3MvMzM3bUVGMGJJNWpmMGV6OXVsYmJR?=
 =?utf-8?B?cXRrL2FqeTMxWkNxZGE3WmdWMkd2YnJVdmEzQXE2UGkvbmhkczM2Ym85R3pa?=
 =?utf-8?B?OGhHeFZnOWdJclJ6c3A1NitWRnM2OWxhbHdLUTlNdk1BZEQzRTdwME5pemg2?=
 =?utf-8?B?RjlYckxjZ0lLZUMxODlnOTBzaWlWZjhjSUEwUWh0RVhBb3l3Q01LQVNEemRm?=
 =?utf-8?B?RURKMU81ckpEampVSTFoUUFTTUJUYVc2M0FlcmN4eFJHM2RjK2toOUdmUk5u?=
 =?utf-8?B?QjlLZGVLeDVhVmgrSFJ1MkxLU2tUTnY2N2Y4MW9RWWU3ZUEyMGRkSUVBWmJi?=
 =?utf-8?B?Z0orQXFVWWxVUXJiOU1jd3RhY2d0TU93Qjh4S2tUVnVhL0VjRHhoSUVzK3ZQ?=
 =?utf-8?B?TVdsYVVjaXNDQVJQRzlXN0RCazdNVmN0RGNTajA4VDFTM0U3cFNqbEttZWNl?=
 =?utf-8?B?Qyt2blJlYzFiRGxCYW10UnR5WkhjTkd2b0VQbUVmczljUVBub1RzRHFobjBr?=
 =?utf-8?B?Q0ZONTVlTXg4Y2VaU0M3ZlZ1eDRWMWw0dC9HN3pUak51VnZMZXFXRU1GS1JF?=
 =?utf-8?B?MW1zaVVrdGlkdkZjOHpDelhZMHNFdW1hWnJjRjZNTFU1YlMwNkNJV3NaUXEz?=
 =?utf-8?B?TXhrUG9mVFNHV3NqYjYrRGZkZ3BNRzJ2SkQxY2hiNWhESkdQa1RBRmtlN2VW?=
 =?utf-8?B?Y0MxdXNJcWF6UFZ6aXRrOTN3Mzl5amJlSmRoWXRkWGZPd2dqV0plaGVKWWRP?=
 =?utf-8?B?QjI1anJjcWdXOUNZTS9zQTNydzdNdFhqekFpWGFqc0Z1QWxCL2JlOHB1aEN4?=
 =?utf-8?B?S0N6NG5GMktuMjlqTW9qWFlPaU9MS29wdWNlTGFLUVRxMXkydy9Uc2JSMzNN?=
 =?utf-8?B?Yk01dllqbmhJQUdSdHByUXlIVGRNQU1FMXdZWVM1eUNvRW5WdGVsSUcrdjBC?=
 =?utf-8?B?VHNvaHlrdUZ4S2dDTjc2cTJsU2RFQlYyUU94dVIxS0tnaDQwWXFKSWVHZEdX?=
 =?utf-8?B?a3FjSnRzaVRsMEtPbFdwYm96cllVRjNlbG9iSVEvNDFoQmc1bmN2QWNFUDhq?=
 =?utf-8?B?Ry9zd0k0MS9QSkdYK0QwMmpoUFRUWFA2RnRHTnJGWDZ5U0lweVJVVmJzK1Rv?=
 =?utf-8?B?SHRlc1VJaERleEFxSWs4UT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: pvSAcP/wGfekYUVMFW3+QHn1DbKLITzyxZqvcKgALdcTfwgtilwFOl602A3PlqXAeuHORm5ebqKEIWeO7WuGHdPzNlQR9/nxT9/9hX+lsnN/azkfCsmNTuDGxQXHMNT3nvE7/yViwD6cYpVYOpQv8vfXzkczsNV2Lffk8AvVFHCHjfGBMSl4rROWg8axBnBChWZ78hTqwCjchThWmy5NOwC4q+WEbFDmrXnsD7FwowsCd2SIUVfnPVlbSFyYpYWVtx3UKdzHdGB4ZnD2NewiTo9MHeLAqQ58xF7AMC8yaZ2f8WRyfVE8H3p4cBArA51PQctlZWt9AanJOjOr2g4wutuecsrfDR3xgIXFCUJW5AVlQlaAixzv9DRS110Ih58owCrdrAwuFioVNExAAPxnF4jEP3H3BfBJkSttK960hEw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2019 19:12:06.5577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8faf12-4b23-4b02-3c75-08d69b552295
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1300
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_111211_156008_17D1796E 
X-CRM114-Status: GOOD (  22.15  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Hyun Kwon <hyunk@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michals@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

Thanks for the review.

On Mon, 2019-02-18 at 13:17:39 -0800, Rob Herring wrote:
> On Mon, Jan 21, 2019 at 05:12:16PM -0800, Hyun Kwon wrote:
> > Add the dt bindings for Xilinx AI Engine, which is a tile processor
> > with many cores. The compatible string, 'xlnx,mathengine' is kept for
> > backward compatibility as it's the legacy name.
> > 
> > Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  .../devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt | 19 +++++++++++++++++++
> >  MAINTAINERS                                           |  5 +++++
> >  2 files changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
> > new file mode 100644
> > index 0000000..fade9d0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
> > @@ -0,0 +1,19 @@
> > +Xilinx AI Engine
> > +----------------
> > +
> > +The Xilinx AI Engine is a tile processor with many cores (up to 400) that
> > +can run in parallel. The data routing between cores is configured through
> > +internal switches, and shim tiles interface with external interconnect, such
> > +as memory or PL.
> > +
> > +Required properties:
> > +
> > +- compatible: Must be "xlnx,ai_engine", or "xlnx,mathengine" for legacy name.
> 
> Use '-' rather than '_'. No legacy names. It didn't reviewed and we're 
> not going to be stuck with it.

Sure will do.

> 
> Only 1 version of the IP? The compatible should be more specific.

I'll confirm on the proper ip version for the string.

> 
> Are details like number of cores discoverable?

No, the information will need to be added. At the moment, this information
is not used in the driver, but it will be needed. It can be either
properties (number of columns / number of rows / shift), or this can be
embedded in compatible string as a device type. The latter may be less
scalable, considering variations including emulation platforms which can
change and so on. Could you please share input on which one would be more
appropriate?

Thanks,
-hyun

> 
> > +- reg: Physical base address and length of the registers set for the device.
> > +
> > +Example:
> > +
> > +	ai_engine@80000000 {
> > +		compatible = "xlnx,ai_engine";
> > +		reg = <0x0 0x80000000 0x0 0x20000000>;
> > +	};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 32d44447..d119d1d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16040,6 +16040,11 @@ F:	Documentation/driver-api/uio-howto.rst
> >  F:	drivers/uio/
> >  F:	include/linux/uio_driver.h
> >  
> > +USERSPACE I/O (UIO) DRIVER FOR XILINX AI ENGINE
> > +M:	Hyun Kwon <hyun.kwon@xilinx.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
> > +
> >  UTIL-LINUX PACKAGE
> >  M:	Karel Zak <kzak@redhat.com>
> >  L:	util-linux@vger.kernel.org
> > -- 
> > 2.7.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
