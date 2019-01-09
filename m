Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1332C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:44:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E10D206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="imHpyl1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E10D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Vo1ZA3tJPImgkINrKWRrR2e2dOHTOBcCz2pDHxcwz0=; b=imHpyl1u4av0qO
	hWQqd7QHCAjbXLTkLyrk4p7tlhdcixvXOZ0GoSfdgRciMemK7b8ppzwn2Qqm/tElrP4e5hB2DM8LB
	bA0uD92TBfAkd2rrWylwgFFLUOJ0I+x3DoxeK9ZEGIBAWbSlOJ/Uy6lBq7OgHSwiHxDK3NGZgWDb9
	csJXtrk1CDpjET67rJyNCKlngICgpjOodNBlCqQ97r9JoJhVBSLVGGoaEcZGMxkDqFo/PMlqsrN/b
	3hfHE2zqEi+qw8H+4BBNmyhugpSXZasHKOnqoBS6CXAKOV+LoH+r54dBscFbMpHYFpZU9xyO9Lqxl
	aG/iZ6m4CVGZxOGGLzbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghKi4-0002he-3y; Wed, 09 Jan 2019 20:44:20 +0000
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghKhz-0002gw-Il
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 20:44:18 +0000
Received: from belgarion ([90.89.192.192]) by mwinf5d16 with ME
 id NLjq1z00A49XSTe03LjwQ8; Wed, 09 Jan 2019 21:44:11 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 09 Jan 2019 21:44:11 +0100
X-ME-IP: 90.89.192.192
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2] ARM: pxa: remove raumfeld board files and defconfig
References: <20190107073257.9864-1-daniel@zonque.org>
X-URL: http://belgarath.falguerolles.org/
Date: Wed, 09 Jan 2019 21:43:37 +0100
In-Reply-To: <20190107073257.9864-1-daniel@zonque.org> (Daniel Mack's message
 of "Mon, 7 Jan 2019 08:32:57 +0100")
Message-ID: <87h8ehsgsm.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_124415_898861_C8D312D2 
X-CRM114-Status: GOOD (  12.61  )
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
Cc: linux-arm-kernel@lists.infradead.org, haojian.zhuang@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> These boards are now fully ported to device-tree, so the old implementation
> can go away.
>
> The defconfig needs downstream quirks anyway, so we can just remove it from
> mainline.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Applied to pxa/for-next, thanks.

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
