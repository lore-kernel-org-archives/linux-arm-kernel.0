Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C47C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:17:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A740A20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ANjofRd/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nV05wTbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A740A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dOdLqFyK2/Sn2h5jZM07aQ252r6lhtNZvSTanseHDYA=; b=ANjofRd//IHKRh
	iJKIB40PWYh07fM/VN6yLkMjvr0sDHO+rV+xFUQPlXzX7jvrPzX2dSGilD0YhScZVN7b466f4OivT
	MzL4keVMvcCTIZxOTCuweGLBqa/xnz1OK2ZeMuq3olZDde7lE+hRQ4dwUWTatHpACGATmhnSMbYG2
	G/PsuzvSAcajHl2732Vn1kTYRewP1HEP1AH1TFcrLi/6uBtMm+ZFvZRljiQeCIa8+RwZZfljHvPVP
	Ep8yZ+YhEP7LAK9fdFnlg/J2fmmtjM0ggul8WGSUe8JxYXyTGpejlSObMH5n2VhL/GpvbhwIf5tnS
	fUl1zcFBoPN8nN5AxGXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmPv-0007Ax-JO; Fri, 30 Nov 2018 17:17:27 +0000
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmPs-0006wt-Fd
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:17:26 +0000
Received: by mail-yw1-xc43.google.com with SMTP id g75so2576520ywb.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eA8RA4BMCo4J6Tj7FedpLFV8GAZ8Ue1y/wfOuYx7IRw=;
 b=nV05wTbR9GdI2h4En2tMC6ecY9fatk6N+XQPboTAptZvLo8XtMgte+MdmEMglze9Dt
 /y2dVXn4NidmLvTt6UE6aHbl2ZbMqht0r2NVBicchD71ylSLz4rzd1+Ldt0HqCr611C7
 2TarH69sIG6gt1L5N0uVfc3y4G5guz1BelI3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eA8RA4BMCo4J6Tj7FedpLFV8GAZ8Ue1y/wfOuYx7IRw=;
 b=r2tezMov0EwLFS/aOGFRWgAVLFpl1UTrs/abZDFb4AcKgcQ5nCp2R55qRUcj3CE0qZ
 s3PM1UX+zOSejFBFRPR0xjC22XPi3WVtvo5eg7bxjFtcNpljJrgzwlYnp+XL/q+VneN/
 R3lfEIG1BViJrzS6uYFJy2J9tMuZtsfUxFY7MpxUQwrT/V0lokxyjtLUO/RLwS2SM8O5
 /V9sH9V/R5pCGYO21wygsqSXEZhqwYpgYdtsR9vxq4gp9BsUYqt0L7gKP4pnD4iFVPFy
 XB32gM0zcep8zjHk7Vsx1Uay8AI0i7yuVxOFfOr+b9A+vLzCZkXBqaunhVCSkeT5Iohw
 0iAg==
X-Gm-Message-State: AA+aEWaFL/hsfMqueMZBBnNMewZZ/vvJ3ur3c1yKKm97GuzgIKVO7JPa
 sDZMZvH3GSQdXfy6ZE94qLQGV5Fmxug=
X-Google-Smtp-Source: AFSGD/U8Lt3umtqsYW519Rbgnw2zPgfcTkTycTQNWqdS857nDlqJnaz+tef6yyzNAdj0tpzZYJGuHQ==
X-Received: by 2002:a81:3c52:: with SMTP id j79mr6528257ywa.38.1543598231826; 
 Fri, 30 Nov 2018 09:17:11 -0800 (PST)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com.
 [209.85.161.47])
 by smtp.gmail.com with ESMTPSA id u4sm1647959ywl.29.2018.11.30.09.17.11
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 09:17:11 -0800 (PST)
Received: by mail-yw1-f47.google.com with SMTP id r130so2561849ywg.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 09:17:11 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr6717118ywo.168.1543597754077; 
 Fri, 30 Nov 2018 09:09:14 -0800 (PST)
MIME-Version: 1.0
References: <1543583987-27948-1-git-send-email-alex.popov@linux.com>
In-Reply-To: <1543583987-27948-1-git-send-email-alex.popov@linux.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 30 Nov 2018 09:09:02 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ7LmHRJJxtH2HD4XEu5hPLtAe=koJbaCmqF9qoSw=sVw@mail.gmail.com>
Message-ID: <CAGXu5jJ7LmHRJJxtH2HD4XEu5hPLtAe=koJbaCmqF9qoSw=sVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] stackleak: Register the 'stackleak_cleanup' pass
 before the 'mach' pass
To: Alexander Popov <alex.popov@linux.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_091724_529677_A8958D6C 
X-CRM114-Status: GOOD (  19.90  )
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

On Fri, Nov 30, 2018 at 5:20 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Currently the 'stackleak_cleanup' pass deleting a CALL insn is executed
> after the 'reload' pass. That allows gcc to do some weird optimization in
> function prologues and epilogues, which are generated later [1].
>
> Let's avoid that by registering the 'stackleak_cleanup' pass before
> the 'mach' pass, which performs the machine dependent code transformations.
> It's the moment when the stack frame size is final and function prologues
> and epilogues are already generated.
>
> [1] https://www.openwall.com/lists/kernel-hardening/2018/11/23/2
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Thanks, applied!

-Kees

> ---
>  scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index 2f48da9..6f41b32 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
>                                                 PASS_POS_INSERT_BEFORE);
>
>         /*
> -        * The stackleak_cleanup pass should be executed after the
> -        * "reload" pass, when the stack frame size is final.
> +        * The stackleak_cleanup pass should be executed before the "mach"
> +        * pass, which performs the machine dependent code transformations.
> +        * It's the moment when the stack frame size is already final and
> +        * function prologues and epilogues are generated.
>          */
> -       PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER);
> +       PASS_INFO(stackleak_cleanup, "mach", 1, PASS_POS_INSERT_BEFORE);
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
