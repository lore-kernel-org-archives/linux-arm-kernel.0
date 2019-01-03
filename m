Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B02C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:07:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94A02184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Geryh0eC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94A02184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W94eD0ijtPa0hnagmEPBCYNocNrrST129GuOz12NSS4=; b=Geryh0eC4L8ZzA
	Sd893A76s9ffqCZ0uz3hIBpY/GsANZl+JWbuBjCIK6HwEYUupgWpOVNM0KlcIzUNPdIqE5c4bdmuy
	+++iI84mp+CISvXEuInrucIRrLh6iOFqRAW39/RToF2LZKMAxurRsSZNO5SO1Q3VcgcQf8QDH3eEz
	j3BVCSYrW/U84yNn6i7/I3rBAOZ4TxmLlx/8uxwo6sIHjzY5AQdUUX+ZtjtdsOw/bMUcAjbYu1zcY
	o/KyQcLnDAh2cchlTUoN3Bfx2rcgTeK2bu/cUlJLdREtfarq+EHR0sfp5jh76JnsEVIrI+kbR7lj3
	/5gy5ViP3CEA5Kqw3bBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfACj-0003c8-Gn; Thu, 03 Jan 2019 21:07:01 +0000
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfACf-0003bR-ME
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 21:06:59 +0000
Received: from belgarion ([90.89.234.36]) by mwinf5d75 with ME
 id Kx6p1z0030nnJME03x6prY; Thu, 03 Jan 2019 22:06:52 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 03 Jan 2019 22:06:52 +0100
X-ME-IP: 90.89.234.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Peng Hao <peng.hao2@zte.com.cn>, linux@armlinux.org.uk
Subject: Re: [PATCH 2/2] arm/plat-pxa/ssp : unneeded to free devm_ allocated
 data
References: <1546060206-97556-1-git-send-email-peng.hao2@zte.com.cn>
X-URL: http://belgarath.falguerolles.org/
Date: Thu, 03 Jan 2019 22:06:48 +0100
In-Reply-To: <1546060206-97556-1-git-send-email-peng.hao2@zte.com.cn> (Peng
 Hao's message of "Sat, 29 Dec 2018 13:10:06 +0800")
Message-ID: <87tvipsb6f.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_130658_008039_A0D25C48 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Peng Hao <peng.hao2@zte.com.cn> writes:

> devm_ allocated data will be automatically freed. The free
> of devm_ allocated data is invalid.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Hi Peng Hao,

Thanks for the patch. I changed your title to fit my tree, ie. :
"ARM: pxa: ssp: unneeded to free devm_ allocated data"

If you have other patches please check what is the commit subject's prefix for
the file(s) you're touching.

Queued to pxa/fixes.

Cheers.

-- 
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
