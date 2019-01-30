Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E025C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:42:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAE52184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F0T2UxKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAE52184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G/E1THIq+kobirp9jvV1rOnVCMrRCXkUYgkARso1RZM=; b=F0T2UxKgP3OHsT
	e6uvUghAvuYybCBrY/eMaf/o9JQa1OkWM4tObKUT8Bv7+FvxnXG9m+1GQKoup9c8P76ONVFoPH3dM
	TbEAhz/ubdWofe/ZTEnn7OoNGAEG4Jf27Xz+Ntpiyc6j8Mvv+FCyXFkiCC1oXN4Kgy58KOpeX0r+s
	Mj32C/eaELXAudq5q6KbgKOSUA320fDhO0q63giKM5kSGUxeY4mI+4UenOV1D1O9pDnbZaB+3hSPa
	/RQ5sgwlcdLbjb00NAse8EjM9+oq7KxA80bhihG5XmaIKFL3E0GzIPJOWjyXmQOL/LSk1VxzaJ0IY
	UvCRULS39YkrHSlV07ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonKa-0000Dk-0L; Wed, 30 Jan 2019 10:42:56 +0000
Received: from mail-qt1-f175.google.com ([209.85.160.175])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonKV-0000D9-04
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:42:53 +0000
Received: by mail-qt1-f175.google.com with SMTP id e5so25585995qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YeyAxQ5hjwkykAdT4/swCCucfA6tExp+OHYx6FIZ1Mk=;
 b=bSW3qZjDY4IxUSYd2JjSNQq5CsAhdmWKS/+INaue1GOoAH9DtFI+fwFigFmMnuHDjO
 UyY9WTs9C5G44hUsLlsbep69teGIle/MP1/bJo6w/o7lKMOK22+cNES13YVEaCJC91gv
 Mfn1x05bJrrV1ltXMcOOwUHmbBfKUOa7WkxOMUTXFpVJTMCeLxUrfzNQLRdP0TWYq2oo
 b8BK2QzGvRpic+vA+89ffX5LEuTixh2XcI1+QDM4N/xNKcVqDrIkYG9WRyd+QeUXl09B
 d2fDdkDagV5nFsxT8dIlFwhGXn4Buru3jql3unnbQj0fsjh0CvzOo1PIcJ9qHZP7aaSK
 jlVg==
X-Gm-Message-State: AJcUukfhoSzaCtTgtDlopxkEFzBV+xUXpg/VZJzFvPXUyeNwyp84R3Ti
 1UAjY9FNrrtn5My4gvO0AAg/h3CXGcocp/+qrDSsIA==
X-Google-Smtp-Source: ALg8bN5PvRjXft0nqQFmlm766TgnGbuZXtYq2YazM7gsZ9GyljnmMYq4/HuBFSAniVT1MhhnzGkA7Mcbjm+4hOSj6Bk=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr27393683qvm.149.1548844969752; 
 Wed, 30 Jan 2019 02:42:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548843393.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1548843393.git.horms+renesas@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:42:33 +0100
Message-ID: <CAK8P3a3rZ9tvzXjWRGEiiNeynZHkypPvCa7vPvFxui6H4ttFFw@mail.gmail.com>
Subject: Re: [GIT PULL] Third Round of Renesas ARM Based SoC Fixes for v5.0
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_024251_483830_E25E69D8 
X-CRM114-Status: GOOD (  10.71  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 11:18 AM Simon Horman
<horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these third round of Renesas ARM based SoC fixes for v5.0.
>
> This pull request is based on the previous round of
> such requests, tagged as renesas-fixes2-for-v5.0,
> which I have already sent a pull-request for.

Pulled into arm/fixes, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
