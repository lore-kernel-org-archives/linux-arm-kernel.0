Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:58:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AF32192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d4eDq373"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AF32192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Onm/EGRpTGkWTbV2gl23pUwbMOUxqWbn7VeWVdzHVMo=; b=d4eDq373AtN3AX
	U+vpJ9F8Y69MknOdW/FDqT6lylS0AClsdymDZvSjDlfie+WY69BCwC5Vcksfc5tenFaeYp8zOI1Eq
	faoPa0G7REbrpB3dbHfX3+5Uq/1/e8kKZPafd2oUZzVYihyXrHjI73mg+JLx4842OIqezD0h2kyqQ
	Fqba9dHgUaFdfez+3ylBM2FUBiScByxPTFyza6LpLthJ/VJDtepuhiFp8F9+zPd+YIKUYDBGCQgsy
	9x+GSXvs8bp7aLASt3c2NeZxyKF0CWUqJouW4P+lJF9C0FApvIsBEmVtwhUg6t/6q20qbIW/XM7SF
	S8jvttCFW9ellk1vFmuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gulUi-0003rB-Np; Fri, 15 Feb 2019 21:58:04 +0000
Received: from mail-oln040092068109.outbound.protection.outlook.com
 ([40.92.68.109] helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gulUf-0003qU-3B
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 21:58:03 +0000
Received: from AM5EUR02FT048.eop-EUR02.prod.protection.outlook.com
 (10.152.8.52) by AM5EUR02HT170.eop-EUR02.prod.protection.outlook.com
 (10.152.9.160) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Fri, 15 Feb
 2019 21:57:56 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.8.55) by
 AM5EUR02FT048.mail.protection.outlook.com (10.152.9.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 15 Feb 2019 21:57:56 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%4]) with mapi id 15.20.1622.016; Fri, 15 Feb 2019
 21:57:56 +0000
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Thread-Topic: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Thread-Index: AQHUxWnWUPB2na06qUiuVihk2ZlxqKXhaC0A
Date: Fri, 15 Feb 2019 21:57:56 +0000
Message-ID: <VI1PR0702MB3840A772914621B2F026B349E4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
In-Reply-To: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::20) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:E2F5A3C02BA13A07D57263D45A098C5034B7D93680B2AD14D0A718FE19B467D1;
 UpperCasedChecksum:11BB2A1D032816DBD0E4A5F3AF5D2C63BBA551218E352934BC5FA9D57BBDADD0;
 SizeAsReceived:8675; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [xJO74fK82WMgckmuKaezBSPbqIUdjd/e]
x-microsoft-original-message-id: <5cbb9f26-5244-3afc-1248-a0263cbeceed@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:AM5EUR02HT170; 
x-ms-traffictypediagnostic: AM5EUR02HT170:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:AM5EUR02HT170; BCL:0; PCL:0; RULEID:; SRVR:AM5EUR02HT170; 
x-microsoft-antispam-message-info: 2LZYQd7CvcKstHZTYQKG429kGe55jhXOHRGCaVWcjrmD8fGDGdmdpDZvxH2YKuol
Content-ID: <BBB1C2B85CB4A646B1F74D6443620BE8@eurprd07.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d5b2d0-7cda-4140-4c9c-08d69390a40d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 21:57:55.2309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT170
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_135801_138871_4ED796DA 
X-CRM114-Status: GOOD (  24.64  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, "yadi.hu@windriver.com" <yadi.hu@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/15/19 9:05 PM, Sebastian Andrzej Siewior wrote:
> From: "Yadi.hu" <yadi.hu@windriver.com>
> 
> Accessing a kernel address in user space causes a SIGSEGV which is sent
> via
> -> do_DataAbort
>    -> do_sect_fault || do_translation_fault
>       -> do_bad_area
>          -> __do_user_fault
>             -> force_sig_fault
> Since commit
> 
>   02fe2845d6a83 ("ARM: entry: avoid enabling interrupts in prefetch/data abort handlers")
> 
> that path is carried out with disabled interrupts. Page/alignment fault
> do enable interrupts but data abort has been left out.
> 
> On -RT the siglock is a sleeping spinlock and requires interrupts to be
> enabled in order to acquire it.
> 
> Enable interrupts in the DataAbort handler if the parent context had
> interrupts enabled. Move harden_branch_predictor() before interrupts are
> enabled.
> 
> Reported-by: <Bernd Edlinger <bernd.edlinger@hotmail.de>
> Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
> [bigeasy: rewrote patch description, reordered patch]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> I though that the "interrupt enable part" has already been posted and
> then Bernd complained about a warning from harden_branch_predictor() on
> -RT so here it is.
> 
>  arch/arm/mm/fault.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 58f69fa07df95..da82967865836 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -161,8 +161,6 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  		unsigned int fsr, unsigned int sig, int code,
>  		struct pt_regs *regs)
>  {
> -	if (addr > TASK_SIZE)
> -		harden_branch_predictor();
>  
>  #ifdef CONFIG_DEBUG_USER
>  	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
> @@ -191,6 +189,11 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	struct task_struct *tsk = current;
>  	struct mm_struct *mm = tsk->active_mm;
>  
> +	if (addr > TASK_SIZE && user_mode(regs))
> +		harden_branch_predictor();

This is somehow inconsisten with do_translation_fault, where
we have this:

	if (addr < TASK_SIZE)
		return do_page_fault(addr, fsr, regs);

> +
> +	if (interrupts_enabled(regs))
> +		local_irq_enable();
>  	/*
>  	 * If we are in kernel mode at this point, we
>  	 * have no context to handle this fault with.
> 

I have seen three different failure modes, pleas see the first 3 calls stacks
here: https://marc.info/?l=linux-rt-users&m=155016888714927&w=2

I am concerned about this fist issue, because it removes the branch
predictor hardening after the do_page_fault has executed:

do_DataAbort->do_page_fault(addr>TASK_SIZE)->__do_user_fault

This is reachable because do_page_fault is not only called from
do_translation_fault but also from here: arch/arm/mm/fsr-2level.c
and here: arch/arm/mm/fsr-3level.c
those are callable with addr > TASK_SIZE

And the following code path does enable the hard irqs before do_bad_area:
do_DataAbort->do_sect_fault->do_bad_area->__do_user_fault

So this function, would need to be rewritten:

do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
{
	if (interrupts_enabled(regs))
		local_irq_enable();

	do_bad_area(addr, fsr, regs);
	return 0;
}



BTW, the complete linux tree I am testing right now is here:
https://github.com/bernd-edlinger/linux-rt
in the branch: patches-rel-v4.14-rt


Thanks
Bernd.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
