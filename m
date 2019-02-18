Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D550C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:42:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4D1218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PBRC24wf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="P7PzVX51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4D1218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o/z2p2PqqDDi1buKGrzFnPqvKUglx8JsJcbvbeoPw/k=; b=PBRC24wfgrG7Ja
	HpKt0p484fzZee+2lWFkQIp8CZJTdvlp3ZsBUN+/cY2UbvUIrXEKQOIbFjiJODC68wwK+UBhkO8px
	bNTg6JYcewvXwUpSzurYdQeo+B4IYMHcJNmFInKbf6fqYS6lnBe655THgW+v6ioa+yPZ/RXr6PP93
	w8Y85S3ReCoi1vwfSyjfPGvM1EkRPfPpaRpeYIZSGwZUtSpf1bqHF7mBMNi+6tL074b95oUBSQ1Ou
	crGidPEKdbwRXy3eFbTT+3aG25yxvDyTOK2Jo5ivkPGhNqTS1o5rVAlwAdYLj6j3B5lybPFRcqy32
	mtB2lnIz6m7j9vX6xvQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gval8-000715-RK; Mon, 18 Feb 2019 04:42:26 +0000
Received: from conssluserg-06.nifty.com ([210.131.2.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gval5-00070l-Ni
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 04:42:25 +0000
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x1I4fr5t004907
 for <linux-arm-kernel@lists.infradead.org>; Mon, 18 Feb 2019 13:41:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x1I4fr5t004907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550464914;
 bh=ztgmX9sUlu2nCI1xh+b3f1xiPfCJOBT6fDt3BnwveqQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=P7PzVX51KZrab9ZW5oqrIT8J9Ju9pNbYmQPWl8I6DAq46mu+FA3czUDWoB7WdsK/u
 X79Ht0QijuBBSrGktArNitimGyuQajVsVVRuJ0R0KuRAy/Oe/8nA0Qa6Rgj/4nc4hF
 VP+5O4peyXNM6rnOwkbzcIWbXY5HKC8KVk97dABHZJgxqDD58FaAzrCXWLKwhElRuq
 r/pc89JXEpH6G2yYVcQiN4lM0Wdy+26umFJ0Quc0WI5A+3ABJIiwAHwRi4BaGRlPDF
 Dsz4qgRGrI7WpF2vdIjugdj22qHEUNvtvd5AZtVKuCD7+mCJReMkNaAspioJUkyt9j
 KbTanO5DajEOw==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id c5so3487088uaq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 20:41:54 -0800 (PST)
X-Gm-Message-State: AHQUAuYjxqOp4H7nq1FVWIrZITwsAJ48KmDDX+uG6ldhtun/CeazPVLz
 9gdasS3+AaDQNbJP4s4jtFVm05cfos+nPHXwZCE=
X-Google-Smtp-Source: AHgI3IbyDkHjiQeJ0+9MBKEkpsesEfJvKrQFdgUzRewMFLa/BtvuEl7ZmkGxg3+pBwxrNuanj1WRJZbecRcwpSL6DI8=
X-Received: by 2002:ab0:c07:: with SMTP id a7mr12558uak.55.1550464913003; Sun,
 17 Feb 2019 20:41:53 -0800 (PST)
MIME-Version: 1.0
References: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 18 Feb 2019 13:41:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPU9DJaOMP=8oOMjeGSuAqWSTh2rSesvvfhjXx4HfxRg@mail.gmail.com>
Message-ID: <CAK7LNATPU9DJaOMP=8oOMjeGSuAqWSTh2rSesvvfhjXx4HfxRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] media: clean-up header search paths and add
 $(srctree)/ prefix
To: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_204224_003856_73DDAA19 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: Abylay Ospan <aospan@netup.ru>, Andy Walls <awalls@md.metrocast.net>,
 Sergey Kozlov <serjk@netup.ru>, Akihiro Tsukada <tskd08@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Patrice Chotard <patrice.chotard@st.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Sakari Ailus <sakari.ailus@iki.fi>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Hans Verkuil <hans.verkuil@cisco.com>,
 Mike Isely <isely@pobox.com>, Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mauro,

On Fri, Jan 25, 2019 at 4:00 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> My main motivation is to get rid of crappy header search path manipulation
> from Kbuild core.
>
> Before that, I want to do as many treewide cleanups as possible.
>
> If you are interested in the big picture of this work,
> the full patch set is available at:
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test


Could you take a look at this series, please?


>
>
>
> Masahiro Yamada (3):
>   media: coda: remove -I$(src) header search path
>   media: remove unneeded header search paths
>   media: prefix header search paths with $(srctree)/
>
>  drivers/media/common/b2c2/Makefile            | 4 ++--
>  drivers/media/dvb-frontends/cxd2880/Makefile  | 2 --
>  drivers/media/i2c/smiapp/Makefile             | 2 +-
>  drivers/media/mmc/siano/Makefile              | 3 +--
>  drivers/media/pci/b2c2/Makefile               | 2 +-
>  drivers/media/pci/bt8xx/Makefile              | 5 ++---
>  drivers/media/pci/cx18/Makefile               | 4 ++--
>  drivers/media/pci/cx23885/Makefile            | 4 ++--
>  drivers/media/pci/cx88/Makefile               | 4 ++--
>  drivers/media/pci/ddbridge/Makefile           | 4 ++--
>  drivers/media/pci/dm1105/Makefile             | 2 +-
>  drivers/media/pci/mantis/Makefile             | 2 +-
>  drivers/media/pci/netup_unidvb/Makefile       | 2 +-
>  drivers/media/pci/ngene/Makefile              | 4 ++--
>  drivers/media/pci/pluto2/Makefile             | 2 +-
>  drivers/media/pci/pt1/Makefile                | 4 ++--
>  drivers/media/pci/pt3/Makefile                | 4 ++--
>  drivers/media/pci/smipcie/Makefile            | 5 ++---
>  drivers/media/pci/ttpci/Makefile              | 4 ++--
>  drivers/media/platform/coda/Makefile          | 2 --
>  drivers/media/platform/coda/coda-h264.c       | 3 ++-
>  drivers/media/platform/coda/trace.h           | 2 +-
>  drivers/media/platform/sti/c8sectpfe/Makefile | 5 ++---
>  drivers/media/radio/Makefile                  | 2 --
>  drivers/media/spi/Makefile                    | 4 +---
>  drivers/media/usb/as102/Makefile              | 2 +-
>  drivers/media/usb/au0828/Makefile             | 4 ++--
>  drivers/media/usb/b2c2/Makefile               | 2 +-
>  drivers/media/usb/cx231xx/Makefile            | 5 ++---
>  drivers/media/usb/em28xx/Makefile             | 4 ++--
>  drivers/media/usb/go7007/Makefile             | 2 +-
>  drivers/media/usb/pvrusb2/Makefile            | 4 ++--
>  drivers/media/usb/siano/Makefile              | 2 +-
>  drivers/media/usb/tm6000/Makefile             | 4 ++--
>  drivers/media/usb/ttusb-budget/Makefile       | 2 +-
>  drivers/media/usb/usbvision/Makefile          | 2 --
>  36 files changed, 50 insertions(+), 64 deletions(-)
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
