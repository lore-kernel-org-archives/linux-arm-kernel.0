Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE430C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:32:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF5520878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nuozaa0Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOb/fWf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF5520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y95Zu5fYV/znDKARALwdJ5Sw57Nyq5ewgmm3b97HWv0=; b=Nuozaa0YF4A9Sc
	pBqiZOuFknUymGTccuKjuI49syAbhZhd72BTpml3/n0zyJMqTSfKCX2uzIRgp8Qgr8hObsIJx0X4+
	IDfQ8kSQ/AMzPzjtrSASBlWFNRrQqD4R04s/MX4uGYR7Djk69kYiFZkG8FS40jBLzDEhwMR7NlfrX
	k/DFPwK0PIg6uVimZQEC6wBV7+M91+ff3I9IT8cSVGBd9I/hLKdiU7B5TW6EhnShTXY93aIkrcWvB
	+06tvoeuKRgY0UB5LTu/ikN7r1k66ZdH9pAiQJD28cdCKEIncihmUe/HVi/5a1nKNapRQAgXTfwpQ
	Xw12DOxOvOdLvOgz/UxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuhM-0001IN-IW; Thu, 06 Dec 2018 14:32:16 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuhH-0001HE-Tt
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:32:15 +0000
Received: by mail-yb1-xb44.google.com with SMTP id c15so506226ybf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 06:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mI3le/AIaBijHw5uZ2k9t8fgzRfmVnmWoFR1dUmPcUk=;
 b=dOb/fWf8y2Uy9Urs1EeiKNYHSgOo/cOmGNQRiH/6+sSrbRXwjTr/+xiQFBD2tuDf/6
 xFnjVL5TJ6rSmaQuNxrrbi721vpKpbb4ubNl/BBPmNaff3DG+YYhqnN8tvvdxBRVhaNQ
 IQVFmIWX1N7YZTP3ukCzi6ksb/MHPPPri0dM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mI3le/AIaBijHw5uZ2k9t8fgzRfmVnmWoFR1dUmPcUk=;
 b=Mm4pSpCQDm12D6k6ucydD331PomuW9fV7diAw7XwDiFBBIb6y3V2Z0gMQZvu7rvwa9
 YbnqMqJUYh7bsKiNHvHmyOBqRJeLirbgs2Dm+mvlkdxwnzlWB6Y1aRZJTOHb2rv0yngQ
 JsrwLz+/uHmw+/+kms3U0X4vuU60b6kgVuT1vZuW9DvfoY3iRd40zKJb1UQP5X5oCiFa
 oE4Y13hKVwFnvWZ0Rv6kCwnmhL2rDkvweHIeWPv5l8kratxwLBWl1sRkHGYChN3IkagJ
 fp25rMBjojtknB011NrY1271o+YPkVsoZlHvQoZqw4rXgbsZdue8/3KETgW3wY8+5aRu
 xGHw==
X-Gm-Message-State: AA+aEWb2UJX4u7syS4TSkUfdDjab+/VwxMvVgr0yPPX0UFLFQ2jpbSx0
 OjZsXEFOy3al/zuVORbdZ9Eoma6wNjoXBll7EThzvA==
X-Google-Smtp-Source: AFSGD/VVtoqYQoxxGjb6oM9lBVGFt4zwqsE16/q067B+3dPwrg4Sgakw3PYJsNSEyuNsXpG4wpcdU649ORSdkQT1uwM=
X-Received: by 2002:a81:2e0d:: with SMTP id u13mr28814164ywu.45.1544106720591; 
 Thu, 06 Dec 2018 06:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20181205174852.435233070@goodmis.org>
 <20181205183304.000714627@goodmis.org>
 <20181206132007.GB27744@arm.com>
In-Reply-To: <20181206132007.GB27744@arm.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 6 Dec 2018 15:31:49 +0100
Message-ID: <CADYN=9KpSP3n=g=M3+217MVs-OXMBJzcUqAPrh7Jm-b8_aH3TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: ftrace: Set FTRACE_SCHEDULABLE before
 ftrace_modify_all_code()
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_063211_966297_F0ADC44D 
X-CRM114-Status: GOOD (  19.16  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rostedt@goodmis.org,
 mingo@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 at 14:19, Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, Dec 05, 2018 at 12:48:54PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> >
> > It has been reported that ftrace_replace_code() which is called by
> > ftrace_modify_all_code() can cause a soft lockup warning for an
> > allmodconfig kernel. This is because all the debug options enabled
> > causes the loop in ftrace_replace_code() (which loops over all the
> > functions being enabled where there can be 10s of thousands), is too
> > slow, and never schedules out.
> >
> > To solve this, setting FTRACE_SCHEDULABLE to the command passed into
> > ftrace_replace_code() will make it call cond_resched() in the loop,
> > which prevents the soft lockup warning from triggering.
> >
> > Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org
> >
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/arm64/kernel/ftrace.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index 57e962290df3..9a8de0a79f97 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -193,6 +193,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >
> >  void arch_ftrace_update_code(int command)
> >  {
> > +     command |= FTRACE_SCHEDULABLE;
> >       ftrace_modify_all_code(command);
> >  }
>
> Bikeshed: I'd probably go for FTRACE_MAY_SLEEP, but I'm not going to die
> on that hill so...
>
> Acked-by: Will Deacon <will.deacon@arm.com>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

>
> Thanks, Steve!
>
> Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
