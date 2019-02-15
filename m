Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC96DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:23:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79ACD21925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G/y0y4ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ACD21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vjWl04zZ8WqnF1GPBOGQyrRTvYdGx1SwTD5lkfBpfpg=; b=G/y0y4yavPcVS3
	o3FmpjbIy0tF5y0GQRMDT6Kd9jKXcLsn/FXl4QZb8A6QQpaVJhI3ZKT7tXCUJGLWeSX9rjYgE1uTo
	B+MAN5Gj4DJYh5ahtM8shANWoBAtMm95neEwCdC29tycVlnhF4DphV/Z1NIv4btPnRsIOi5abwG5V
	dN/WPu8b6SOY60iPDhcyycLUaNhwW/0C17bkS35+hKw8lb3ElkGo68bqAT1OrZYmzLoqZLgTNqPG1
	EiIqvKgfmFvSdOGCkLm52d66KVPJnNAeRda7uLlceW6cWKvK14RsPE+hpnEbnuZeSQyUCjmZ33wuo
	4sEabp5X+XbL/OndpRgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhCu-000793-Js; Fri, 15 Feb 2019 17:23:24 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhCr-00078h-3j
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:23:22 +0000
Received: by mail-qk1-f194.google.com with SMTP id o125so6154642qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 09:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i8DlEWADa+N2/dXeCsAbDhJPjwX5LlIG/alE01RSxjY=;
 b=MyR3ZxDu30zazFMnWLMX/1In5ThSZNm2PqQu1puPFPlJJl4G1pDoL+kekLdosNBVSX
 Y+BSS2/KgHQ835qms4qEQ0u4XSDfpLpN3b/RXqqN/ide9vXpB8E13f+UBhI/0vOw3gwq
 Ki8azjkO+eJTg68wzbn4tDDn3TZh2HEyVAWQ7oV1hAnGLb7ytEop64sFQMAfXqmWpEWf
 afuW8P3ymMkw8NlmgCYf02RPTV1W9031H0Sneo59h4Uw/ShjatER4zRQOHisxnPJmMjy
 f43gTiytgX23Ui0clU1FFP4+VT8L2WobtbR65hg6ey/rZ0XAvzWlXJY1140q1iUcUBA/
 +2+Q==
X-Gm-Message-State: AHQUAuZ7dwRm5xW/c44F9F0oHdSXxdwxdXccNzxUh6UAHJyIo7IdOszD
 Eg+GzihEfDKy7U+aMsGhHHODEEzLm0fjspJf3dc=
X-Google-Smtp-Source: AHgI3IaUseqBV/M2Gf0+uZPfFNHH55X9zazeh0Px8vLN7ZQieF1N5xwQ1x4AHOjnXhtM0jbJ2jky4T4nMxyXRE/cxUc=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr7663935qkf.330.1550251400113; 
 Fri, 15 Feb 2019 09:23:20 -0800 (PST)
MIME-Version: 1.0
References: <pull-1550167958-188990@atomide.com>
 <pull-1550167958-188990@atomide.com-2>
 <CAK8P3a0y5FYYOvqPqhDSmR1Jxgx3AJzHtEkuku+_s-1vV_a8Lg@mail.gmail.com>
 <CAK8P3a0kZhJppsFzaTZL+PVCDP8BHwiquF6et3=i6MwA8YNpAg@mail.gmail.com>
 <20190215154742.GJ5720@atomide.com>
In-Reply-To: <20190215154742.GJ5720@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 18:23:03 +0100
Message-ID: <CAK8P3a03C15BJY4Z884-suceVZYO=kAzzLbjMUQukQV+xDvJWQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] more dts changes for omaps for v5.1
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_092321_155750_A4DE2B34 
X-CRM114-Status: GOOD (  10.36  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 4:47 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Arnd Bergmann <arnd@arndb.de> [190215 15:44]:
> > On Fri, Feb 15, 2019 at 4:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > During routine checks, I came across these gta04 warnings:
> >
> > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > node unit address error, expected "0"
> > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > node unit address error, expected "0"
> > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > node unit address error, expected "0"
> > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > node unit address error, expected "0"
> >
> > Can you have a look and send a fix?
>
> Hmm sounds like that's because the branch is based on v5.0-rc1
> that is still missing already merged commit 5b90df44fd9b
> ("ARM: dts: omap3-gta04: Fix graph_port warning").

Ok, got it. Everything's fine then, sorry for my confusion.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
