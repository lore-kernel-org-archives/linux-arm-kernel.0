Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B4DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:20:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E093320645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D7w8hwXx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UrT1FD+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E093320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oOerZWiZZhbPOL/lP6hDz1uPSxccuK2jrdpfgQV/aCw=; b=D7w8hwXx4YgQiL
	nImnTqFbNA2ECkWYxVQxAzByNCDrNfp9NleH+drzmGukZqH6Tppxy2Xa8P+wcDyT99G+4kv5WrZtj
	sZlCimaFRGexBV0wCiznWyvfIJ6NVA94Y3e9BYmM6xUVQJwaavbj90AyjVpJl91hSJcAaARbqnq2Y
	+77OeZWu4H13XYvCKDe4dxCKKC4Cb2d/cvsvdvL6Yaz0jeQKHnIAGJkGatD4EhVfyw9hhVFcoa3wo
	RKFAUUaRBRiGAtH10giQpwG7iaS2vqaWEkYxs2dGO7CI0zxiYGzzCg66coFZ/W4vFj4gH3LC/6u+G
	kSQ6RceF1OPvkNHSboQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjFH4-0005cz-OZ; Tue, 15 Jan 2019 03:20:22 +0000
Received: from mail-db5eur03on060d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::60d]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjFH0-0005cP-LX
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 03:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orcUbwCy7jIjhrYydPW+aabw2XI6AP6PQf7mbli6b5o=;
 b=UrT1FD+Ey0vLzpW+tKYT3qF6nsMpjPeX66tM2N0Q6kXwoE1J4zJmgQKXJnFsDhv8lRkC6j2mgbjsdVi+GDYdLvYeS3MizGA5ONRpKue41yH1mmflmWjL+Pqn1eYmNVhQg3j/5ce7mONiwF/6ZjT1oInr7nFqDqG4ayZsmyoLsNE=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) by
 VI1PR04MB5677.eurprd04.prod.outlook.com (20.178.126.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 03:20:13 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::a13c:ebf5:6fb5:8c7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::a13c:ebf5:6fb5:8c7%2]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 03:20:13 +0000
From: Bharat Bhushan <bharat.bhushan@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] soc: fsl: dpio: fix cpu range check
Thread-Topic: [PATCH] soc: fsl: dpio: fix cpu range check
Thread-Index: AQHUq8eyjXksS82nRkmGUg0ZzKV3DqWvI94AgACF3YA=
Date: Tue, 15 Jan 2019 03:20:13 +0000
Message-ID: <VI1PR04MB4845D340471C4E447A0427479A810@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20190114050237.32140-1-Bharat.Bhushan@nxp.com>
 <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
In-Reply-To: <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.143.254.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5677;
 6:c93kYnH8gz0UNBerx4TER8dyg8no9F0POH3WK3UTeayPVAUKtkYNd+2T4urS1FH+nDbiWKhZKAS7S01ZeajENW99c+usNuCzG4Jj5Ki5Y7KgBmfyUm0y40oc1E+9Tu/LhyV30D/KYWK53RU+IfpuBwpD1SlvbuV51bRfHKduMJNdYWZIMZNt/P4/M8mYHwDJB24QeqwK79yokhMaLjyaOamv1Z5/xIIxreJ80X987/Cya4lYA3mkTFb8UuWI1HiHndklxCC5ZZuwpflAWmuGH6oyidGIXgCNrP9u5rkx+s/7+DCP2mCvvjQ5T48yrpyJjF0COXN+S+ILizt9IxHr6sKa2OATp4uL/RaP0wKD7YSQYprTHM6007RFfoGbqRZGocZldgAfz5N2naAtRlbNWdJbqBweg+pbGlGPkHXMmlRrfoMaCKpOjYC7mZOetwjXI8gdns48i4K6rbqvh9PwhA==;
 5:HbLfGb1+XD5wIoGFWn/r6GapeI/C2L8uNTez15f3wNwWDhINZVkfSe2q556Zc/iIZHd8E+0W0ZCWz+y9YogA9Zxy+72uDCkQZ8PiSOFxDTattBGJsYKw2Ou08/7V+blvue2291qbBzaPVoWk8N4NL1AtI4dnG5x+zol6lSc7bY9vCB1GszmZw0xHPrdSlbsT7+91MxqjaO/dxcdB4BSHJQ==;
 7:JFFb7f/WJPQycuLSyalFB4H0ZnuEjKTmBYkAkeyanoq6tYUMjqsGBpeAaHdnsV97LzMTlOzry1VzWRtXUvLWnDaaX6MkcyldHIgkKulQ8HqeU7IVDiBFEfRWlpKs5KCrA3vetBMpdKYwQsTRNt6TUw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5e8d073e-d7cd-408d-4e98-08d67a985d48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5677; 
x-ms-traffictypediagnostic: VI1PR04MB5677:
x-microsoft-antispam-prvs: <VI1PR04MB5677EE908D4250AA669F6D859A810@VI1PR04MB5677.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(13464003)(199004)(7736002)(81166006)(39060400002)(97736004)(305945005)(8676002)(478600001)(66066001)(14454004)(26005)(186003)(6246003)(14444005)(81156014)(4326008)(6862004)(2906002)(44832011)(256004)(99286004)(86362001)(53936002)(6306002)(54906003)(9686003)(486006)(316002)(8936002)(7696005)(55016002)(229853002)(6636002)(446003)(105586002)(45080400002)(68736007)(106356001)(78486014)(11346002)(476003)(33656002)(76176011)(71190400001)(5660300001)(71200400001)(966005)(55236004)(6506007)(102836004)(53546011)(3846002)(25786009)(74316002)(6116002)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5677;
 H:VI1PR04MB4845.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1wik/Lj1VnF84PW/5Siu3dpyu1FnjAsaaDnhDUsopQ53PeoPMvwevyKuC4eYLO/9OINuOzpf8H3dWgvq4A6X+8VT59sGhjZgzFEyEw/IL2JgRt3xjURv/9OrF/HTDbzNNAjq+Tm1XpylLTpgxIiq0RxMlgH3wIM74m1kcAByNIMX9ZKjuyCk0mzQL8EuhA0yXRAREZXc6xXLLodqTctncMa+8Sb5mwhehpCFgrF+oezrR1LsqoVVbaJQRpvdnrFuZaq3vIwCnY729CQ74TXf+2QAFdeV1dyFdNO3HfI6z9xGR599lIoeqi27Ywpbis0Ei+VbXeJd7X7j55PXaIUv8LJ25SZpznu2Bok/m1t/kcdJCSXU7aLazn1RR71VW2Jsz+Ad6NsYICNMHVA6dGbjaTw60gTSjpJrtnSOuj/hevQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8d073e-d7cd-408d-4e98-08d67a985d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 03:20:13.7203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5677
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_192018_711094_31689028 
X-CRM114-Status: GOOD (  20.99  )
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
Cc: Roy Pledge <roy.pledge@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Li Yang <leoyang.li@nxp.com>
> Sent: Tuesday, January 15, 2019 12:47 AM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>
> Cc: Roy Pledge <roy.pledge@nxp.com>; linux-kernel@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> bharatb.yadav@gmail.com
> Subject: Re: [PATCH] soc: fsl: dpio: fix cpu range check
> 
> On Sun, Jan 13, 2019 at 11:13 PM Bharat Bhushan
> <bharat.bhushan@nxp.com> wrote:
> >
> > cpu_possible(cpu) will always return true when cpu parameter is from
> > cpumask_next().
> > Check for nr_cpu_ids rather than !cpu_possible(cpu).
> 
> There is another patch pending merge seems to cover this issue too.
> Please let me know if it doesn't.
> 
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flor
> e.kernel.org%2Fpatchwork%2Fpatch%2F1020905%2F&amp;data=02%7C01%
> 7Cbharat.bhushan%40nxp.com%7C47af6861c3f84094434c08d67a54e1c4%7C6
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636830902314446677&amp
> ;sdata=wLPuMGosXOT48Gm9K%2FBjm1IRbGQEWR4D%2FSqRt0I0XyE%3D&a
> mp;reserved=0

Description and intention of the patch was to fix some other issue but this also fixes the cpu range check issue in my patch.
My patch can be ignored.

Thanks
-Bharat

> 
> Leo
> >
> > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > ---
> >  drivers/soc/fsl/dpio/dpio-driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/fsl/dpio/dpio-driver.c
> > b/drivers/soc/fsl/dpio/dpio-driver.c
> > index e58fcc9096e8..eb369dd9e0a7 100644
> > --- a/drivers/soc/fsl/dpio/dpio-driver.c
> > +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> > @@ -133,7 +133,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device
> *dpio_dev)
> >         else
> >                 next_cpu = cpumask_next(next_cpu, cpu_online_mask);
> >
> > -       if (!cpu_possible(next_cpu)) {
> > +       if (next_cpu >= nr_cpu_ids) {
> >                 dev_err(dev, "probe failed. Number of DPIOs exceeds
> NR_CPUS.\n");
> >                 err = -ERANGE;
> >                 goto err_allocate_irqs;
> > --
> > 2.20.1
> >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
