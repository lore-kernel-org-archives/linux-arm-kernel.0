Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607A9C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:50:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93AB20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dKH+Q6b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93AB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fJoYlXTyCTfGaGpaQZjn62OFY5BX5hFz64bsYwvwxE4=; b=dKH+Q6b0LyBr6dR+Nr35YHsOq
	UGSb71NADa95KHvT+ailBFKm2B37TQD0rw5Ln8p6RDxvSszLJRGudw4DI0J30MJQgzeq/J2tjHku9
	3Q6vSeL31XB+c06rCHsq3CRLLk+auPwx/3XaG9QXxH37OIAdpkEoO9nqXp/aXHqAneuG/ADh2TU0i
	eXo9BvV3/3UOG+cldMOorJETcFQtf2z5S6ababETA5JhmXp4CGPKf85sI0ugUGfCR1WWYClmvgv34
	hKgpfB6yoBpBkdE7yVOdahkADrQ76FGxuYmTP9tnhyDgq2PzoruWmvduM6FcvF3aU6x46yqJpZQmB
	/3Domko3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT5ee-0008N4-Ox; Sat, 01 Dec 2018 13:49:56 +0000
Received: from mail.bugwerft.de ([46.23.86.59])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT5eb-0008Mc-5N
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 13:49:54 +0000
Received: from [192.168.178.170] (p57BC9ACB.dip0.t-ipconnect.de
 [87.188.154.203])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 582612C47AF;
 Sat,  1 Dec 2018 13:49:23 +0000 (UTC)
Subject: Re: [PATCH 4/7] ARM: dts: pxa: merge &pxa3xx_ohci with &usb0
To: Robert Jarzmik <robert.jarzmik@free.fr>
References: <20181130175543.32628-1-daniel@zonque.org>
 <20181130175543.32628-5-daniel@zonque.org> <87lg59xtkq.fsf@belgarion.home>
From: Daniel Mack <daniel@zonque.org>
Message-ID: <8f6aa1b2-b154-dbdd-9c0c-76ba882f7933@zonque.org>
Date: Sat, 1 Dec 2018 14:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <87lg59xtkq.fsf@belgarion.home>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_054953_340035_9D0B3623 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, haojian.zhuang@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/12/2018 2:30 PM, Robert Jarzmik wrote:
> Daniel Mack <daniel@zonque.org> writes:
> 
>> Both pxa3xx.dtsi and pxa2xx.dtsi define a node for the USB controller. Merge
>> them, and get rid of the one in pxa3xx.dtsi.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Excellent, but can be even better :)
> Could you please address as well pxa27x.dtsi ?
> 
> As a matter of fact, this was already discussed here :
> https://patchwork.kernel.org/patch/8375421/
> 
> So the proper solution might be a bit different, as if you look at the thread I
> put up there, pxa25x doesn't have an USB host controller.

Ah, okay. Thanks for the pointer. Will send a new patch, just ignore 
this one please.


Thanks,
Daniel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
