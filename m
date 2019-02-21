Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9289C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:32:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81AA20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nqThK6Tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81AA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tiutfdm5PmV4b5DzK0p6T1juogsjmKuEkSLSr3bIsyw=; b=nqThK6TfNHTc1s
	Mt4wMV4rTwMwRcQsF95oLZP8KGzLuRAMeirhA8M9Bjq1BtvH0tBclItBy3HuhphKRb5RCd5KRcQLC
	So3JqdICd6+0OCrl8qMr8QhHd2AMzNAXOJ5K7hUD61AbXhJxuQsWVXga1hniwe3LZ1sjPJdqlHimE
	PbZlJoVl3P2SgnQFbAfvktskNTUtvE0DRrsDeHge5iOGy7dKVFiuaDcfVLesN4V5MBtp/FtVYzu3L
	bFi8HU9zXYIkAIwEUnxkrXQxfEED2paNJvcRSijDgiCyM94yKaXqynnmc95Ae/oXi1Og1fODyfzEX
	5DEbG06DIptN0zvZohXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwki1-0001er-8y; Thu, 21 Feb 2019 09:32:01 +0000
Received: from mail-oln040092068021.outbound.protection.outlook.com
 ([40.92.68.21] helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwkhw-0001Zu-P6
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 09:31:58 +0000
Received: from AM5EUR02FT063.eop-EUR02.prod.protection.outlook.com
 (10.152.8.59) by AM5EUR02HT152.eop-EUR02.prod.protection.outlook.com
 (10.152.9.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 21 Feb
 2019 09:31:53 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.8.51) by
 AM5EUR02FT063.mail.protection.outlook.com (10.152.9.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 21 Feb 2019 09:31:53 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%5]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 09:31:53 +0000
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Russell King - ARM
 Linux admin" <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Thread-Topic: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Thread-Index: AQHUxWnWUPB2na06qUiuVihk2ZlxqKXiTBcAgAZAHICAATa1gIAAP62n
Date: Thu, 21 Feb 2019 09:31:53 +0000
Message-ID: <VI1PR0702MB3840118FE9014CB1E9801F83E47E0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
 <20190216113338.irr5j4ukhpwngval@shell.armlinux.org.uk>
 <20190220110039.2p2iglhqlf6xapsb@linutronix.de>,
 <f05d2cae-5664-6cc7-51c8-933d6d1403ec@hotmail.de>
In-Reply-To: <f05d2cae-5664-6cc7-51c8-933d6d1403ec@hotmail.de>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:F26606F90343DD771E8EEF8B18B206AEB1FD001576E14AC2FA1DB30A8D7F27C0;
 UpperCasedChecksum:B4DD90C9AFA74E189500AA6C299D2888E1F74147CA4153EB32DDF93360D058B2;
 SizeAsReceived:7369; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [jvwKyT6qBzSi5o8JQohjAjLKDvJPXz3P]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031322404)(2017031323274)(1603101475)(1601125500)(1701031045);
 SRVR:AM5EUR02HT152; 
x-ms-traffictypediagnostic: AM5EUR02HT152:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:AM5EUR02HT152; BCL:0; PCL:0; RULEID:; SRVR:AM5EUR02HT152; 
x-microsoft-antispam-message-info: WyhQUE+ed5aC8eY251oPTi2eDmtViGAvB0dwN64ZRGkBnoLm1E6gvLvqA41Al7Sn
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: b07ec461-ef3a-4ba0-50f2-08d697df6a3a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:31:53.4151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT152
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_013157_005187_2C8F2EE1 
X-CRM114-Status: GOOD (  14.15  )
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

> But if there is a way to get into the code path do_DataAbort->do_page_fault with
> addr > TASK_SIZE, then I don't see why that works without the RT patch,
> since the interrupts are enabled here:
>
> do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> {
>         struct task_struct *tsk;
>         struct mm_struct *mm;
>         int sig, code;
>         vm_fault_t fault;
>         unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> 
>         if (notify_page_fault(regs, fsr))
>                 return 0;
> 
>         tsk = current;
>         mm  = tsk->mm;
> 
>         /* Enable interrupts if they were enabled in the parent context. */
>         if (interrupts_enabled(regs))
>                 local_irq_enable();
> 
> Is preemption disabled at this point, without the RT patch?
> 
> I still don't quite see why is this no issue without the RT patch.
> Can someone explain that?

Never mind, now I found out how to prove that it is not a RT issue:

$ cat t2.c 
int main() {
  *((char*)0xFFFFFFFF) = 1;
}
$ gcc t2.c -o t2
$ ./t2 
BUG: using smp_processor_id() in preemptible [00000000] code: t2/832
caller is debug_smp_processor_id+0x18/0x24
CPU: 1 PID: 832 Comm: t2 Not tainted 4.18.0-00005-g7523d7f #1
Hardware name: Altera SOCFPGA
[<80112e68>] (unwind_backtrace) from [<8010da28>] (show_stack+0x20/0x24)
[<8010da28>] (show_stack) from [<806bcaec>] (dump_stack+0x78/0x94)
[<806bcaec>] (dump_stack) from [<8043f2d0>] (check_preemption_disabled+0xe4/0x120)
[<8043f2d0>] (check_preemption_disabled) from [<8043f324>] (debug_smp_processor_id+0x18/0x24)
[<8043f324>] (debug_smp_processor_id) from [<80116ba0>] (__do_user_fault+0x48/0x13c)
[<80116ba0>] (__do_user_fault) from [<8011700c>] (do_page_fault+0x2f4/0x328)
[<8011700c>] (do_page_fault) from [<80117200>] (do_DataAbort+0x58/0x100)
[<80117200>] (do_DataAbort) from [<80102460>] (__dabt_usr+0x40/0x60)
Exception stack(0xbf197fb0 to 0xbf197ff8)
7fa0:                                     00000001 7e963d94 00000001 ffffffff
7fc0: 000103f8 00000000 000102e0 00000000 00000000 00000000 76fa9000 7e963c3c
7fe0: 00000000 7e963c3c 76e47bbc 000103e0 60060010 ffffffff
Segmentation fault


What exactly is the reason why we should not apply this patch in the non-RT kernel as well:

https://marc.info/?l=linux-rt-users&m=154997565610392&w=2



Thanks
Bernd.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
