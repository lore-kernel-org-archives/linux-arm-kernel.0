Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E43C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:07:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE3F206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pMs2qAlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE3F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1QLAef7jts+o+gjNVixnDEs6SfTYAubnt2nTZIePg1Y=; b=pMs2qAlMfJP7gE
	H4aN3S9mw5Zhw29vG3gXcwRch6dpZckQjttXjBnh6FfxXW5yhHCwwyAe8dCx85Tw8uX/Bwg4VOTNm
	gOYpwXzn6kg2M9ZDGke5DrjMimUcv184HN4M8jo6reiE4HrphHiMIYGupXcwA+rumQU4WfAQ/lXc1
	F/r/Agj+443lYlPvf2MHNM4RvsZue/5kdWnNlmLkfYkeSL1UVILZXp6bu8FLiYtlrGLwdPGTVc14M
	yCIREpgAxz3M1q+AJ7GoipJ5BubYAZESpj1IwTnwzbw/rFX2Aba9iLL4/7l/jK805cKPDoRz/SNVK
	cJy3be/Fc2gP7pVYfZVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXq05-0000d8-89; Fri, 14 Dec 2018 16:07:41 +0000
Received: from bastet.se.axis.com ([195.60.68.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXq01-0000c0-LK
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 16:07:39 +0000
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 507F9185FC;
 Fri, 14 Dec 2018 17:07:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id eqeNzm4zGd3u; Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
 by bastet.se.axis.com (Postfix) with ESMTPS id B7D56185EE;
 Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A719E1A063;
 Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BB941A062;
 Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder02.se.axis.com (Postfix) with ESMTP;
 Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
 by seth.se.axis.com (Postfix) with ESMTP id 8F693266E;
 Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
 id 8DE0F80D7B; Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Date: Fri, 14 Dec 2018 17:07:25 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v5 2/2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181214160725.kfhatfi47dz3guts@axis.com>
References: <20181204141415.969-1-vincent.whitchurch@axis.com>
 <20181204141415.969-2-vincent.whitchurch@axis.com>
 <20181206172920.GA2728@linux-8ccs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206172920.GA2728@linux-8ccs>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_080737_855158_9087DC97 
X-CRM114-Status: GOOD (  11.34  )
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
Cc: linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, dave.martin@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 06:29:20PM +0100, Jessica Yu wrote:
> Also, do you mind if I drop the module_ prefix from
> module_kallsyms_symbol_value()? I recently submitted some internal
> module kallsyms cleanups [1] and there we have the newly renamed
> kallsyms_symbol_name(), so I think it'd be nice if we kept the naming
> scheme consistent with just kallsyms_symbol_value(). I could just do
> this myself if you don't want to respin a v6.

I've sent out a v6 with this change.  I also rebased the change on top
of your cleanups in modules-next.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
