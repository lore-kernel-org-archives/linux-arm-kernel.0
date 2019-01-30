Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E857AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:02:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A5120989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A9xR9m+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A5120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1ibtKioiGsiiL5YVE0JCbK9lb67pe9/5s7tC7FfWBbc=; b=A9xR9m+Fk4iVeB
	0FLNuRzlR/+vzXnSNNO2zFqdxIkUsuUWFcumv9PY+9K/c1wgKAMU3VfQBGwhcWKDMRUkdv+RADM4K
	MbxAS9ij048uzAXa69qeMxTTb4ql0F2VdZ2c1FTyzDrBKBeN9ksbbFh5VfMNfaojtFrp4Z6HrBfmn
	ixqRGmzfaiTR2JnVLLGwu+0L2Rjf5eMqT5Zfjbh5kYCHVBKL+AsPoaoaFGUo3i715zn3rRavScPGT
	oGwaYZ+lk44HvtT1jRvkygFHY/hHsx2+7/LoCmzMSnSACIHr6e4hgtHzCPI7GsQi3Nij2cEJR7PTT
	Mm+4U1D2GXO2fijoe5Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotFP-0003QL-Gz; Wed, 30 Jan 2019 17:01:59 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotFI-0003Pz-Sc
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 17:01:57 +0000
Received: by mail-qt1-f193.google.com with SMTP id y20so209986qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 09:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rNrzBdHR+DAuEZYOSpEKHW3eCZjn42JWF433c5lnn7E=;
 b=L18hqsYEHqs2VnAgDgHd2ZinUjmlVmsC5xYjtOD3wfZZK0Kw/9oN/TlxdBBYJEsKyn
 Q/JDZgxIGYpXrT9y6hH3Chdp8oMmvC0FNtUo82KAsJKBYozvW6vSqbnOqK+CyF7QAx1v
 +XtY+9Vgw39tc5duA079qdo5Tkh5esiXOVROx7G9DcAXiz3f2H2s4R2IBYzfOor3fAJM
 o8zqhSVq4IbaZPurTKGQTSI72TSN1bsa/EXVpwYoTgFKMvtjwsIs4s8CtLgLALaOYBcJ
 p8csgqEeIaf1Q7+DfHDSCb120yyA7K3/JR8xB1mgfPdSZwCXt3znF+d0aVUv8MduDNgR
 vMWw==
X-Gm-Message-State: AJcUukeOreHIDUYlbE5TOBZVKHbnWYvEFe14Nd4NrRATy3275GbQfKtc
 1V+y9CV6vjwNxxPhdKj0EOj2kFd7xLiWQtLHkeE=
X-Google-Smtp-Source: ALg8bN4zMB4SqhRQmXyU+pQmyitIhX17EsbiMYnSMHy4iYPcQlel/BHO07sxUsiHfeHybKFmHQ/n6AspB+xTdGmbvyg=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr29321823qtm.96.1548867711815; 
 Wed, 30 Jan 2019 09:01:51 -0800 (PST)
MIME-Version: 1.0
References: <CACPK8Xczpf-wwGYJYHOgQ3TOpcLOz5wkPJbR8RfxjS0i2i52eg@mail.gmail.com>
In-Reply-To: <CACPK8Xczpf-wwGYJYHOgQ3TOpcLOz5wkPJbR8RfxjS0i2i52eg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 18:01:35 +0100
Message-ID: <CAK8P3a3NBLA0FpTJeMoy2uz+cnNw3ik1eBr7adantp140cy0Zg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: aspeed: dts changes for 5.1
To: Joel Stanley <joel@jms.id.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_090155_961006_94312BE7 
X-CRM114-Status: GOOD (  12.76  )
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
Cc: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>,
 Mark Walton <mark.walton@serialtek.com>, Patrick Venture <venture@google.com>,
 arm <arm@kernel.org>, John Wang <wangzqbj@inspur.com>,
 Vijay Khemka <vijaykhemka@fb.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 5:20 AM Joel Stanley <joel@jms.id.au> wrote:
>
> Hello ARM Maintainers!
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
>     tags/aspeed-5.1-devicetree
>
> for you to fetch changes up to e1542521499070f88b18846f676b4cd2a166aee5:
>
>   ARM: dts: aspeed: quanta-q71l: enable uart1 (2019-01-30 14:28:57 +1100)
>
> ----------------------------------------------------------------
> ASPEED device tree updates for 5.1
>
>  - New machine: Inspur ON5263M5, an Intel Xeon OCP compute node
>
>  - Misc device tree updates from the OpenBMC project
>
>  - #iterrupt-cells fix for GPIO controller


Pulled into arm/dt, with a small typo fix for the changelog.

Thanks,

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
