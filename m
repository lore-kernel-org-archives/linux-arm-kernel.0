Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFF1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 08:00:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A9C21939
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 08:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rAvP8O4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A9C21939
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l/4UH2w8RBVOasb+6mMvFDglrwCS8aFN0Cg5b8nqO0Q=; b=rAvP8O4GkrYAVy
	lO4yQMkU/10KuklcghaoWg+Jyly6pTzE/as3/TQ+HAp4ys+knvkFCqynUwa1qoCUvuFf9ko2wlFq8
	ByW8Frb84BgS5sodfRa/r38TXleCxbrWC0MPHDbEWTVIGpgyg0MZicgeImbtjz7MUMT91FWV4/tDQ
	jvEL949HWJ2ukVZ0/Lh3zUeez3aE/PJtv57sb7zZDnM3hGgboI1EfNo7qRwSEp3U3wyO3TPCc0lmk
	EiWMwJA1jccNwRdPPQGtZPbUm1rzRNoB379heJDx7d9WvGB5OaS+YSf82bDnVn6Ds1z/du0fVGY6T
	AK6MppynN+VxCKrorReQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gacCr-0004Xf-WC; Sat, 22 Dec 2018 08:00:22 +0000
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]
 helo=mail.osadl.at)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gacCn-0003IU-EH
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 08:00:20 +0000
Received: by mail.osadl.at (Postfix, from userid 1001)
 id C59C15C0864; Sat, 22 Dec 2018 08:59:44 +0100 (CET)
Date: Sat, 22 Dec 2018 08:59:44 +0100
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
Message-ID: <20181222075944.GA26155@osadl.at>
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
 <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_000017_662853_B8D10F4F 
X-CRM114-Status: GOOD (  12.63  )
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
Cc: Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 08:29:56PM -0600, Scott Wood wrote:
> On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> > devm_kstrdup() may return NULL if internal allocation failed, but
> > as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
> > can be used here, which will only copy the reference.
> 
> Is it really going to only copy the reference?  That would require that
> is_kernel_rodata(machine) be true, which it shouldn't be since it's not part
> of the kernel image.
>
I had tried to figure out what is RO and what not but was not 
able to determine that - from the discussion it seemed that the
assumption of RO is correct though I did not ask if it would
satisfy is_kernel_rodata() so that explains the incorrect assertion.
see https://lkml.org/lkml/2018/12/6/42
So then the only option is to check the return and cleanup
on allocation failure as the orriginal patch proposed.

thanks for clearifying this !
hofrat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
