Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DC5C676F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:43:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BDF20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CroLJoDl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/BoH4Nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BDF20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Us4/3jLIItcGU8ZEF0BjcZWGltv4e1GzswnlMh0/YaI=; b=CroLJoDlDuymfU
	aYPwOUdhq7Z/ZR42ca7d8jb78OpwJJ4+l0CMxRO5rwSRX8Da6+yvywFW0z1cqZn++xTXghmjnJf5l
	um41ARrQUghHhtaIdPuqHUUKgCH4ZGbUHVrligQluj39x1D+0w+5yTzNlmhlIHIIN805LMwSpsL+u
	7VOvlV+TYqtPY6GMhRgFbrXrPNmRbkWbkBxNZL426tvC+lkQpwyADdE5zp7tw+nb8YAvSQG8RwYHx
	BCxkTjBFW8/bx3FokjYjYvSpfHOHBOWdmtcdup0s4o95Zu5Mo8tjtzu7TcqbFIa8Tvjn+bC5Q4kR+
	Wzudpnygu2r6gDKsgdRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glFGA-0005s4-RM; Sun, 20 Jan 2019 15:43:42 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glFG6-0005rg-Te
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 15:43:40 +0000
Received: by mail-it1-x141.google.com with SMTP id a6so12048980itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xt6OSfbY32n9hhAD9g737/33MNLX0J6L8rwgNqtQGC4=;
 b=K/BoH4NrB8SAS/IdxZxBMqXhBQ3FKXUs9x/M+V8tNqEIzc9+NlbNIijpqqIwbK3yuh
 hLSbTR6QWo4XyxisOgqBaKA25hKX0OUAzWwTmZf5xukEgU1ouzRyxxs+NEG9A9vwniMr
 ZD/TTfvf5RTNHqHoZQ3L1hNtu8Zoj/qNDOHI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xt6OSfbY32n9hhAD9g737/33MNLX0J6L8rwgNqtQGC4=;
 b=i/9CDlcDzRzIJW5fsOFvTtTof0JbEiykJztAm0JpcApR7sVRdduSTdZZdlGDYS1mh5
 D5i+LyXf90v2yUwpAmHKCU0eYnmPKTs9LClkgOil+uF/+GovB3E07H9aprWKa3pe6/j0
 bQCHk9enS42twHmdD12ymEz8uCPZTS9ycBeD/zjE4rve97Ob57esaCfxs/zVlxUw9mZ9
 b1o00S5TPrWrXzZ/BjpL8Am6y5pGkNntWdW8+BlopsB6sfp3c/K3VayThkxbdbD6EIST
 uYJY4p29kSZXyuY45z7OBZBeSI1oYLtNGNl1PJi3Jsvuo5CaKG2HhxLGcN4gK8PRq703
 zW9w==
X-Gm-Message-State: AJcUukcBBywkqJRTFQtfokK9tD5fN36lUsMMGyNsQAWVjcn2e41X7VpZ
 28nsIhty8gDbAHr9wLYHCbNzFfj4PzeWdgGvvfGmZg==
X-Google-Smtp-Source: ALg8bN7faX177yOYMc/jL/sb/U1fdkkITjUcvPFwl8D2zoWPGloddnuId5odHIL5Fzp9W0QtwVRFK9mJXKN2icjv1Qc=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr16780026ith.158.1547999014337; 
 Sun, 20 Jan 2019 07:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
 <CAGXu5jKa6Tzea9SyTi5aOZusnb+1+yTJhMNaz-Ha8sjR7oCWsw@mail.gmail.com>
In-Reply-To: <CAGXu5jKa6Tzea9SyTi5aOZusnb+1+yTJhMNaz-Ha8sjR7oCWsw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 20 Jan 2019 16:43:22 +0100
Message-ID: <CAKv+Gu_VBQOfV7Z=PfAoBhUbyNtYg8tHumOciN7Yxa8RuQ06XQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] gcc-plugins: fixes for arm_ssp_per_task_plugin
To: Kees Cook <keescook@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_074338_959324_F500455C 
X-CRM114-Status: UNSURE (   9.71  )
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
Cc: Emese Revfy <re.emese@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 20 Jan 2019 at 02:51, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 18, 2019 at 2:58 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > A couple of fixes to permit newer versions of GCC to use the stack
> > protector plugin for ARM.
> >
> > Ard Biesheuvel (2):
> >   gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP mask
> >   gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+
>
> Nice; thanks! It seems like these should go into -rc4, yes? I'll get
> them queued up for Linus...
>

Yes, given that it is new code anyway, let's merge it as fixes.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
