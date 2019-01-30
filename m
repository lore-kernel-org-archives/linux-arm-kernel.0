Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8683EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:00:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D25218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QJwdq+Xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D25218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VZ8xUpHH7vu2AE4AF91NmFuoiMrby1us0RqLR/cRQJk=; b=QJwdq+Xyo3GFkV
	5uwOspYyxtK497V9t0eIxazUiR+Fd/zn0OMAZDRWztHrwXWB9qftnligIav6WmocH4HujZTgGmeaL
	JXQux/lG0M0lDu5oT6MuWWYwBmLh2gkoiHs6bwTxsWORmMtwNF1ivV+uMttdKQSjlBR6kMFn/56+T
	WRGDAj/gvNXF/9DEM79IpohO2a9DfQAxil8CmBeQTpHx81AD79bl5o2D2Z+UJaKb8FU0U5oqqi0D8
	0cestgSW71OJbW2SP739N59VtceNkmQPEAZbmm/az1TETBLHObFb5hcc5WW9tdyFeuqDi4Xs5+8Gi
	JmUugUK6DwbTtN661A3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxuS-0000s3-Sa; Wed, 30 Jan 2019 22:00:40 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxuO-0000rb-RC
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 22:00:38 +0000
Received: by mail-qk1-f196.google.com with SMTP id y16so717084qki.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 14:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rwvisFl3ym8ybE7hkwPtUj68rTjAeG0WAzKmdDl81zM=;
 b=p8s35twPKx59CsVYN7wjHPkQNUY41jcW9HfAVPM8aSPyTKM0FQbC2KQ3MjnPADXE/q
 ZDlEBvnp87qzyBy6+tMMmxkVBkYg4Djz4SYmC+LbcqYWKShvdDOHFedEKY9cTW+dWJJt
 vt4bKVXiibA4ymtUy4TRrS6HP70M9mJATBtk0XNHnZMJFOraP+Wb7oBSVbHNaNrQB3kF
 6j/Z0y+tVR+62R5qgi9Yui43cODCfiyI8L/Rj2AEbyC4SZCpUZ//keVUrCbAhfV3cbhD
 mhjU+MmXD6TCwYLqVfQz4TozIgAtRtzNGwCKt/A+fxO6hOjzswEkRSHUkASvbg7Qosfg
 ZpmQ==
X-Gm-Message-State: AJcUukdjV+6thNGgs/PjsKq8lkGmxbMq48vXzFAznzvxitw8WS9cQ8OA
 SLYPc4qfx4/ZB20vw9d/a05y7kkfGlvPIWcEQAc=
X-Google-Smtp-Source: ALg8bN6wEGw/fP0cjF2MygESjFk9pXZ9+fggbK2dINbo1vNXDL3MCYLRLJZunE9dmZKwcphyYzEelwsHk8kKJgVAf8Q=
X-Received: by 2002:a37:bdc6:: with SMTP id
 n189mr28721678qkf.330.1548885635965; 
 Wed, 30 Jan 2019 14:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20190117143751.GA3462@hp-pavilion-15-notebook-pc-brajeswar>
 <12f44672-ff9a-20cd-0f4c-44cf1c18bb5b@gmail.com>
In-Reply-To: <12f44672-ff9a-20cd-0f4c-44cf1c18bb5b@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 23:00:19 +0100
Message-ID: <CAK8P3a0TRRQ53UEjdFsmwGqvPgEfkm-7a3Ki7EDWP+dZniB+Aw@mail.gmail.com>
Subject: Re: [PATCH] arch/arm/mach-ep93xx: Remove duplicate header
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_140036_885390_C5516F82 
X-CRM114-Status: UNSURE (   9.77  )
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
Cc: sabyasachi.linux@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Lukasz Majewski <lukma@denx.de>,
 Hartley Sweeten <hsweeten@visionengravers.com>,
 Souptick Joarder <jrdr.linux@gmail.com>,
 Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 3:48 PM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
>
> On 17/01/2019 15:37, Brajeswar Ghosh wrote:
> > Remove mach/gpio-ep93xx.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
>
> Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>
> Arnd, would you take it into one of your ARM trees?

Applied to the arm/soc branch now, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
