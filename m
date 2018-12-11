Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A6EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C7C2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IT6a1fz9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OPczIJ4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C7C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iW+Nt/nfHRRDeoXRex8eXoqR8Q/Hs0xoFIKqa5/DYqE=; b=IT6a1fz9zYhdMb
	+h+zuN7PWBU4ukSc9YWRXkFO+JVohLQIhXTMdRNAtPOsnbtRgjWqJxDgYJHD+xYTdBD3iyVbh9auz
	VeyrmbdEnuRAxMRg94s9KnXqo8nuVDaspl3nPHMs19Ktz6KxoxdbtR6MtjyXfYzfi/3+4YOuxO2S0
	zZ0CPfzgTXMSKYAICJzP6Bg03uZRbh/ByTmpnsniPHb0fdYpT7wx5gfeM2u/32lwMquCifqWC7S6N
	VAf6sESRsXRt/p3LyXqodqTgv9kj1yTH2SQiibEK57yj0qZFkAla1yTdu569bvFpofnv5d/7OPUFx
	cdOqmIECMvKJpFS7q4yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkW7-0001Ph-J8; Tue, 11 Dec 2018 16:04:15 +0000
Received: from conssluserg-03.nifty.com ([210.131.2.82])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkW3-0001Og-Ca
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:04:14 +0000
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id wBBG3Z60016707
 for <linux-arm-kernel@lists.infradead.org>; Wed, 12 Dec 2018 01:03:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wBBG3Z60016707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544544216;
 bh=yybUklpXv+i3ZvDZN0IW/BOVhtWK4rILiidGaAjhMpM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OPczIJ4FOYy580LZ7DS/3nKvrqqoOMHIZIKWccecRRjdvtFhKfsasloqP+Dao9mEm
 yzIvnhZYIU23eLSWDkv5eknjQSTX81s+9ltfglUEI9fvClHdaKOOIV0hO2IbCPtae5
 cU9qNLWUULDw8JVFXwonarCPtCbPoaKBO6MB1qZxmij13lnLAV6E9ZPLkrDQlccFhG
 Nvs9c5jSADVSTLnT7pFwfBpGaFqq76gCdwKJ5HV/jPocJnHYkPkZ8QYjqAq0l478+r
 Q0qx8ITQFTQfN63dUPdk+p7cMblUVHzDlDv83AUwvUQbE3b0yFbwuVZGN8cnpvfj0R
 IO0sQl7AJbqKg==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id j3so5310372uap.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:03:35 -0800 (PST)
X-Gm-Message-State: AA+aEWbmUw8IOJYTRymAUgRD3HMhpYPOgFAc8Ul9+yShhpeITGEOGD/G
 E8+KZOIgZ25pSzbiBN262aRCxZ+Sq7cO60WhFj8=
X-Google-Smtp-Source: AFSGD/XZc79/L4SuKcG1VJ0VKvjIawgbFQtNLlqIpxPcLm8VGbMkBdVTmt2/WSQVL+Vpd0inHxvZI+sz8UNKgKFxppM=
X-Received: by 2002:ab0:849:: with SMTP id b9mr3720525uaf.93.1544544214488;
 Tue, 11 Dec 2018 08:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20181210203225.11179-1-robh@kernel.org>
 <CAK7LNAThtAOy4PQiYZ2X0oWrHdcLi7on8ctSXJ=bfT0HNh7NFQ@mail.gmail.com>
 <CAL_JsqL7n2sjLbJVieVDQ4YtKMi2COCaijO9ZNu7ggzmXXxLEg@mail.gmail.com>
In-Reply-To: <CAL_JsqL7n2sjLbJVieVDQ4YtKMi2COCaijO9ZNu7ggzmXXxLEg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 12 Dec 2018 01:02:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkr-g9ae+74QE6GMuxLM0JPgEqYOkwb0njXcb9-=nBdQ@mail.gmail.com>
Message-ID: <CAK7LNARkr-g9ae+74QE6GMuxLM0JPgEqYOkwb0njXcb9-=nBdQ@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Add support for DT binding schema checks
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_080411_777301_0CBC619C 
X-CRM114-Status: GOOD (  20.28  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, arm-soc <arm@kernel.org>,
 darknighte@darknighte.com, Jonathan Corbet <corbet@lwn.net>,
 Frank Rowand <frowand.list@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Michal Marek <michal.lkml@markovi.net>, grant.likely@arm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 12:13 AM Rob Herring <robh@kernel.org> wrote:

>
> > > +$(obj)/%.example.dts: $(src)/%.yaml FORCE
> > > +       $(call if_changed,chk_binding)
> > > +
> > > +DT_TMP_SCHEMA := .schema.yaml.tmp
> >
> >
> > BTW, why does this file start with a period?
> > What is the meaning of '.tmp' extension?
>
> Nothing really. Just named it something so it gets cleaned and ignored by git.


It is cleaned whatever file name you use.


See scripts/Makefile.clean

__clean-files   := $(extra-y) $(extra-m) $(extra-)       \
                   $(always) $(targets) $(clean-files)   \
                   $(hostprogs-y) $(hostprogs-m) $(hostprogs-) \
                   $(hostlibs-y) $(hostlibs-m) $(hostlibs-) \
                   $(hostcxxlibs-y) $(hostcxxlibs-m)


$(extra-y) is cleaned.



You are adding *.example.dts to .gitignore

Why not "schema.yaml" ?




> > > +extra-y += $(DT_TMP_SCHEMA)
> > > +
> > > +quiet_cmd_mk_schema = SCHEMA  $@
> > > +      cmd_mk_schema = mkdir -p $(obj); \
> > > +                      rm -f $@; \
> > > +                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
> >
> >
> > "mkdir -p $(obj)" is redundant.
> >
> >
> > Why is 'rm -f $@' necessary ?
> > Can't dt-mk-schema overwrite the output file?
>
> It is for error case when the output file is not generated. I can
> handle this within dt-mk-schema instead.
> > > +DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
> > > +DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
> > > +
> > > +extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
> > > +extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))
> >
> >
> >
> > I assume you intentionally did not do like this:
> >
> > extra-y += $(patsubst %.yaml,%.example.dtb, $(DT_DOCS))
> >
> > From the commit description, DT_SCHEMA_FILES might be overridden by a user.
> > So, I think this is OK.
> >
> >
> >
> >
> > > +$(obj)/$(DT_TMP_SCHEMA): | $(addprefix $(obj)/,$(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))
> >
> > I do not understand this line.
> > Why is it necessary?
> >
> > *.example.dtb files are generated anyway
> > since they are listed in extra-y.
>
> It is enforcing the ordering. Without it, the binding checks and
> building .schema.yaml.tmp happen in parallel because both only have
> the source files as dependencies. The '|' keeps the dependencies out
> of the dependency list($^).


What kind problem would you see if
the binding checks and building .schema.yaml.tmp
happen in parallel?



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
