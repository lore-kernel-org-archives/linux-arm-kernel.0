Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC5AC10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:16:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBBE2077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MlG6tcRB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="X9N2wtn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBBE2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KMnPdB4YHB0p5/ZtTnHNg+vkAtvdgpn0YACK+y2ctc0=; b=MlG6tcRBaAZEXO
	lD+/ndfF5gmTRwnaiB7h8UshVH5O+ASA3oeI9+Jx2RfpOs/+nQkgzwPTc47dRYWQ55r2gQL/vIsSk
	QWs1r0Nsp18qdyXu4YQ1+oOMmqJoWViutDP3xGTKYJHWAXsVCkuNGP/pbUBlHg9q8T+FoKtHmvm8I
	1tmlqc2BtFkop8oT0NFFxQok/hMvUMas8jICWIGiDiXGrHB2wNOHDMNWrudAVXYyZ7jZAAXu7ZW0X
	FJ5UIj4cl0aUXJmxToVw3RQNwt9JBJVobRAltkSkVRGStx7PDHY6UglBKGwHvo+tsEjRIoQQraENY
	cNUkJH5vSukMQzShU+lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJgH-0003ad-VC; Thu, 14 Feb 2019 16:16:09 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJgC-0003Zc-Fr
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:16:07 +0000
Received: from zn.tnic (p200300EC2BCDFC001CE8649D49136343.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcd:fc00:1ce8:649d:4913:6343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11D161EC0253;
 Thu, 14 Feb 2019 17:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1550160957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=nRzGo2WdRGVlfCrR5IW3r6niSjb+gE5vLdPAiNJgD2c=;
 b=X9N2wtn6f0+HrkqlYxsrPU1T4BUJXTu6UuzwxZwPNn+jFGABVXEN4BN5WClF+wGi1DxAQq
 E/Rvm4hnd4jV3rJSqgqbAXFSHNsWcXRoVTe1Ju+cvwu5Lugv3hoDPrpvlrXJiHO4y4eoFV
 P1NBzIFEoRdA87/zavwJ2qWiX1cCQrQ=
Date: Thu, 14 Feb 2019 17:15:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v8 03/14] mm, x86: Add support for eXclusive Page
 Frame Ownership (XPFO)
Message-ID: <20190214161552.GF4423@zn.tnic>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <8275de2a7e6b72d19b1cd2ec5d71a42c2c7dd6c5.1550088114.git.khalid.aziz@oracle.com>
 <20190214105631.GJ32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190214105631.GJ32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_081604_683628_6B599D28 
X-CRM114-Status: UNSURE (   7.66  )
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
Cc: mhocko@suse.com, Tycho Andersen <tycho@docker.com>,
 kernel-hardening@lists.openwall.com, catalin.marinas@arm.com,
 will.deacon@arm.com, dave.hansen@intel.com,
 Khalid Aziz <khalid.aziz@oracle.com>, deepa.srinivasan@oracle.com,
 steven.sistare@oracle.com, tglx@linutronix.de, tycho@tycho.ws,
 ak@linux.intel.com, kirill.shutemov@linux.intel.com, x86@kernel.org,
 jmorris@namei.org, hch@lst.de, kanth.ghatraju@oracle.com, jsteckli@amazon.de,
 labbott@redhat.com, pradeep.vincent@oracle.com, konrad.wilk@oracle.com,
 jcm@redhat.com, liran.alon@oracle.com, luto@kernel.org,
 boris.ostrovsky@oracle.com, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com,
 Marco Benatto <marco.antonio.780@gmail.com>, linux-mm@kvack.org,
 juergh@gmail.com, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
 tyhicks@canonical.com, john.haxby@oracle.com,
 Juerg Haefliger <juerg.haefliger@canonical.com>, oao.m.martins@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, torvalds@linux-foundation.org,
 dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 11:56:31AM +0100, Peter Zijlstra wrote:
> > +EXPORT_SYMBOL(xpfo_kunmap);
> 
> And these here things are most definitely not IRQ-safe.

Should also be EXPORT_SYMBOL_GPL.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
