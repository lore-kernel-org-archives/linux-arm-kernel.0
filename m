Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D38C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:32:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6DF218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PyDSuKi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6DF218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Mime-Version:References:
	In-Reply-To:Date:To:From:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wKNJW9cnaA/Ar/ZTrRQ5giiGstFg/NPmt9uMmF3RuN4=; b=PyDSuKi/5SXgk+
	fIc5tckD+qZowVVGvkg0ewtwMmeuLHncsngJDhq7lalksYHRdNjPHcP3Czoy6kDub6WcTyG29qp2y
	c+gu5L/ResDttvWrAynDj9ULVuceuw6ldYh8E/6uAPI4MwFrFCAVvvohAyZ2RxquVNdu+Hw8Wq2KP
	5FsfVT0ZR2S+1uP90hHhiY5QYJTb2BBCjpzHLoyK6Hkub5266Pe9yQj9AfD5IGY61evhTYDkBaXm7
	jucQTKgNhgNgn9i1Bp6HF/t5uuxDFli5aQTtAi85raIN8EhxAzqPErnuiVMtgr5u6T4tOkOJR4ZK8
	1QujLKmFS9Fm+YnkqnVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaX5b-00073n-IB; Sat, 22 Dec 2018 02:32:31 +0000
Received: from baldur.buserror.net ([165.227.176.147])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaX5Y-00072v-KP
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 02:32:29 +0000
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gaX37-0000Oj-C3; Fri, 21 Dec 2018 20:29:57 -0600
Message-ID: <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Nicholas Mc Guire <hofrat@osadl.org>, Li Yang <leoyang.li@nxp.com>
Date: Fri, 21 Dec 2018 20:29:56 -0600
In-Reply-To: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
Organization: Red Hat
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: hofrat@osadl.org, leoyang.li@nxp.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_183228_740743_03AF7EFC 
X-CRM114-Status: UNSURE (   7.97  )
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> devm_kstrdup() may return NULL if internal allocation failed, but
> as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
> can be used here, which will only copy the reference.

Is it really going to only copy the reference?  That would require that
is_kernel_rodata(machine) be true, which it shouldn't be since it's not part
of the kernel image.

-Scott



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
