Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD505C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:31:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744EF2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U0S/IdV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744EF2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p83Ud2ZTIfsQTbLEpJmDeKcHUOVpD/r6arTRLkABE8Q=; b=U0S/IdV0zfGYRh
	+Oum4uuI9m4dpbZE5Noz/oIRgms01a/ap5MSnulAQIAxz2ozRalCS9B+F/3UWiAJilLmXfZAzXTYg
	l3weIi4fv0LyezncmbkS7XemcB4wuP/UfizwfyzKdn63ZYKrYx+P4oeHxel0mRXQljstlNuO+r48r
	uNY6fpgrjgAJs2CBtjXU+lRzH15ZKyU92pj8AsdblVGD6AuQ5gBednQX7m8MqOjbmdapyAtGaYIHJ
	OYlmwnb61eucTBIp7w2Feqcg34Wi9GIqKQaeFcqq8TQxs8s7j5RIfFbgJ3Ijj/bnQVtYOQtSG1uDb
	Z4ckMTYee3zn/P/I65wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT5MP-0002dP-Rg; Sat, 01 Dec 2018 13:31:05 +0000
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT5MM-0002cq-4n
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 13:31:04 +0000
Received: from belgarion ([90.89.234.36]) by mwinf5d39 with ME
 id 6dWm1z0080nnJME03dWmDR; Sat, 01 Dec 2018 14:30:49 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 01 Dec 2018 14:30:49 +0100
X-ME-IP: 90.89.234.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 4/7] ARM: dts: pxa: merge &pxa3xx_ohci with &usb0
References: <20181130175543.32628-1-daniel@zonque.org>
 <20181130175543.32628-5-daniel@zonque.org>
X-URL: http://belgarath.falguerolles.org/
Date: Sat, 01 Dec 2018 14:30:45 +0100
In-Reply-To: <20181130175543.32628-5-daniel@zonque.org> (Daniel Mack's message
 of "Fri, 30 Nov 2018 18:55:40 +0100")
Message-ID: <87lg59xtkq.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_053102_466341_53B9CAB2 
X-CRM114-Status: GOOD (  15.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> Both pxa3xx.dtsi and pxa2xx.dtsi define a node for the USB controller. Merge
> them, and get rid of the one in pxa3xx.dtsi.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Excellent, but can be even better :)
Could you please address as well pxa27x.dtsi ?

As a matter of fact, this was already discussed here :
https://patchwork.kernel.org/patch/8375421/

So the proper solution might be a bit different, as if you look at the thread I
put up there, pxa25x doesn't have an USB host controller.

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
