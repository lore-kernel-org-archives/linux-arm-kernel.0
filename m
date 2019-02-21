Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDC2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:06:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B74F2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BPGZMOFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B74F2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V/R3uk263XBWd/oBybPIBCeZ5fEuxjhlE5JkJAgFJM4=; b=BPGZMOFhIg/dnt
	BSwumVQ0/YhDBNn2PGZl4BD5ewXEjGNq2QAVHbGr8VT4zk0CrGoQ+/hGMzihONmGBReSANtS0uIdT
	ZzNAzsl4kquw0IT0CQmb4Hgnh8tguEE13xjTkajHvj3nidmdcADVl7Dqx4Q9Gdmhk6/EgWG16QH/h
	I51JU8Psc1oeZjtZi9PwPi1Ekdx09SYM4V+dia2LT8/AwfoLDh+hIQlhk8blmAeWh1GCLUyE4dkj6
	yy+85qCHXAp33pajvxT5PFCIS76UIdyNEd6ihmuxvHFCk+FiHcLUtDQN7+i5kuoKZe+HRuj9o8CpO
	GvTC3Ph/whqlBLhQm/LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwjNI-0000e1-9K; Thu, 21 Feb 2019 08:06:32 +0000
Received: from mail-oln040092070068.outbound.protection.outlook.com
 ([40.92.70.68] helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwjNF-0000dd-GK
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 08:06:30 +0000
Received: from VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (10.152.18.57) by VE1EUR03HT070.eop-EUR03.prod.protection.outlook.com
 (10.152.19.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.11; Thu, 21 Feb
 2019 08:06:25 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.18.55) by
 VE1EUR03FT021.mail.protection.outlook.com (10.152.18.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Thu, 21 Feb 2019 08:06:25 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%5]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 08:06:25 +0000
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Russell King - ARM
 Linux admin" <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Thread-Topic: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Thread-Index: AQHUxWnWUPB2na06qUiuVihk2ZlxqKXiTBcAgAZAHICAATa1gA==
Date: Thu, 21 Feb 2019 08:06:25 +0000
Message-ID: <f05d2cae-5664-6cc7-51c8-933d6d1403ec@hotmail.de>
References: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
 <20190216113338.irr5j4ukhpwngval@shell.armlinux.org.uk>
 <20190220110039.2p2iglhqlf6xapsb@linutronix.de>
In-Reply-To: <20190220110039.2p2iglhqlf6xapsb@linutronix.de>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: AM6PR0702MB3831.eurprd07.prod.outlook.com
 (15.20.1643.000)
x-incomingtopheadermarker: OriginalChecksum:F2725633AE2BEA403BA8AAF847FA9B23C977A326B1699229E4BB019027BD26C4;
 UpperCasedChecksum:2A7C2078EB85E904DB14452400520EC7BF6826725205188E4B0BC38061241B42;
 SizeAsReceived:7317; Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [CoNfN32Ps0imScO/YnD2Yof4Ni0VJ4r0]
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:VE1EUR03HT070; 
x-ms-traffictypediagnostic: VE1EUR03HT070:
x-microsoft-antispam-message-info: bTBzhgew3K0FCtQGZ5khVnMEzgd/GwNtHfa+KoyPp4VRU/fKpdggIbip50cxcKuB
Content-ID: <C73D32B78412494D97EA4065A27708FB@sct-15-20-1580-5-msonline-outlook-518d2.templateTenant>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cf7920-9f8a-4448-2595-08d697d37985
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 08:06:25.1396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_000629_543032_8F639FDE 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "yadi.hu@windriver.com" <yadi.hu@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/20/19 12:00 PM, Sebastian Andrzej Siewior wrote:
> 
> Bernd Edlinger explained the missing piece to me. With
> PAGE_OFFSET=0xC0000000 and without LPAE a R/W of 0xbffffff0 will ends up
> with:
> 

I am unable to reproduce on my target, wheter do_page_fault is directly taken,
or do_translation_fault is taken depends on whether the page table root directory
permission bits deny the access or the second level page table deny the access?

But if there is a way to get into the code path do_DataAbort->do_page_fault with
addr > TASK_SIZE, then I don't see why that works without the RT patch,
since the interrupts are enabled here:

do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
{
        struct task_struct *tsk;
        struct mm_struct *mm;
        int sig, code;
        vm_fault_t fault;
        unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;

        if (notify_page_fault(regs, fsr))
                return 0;

        tsk = current;
        mm  = tsk->mm;

        /* Enable interrupts if they were enabled in the parent context. */
        if (interrupts_enabled(regs))
                local_irq_enable();

Is preemption disabled at this point, without the RT patch?

I still don't quite see why is this no issue without the RT patch.
Can someone explain that?


Thanks
Bernd.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
