Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E36C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:22:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4092C2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S1dUXvXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4092C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=scayCF0lurrvBcJBx008y4LAC5zfFBud3zIbLc5zCGA=; b=S1dUXvXJzeorXr
	xXmqP3b5/FC49UFJMdZjCfw6V3mthCwB6GGw/8Sxx6vp3P1y5ydiIrFlfxNm5pkxIS9OrBi+jZR9M
	U92uUhED0NcwSmttgIL3UNnQrXHLk02m2ljMtlEaIytP/pZKia9Z8APxZeZmHVdsXx8Bp8WkIGX12
	kh3bDHjbtsswgIcFwH+vdqQuVFZJhcMFuvkSmuJoCrG5TyRRoJpWRJrw9MCf8dyCsPgWA3rh9P180
	hDMb9aZMj1TeAngTnnY769i5PrWvQif7BjNUUK4dQZ9Z7Ixof2P5YFUtSwPED+dlrXnsGfK7N5fUT
	0mLx+531mpagjE6diQIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmUU-0003bN-MO; Fri, 30 Nov 2018 17:22:10 +0000
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmU2-0003IM-0m
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:21:43 +0000
Received: from belgarion ([90.89.234.36]) by mwinf5d60 with ME
 id 6HMV1z00N0nnJME03HMVNT; Fri, 30 Nov 2018 18:21:30 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 30 Nov 2018 18:21:30 +0100
X-ME-IP: 90.89.234.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 5/8] ARM: pxa/mainstone: switch PCMCIA to MAX1600 library
 and gpiod APIs
References: <E1gRxl8-0001uz-6u@rmk-PC.armlinux.org.uk>
 <874lbzzt65.fsf@belgarion.home>
 <20181129174208.GA30658@n2100.armlinux.org.uk>
X-URL: http://belgarath.falguerolles.org/
Date: Fri, 30 Nov 2018 18:21:29 +0100
In-Reply-To: <20181129174208.GA30658@n2100.armlinux.org.uk> (Russell King's
 message of "Thu, 29 Nov 2018 17:42:10 +0000")
Message-ID: <87tvjyxyzq.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_092142_343855_3207E4B8 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> Please try initialising mst_pcmcia_bvd1_status[] to 1.
Indeed, that removes the warning.

With the fix to the interrupt thing, please have my :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

> Thanks for testing.
That was rather done on the Lubbock side in the following patch, but I hope
that's a good enough health sign for the serie.

Cheers.

-- 
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
