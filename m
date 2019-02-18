Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4041C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:10:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698F22077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mi9/b3O/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1nah7a5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698F22077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FdGkP/oAdo4gjbD+pPRom0fKPRNkIhL12tJsr7W2lAM=; b=Mi9/b3O/EYu07T
	xcPdgV1ZRn7A15z0WFt4Ty2m/N7OcwJvxzuEYya2oYEV0LN/B/sVsJONDietsWVHHqNkiRl0DOnvs
	Bn5QdJo1fAPmPtnCR9/KndpJNhOa8NgsrYHThP1dNK7W3QykpqsF6WalghzFfVSfkJDyvfBd5A0ZM
	XJpPJt0Y63fvsIaq97VQFTvoi/ebTAzRSPHTwLaCmmAgnQq9QmtW50wEcuC2GQu8ffPPE7lK9wmNB
	X4pK+fL+28gRROuS/z1r0W1SwFyl9jaWDC5n5zEeRaN+4QNoyroGakPttIx8GsZgh5vVi8vymZH9o
	8a2dTiylW1yMHryc/mGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhkn-00016d-0z; Mon, 18 Feb 2019 12:10:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhkf-00015W-AG
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:10:31 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9536F2077B;
 Mon, 18 Feb 2019 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550491824;
 bh=A6Y3qaXf+pA491fWP51Z3P7/jPhiPA49fnNMRE0l/AU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1nah7a5vXokx8aztzMsfGjpxCjItqrhsMvGm+W0EJYFqrmDfRWZ8+ia01haYvnzBa
 wu+Bz6d40QywGZYkMB5WwycayLgdSoPt9r+rlANjPoumLlJo1aM0jCUFLQa9aN9BjK
 gX+GjiTJAuY8d7f8vgtK/+vaCLBdSiszAjFfN0yc=
Date: Mon, 18 Feb 2019 13:09:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: next-20190215 build: 2 failures 19 warnings (next-20190215)
Message-ID: <20190218120921.GA11524@kroah.com>
References: <E1gukSa-0003kX-JD@optimist> <20190218113217.GA10794@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218113217.GA10794@sirena.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_041025_900489_1E270602 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 Jassi Brar <jaswinder.singh@linaro.org>, linux-next@vger.kernel.org,
 linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 11:32:17AM +0000, Mark Brown wrote:
> On Fri, Feb 15, 2019 at 08:51:48PM +0000, Build bot for Mark Brown wrote:
> 
> The build failure with mbox_fush() in the tegra-tcu driver that was
> initially reported two weeks ago is still present in -next (this report
> is from Friday but it's also present today):
> 
> > 	arm64-allmodconfig
> > ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!
> > 
> > 	arm-allmodconfig
> > ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!
> 
> Is there any progress on getting a fix merged?

I can take the fix in my tty tree if I get an ack from the mbox
maintainer...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
