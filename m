Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:56:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84ADC2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bvZVOt0m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="h3J38A9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ADC2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=45kx83ZAUkuBJNx0DV5ZPu+QxjVMb1ozxvuNOVPY4Aw=; b=bvZVOt0m84Vvsc
	kmviCXFdDJnMvjEU/ifulAXzXskCktXAUh8aXSLfFF6AgepYh/SbcqOkgnRqNZPRGPeLz3pbR0uff
	+Y0jDwIDUtREfYqqOIPoVnUa/RCl5kxHAASPNVTjJUOEQOGUgJZoEMZ3NhlLYHnSm1o+uoByGWhGi
	1Q8mxkf0M7xmhYF0z3H/3ND5hNgYay+7+Nf2WOB3PxzE80LVvT0XT/ek/jQAiEy1ExDdnmX+5DmYL
	eTTEOb3Km8C9dUWNCITqZJYadgE+7HtAaWPZEkNlztGoEdHy8d7TFbd83Yn8veOQ0GQSiqDeNjnTE
	sTNChqt75UvKeeVKYf7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOqm-0004gW-Ep; Mon, 10 Dec 2018 16:56:08 +0000
Received: from mail-he1eur01on0619.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::619]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOqh-0004fl-ID
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:56:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYeFMo4SipZxCSEgYkWa1FZcU8F9BMoQlpYVqdtWfZQ=;
 b=h3J38A9SfeHECtDB8LXk2eYBecx2zgRLAfmrRpgBTGp+7d6swpEHmdArbe8ukMJMDRre2CtFO5j+cZU6ulxjSdyuxc0j+s6iMkNP8nd8b1uDLjmVFTBqhVHUCEZ3UW7/EuoxPpSwRDP1aYV+61fWVv6HzSrBqukl/ijGsehJ9pw=
Received: from HE1PR0801MB1370.eurprd08.prod.outlook.com (10.167.248.14) by
 HE1PR0801MB1851.eurprd08.prod.outlook.com (10.168.150.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.24; Mon, 10 Dec 2018 16:55:48 +0000
Received: from HE1PR0801MB1370.eurprd08.prod.outlook.com
 ([fe80::5981:fde9:9872:3c2c]) by HE1PR0801MB1370.eurprd08.prod.outlook.com
 ([fe80::5981:fde9:9872:3c2c%7]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 16:55:48 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH V5 5/7] arm64: mm: Prevent mismatched 52-bit VA support
Thread-Topic: [PATCH V5 5/7] arm64: mm: Prevent mismatched 52-bit VA support
Thread-Index: AQHUjbYvYWNtg10+lUm5xOFhELKjyqVzGTSAgABNsACAACJbAIAEdhcAgAApHACAAAQWAIAACmUA
Date: Mon, 10 Dec 2018 16:55:47 +0000
Message-ID: <20181210165538.GA26756@capper-debian.cambridge.arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181206225042.11548-6-steve.capper@arm.com>
 <81860712-ff5f-5a51-d39e-9db9e3d31a26@arm.com>
 <20181207152529.GB2682@edgewater-inn.cambridge.arm.com>
 <be06b735-c6b4-1520-73f6-02a3a8e8af45@arm.com>
 <20181210133640.GA31425@edgewater-inn.cambridge.arm.com>
 <20181210160348.GA4564@capper-debian.cambridge.arm.com>
 <20181210161826.GA11135@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181210161826.GA11135@edgewater-inn.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0052.namprd18.prod.outlook.com
 (2603:10b6:3:22::14) To HE1PR0801MB1370.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0801MB1851;
 6:0x9S7KYIxmijqXnFDuUUDEjv1iKm96OWqNIFC5SCO7bu+PK9NlNY7xFuz1hV8zd88/sMLMwAaaCqJRC9shc4s/VABu9Ur36a11c2YFyJkyXaw1WtyKPHizc4L6QEiXfsl+9+sMawlNDEji+EmMF7I3h45GpQ7ugi/gGWOGnR2QQ3WkMjgAai8T/9WzEpKYIwuWmmDft5LPQgIZDQ0vNYaVNm6M++HNHNL7sF3HS43qASYZAQiKOnajT+AUVRsM+nxxo9LHKPaGXYvxVI9LDf/sAXjyuj5USKWERVCee7m9OmTZL4xArQoRz4H4HfYfULmsJsufRTEe+BtCjhdDtio6X408qbOCrRQ9USDCGeG7nssMlYj1ywStseYsT2FQM3FSZ3A/D6wunvNmBt4HHW74PN7WRRl1sJpeJv7lEkS4NcEeLjRjJw2SGRa8w00exbtuSz6C0amL7piimvl5chyw==;
 5:WPFH21DCT9wpctehssSqXoj2RsDVSKkmaDsd3OloKLQg5aXkVwHeLAnYdoH1aroK8dvSH6x+gxT13AktSBofqebk7mNq9n24kPmDKuIRxb2ekA5J79MovTpesXkiwm02MBlh6S0dq/mYp+xsb+g5zuvXKo6mtQrWQ+XdmGzxIRU=;
 7:DtFXIHhuJzVFiPbqobo7CbpRNGk6+U8GMj3JpUv878SwVv/sVoG0OE0P4DVKzTI0wuQuL5MP61WcwPlpdOSgfWHLM+utfVx+/cKxudafxKbdXkzJmrcWsnxVL0U0r3jJaHJgjwqdf7rnfIQ//yzYwA==
x-ms-office365-filtering-correlation-id: 7c7f1526-6c21-41aa-6d03-08d65ec0551b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0801MB1851; 
x-ms-traffictypediagnostic: HE1PR0801MB1851:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <HE1PR0801MB18519D57E420EB7ECF07890281A50@HE1PR0801MB1851.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR0801MB1851; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0801MB1851; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(316002)(446003)(99286004)(305945005)(58126008)(53546011)(386003)(6506007)(54906003)(6486002)(6436002)(26005)(33656002)(76176011)(44832011)(6636002)(93886005)(476003)(229853002)(3846002)(6116002)(2906002)(5660300001)(186003)(52116002)(97736004)(486006)(11346002)(1076002)(14454004)(4326008)(72206003)(6862004)(86362001)(71190400001)(71200400001)(8936002)(68736007)(25786009)(106356001)(105586002)(53936002)(6512007)(81166006)(81156014)(8676002)(256004)(7736002)(14444005)(102836004)(6246003)(66066001)(478600001)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0801MB1851;
 H:HE1PR0801MB1370.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OBz+taDd+qXToIQpi7mStaRn9XfKtbr2vTOTOuJiSD57jgusmnT5ozK0Q+JahT/JCvppk/TSBT/z2uQ/NtlMGvVlvECsZN1EihJVBlsh3mm7BykIoynBGi7ozKh5JSk/v4KFAK14K5Aiw/dWRG8oSNYC/cpzpG0Il0My/Nap59xrq82uQ6UJxDh2yKkqC48xSTF9BD5ZJzQNQI6KN9Pzg7s4mRmZQN//nr4uIlf8DJ8RtLswJtaRRn48ACyI6j5ndOunASi8wKRJT8AJdd3xBDADh4zGPGLkpzqS+DpFphkenYwlyUKrbH7FpgRmNC6ayvQzh/HhtsneyZytYXPxGaeMEwaC3VJSWPUdDepOjN0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <4B8FC8C33CB6FD4EB102036505C1F1B7@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7f1526-6c21-41aa-6d03-08d65ec0551b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:55:48.0121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1851
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_085603_911540_FA134F0D 
X-CRM114-Status: GOOD (  25.25  )
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

On Mon, Dec 10, 2018 at 04:18:26PM +0000, Will Deacon wrote:
> On Mon, Dec 10, 2018 at 04:04:02PM +0000, Steve Capper wrote:
> > On Mon, Dec 10, 2018 at 01:36:40PM +0000, Will Deacon wrote:
> > > On Fri, Dec 07, 2018 at 05:28:58PM +0000, Suzuki K Poulose wrote:
> > > > On 07/12/2018 15:26, Will Deacon wrote:
> > > > > On Fri, Dec 07, 2018 at 10:47:57AM +0000, Suzuki K Poulose wrote:
> > > > > > On 12/06/2018 10:50 PM, Steve Capper wrote:
> > > > > > > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > > > > > > index f60081be9a1b..58fcc1edd852 100644
> > > > > > > --- a/arch/arm64/kernel/head.S
> > > > > > > +++ b/arch/arm64/kernel/head.S
> > > > > > > @@ -707,6 +707,7 @@ secondary_startup:
> > > > > > >    	/*
> > > > > > >    	 * Common entry point for secondary CPUs.
> > > > > > >    	 */
> > > > > > > +	bl	__cpu_secondary_check52bitva
> > > > > > >    	bl	__cpu_setup			// initialise processor
> > > > > > >    	adrp	x1, swapper_pg_dir
> > > > > > >    	bl	__enable_mmu
> > > > > > > @@ -785,6 +786,31 @@ ENTRY(__enable_mmu)
> > > > > > >    	ret
> > > > > > >    ENDPROC(__enable_mmu)
> > > > > > > +ENTRY(__cpu_secondary_check52bitva)
> > > > > > > +#ifdef CONFIG_ARM64_52BIT_VA
> > > > > > > +	ldr_l	x0, vabits_user
> > > > > > > +	cmp	x0, #52
> > > > > > > +	b.ne	2f > +
> > > > > > > +	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
> > > > > > > +	and	x0, x0, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
> > > > > > > +	cbnz	x0, 2f
> > > > > > > +
> > > > > > > +	adr_l	x0, va52mismatch
> > > > > > > +	mov	w1, #1
> > > > > > > +	strb	w1, [x0]
> > > > > > > +	dmb	sy
> > > > > > > +	dc	ivac, x0	// Invalidate potentially stale cache line
> > > > > > 
> > > > > > You may have to clear this variable before a CPU is brought up to avoid
> > > > > > raising a false error message when another secondary CPU doesn't boot
> > > > > > for some other reason (say granule support) after a CPU failed with lack
> > > > > > of 52bitva. It is really a crazy corner case.
> > > > > 
> > > > > Can't we just follow the example set by the EL2 setup in the way that is
> > > > > uses __boot_cpu_mode? In that case, we only need one variable and you can
> > > > > detect a problem by comparing the two halves.
> > > > 
> > > > The only difference here is, the support is bolted at boot CPU time and hence
> > > > we need to verify each and every CPU, unlike the __boot_cpu_mode where we
> > > > check for mismatch after the SMP CPUs are brought up. If we decide to make
> > > > the choice later, something like that could work. The only caveat is the 52bit
> > > > kernel VA will have to do something like the above.
> > > 
> > > So looking at this a bit more, I think we're better off repurposing the
> > > upper bits of the early boot status word to contain a reason code, rather
> > > than introducing new variables for every possible mismatch.
> > > 
> > > Does the untested diff below look remotely sane to you?
> > > 
> > > Will
> > > 
> > 
> > Thanks Will,
> > This looks good to me, I will test now and fold this into a patch.
> 
> Cheers, Steve. Testing would be handy, but don't worry about respinning the
> patches as I'm already on top of this and hope to push this out later today.
> 

Thanks Will,
This looks good to me so FWIW:
Tested-by: Steve Capper <steve.capper@arm.com>

(for both the 52-bit VA mismatch and 64KB granule not supported cases
using the model).

The only small issue I see is that if subsequent CPUs aren't brought
online (because they don't exist in the model) then the error reason is
repeated.

I'll dig into this.

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
