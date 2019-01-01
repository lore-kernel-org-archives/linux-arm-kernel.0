Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F57C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:32:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFF02080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FmJW+0qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFF02080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6hIya70N0YxXldkCJ8zCtToi9ANvnHBmKMWnv7Pn0IQ=; b=FmJW+0qZJ+oetL
	raHk6HJvSZs7J3Exb6qRHuW4dM6qrsalw8TeoT+bcczJcON7A/g7cKUUDpsDl5Hzw9c3kxMlglVb2
	n8qjS30UJxPwSxtXO8v2/rXvYS/S3jMgcz8cwl3qNkbvqldehM8o0CM09A1Z64jXi0hYGLoKtgQXy
	S0N6PxPOokH9/xrFv+SgNr76rHBO+Wp09snGUH9bFTHuDXf92bfLs4mjeetl5yRa2bBZnqUyVIWnN
	TXWqCsDuEe/gmDRIfJ3/VHm7Uks/ER6oHTEy65ai7P7+1AH68aZY/bLsZouS9DuVe7YC171IMJf7+
	jchunSObibVk7m3nIzBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geRdt-0004tw-Vb; Tue, 01 Jan 2019 21:32:05 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geRdp-0004tF-Ve
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 21:32:03 +0000
Received: from oxbsltgw01.schlund.de ([212.227.220.145]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M2ON6-1gcmgF1xTa-003xbT; Tue, 01 Jan 2019 22:31:49 +0100
Date: Tue, 1 Jan 2019 22:31:47 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Woojung.Huh@microchip.com
Message-ID: <958035754.310420.1546378307673@email.ionos.de>
In-Reply-To: <BN6PR1101MB21305BBBB3F617C9C49141E4E7B10@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <1082628525.187562.1546041777025@email.ionos.de>
 <86efa0brfx.wl-marc.zyngier@arm.com>
 <BN6PR1101MB21305BBBB3F617C9C49141E4E7B10@BN6PR1101MB2130.namprd11.prod.outlook.com>
Subject: RE: lan78xx: WARNING: irq 79 handler enabled interrupts
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:eKwtrkAbx/WiVbmfBkPgu6kUoi3IcX5GwWOmzbziuqDG5KHTCL0
 XxZKSLXfLzZun0QDM2K5nInEGMkoWIFcHSJbByGVWWWI95uywXtZvT59LCGoBnGZ1qTuGGQ
 UqRB9UaoElawO8o8rgZlT88g1s0nPaXv244pVIRN+uGyH8OIhAzN3lQoLWcAJGfg3jVckR6
 8qgxPQWyBPIotoexcMpng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K8X7igpq9ao=:IFBAVE9m2V3Xzcs0DVheZ9
 6AXIsV2daw4FFuIR9qGU8hSz6k+ljDJ7JQQnPEaXeUqE/moRh9HKUiaYgXf4EKe4nQwUf6/fg
 Xeb2Wu0wFrTLqLrrKgPYHohpvH+kiL67yaXs0Lo8+HfSlhEKakNj1EGyohRszAuUjxxvrEWjK
 c9Rc8PrIXGEwMp0tmhcnoVWojbcdxuv+AqcQ0YVfO65FKD1O7lEFFLUSIPXFo7jDS7AHgv/w5
 Ej9UGpGOYUQkOvNM8s5CxeOC0lozLCl4NN4JAYL894Y/e/yi7h6BdPDcykeYlDKBPeg9btbfJ
 x+EOeRrsE5HAinVtItBlpE6hn0QRNBva5Y3pK2CyXMbC7+cOkCw2SzSoYNPYt+RvNIiM2LFsR
 m+viZd4LGUQTzTP+5/GUSQSTlHoQbro0waaJhqU07y9nCkKkOxpVOj6wFGOdC8dhJQLBRJjv5
 fsB07BqvGnp7gK112iW6bx40zawtO+rnsrtA73kfOPM1RMFIlgLblk9xG3TvwcYnXfpiG5RKP
 eGfhoyVHG/zJDjCxBxntCRSSZkpZosyLYsjbdXVht8QSliJbTmwgi7L0DLU+EK1JNcx5oKnqC
 mTWyIyg1f4R16XolihsL86yix+j1VOgCXGeuGGbNMTQGY1eGiXSjM0HuWlvZHoSE/GyzQWeCL
 0tUqg+xsWrSNkIvZcTDbRFidAWM9vw1zc7zsr6DozwmPL/0Dylnkd+PgwzwIbqezM9XC0BSSS
 D7R99uM/X85f3v+6pzbmPrQ4DBHCyVlFmf7mPM6TjdkmEdFXBC9XNnBZwn4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_133202_323154_956BB08C 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: marc.zyngier@arm.com, eric@anholt.net, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Woojung,

> Woojung.Huh@microchip.com hat am 30. Dezember 2018 um 04:25 geschrieben:
> 
> 
> HI Marc & Stephen,
> 
> Most of engineers are out until New Year's Day.

thanks. I didn't expect a reply that fast.

>  
> LAN78xx driver uses irq_domain for phy interrupt, but smsc95xx uses polling.
> Need to check flow again, you can try that comment out "lan78xx_setup_irq_domain" to
> make dev->domain_data.phyirq = 0 which forces PHY polling.

I tested your suggestion with multi_v7_defconfig (32 bit) and arm64/defconfig.
The warning disappeared and Ethernet is still working.

Only the old issue that we can't receive until a first packet has been send out reappear. But this should be manageable.

>  
> Can you share if this is filed on RPI forum?

I didn't submit this to the raspberrypi.org forum / github. They mostly care about the next LTS release 4.19 and not really about arm64.

But an Arch Linux user (aarch64 using Mainline kernel) already discovered this issue:
https://archlinuxarm.org/forum/viewtopic.php?f=65&t=13302

> Also, it would be appreciated if you can create a ticket on Microchip site at
> https://www.microchip.com/technical-support/hot-topics

Done

Best regards
Stefan

> 
> Best Regards,
> Woojung
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
