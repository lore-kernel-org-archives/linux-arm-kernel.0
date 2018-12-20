Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C3FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:05:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F1321741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jeRRpzR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F1321741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanmierlo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aMRwnIpLQdPK9pgjFmglXrFxOnow+T3cB9kpJlSo3xY=; b=jeRRpzR8v6YTQxho4z/pHB7xR
	+IT4Oa+47eBED5nTFPNRHOkVJXdY+3vnW+jJt7B9P+O8Uwy/p91koexY+uF5jKd2P6vpQzxCO39j2
	ckKP7MUcatqDIwU0IQ8TjDltYN8qIxBhtGdTxWvd8RqZp9asCra4iOtMAhBzd/NF3cFXylDlqxDUY
	HVflPXxrZrXx8vT/MS2ROtIz3yzW77AGkvLNKkqe+GJg1y6c+3WuTF1rIBvvvoqqhNxgDl8lyKOKs
	80KSTWWTFZBARErvbFGWTjLDGTiX63JM3niPpLeQaCUaU+KThHw1HW30c72nym9qFQBi+xunGkggw
	28yD9Bimg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZw8U-0007AL-5g; Thu, 20 Dec 2018 11:05:02 +0000
Received: from fieber.vanmierlo.com ([84.243.197.177]
 helo=kerio9.vanmierlo.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZw8N-0006wp-1t
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 11:04:57 +0000
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
 (authenticated user m.brock@vanmierlo.com)
 by kerio9.vanmierlo.com (Kerio Connect 9.2.7) with ESMTPA;
 Thu, 20 Dec 2018 12:04:31 +0100
MIME-Version: 1.0
Date: Thu, 20 Dec 2018 12:04:30 +0100
From: Maarten Brock <m.brock@vanmierlo.com>
To: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 0/4] serial: uartps: Driver updates
In-Reply-To: <be121f63-fe03-8b50-54e5-24865d856e56@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
 <06bcd18cb2e0e81d3051ef6305139d40@vanmierlo.com>
 <be121f63-fe03-8b50-54e5-24865d856e56@xilinx.com>
Message-ID: <923d0af3a92f4be6e064de90db0925ea@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_030455_301889_B89CEAE5 
X-CRM114-Status: UNSURE (   5.57  )
X-CRM114-Notice: Please train this message.
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
Cc: monstr@monstr.eu, linux-serial-owner@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-20 07:52, Michal Simek wrote:
> Hi,
> 
> On 19. 12. 18 19:40, Maarten Brock wrote:
>> Hello Michal,
>> 
>> On 2018-12-18 13:18, Michal Simek wrote:
>>> Hi,
>>> 
>>> I am sending 4 patches in series to fix some issues we found.
>>> Patches were sent separately but I have been asked to send them in
>>> serial that's why I am also adding cover letter to explain this v2
>>> version.
>>> 
>>> Thanks,
>>> Michal
>> 
>> I'm wondering why, when reading the linux-serial mailing list, I can
>> only see this cover letter.
>> Are you perhaps using a different To/Cc for the actual patches? And if
>> so, is that on purpose?
>> 
> 
> I have checked linux-serial mailing list and I see all of them there.
> https://www.spinics.net/lists/linux-serial/
> 
> Individual here.
> https://www.spinics.net/lists/linux-serial/msg32919.html
> https://www.spinics.net/lists/linux-serial/msg32916.html
> https://www.spinics.net/lists/linux-serial/msg32917.html
> https://www.spinics.net/lists/linux-serial/msg32918.html
> 
> Also I see linux-serial@ in CC in all emails I have sent.
> 
> Thanks,
> Michal

Thanks, I see them there too. But the odd thing is that I did not 
receive
them in my mailbox. And I had noticed this before that I was missing 
your
posts following a cover letter.

I normally do receive other peoples patches after a cover letter.

Maarten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
