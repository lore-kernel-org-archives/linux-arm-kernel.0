Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72C2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:09:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B212A20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HbQYR5Y4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XavnlZC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B212A20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b+WLucQ1AvUtgAHfXDFHErQVDGL3BZQpnTP4iZhX6sA=; b=HbQYR5Y4Doczc2
	fXw0/yHOGbiVblnRvczCmwE36QDOoMOZxgOwwPabrKWtTmmwgrZNxzVhkVMviAb6F8T2WJbjPCtsk
	FUUml4ss2tCFvgS2a+vsCm47YsZtjH6uehKDM69LILxvYFD0QrLgVWhHwlRj2BxqZEcudJuPMQ0wC
	X5meMhiXIBhUI0jov2M0wKlgSgCW5S1evbCGvkbrtbjQWKTBDx1BucEu7AjMnjhEhjwWHKdrVm4vy
	jMBpwCTmvbXDsbt8o6l3n+OXSoUDOmyjlZxBSILTBUFYh3osWlfT4M8WegZKnwBrWBcohPOgSVfM0
	9oL80+Qh2ERBGsyeaiyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWP3H-0000S2-Nx; Mon, 10 Dec 2018 17:09:03 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWP3C-0000RO-Qi
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHEij9qhf0czcbngAp77RMV/p7I7xqZWJSs77wx6Uow=;
 b=XavnlZC9QkKj0508D6OGzDT+5GJbh1qwf7G2DzKGQVd1bO/Q7eiWHqioCvS0W9hS7t8VNtrRhuQoNGaQcRz26Cqh0b+ZSI9Wiue1hMIIiO50gptQx52K/vMHtZxEeeM5v4RX/qzGznzPS3t7Ckp8Ds/g9ViFNAuRiFX3HdToxLs=
Received: from HE1PR0801MB1370.eurprd08.prod.outlook.com (10.167.248.14) by
 HE1PR0801MB1849.eurprd08.prod.outlook.com (10.168.150.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.24; Mon, 10 Dec 2018 17:08:41 +0000
Received: from HE1PR0801MB1370.eurprd08.prod.outlook.com
 ([fe80::5981:fde9:9872:3c2c]) by HE1PR0801MB1370.eurprd08.prod.outlook.com
 ([fe80::5981:fde9:9872:3c2c%7]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 17:08:41 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH V5 5/7] arm64: mm: Prevent mismatched 52-bit VA support
Thread-Topic: [PATCH V5 5/7] arm64: mm: Prevent mismatched 52-bit VA support
Thread-Index: AQHUjbYvYWNtg10+lUm5xOFhELKjyqVzGTSAgABNsACAACJbAIAEdhcAgAApHACAAAQWAIAACmUAgAADmoA=
Date: Mon, 10 Dec 2018 17:08:41 +0000
Message-ID: <20181210170831.GA28176@capper-debian.cambridge.arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181206225042.11548-6-steve.capper@arm.com>
 <81860712-ff5f-5a51-d39e-9db9e3d31a26@arm.com>
 <20181207152529.GB2682@edgewater-inn.cambridge.arm.com>
 <be06b735-c6b4-1520-73f6-02a3a8e8af45@arm.com>
 <20181210133640.GA31425@edgewater-inn.cambridge.arm.com>
 <20181210160348.GA4564@capper-debian.cambridge.arm.com>
 <20181210161826.GA11135@edgewater-inn.cambridge.arm.com>
 <20181210165538.GA26756@capper-debian.cambridge.arm.com>
In-Reply-To: <20181210165538.GA26756@capper-debian.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0068.namprd18.prod.outlook.com
 (2603:10b6:3:22::30) To HE1PR0801MB1370.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0801MB1849;
 6:HUlhDFY6cAsQKW2n+3pbwffrVuK8SHmJnOXlB6p4vb8J9aJLdTVeV6/mo7dl9ENpM//bPaTCyTN4rkzl2eqDP+4YvtOTA95ZHxWPX5brUg8l/c6BhHlkPfcYFhj/i2C/rE+/44R+kqr1fQbQ86RrwHWdYanywzq75CtArnZfnlckfqruer5dl08fyy4o/9TPuW3rhaapIVKhdLMWeRMq1aj6sGeXXca/YkpJfcvYQjfTtHnlXzm85qX2EvCkTV1yfiVPjPv5A2WRUpKJAUzRI/M7d+ooISDQa7Hb+TFQ5eEHUcOw65cyGbPtGu/P4XTV0kodLcpLdnkMlUjK2NW7sJO8ylQAfdhAg0U0ewTXsbc39QKdXZhlcrX9ovJ5x1TTX1Ms1VFr5ZjYlrMQ6rBfaaJaWEteevmp14q7OLLutbcQXfSkV5y9ZopUFiNlm5FUz7385pGrDAehUEFHXrJuAg==;
 5:9NGXGWSp8SFJAvp+qlIQLtGotS1uFkNZpqnqsXaE/jl3eaYHDbFP4K4oqjMvLnrmzkGPDf5KRgrr30Fn/TPJeVmZqNNnnMy0YkH4N1BroKg8vy8b4yFd3ZhW96K1gQItZLejebU9/cj5kJ9M7VTGauRu9QrYM20YRG+Ttn51x9M=;
 7:3c17ijbj/7T5SJOzISIV93ECDWjBjEnTt/DEe+oc1Ru05xD+qqsVZq7DStdF0VJcMcURmZOFb7TwU5Bn8xTgDqot8bOrj6AGczf/gXhbqMMRjuDt+wMsyyAy7V15qJwy9FWO89ndpXPG2KocKFxT0A==
x-ms-office365-filtering-correlation-id: c57e7754-ada2-45f0-954c-08d65ec2224e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0801MB1849; 
x-ms-traffictypediagnostic: HE1PR0801MB1849:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <HE1PR0801MB18493E488826A5EF00FC25E481A50@HE1PR0801MB1849.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR0801MB1849; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0801MB1849; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(316002)(3846002)(4326008)(186003)(476003)(1076002)(2906002)(99286004)(486006)(66066001)(11346002)(26005)(446003)(86362001)(5660300001)(305945005)(14444005)(93886005)(54906003)(256004)(44832011)(6116002)(52116002)(53546011)(386003)(6506007)(58126008)(76176011)(7736002)(81156014)(106356001)(102836004)(8936002)(14454004)(478600001)(229853002)(97736004)(72206003)(33656002)(6486002)(81166006)(105586002)(6436002)(8676002)(25786009)(6246003)(68736007)(53936002)(6512007)(71200400001)(71190400001)(6862004)(6636002)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0801MB1849;
 H:HE1PR0801MB1370.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DRaoQrOcHN9nOwRK16XZ3wKyCAVhZnKwHcfxZrZ79f6/+D/1nLJLdv5k+iQdBxPum2cPJjTcCZi3pdttJBFCFXFeeU4JAepQwJpdAiSWhquXapChVzEJ3UvsU68DuESNqJIzr8UI1W+f0CecYatIrZf22WKqJviN2+CKiT2Mq/9dpORHQ6SP39dQD77hV0mMXWzIL5RLPAN3XLQbS4vPY+PzgTskwEAfd7MK7hHQDpsvYg5HpLMiWh+xJJe2DfXo0xMa2b/EfLvKUX65mVV3QECKFr2xRxvUp7+YFVsXwaiWBKQoB1QQnt/v8oqkNxsr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <F37A22ACA2EC57428771F87A008C4BAB@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57e7754-ada2-45f0-954c-08d65ec2224e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 17:08:41.7310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1849
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_090858_865578_1F9CE454 
X-CRM114-Status: GOOD (  26.24  )
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Suzuki Poulose <Suzuki.Poulose@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "jcm@redhat.com" <jcm@redhat.com>,
 nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 04:55:38PM +0000, Steve Capper wrote:
> On Mon, Dec 10, 2018 at 04:18:26PM +0000, Will Deacon wrote:
> > On Mon, Dec 10, 2018 at 04:04:02PM +0000, Steve Capper wrote:
> > > On Mon, Dec 10, 2018 at 01:36:40PM +0000, Will Deacon wrote:
> > > > On Fri, Dec 07, 2018 at 05:28:58PM +0000, Suzuki K Poulose wrote:
> > > > > On 07/12/2018 15:26, Will Deacon wrote:
> > > > > > On Fri, Dec 07, 2018 at 10:47:57AM +0000, Suzuki K Poulose wrote:
> > > > > > > On 12/06/2018 10:50 PM, Steve Capper wrote:
> > > > > > > > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > > > > > > > index f60081be9a1b..58fcc1edd852 100644
> > > > > > > > --- a/arch/arm64/kernel/head.S
> > > > > > > > +++ b/arch/arm64/kernel/head.S
> > > > > > > > @@ -707,6 +707,7 @@ secondary_startup:
> > > > > > > >    	/*
> > > > > > > >    	 * Common entry point for secondary CPUs.
> > > > > > > >    	 */
> > > > > > > > +	bl	__cpu_secondary_check52bitva
> > > > > > > >    	bl	__cpu_setup			// initialise processor
> > > > > > > >    	adrp	x1, swapper_pg_dir
> > > > > > > >    	bl	__enable_mmu
> > > > > > > > @@ -785,6 +786,31 @@ ENTRY(__enable_mmu)
> > > > > > > >    	ret
> > > > > > > >    ENDPROC(__enable_mmu)
> > > > > > > > +ENTRY(__cpu_secondary_check52bitva)
> > > > > > > > +#ifdef CONFIG_ARM64_52BIT_VA
> > > > > > > > +	ldr_l	x0, vabits_user
> > > > > > > > +	cmp	x0, #52
> > > > > > > > +	b.ne	2f > +
> > > > > > > > +	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
> > > > > > > > +	and	x0, x0, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
> > > > > > > > +	cbnz	x0, 2f
> > > > > > > > +
> > > > > > > > +	adr_l	x0, va52mismatch
> > > > > > > > +	mov	w1, #1
> > > > > > > > +	strb	w1, [x0]
> > > > > > > > +	dmb	sy
> > > > > > > > +	dc	ivac, x0	// Invalidate potentially stale cache line
> > > > > > > 
> > > > > > > You may have to clear this variable before a CPU is brought up to avoid
> > > > > > > raising a false error message when another secondary CPU doesn't boot
> > > > > > > for some other reason (say granule support) after a CPU failed with lack
> > > > > > > of 52bitva. It is really a crazy corner case.
> > > > > > 
> > > > > > Can't we just follow the example set by the EL2 setup in the way that is
> > > > > > uses __boot_cpu_mode? In that case, we only need one variable and you can
> > > > > > detect a problem by comparing the two halves.
> > > > > 
> > > > > The only difference here is, the support is bolted at boot CPU time and hence
> > > > > we need to verify each and every CPU, unlike the __boot_cpu_mode where we
> > > > > check for mismatch after the SMP CPUs are brought up. If we decide to make
> > > > > the choice later, something like that could work. The only caveat is the 52bit
> > > > > kernel VA will have to do something like the above.
> > > > 
> > > > So looking at this a bit more, I think we're better off repurposing the
> > > > upper bits of the early boot status word to contain a reason code, rather
> > > > than introducing new variables for every possible mismatch.
> > > > 
> > > > Does the untested diff below look remotely sane to you?
> > > > 
> > > > Will
> > > > 
> > > 
> > > Thanks Will,
> > > This looks good to me, I will test now and fold this into a patch.
> > 
> > Cheers, Steve. Testing would be handy, but don't worry about respinning the
> > patches as I'm already on top of this and hope to push this out later today.
> > 
> 
> Thanks Will,
> This looks good to me so FWIW:
> Tested-by: Steve Capper <steve.capper@arm.com>
> 
> (for both the 52-bit VA mismatch and 64KB granule not supported cases
> using the model).
> 
> The only small issue I see is that if subsequent CPUs aren't brought
> online (because they don't exist in the model) then the error reason is
> repeated.
> 
> I'll dig into this.
>

I think __early_cpu_boot_status needs to be reset at the beginning of
__cpu_up before the secondary is booted. Testing a check for this now.

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
