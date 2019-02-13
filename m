Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB1C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:52:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E63222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rQLl+fSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E63222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F7OKZu5PcPCUKDKxhuoN/BETL3EkZs8bxTL//UudKNU=; b=rQLl+fSu+4ceKK
	gGgxwlmBfR7P8MzgxHnvEMIlrk/cU2yNS1jccsvUCzfrVOD2QWA5zVCPaDEAw8tK/6r5ZKu7Y+vhJ
	KdGmBOnNb5+CTUzS9tuw9EzTXNABhw0+rVafHqhoZQr+lZuNZKihLatm6Eu9Ekzlw+Uf/+IsNizkh
	RaNAeWNpno65nBegFQPdXfxREhTpXoNGoAAGLcEUo7+PzNOiov4zxOpApQ8iS5nqh/J3G+WMZaiUU
	RXRWJeEvHR/IsK0lXdo2qmHHrbKazI+WTtA+tEUjG0URP0jDj1lkq3+GIrX0ZGG82mjxdxWMUgvIq
	xtjibcnmYqmwQtspIcjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvtz-00078w-Cy; Wed, 13 Feb 2019 14:52:43 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvtw-00078F-Ab
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:52:41 +0000
Received: by mail-qt1-f194.google.com with SMTP id o6so2822065qtk.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 06:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d9KSjIK52ErBRfHNEMox6sTC1sXaTyTQwnEhhuFMq8g=;
 b=Kh5yjmHzAqWuiFMNGt+qcwJprzNX+d9uqn12k7rFU6dqPJf4PCxFIIQvaY1Ddx3xzH
 mxhXk660jMrFai84JsfeN6qD72bitthqp1fO2RFfcWzTcRqyG8RvaJu/ocROjdAXyiYS
 O30ql0Vgt7N5E63T4AUXHZHeIChQKuctNMbjlDEkIL+yB6O++AL+HJhCUz3hUHoJgryJ
 ssW+sr0d8foJx5X1mA3LSiI2sxojJklMDW8kqelM/jwkLGqPlwJwZT1nXUS6uLv7S3Yy
 a0Qw3b0Vh3/gOQGZGgjRqIns2vxNErWhzjQ1ev95OWzEG3s2ugk4QVUWEc4Bq7HMrP+R
 Fsnw==
X-Gm-Message-State: AHQUAuYxBH2oTWaPEv4n2i+Xmi15foTkqkrBu5Iubiv4Kthd8jo4xe1E
 4LalS0HOacIUKnFViJnaFVVFHXXPJJHLbibL0aY=
X-Google-Smtp-Source: AHgI3IYnzFi2wTloBnRpZY8ymIWUUUlevsvxmXjBYzP1x7OeAOvAThJDQ8eBENxNwCKsDXGHCsSJxNTNqQ27L7BrZ+c=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr692562qtl.343.1550069558029; 
 Wed, 13 Feb 2019 06:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
In-Reply-To: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Feb 2019 15:52:21 +0100
Message-ID: <CAK8P3a0mbEqfzQhP0qX3kSnErBLws9ojkmbVQng9HhujFLCMvA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ARM errata 814220
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_065240_370525_33BDFC4E 
X-CRM114-Status: GOOD (  16.24  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Alexandre Torgue <alexandre.torgue@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 10:56 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
>
> Implement ARM errata 814220 for Cortex A7.
>
> This patch has been wroten by Jason Liu years ago but never send upstream.
> I have tried to contact the author on multiple email addresses but I haven't
> found any valid one...
> I have keep Jason's sign-off and just rebase the patch on to v5-rc6.
>
> Benjamin Gaignard (2):
>   ARM: errata 814220-B-Cache maintenance by set/way operations can
>     execute out of order.
>   ARM: stm32: select ARM errata 814220
>
>  arch/arm/Kconfig            | 10 ++++++++++
>  arch/arm/mach-stm32/Kconfig |  1 +
>  arch/arm/mm/cache-v7.S      |  3 +++
>  3 files changed, 14 insertions(+)

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

It probably makes most sense to keep them as a series, either
through the soc tree or Russell's patch tracker, so feel free to add
it there, and have them both in the stm32 soc branch for arm-soc
if Russell prefers.

As we have a number of Cortex-A7 based platforms with all
kinds of revisions, I wonder if we should also select the workaround
for the others. I can probably figure out which SoC platforms
are based on Cortex-A7, but I have no idea about the revisions,
so that might mean we'd have to do it for all of them. According
to the latest TRM I found, only revisions r0p0 through r0p5
exist, and the erraturm text lists r0p2 through r0p5, which may
mean all products ever shipped in practice (the oldest public
TRM from 2012 already describe r0p3).




     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
