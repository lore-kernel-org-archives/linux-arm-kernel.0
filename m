Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF62DC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:37:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1822218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RURaEzwU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="LqxiRul4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1822218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Content-ID:
	In-Reply-To:References:Message-ID:Date:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9os+T1gMQ5OoaH0ybjW/vvAFGUTLr0AqkkrdlMs6CE8=; b=RURaEzwUsFpwiX
	SXG6iJlF7zJenSPA1iKMRag0pbv+nsdqmH+hyzzGGZMrJlK9Io0qcN1wDU/y2lVAr/xrYzl6jQgYH
	TBDNpN+Em5aUEJmdLqzHkz84oZGINr3cG/xoQzI4fVHhPDp9fbuLm6OYCHWJcmr0nmoFSeSDVsnmd
	PQ7iolLf5jX0q/O922CUsXhVxxScqiPHLik2AFnaAMfBuMVKmu7cVQXMM84vhX7fuUnOASglGx76o
	Ha4d7sL53RitNlC8LZaxPWSfSiRZN/boVr8fLMrAnFEqPzmDMNLMuv/RvPY3uhGrLmPOfiBiIBKRZ
	aUlxOmEZ5iJ+iLa5Io5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpcl2-0001Uc-9y; Fri, 01 Feb 2019 17:37:40 +0000
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]
 helo=mx0b-00010702.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpcky-0001Tu-BX
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 17:37:38 +0000
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
 by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x11HWbmF031188; Fri, 1 Feb 2019 11:36:54 -0600
Authentication-Results: ppops.net;
 dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam03-co1-obe.outbound.protection.outlook.com
 (mail-co1nam03lp2051.outbound.protection.outlook.com [104.47.40.51])
 by mx0a-00010702.pphosted.com with ESMTP id 2qc1m64t0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Feb 2019 11:36:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUG9bxXp3j5/Zlzk0MW/QeS78gb1kkQVKhuBNOPzayE=;
 b=LqxiRul44xzR/MJZpR6TnGD6h7R68v5xkHeD3mv0kmEd15ZMgLFRj8RCfpC5mgJygRCaQ667/1nyrla1+Hg8x6j+xnw4uwl0RU9ZzXxB8TYhPTzzR0ET3c1dMQ22faySsxUzJ6sfAuuxB9cBvUAjBuXr37x77LBMv7Ykv9lNpjA=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB0405.namprd04.prod.outlook.com (10.173.199.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 17:36:52 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f%6]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 17:36:52 +0000
From: Julia Cartwright <julia@ni.com>
To: Julien Grall <julien.grall@arm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/3] KVM: arm/arm64: vgic: Make
 vgic_irq->irq_lock a raw_spinlock
Thread-Index: AQHUulS3ozkeZJl0akizUjBTsERiAQ==
Date: Fri, 1 Feb 2019 17:36:51 +0000
Message-ID: <20190201173650.GC29111@jcartwri.amer.corp.natinst.com>
References: <1546873577-13895-1-git-send-email-julien.thierry@arm.com>
 <1546873577-13895-2-git-send-email-julien.thierry@arm.com>
 <fa628aae-68eb-7140-0533-367cafa26ed6@arm.com>
In-Reply-To: <fa628aae-68eb-7140-0533-367cafa26ed6@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0057.namprd02.prod.outlook.com
 (2603:10b6:803:20::19) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.151]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR04MB0405;
 6:Bj4HmGLdkVnBoSNGtzik96edGN9T4QSS1rklhz4wkmNWF4htuKV5PWbiVqHxYR4DDkeZVUz88Yqj6bW3WnWrDJdekSlD9W+RaCPoVzlo3OX/8slnDu7ANj+tkNj8PvHZ6p3fpvHMiu2+0yxsW8CoKNVXQPnmg18K/Ql/wZD+6a/wsFyghscmlQ/fFzdQ3DmVEgd49P2qiHqYt265jAw4f+hcagdfYLRKYEY4NFM7+/HMEuMSaqS9rE4JIvk3JUE7VvxZhCvy3Rok0FR/NHu7bWUEPXg/IBVI8XaJUjSXT1zIApHHA/vwvkaryNECqa3FQOrZzavoOhaqghKpjMo+SL/qfOaZ+YUqvID5vBXjsrmKX8z4Zkt9Ro7sXfzfcHFYwfAv43DlfNZnPgmyoR1ISrOgVQhuxrgMKPD+XcsPr8LPg80GqRl0yBlK1V+8vMULUGoF7UHiR3otqMp/m4t/OQ==;
 5:2Ur2N3uqIj3HfIbi5ecw/FDgupicYU4AcVhbejfmuLCcc5qWRTa56v4BZzuOu91+feEBPG8QDS4UtuT1HutcoL6QXAIZARxHq9ney48xNbr2/zwQj9UXNGBdF91dbx2WayWdkLNduIOShiwKAwXwIRtDYQxB1nbeNq/vCAdBSqIMCjDCWGgbNwD4yaYGuTVbwUwrkwXSRIt8Ll/1+0m64Q==;
 7:0ObvD4M3jl14b2cgKPaCmD9Lqp4VojetldcYMOuAGpnjRtbyfZ5PyoFGpmHni5gjAGgq2bioUTblVqPqt37mREZC231WVIFSwVbjFIIFXeu/cpGospMKn4J/PC/zuSEsmlm6TgRWbH74lOw+YNMsqA==
x-ms-office365-filtering-correlation-id: d8f0b6a1-6561-4c51-ab01-08d6886bd9bb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR04MB0405; 
x-ms-traffictypediagnostic: BN6PR04MB0405:
x-microsoft-antispam-prvs: <BN6PR04MB0405DBAF0CB47FEFC4F8D275F4920@BN6PR04MB0405.namprd04.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(136003)(396003)(366004)(376002)(189003)(199004)(229853002)(8936002)(81156014)(52116002)(81166006)(8676002)(7736002)(305945005)(76176011)(33896004)(105586002)(14454004)(1076003)(66066001)(71200400001)(53936002)(186003)(71190400001)(386003)(53546011)(6506007)(486006)(26005)(6246003)(256004)(11346002)(14444005)(446003)(6116002)(3846002)(6512007)(6346003)(4326008)(68736007)(316002)(6436002)(33656002)(478600001)(99286004)(25786009)(102836004)(7416002)(106356001)(97736004)(6486002)(54906003)(476003)(9686003)(2906002)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR04MB0405;
 H:BN6PR04MB0963.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E0SCRGBSYOi+iTH/H6OgjoInn7nlOpUjLDwgDRr/BUOaydWV8Y43Wp85XCZ5Z8k/K/W4r7fmm2ffUMp4Bq4JNB6fgHLfei6uDkdnA0ZJBON61XDNo0koGzPgei35jrvSC30xdDmjPBg0pHxqaGBHiTAMx3mrJSWV6QrmO7WLLJgC7fj63olu3oyUkhFGsNjEtrmQHeEbd6sMO17Q9ALFDP72lXuzfYu0R2Mfp4vDSVDBtgO1Zw8O1qYcjsx3JHJXRUxK1gwLckJb9CBWyy1Zvsayj6mN+IQ5qQUDzxsVSaHHRkhye57deDd/YQ5OUG8CW2ZWjLqqZGrTiN8SSBlmhs3UbFGOVPDb8h/hjR6f0O4zEbGBFclNMTiT8vYRBZhRVZrERjFlkCqlk05A94UVhNxlOdYzi0ukjhoI5Ds+WvA=
Content-ID: <B21F09D3BD4EC84294307AC2D0DEACF6@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f0b6a1-6561-4c51-ab01-08d6886bd9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 17:36:51.4796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0405
Subject: Re: Re: [PATCH v3 1/3] KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a
 raw_spinlock
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-01_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy
 score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_093736_814320_F3998E10 
X-CRM114-Status: GOOD (  15.07  )
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
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 Julien Thierry <julien.thierry@arm.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 03:30:58PM +0000, Julien Grall wrote:
> Hi Julien,
> 
> On 07/01/2019 15:06, Julien Thierry wrote:
> > vgic_irq->irq_lock must always be taken with interrupts disabled as
> > it is used in interrupt context.
> 
> I am a bit confused with the reason here. The code mention that ap_list_lock
> could be taken from the timer interrupt handler interrupt. I assume it
> speaks about the handler kvm_arch_timer_handler. Looking at the
> configuration of the interrupt, the flag IRQF_NO_THREAD is not set, so the
> interrupt should be threaded when CONFIG_PREEMPT_FULL is set. If my
> understanding is correct, this means the interrupt thread would sleep if it
> takes the spinlock.
> 
> Did I miss anything? Do you have an exact path where the vGIC is actually
> called from an interrupt context?

The part you're missing is that percpu interrupts are not force
threaded:

	static int irq_setup_forced_threading(struct irqaction *new)
	{
		if (!force_irqthreads)
			return 0;
		if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
			return 0;
	
		/* ...*/
	}

   Julia

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
