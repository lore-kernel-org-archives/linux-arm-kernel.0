Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:31:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061762082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qDFN8Hxa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lzBf/WFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061762082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cXPY9MyN/M/cqh7MZR4hJgoWttSO6JQ/+9hZF8Q0mNg=; b=qDFN8Hxaq4KL9y
	tFwmDv6QBAIUBFIMf1mm7dvq5gCd6wsnxmO0wpRAkiUAo5pSh9yQooga+NduEaIUqCt90ejttdeHc
	HWTQBX3NAQsisdS3QyjSsHbEtoI3X1CQSHIaZpppjyoZQj9eaXxxebAz+t+yEH+FDVgzN6dlu6LA0
	ntnxuBcK+It+tBaIgjTL28hHTC44SYFA+My6e9XXCPDOQvaRV7b6ij7x/Lf9cwVj9Fqilmx9KGKcg
	+m4BRGug4ejZd6zhXmrg5IxK7V2iUCeve1ZEHifgik3aPMlMJvMhVZLHCE93jKqyM0uN6xde7vz75
	zHoPmqz41SqP+/2H4vwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjp2j-0001O0-IQ; Wed, 16 Jan 2019 17:31:57 +0000
Received: from mail-am5eur02on0608.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::608]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjp2d-0001NF-8U
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4roUDKUCNg0eKoLtKsa3IEw651nJRge5sRyGmhH3Xic=;
 b=lzBf/WFEiYVlvHSx6R0kKwX/0bCI+cQ9asaHA0c696MzhlLsXcF5K3rfm+BxpI8Zm+5VFLcQIP1n87cX23cS+hPBjp7uTcF85tRzoNKEiZmeTRhbncG5ZYGCWdyP5rjmcGXUMblqDKvJA0guftUItRPy+KTa9pkFuT8V7qD2K58=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3581.eurprd04.prod.outlook.com (52.134.4.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 17:31:46 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426%7]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 17:31:46 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2 platforms
Thread-Topic: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Index: AQHUmUIyF6ylLjPS3UibJyYT5PgWG6WrD8gAgAbCicCAAA9NgIAAALAAgABrd1A=
Date: Wed, 16 Jan 2019 17:31:46 +0000
Message-ID: <VI1PR0402MB2800477D1F1FE0E78F1D8D33E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
 <20190112024725.GO32649@dragon>
 <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <20190116105559.GM15808@dragon>
 <VI1PR0402MB28007817A29E6116D1FAFC2BE0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB28007817A29E6116D1FAFC2BE0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3581;
 6:bq2NYa9E/UUBNquVH30y0OtgAqL+3IY62KI9YMNVbAh3Wl3T9Y0HhYPU5Fmo35h4oVgxEjbCl/J58KLJUEvcU5ZfsYRx8qrN4yFFhuRI2KEGisjaQVM84o8meRifY3h4RqpK+z6qiQMI1o7zKj3yAru9B9H4s0ghGvTE1FeDhMJMZyc3HaS7eui0+McT350UY2bQyqmgY0E6LWlhFAeRpVSsx7hVyPNxwHQPAwHvodP5zRxmi4PlxrMJRBMaxz7UPkzIZbXOjvDWe8WW3zTkEV6R4JzwfV/6GASyNtdEtGicd6TmIgVRn8AtShnhelUgn21UOonEyCXMaQcuJYSrPWBNjNyRKbL2s+fW6XOE6z6kl1Ndt0/cwwQlCh4ASpIdt2PJCLYXTN0lLXEnAVaauNhEuM3817VrqvfvDmrVa76oCXxZLuzWtrovSdOVhRUpiGlpM4XmwPQYYdBE3YK/Qw==;
 5:ue32SDocRK1H3p6EEiaDkUJ3Pqo7WhfyTtOx75WqKnWmCpnVFGJpwZo6aEcBx/9aaZWnwdxGmL1wTTOLt2xPqOZHlr+KszVY0HsvuNoukFtpUM/aPvsxDzLqZIRP00bCPozWXn+hf62INvUDFRMKEO1kVegglF6I4B6IJlvN1ASdp24JqSqb5dm/uSWaAcVezVhMPPcXzWMBq9tYTc2Dvw==;
 7:gSsl4tyGK3J4rqzyftIU2pXJV4mEMOCIZEw6VktITIWJj3kTmbDbXupMQNsJ5ipiDRLMhQ1SMTvZpVS4CbDbvcJW98p6MSCwiyRG/dLRiwCy5M6uKNZBiJ6SoinVA2sr6TQ9pH+K7sG1anPddSCZQg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 87a993c5-19aa-4c6e-46e1-08d67bd87d4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3581; 
x-ms-traffictypediagnostic: VI1PR0402MB3581:
x-microsoft-antispam-prvs: <VI1PR0402MB3581FF13D7A48E6CCF24DDC8E0820@VI1PR0402MB3581.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(93886005)(106356001)(8936002)(105586002)(74316002)(97736004)(5660300001)(6916009)(7736002)(486006)(44832011)(81156014)(8676002)(305945005)(68736007)(81166006)(2940100002)(316002)(446003)(476003)(54906003)(478600001)(99286004)(14454004)(25786009)(4326008)(186003)(26005)(9686003)(102836004)(76176011)(6246003)(2906002)(7696005)(11346002)(229853002)(6506007)(3846002)(6436002)(93156006)(256004)(71190400001)(55016002)(33656002)(71200400001)(53936002)(6116002)(66066001)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3581;
 H:VI1PR0402MB2800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IoBcJsZR6UcZCpECh+fV0rx6JpfN2AkDUnLqAne6XJRLTRsXjufyzIE97lztAwXHUsQrGCWRpu4R0lXjMVYwNANLU78m+TRVeFem7VV1g4OFF0IAZiSewB2Seyrso88HBfmup1kFfrqcBUX7MNoCnZRYSbtY5Cg615C99CNeW0HwYXTpC6rlcovdGiFo0uBJmPj8kjsq7CQbiYnAaAtwIhX40s2yNNa6xYrjfo99SPNyh7F5BdLqlPjlNaqFw91E7JGVUy2trjrvT2fHtjfvg405hc89r0EQpDav3s/KRt0TS0+eysBlCIk9/WYgDOMUVW+ctVokAYSXG81z5Uy8JWeEyeragk0t/ItpyXo/rom9kb8zeI5YH/90PADylAJHhfXDQOQBrO6RFK4MRGiswF1vDkN9f/yq9yydizrZb9Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a993c5-19aa-4c6e-46e1-08d67bd87d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 17:31:46.3352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3581
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_093153_922149_22EF88E8 
X-CRM114-Status: GOOD (  17.06  )
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
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
> > platforms
> >
> > On Wed, Jan 16, 2019 at 10:02:01AM +0000, Ioana Ciornei wrote:
> > > > Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for
> > > > DPAA2 platforms
> > > >
> > > > On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> > > > > Add the dpaa2-console device tree node for the following
> > > > > DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> > > > >
> > > > > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > > >
> > > > DTS patch generally goes to the last in a series.
> > >
> > > Should I resend this with the DTS patch the last?
> >
> > You do not have to resend the series only for this.  It's pretty much
> > a suggestion for future posting.
> 

One more thing, do you have any other feedback on the DTS part?
I think the best path for this patch set is through Leo's fsl soc tree but of course we need an ack from the DTS part also.

Thanks,
Ioana

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
