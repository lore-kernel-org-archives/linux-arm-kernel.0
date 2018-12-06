Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1D920892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DOvAbkrg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzMk8ZUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1D920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=13qNaCGLXG6urJhcsv1OsguX0F9iRN/gfTDIyDQ6yqQ=; b=DOvAbkrgdB6sWb
	ejQu/I8CEKiVRPCINBJvda/CvMXllGDaLVCwWg0F1iwlAVpYtDBm3ewl1Ki9fD9w1a2qSWROcbx06
	VeMCj3KqOd4PPgKBeyelzOl8gqkTZMU7nKI1UL5GYWpgt6GpFPGJJu4IbWIcakVG8OTx8UnoHQAWK
	SL8w7dsLrwDBgY35hBpN1sS27t5UsehoLCnql6HUKxUPuXrujJNQJw8Hw/rovh4goeDl5UzV03dhR
	FGnpzdSQdqQ+MxA8/ZzJrNn8kRYR4GHtk7h6TUqtG2FkQteAB6APsWQXDozQBC3/l9QhSau0yWwFW
	ARJ+jOgPgh328erGNFUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyRy-0000XW-BH; Thu, 06 Dec 2018 18:32:38 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyQL-0007KV-2k
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:31:22 +0000
Received: by mail-yb1-xb43.google.com with SMTP id j145so1190258ybg.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 10:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9kTx26BkB0ZFxwyDFWFYU+PHdQctX1gqC06dfakZ1KY=;
 b=hzMk8ZUrY3I06XRjfjOUQnO34ZgyRpK6OU1TDiwdUe94pEswZHBk+CShiVcp/sJqpV
 HAR8lD2Q8tqac69qTbX6I9zUFr8gUbNYIjLtNoG4nACeurO0ml1Ftvf926p+kok2ljl2
 27b0uEChHG5aLgVG88d5btahnZK5zA9iOxd5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9kTx26BkB0ZFxwyDFWFYU+PHdQctX1gqC06dfakZ1KY=;
 b=XBJbIlKbsDWbFua2A/fAIdgyNm3WvoCgvcHEv1czoyvSVAVV9Xkq/V1bl67ddLIZDQ
 NyVkowoDtJk4If/udqzk1DsZ5t1zXXwxkW6QmTb/xCBAUQ82vZ+VN0Or+XPTpsFRdZtI
 nMY3luopMiV36ZxtzW0CLrNpxiGEGyva4MtsOJMwT4U9+xezjA4uUmnhLu4qMSawsbNw
 2JKskepaMsAw2VNX0eP3c1U5Zoe+m4L6mfqdmbh0ovzfgoLnjcSNtT99KYI6X+15h+y4
 vfTtZrci4RMJk2V5Q29UE/3E/vE+zvPRT62IMAQAeg+UmTuzY0BtG8kZrgFuIIR38nxv
 lmOA==
X-Gm-Message-State: AA+aEWYarBBaVIGQ70KV09KX8VYrS253IL/GIbzuEpW9cvN6bEx0hIaL
 nqe/dOEMNpnrSCN+TjyQJgJz+BCi6gI=
X-Google-Smtp-Source: AFSGD/WPlfUNAsQPI8YVLigGxazC2o1q18ZZdIyW0Y28NdRTqyDJ/bxtmolDcER2fPVQ1oFDrXqtQQ==
X-Received: by 2002:a0d:e684:: with SMTP id
 p126mr28827750ywe.315.1544121045407; 
 Thu, 06 Dec 2018 10:30:45 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com.
 [209.85.219.181])
 by smtp.gmail.com with ESMTPSA id f10sm313747ywb.26.2018.12.06.10.30.44
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 10:30:45 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id n134so1202186ybf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 10:30:44 -0800 (PST)
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr30881844ywv.124.1544120729343; 
 Thu, 06 Dec 2018 10:25:29 -0800 (PST)
MIME-Version: 1.0
References: <1544109187-13805-1-git-send-email-alex.popov@linux.com>
In-Reply-To: <1544109187-13805-1-git-send-email-alex.popov@linux.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 6 Dec 2018 10:25:17 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKPTaomgyBiSFCYJDFqGaVd=sWpXnjHpT-7YDmk1AVVyg@mail.gmail.com>
Message-ID: <CAGXu5jKPTaomgyBiSFCYJDFqGaVd=sWpXnjHpT-7YDmk1AVVyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] stackleak: Register the 'stackleak_cleanup' pass
 before the '*free_cfg' pass
To: Alexander Popov <alex.popov@linux.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_103058_110009_33E293BE 
X-CRM114-Status: GOOD (  19.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
 Emese Revfy <re.emese@gmail.com>, Laura Abbott <labbott@redhat.com>,
 Segher Boessenkool <segher@kernel.crashing.org>, Jann Horn <jannh@google.com>,
 amonakov@ispras.ru, Steven Rostedt <rostedt@goodmis.org>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Florian Weimer <fweimer@redhat.com>, gcc@gcc.gnu.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Thomas Garnier <thgarnie@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 7:13 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Currently the 'stackleak_cleanup' pass deleting a CALL insn is executed
> after the 'reload' pass. That allows gcc to do some weird optimization in
> function prologues and epilogues, which are generated later [1].
>
> Let's avoid that by registering the 'stackleak_cleanup' pass before
> the '*free_cfg' pass. It's the moment when the stack frame size is
> already final, function prologues and epilogues are generated, and the
> machine-dependent code transformations are not done.
>
> [1] https://www.openwall.com/lists/kernel-hardening/2018/11/23/2
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Thanks! I've applied this to me tree and I'll send a pull request soon.

-Kees

> ---
>  scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index 2f48da9..dbd3746 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
>                                                 PASS_POS_INSERT_BEFORE);
>
>         /*
> -        * The stackleak_cleanup pass should be executed after the
> -        * "reload" pass, when the stack frame size is final.
> +        * The stackleak_cleanup pass should be executed before the "*free_cfg"
> +        * pass. It's the moment when the stack frame size is already final,
> +        * function prologues and epilogues are generated, and the
> +        * machine-dependent code transformations are not done.
>          */
> -       PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER);
> +       PASS_INFO(stackleak_cleanup, "*free_cfg", 1, PASS_POS_INSERT_BEFORE);
>
>         if (!plugin_default_version_check(version, &gcc_version)) {
>                 error(G_("incompatible gcc/plugin versions"));
> --
> 2.7.4
>


-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
