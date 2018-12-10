Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C83DC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:04:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EA82082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nn3zNjez";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MFIKQmxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EA82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nZaTSL53AVJGHdCUDE35iw0p2x4++iDjvmn83Dl6WvI=; b=nn3zNjezTEoTBN
	E1u+u7WmSMkXwY1QP+xsOH2BXds9pbaEj1HpRDebiJp2kA+n/6W6WTOKkzo8WeaYFKAtO+2aZj0V3
	saorLEQoH+380p18GmXNEaWcwkUrvC4aIO3+SfqvaRUTy5KiQYZ7Syo6kDJti3FsngRCDRTU+Uhhi
	+eIc2Wlkxq/EBlv0vPv/fAGWIVQ6x/I+pDR2UjikzWsEzaaRQrUlcnbRY6PtKcGbxtSTQH75u2Iqi
	mixjhZsrjS5JpC3kUnwT7LvjloLS4gj1jnh47iSfEYkA123sGpU0tr1oZzL2gg6d989uDqXYuXgwB
	pxFjPfhyxT0OeuBCGOOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWO2i-0007pD-1K; Mon, 10 Dec 2018 16:04:24 +0000
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWO2d-0007oZ-GU
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:04:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0Hovyi4WQAbB3E3aafb4CBHzDA2aKPWpjxuhL5U4HE=;
 b=MFIKQmxomx9TBa0LJqBTw3yY2YlIvD0aYHhxVJPgWu7l3WCusi+fb5BLfL5cOuwLnbbdFbC5ql6+LqFPju7ptOsBYrl4ZL6Qzp6JdcmI9qCjBluAl1gbnmTq8cuaXK7OFH1CHaENQkO68RTPNx/1q19rL27eas7GtYXDwalKpDc=
Received: from HE1PR0801MB1370.eurprd08.prod.outlook.com (10.167.248.14) by
 HE1PR0801MB1354.eurprd08.prod.outlook.com (10.167.248.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 16:04:03 +0000
Received: from HE1PR0801MB1370.eurprd08.prod.outlook.com
 ([fe80::5981:fde9:9872:3c2c]) by HE1PR0801MB1370.eurprd08.prod.outlook.com
 ([fe80::5981:fde9:9872:3c2c%7]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 16:04:03 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH V5 5/7] arm64: mm: Prevent mismatched 52-bit VA support
Thread-Topic: [PATCH V5 5/7] arm64: mm: Prevent mismatched 52-bit VA support
Thread-Index: AQHUjbYvYWNtg10+lUm5xOFhELKjyqVzGTSAgABNsACAACJbAIAEdhcAgAApHgA=
Date: Mon, 10 Dec 2018 16:04:02 +0000
Message-ID: <20181210160348.GA4564@capper-debian.cambridge.arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181206225042.11548-6-steve.capper@arm.com>
 <81860712-ff5f-5a51-d39e-9db9e3d31a26@arm.com>
 <20181207152529.GB2682@edgewater-inn.cambridge.arm.com>
 <be06b735-c6b4-1520-73f6-02a3a8e8af45@arm.com>
 <20181210133640.GA31425@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181210133640.GA31425@edgewater-inn.cambridge.arm.com>
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
x-microsoft-exchange-diagnostics: 1; HE1PR0801MB1354;
 6:nQ3s4A6KntG1xtb4V26WpnSS0bJZ7hmhBHJg0wJ9D2GyobgrLY0dXQZNH+6rIKRaWCfF48Bp9i9TgOPcKHdlAECkBsMZVUmHt8pgTqstYU5kpr8fzBjgBZuYPKCTccp9a7SpbNSeYsUQwDqQ7bBWb3TmGxgXDXw8FE1NFsrD8daiapD22UcCqL49IofBnzSeEtMjBj/fJTHSBakAM5XCIjOMTMeBS9KUj0nN69N7zu8AkPtA6pEE1wL/5rUe6oY4zwmvtYAGYRRPtd7yzbhIk7SiVG+WFRgE0ShrIqWt60H6fcorGEKD0sIWzO10rvU1Z9kU/dkGpZt2Coe+vjJXYBmCNo0m6n7U6RkDjcFSowgVmEsUEuK0QbTve5Rk/7fUN9cvQVM2hBMeChHiqGrp8CP0vRJJYvdq7HJzazwJ8IMk4az741hMVRxeRpvLQZz4GJO+7kbBKgHr4g/IQlcNDw==;
 5:9Gdcx1zpBQ/ZFuaWb654oj2IcKHcqcF/ad8ztlZRXUQ4nuTN7jcU+0cjMQjiGGe5k2y8wfWP6/Tfwbdbs5oub2rLMWeXmWxpnu2T01GlzxERfitM9cA3mxNIMyHosA4u0mMsLu4eo/eXPo7QVqss3mTH/fU/dqmtbxkzPa1c3/A=;
 7:Agb19oIcdsAPXT29z1AqDAamor6Sz3KprwOKDJt92PEYo6JPMJVy1rHjiSX3zGCQIpXKVoj+aawK/ikzmB6B24DkaVVSrEXpjRdV0EWa/x+b3HSthnmHHeWDR9X5wRAWV7QeKXJJlS85a+UL34DfxA==
x-ms-office365-filtering-correlation-id: 6fa5baf2-a2ed-428a-4c0e-08d65eb91938
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0801MB1354; 
x-ms-traffictypediagnostic: HE1PR0801MB1354:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <HE1PR0801MB135466FBDD8B109CB2FBE9FD81A50@HE1PR0801MB1354.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR0801MB1354; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0801MB1354; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(53936002)(4326008)(7736002)(6486002)(86362001)(6862004)(8936002)(6636002)(229853002)(478600001)(6246003)(97736004)(25786009)(99286004)(81166006)(81156014)(8676002)(256004)(14444005)(72206003)(2906002)(305945005)(6512007)(5660300001)(44832011)(6436002)(446003)(1076002)(186003)(26005)(6116002)(3846002)(71200400001)(6506007)(102836004)(105586002)(53546011)(66066001)(33656002)(386003)(11346002)(14454004)(316002)(58126008)(52116002)(54906003)(93886005)(68736007)(106356001)(486006)(476003)(76176011)(71190400001)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0801MB1354;
 H:HE1PR0801MB1370.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gkHWdmOdz4J2+E+He3R9e9/qcMZB4Q1EUjY1sb2/xSPPkU1s72nM21twOO1my2Cj0l2E+K4m4GbEeZZ7eFdUEVUDkHu2ybfmx3kr1LLSRDD0HQnwGcCBLR5PdsY+rJbQIAJt4BE7enHmV5Mx+K6wga96hh8QLyKIFortoqP1FPE2l8bfejFFj+F5A9KPZZOLUWF2BP17eRhCAHM7Pb1LerAZfXF3FsH6xRvpU/I4hmyfABrYCD8+Y3zD1fx/xaEPdYOKnPXJffEM8HtyHMUQMn6mWdJFmN7AyUOdJelwOmdGPJ33tzbL+NV7d2CPBqNT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <EE725A03E1E0E944ADBAC7DEA0591271@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa5baf2-a2ed-428a-4c0e-08d65eb91938
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:04:03.2057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1354
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_080419_604930_BC7E244A 
X-CRM114-Status: GOOD (  22.51  )
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

On Mon, Dec 10, 2018 at 01:36:40PM +0000, Will Deacon wrote:
> On Fri, Dec 07, 2018 at 05:28:58PM +0000, Suzuki K Poulose wrote:
> > 
> > 
> > On 07/12/2018 15:26, Will Deacon wrote:
> > > On Fri, Dec 07, 2018 at 10:47:57AM +0000, Suzuki K Poulose wrote:
> > > > On 12/06/2018 10:50 PM, Steve Capper wrote:
> > > > > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > > > > index f60081be9a1b..58fcc1edd852 100644
> > > > > --- a/arch/arm64/kernel/head.S
> > > > > +++ b/arch/arm64/kernel/head.S
> > > > > @@ -707,6 +707,7 @@ secondary_startup:
> > > > >    	/*
> > > > >    	 * Common entry point for secondary CPUs.
> > > > >    	 */
> > > > > +	bl	__cpu_secondary_check52bitva
> > > > >    	bl	__cpu_setup			// initialise processor
> > > > >    	adrp	x1, swapper_pg_dir
> > > > >    	bl	__enable_mmu
> > > > > @@ -785,6 +786,31 @@ ENTRY(__enable_mmu)
> > > > >    	ret
> > > > >    ENDPROC(__enable_mmu)
> > > > > +ENTRY(__cpu_secondary_check52bitva)
> > > > > +#ifdef CONFIG_ARM64_52BIT_VA
> > > > > +	ldr_l	x0, vabits_user
> > > > > +	cmp	x0, #52
> > > > > +	b.ne	2f > +
> > > > > +	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
> > > > > +	and	x0, x0, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
> > > > > +	cbnz	x0, 2f
> > > > > +
> > > > > +	adr_l	x0, va52mismatch
> > > > > +	mov	w1, #1
> > > > > +	strb	w1, [x0]
> > > > > +	dmb	sy
> > > > > +	dc	ivac, x0	// Invalidate potentially stale cache line
> > > > 
> > > > You may have to clear this variable before a CPU is brought up to avoid
> > > > raising a false error message when another secondary CPU doesn't boot
> > > > for some other reason (say granule support) after a CPU failed with lack
> > > > of 52bitva. It is really a crazy corner case.
> > > 
> > > Can't we just follow the example set by the EL2 setup in the way that is
> > > uses __boot_cpu_mode? In that case, we only need one variable and you can
> > > detect a problem by comparing the two halves.
> > 
> > The only difference here is, the support is bolted at boot CPU time and hence
> > we need to verify each and every CPU, unlike the __boot_cpu_mode where we
> > check for mismatch after the SMP CPUs are brought up. If we decide to make
> > the choice later, something like that could work. The only caveat is the 52bit
> > kernel VA will have to do something like the above.
> 
> So looking at this a bit more, I think we're better off repurposing the
> upper bits of the early boot status word to contain a reason code, rather
> than introducing new variables for every possible mismatch.
> 
> Does the untested diff below look remotely sane to you?
> 
> Will
> 

Thanks Will,
This looks good to me, I will test now and fold this into a patch.

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
