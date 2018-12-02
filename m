Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A341CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CDA20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bfcylwqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CDA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ttYmC1lZDmiYCHDnI4n3wiK+FPc6EssR7C9YHaAojps=; b=Bfcylwqt3UrMXg
	nCHm92V/JMXJYnbFIb5K0hYyDqQoKTQALpJTQjsVjycqXg7F+2nSusJAXdpa91jX+h1qvQsVrhu4O
	Uocx9gE7C8XOXfNp0BHTErviX1/RXvXUZjX3d87J5VizatXJyow8vhgLfWZPWs/ZN37WQaiggh7HI
	+9NwhQ2vA52ZKEgUnJ4OaEkLNcuVrgpcsgcaX23ls5LSK06nX5X90xqH9n9a5nATUQTQGlx8oIXze
	/Fc8w6PzPmb1WhZBY9AGoq+bN7StMzooaBxDu0m8S6Z7DeYZWrHNfuLJ0WPOyG76j8h+o5mGYPZlh
	pbsiVICiU8jemgYL9IdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTOjw-0001cR-GW; Sun, 02 Dec 2018 10:12:40 +0000
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTOjt-0001bj-Bs
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 10:12:39 +0000
Received: from belgarion ([90.89.234.36]) by mwinf5d28 with ME
 id 6yCR1z0080nnJME03yCR9L; Sun, 02 Dec 2018 11:12:25 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 02 Dec 2018 11:12:25 +0100
X-ME-IP: 90.89.234.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 6/7] ARM: dts: pxa3xx: clean up pxa3xx clock controller
 node name
References: <20181130175543.32628-1-daniel@zonque.org>
 <20181130175543.32628-7-daniel@zonque.org>
X-URL: http://belgarath.falguerolles.org/
Date: Sun, 02 Dec 2018 11:12:25 +0100
In-Reply-To: <20181130175543.32628-7-daniel@zonque.org> (Daniel Mack's message
 of "Fri, 30 Nov 2018 18:55:42 +0100")
Message-ID: <87zhtow83a.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_021237_688242_BB46D573 
X-CRM114-Status: GOOD (  12.88  )
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

> The clock controller node does not need a unit slave designator as it does
> not have a reg property. Also, remove the underscore from the name.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Applied to pxa/dt, thanks.

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
