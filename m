Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FB6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:31:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EE520840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pizc/KkK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Djjg6HJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EE520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Iv+70qMcj+VI20KgMYD8kWBA/0qrZ/g79jchl9uNPFk=; b=Pizc/KkK04y7Qm
	0+fpbaWecrkTn7ByUFNrZNgkIfKJ5lAdq0pazfMXgIBFXe5BY+ir+8ldv+PvWVYKexTbsvH8/V46O
	79sR101XEJFO7uUYfRQBZYrE0g4Wohdr6MHjZ+1KptvAOkw25Ie8OrTe2rcPIw+zFP0apN/9lNFa6
	45ErCP9JOSUON/emuv/Smq0AHgfR4a/PLYahNCRbBULv/KNvVqkJS+Kpks9z/CFYNkfdKc9xNXLZ+
	kwvcMOEpBwgE4WhMLur/3hvQXnDewKrpoOxhB+HCw/gbovJ7W9OSCcOj48oH8kzIrZ8d53hmBlqHv
	HvpE8J1zOOpdaK5yXTFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjsmK-00064C-V5; Wed, 16 Jan 2019 21:31:16 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjsmG-00063T-Fl
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 21:31:15 +0000
Received: from zn.tnic (p200300EC2BC98A005C5A6BB989505731.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc9:8a00:5c5a:6bb9:8950:5731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAC421EC0B59;
 Wed, 16 Jan 2019 22:31:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1547674265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=dtys+NmIRT0opIiV30YuHca9dgjL9piQ9Ytb2fj5jxU=;
 b=Djjg6HJYlOhSD+E3+wXrjolFDjvW5SAda1VvM2HOvi3ne3/H9lRclElLbz+p+uSMhqO/eP
 7aId2l2yD8DEs0NYoWBhzbFijeTlyflPQcG+tgLYy8C041FyF4B/UB1sPw6XVklp6TxJfy
 sfpED6fu1Di+LMkbAQjdO38TYQXZ+68=
Date: Wed, 16 Jan 2019 22:30:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Stefan Schaeckeler <schaecsn@gmx.net>
Subject: Re: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
Message-ID: <20190116213059.GM15409@zn.tnic>
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-2-git-send-email-schaecsn@gmx.net>
 <20190110095049.GB17621@zn.tnic>
 <20190115175749.01E3C6E85603@corona.crabdance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115175749.01E3C6E85603@corona.crabdance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_133112_681112_4B346E12 
X-CRM114-Status: GOOD (  10.17  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, joel@jms.id.au, sschaeck@cisco.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 09:57:48AM -0800, Stefan Schaeckeler wrote:
> That's interesting. I did a grep over all 16944 GPL licensed files with an SPDX
> identifier.
> 
> 785 of them have a license text while 16159 don't.

Goes to show that we're still in the process of converting stuff to SPDX.

> When stripping off aspeed_edac_, some static function names will become quite
> "bare-bone":
> 
> aspeed_edac_init(), aspeed_edac_exit(), aspeed_edac_probe(),
> aspeed_edac_remove(), aspeed_edac_of_match(), aspeed_edac_isr(),
> aspeed_edac_config_irq().

So namespaced function names we normally use for globally visible
symbols and those are not but only driver-specific. So, for example,

aspeed_edac_config_irq()

is a mouthful, at least to me, and not needed. config_irq(), OTOH, is
clear at a very quick glance.

The others, aspeed_edac_init(), etc, you could call aspeed_init(),
aspeed_exit() or so.

But since you're going to be stare at that code, this was just a
suggestion. Your call. :)

> Does your suggestion also apply to static variables? E.g. aspeed_edac_regmap,
> aspeed_edac_regmap_config, aspeed_edac_driver? Also, here some variable names
> would become quite "bare-bone".

Same as above.

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
