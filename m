Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C7EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:41:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26122087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ifKIkfnX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="l4MbR00t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26122087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FoP1L+NhmzEMX0UjbiY7hpJnBIwSuHxb9Xrgka7KhMs=; b=ifKIkfnXlvio5K
	DiN96eAm6joR7efFIsouei8ZqTEqqdpQ949wif/1qd/3WaVwTdp2LWzplyYGJgXmyobdrq5MLaGzp
	7Pr5U2VIHm55wo+8reKXkt16/a/xr6MIF6gBS3yvT328aIUwv9Rnp1XkUgwBsi9HrV5xw8BKE370I
	YzxSBZ7z3GIRXk4bZFF4R1d4RekwheyZtaQHaz9vTIjxuuzQpwZtcD2IGBV94Dbkm9satWEGnwO9U
	Ul6Fw9ng3pwytEB9sFI34RZB+StChMCovfNa/NIQdMIvdQYSEoEpUUmYF6/qPr8nRtjt44k/D+reX
	qjX0G3EISqiapUXWZ9sQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goaBv-0002SI-BY; Tue, 29 Jan 2019 20:41:07 +0000
Received: from mail-dm3nam03on0616.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::616]
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goaAy-0000xp-Se
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 20:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysLSnnGPWm8C3buRpsePcHQIvj4dmhJCFcXGoKTJrJE=;
 b=l4MbR00tOR1mx+SbTn4ECuaEXsPabzRKVGRuyIpyfpxojOeV6GDuS6+3hOZgJXACi3husqyVXd9RSf2nGnMvxz0k7JdWOc3PoNORg2RJ1scLTmW1m5JAW3+RyDFWgY5i+dBdZz8puZ/MFHJBsJhX7/Kb/6c2nXm276y+Yups9oU=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB3959.namprd02.prod.outlook.com (20.176.248.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 20:40:04 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1%2]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 20:40:04 +0000
From: Jolly Shah <JOLLYS@xilinx.com>
To: Michal Simek <michals@xilinx.com>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "andy.gross@linaro.org" <andy.gross@linaro.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "geert+renesas@glider.be"
 <geert+renesas@glider.be>, "bjorn.andersson@linaro.org"
 <bjorn.andersson@linaro.org>, "sean.wang@mediatek.com"
 <sean.wang@mediatek.com>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, Michal Simek <michals@xilinx.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>
Subject: RE: [PATCH v5 2/3] firmware: xilinx: Implement ZynqMP power
 management APIs
Thread-Topic: [PATCH v5 2/3] firmware: xilinx: Implement ZynqMP power
 management APIs
Thread-Index: AQHUrD6mdAof5ly9qEGscyOgLDHLxqXGT7WAgAB9SRA=
Date: Tue, 29 Jan 2019 20:40:04 +0000
Message-ID: <BYAPR02MB59921AA0C4ADDC078FA28BE3B8970@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
 <1547493778-22720-3-git-send-email-jollys@xilinx.com>
 <e4b34ee3-49ba-8b6e-76ad-69bf078a8256@xilinx.com>
In-Reply-To: <e4b34ee3-49ba-8b6e-76ad-69bf078a8256@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BYAPR02MB3959;
 6:T/IRzfAGX8CIEmuzTLA1WYb7ak08sc3eJrj8UXkph84vAzdXkVFnkOpIRkQjyj7QRNN5wWoINs4P4L6r5jBnKwsg/+ihq8xUU/OGOYbkkoBz3ZD7yLHYIOfXnVPhMwsj8+OwDtiU8Fc4M2yZuupXSXlGJ4dvlQpS5e9MxeqMVrhouY/y/DDKbY2jh1lYV9rdyqSjSeqK92qQGfW/yr2zMZmN7VKejb6G/BRQlVzIMzl5gUPSH/+r6qxoL9pllmBS1VzhmZkSEyPU2qItULARJUAJSTZW2lAUBX2MA6kOiSyqc66IJdQkoX699AiuSPwxb3t+WCggdMTBgC9nY/WaKvrGcmvVIRCEoTU35SmpCCN3ORYQHC1O5seVH4EA2GBXpl9rUmREDdF8tQ92ZBpxQhq8HiA/0DcWIZp5ak+ekwJn3x9MRgkdqZXqsYJ6snFk7iKIB87pRPDtW9S4221eng==;
 5:iZaUaK+H00uvdgcrIn0iDS1S8TFm9ylIrnF6yHRFDyNQ1n4Ul9eHvVevpnlv6W4e2Ka6v1IJwhWys8dY/QeWWnc/vY6VEw1J75HIxt94b2gwbUQtcCO+z1sLfRVJDRyEglZ2SpS6AFZFs3+GuHI1Axa0s2mWORO1Vl7iLWepU8vm/aq1eezuuNR2//m0D0lSJqG23zl+p++NrZ2tPjAT/w==;
 7:59C4gCShb/kGfX7GMJg1ZV/DaELjOdPYnRZP8A76I3JcYtjWXdDWYOhsFgsO1L28H+D42gzxiB4FzR3MT5lAuxfo4kLTakNgRDLAorUB0Ljp6hxr2I6CIZNezJlJoBvx0JhdjJ0iMZVRVGjih12Byw==
x-ms-office365-filtering-correlation-id: 6a0568aa-4d20-4e38-668f-08d68629f2a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR02MB3959; 
x-ms-traffictypediagnostic: BYAPR02MB3959:
x-microsoft-antispam-prvs: <BYAPR02MB39595747A033AD5DD8AFD8EAB8970@BYAPR02MB3959.namprd02.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(13464003)(189003)(8676002)(66066001)(486006)(2501003)(6436002)(86362001)(74316002)(99286004)(256004)(229853002)(14444005)(102836004)(76176011)(53546011)(71200400001)(8936002)(26005)(7696005)(71190400001)(6506007)(2201001)(186003)(476003)(446003)(14454004)(11346002)(39060400002)(478600001)(6116002)(305945005)(107886003)(54906003)(7736002)(25786009)(3846002)(68736007)(4326008)(106356001)(55016002)(53936002)(7416002)(72206003)(33656002)(966005)(316002)(110136005)(2906002)(9686003)(6306002)(105586002)(81166006)(6246003)(81156014)(97736004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB3959;
 H:BYAPR02MB5992.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QjuQjpJX7NEiqVqS123WolFqQBzY94E4IGwLc0MdwzPgUMf+45qIu1dhDPsS13TOE5SaQP60/b6Uv0e15dazVckXsA3YlYYKg9GWTZFTvJ6Q/VDgdOCHctEGJdfn/7e2VpnnrhPKt+UH7QyKT8K4zJg1RR7xGJ1HdqtO7clXZV31NVdGlhp8qeEwyh3dl9ofwGvMbJhKfIpKh8IgSV8OcSSceqvO6NV+BY+vt/FgDxzuuC7q5BVwy2GWkUixqh1P+/+Lgiujqumk20XE1b9VJG+1he1A2z//L9v7/YvWZDsa5cGmoyAwndNFneBIOX/KAJ4DGgLr/JWK8VvzUGV+mJCGYDg41RdKuyuX70rFM5AbRINMVf+EU7YitHBXeQfuaFptjvLWHGdZ7h7wKQOclcOidDlt+jLUXxbKrrRTRNE=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0568aa-4d20-4e38-668f-08d68629f2a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 20:40:04.1172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_124009_890849_C5510E79 
X-CRM114-Status: GOOD (  18.71  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rajan Vaja <RAJANV@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Michal,

> -----Original Message-----
> From: Michal Simek [mailto:michal.simek@xilinx.com]
> Sent: Tuesday, January 29, 2019 5:11 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; matthias.bgg@gmail.com;
> andy.gross@linaro.org; shawnguo@kernel.org; geert+renesas@glider.be;
> bjorn.andersson@linaro.org; sean.wang@mediatek.com;
> m.szyprowski@samsung.com; Michal Simek <michals@xilinx.com>;
> robh+dt@kernel.org; mark.rutland@arm.com
> Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v5 2/3] firmware: xilinx: Implement ZynqMP power
> management APIs
> 
> On 14. 01. 19 20:22, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> >
> > Add Xilinx ZynqMP firmware APIs to set suspend mode
> > and inform firmware that master has initialized its
> > own power management.
> >
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  drivers/firmware/xilinx/zynqmp.c     | 29 +++++++++++++++++++++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
> >  2 files changed, 49 insertions(+)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> b/drivers/firmware/xilinx/zynqmp.c
> > index 84b3fd2..c7a3b6c 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -428,6 +428,33 @@ static int zynqmp_pm_clock_getparent(u32 clock_id,
> u32 *parent_id)
> >  	return ret;
> >  }
> >
> > +/**
> > + * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
> > + *			       master has initialized its own power management
> > + *
> > + * This API function is to be used for notify the power management controller
> > + * about the completed power management initialization.
> > + *
> > + * Return: Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_init_finalize(void)
> > +{
> > +	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
> > +}
> > +
> > +/**
> > + * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
> > + * @mode:	Mode to set for system suspend
> > + *
> > + * This API function is used to set mode of system suspend.
> > + *
> > + * Return: Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_set_suspend_mode(u32 mode)
> > +{
> > +	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0,
> NULL);
> > +}
> > +
> >  static const struct zynqmp_eemi_ops eemi_ops = {
> >  	.get_api_version = zynqmp_pm_get_api_version,
> >  	.query_data = zynqmp_pm_query_data,
> > @@ -440,6 +467,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
> >  	.clock_getrate = zynqmp_pm_clock_getrate,
> >  	.clock_setparent = zynqmp_pm_clock_setparent,
> >  	.clock_getparent = zynqmp_pm_clock_getparent,
> > +	.init_finalize = zynqmp_pm_init_finalize,
> > +	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
> 
> This has been created long time ago and there was one more patch in the
> middle of this.
> I have applied reset driver just now which didn't have any issue that's
> why please rebase your patches on the top of this branch
> https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc and resend.
> 

Rebased and sent v6.

Thanks,
Jolly Shah

> Thanks,
> Michal
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
