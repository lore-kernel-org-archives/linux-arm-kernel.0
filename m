Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90928C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:47:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6302081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CJaU/1h9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWTIImhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6302081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YWbxcrCb5i442687+/NgL1BX34meSV7u6yYauLAZxRM=; b=CJaU/1h9m5gZdc
	XYFaZTki7ny8QRAafWu9L4XxvxwFR+k3sqq8+ctXN7rzItVWrdNdBatnY7iVbPAJ2wiODGNllkrd9
	rMasitlmeD+4g5eYQTDxiWdiGQ9prxh3oAxO0l3OVj5zzwb8Af/hGY2bVEuwviIUZM8Sfcwb0FjyH
	3LCzoC6+iO5B2ajxHbvtF1wwH0UXR+Z9A5/tS0QFc1MaXMK/aR8x+1+UyO3UVuOIDGmzPjmy8F9B5
	w2MDg5OlA4fljJSCsvyuDHvWw6A6M9Du/kGMN7S53x0DlHs0YG+d2HA5LD7lDVOHL9OYobyI4+go8
	cq/FaQeEEx8X/WPaNmLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUByZ-0000Ky-Fs; Tue, 04 Dec 2018 14:47:03 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUByV-0000JU-SK
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:47:01 +0000
Received: by mail-lf1-x134.google.com with SMTP id b20so12114450lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qEIAyhd3q32hXoX6vKAQHHuji5XKnBWqt8xzcwrmFJk=;
 b=fWTIImhww5xyT3JFLaAXctekBWL/Rfpsj6bFtSCYIy0DLEt8nZ2LbLudgZhKkFGflF
 WBjHPF2iL/WKQO6Sk9b2fNzeGA9GNUnpEWoqaTWwpzDyEqOw3oe4bq9zMkP0YhjHpkd8
 haeQlReeYCnzTS5k5n6QxWYwqhtRh7d0K/6gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qEIAyhd3q32hXoX6vKAQHHuji5XKnBWqt8xzcwrmFJk=;
 b=RCCcCLz6t1Mkl+w/oaA65az7+cZWmimrrIgIKjbFE/Zk6no3XW9HBQjJCWOmLRTSji
 jQVQHId60g54A6rcqtiwSk4rLYWEMiWjusdpUinBY1fl3mwWLFURlKFQE+HiUTjdnM6F
 jvkru2sYWtPtujA7d9toDD+kUhHgSp59NSpBYTdGi1Eznc+YIl2i9XvCIQ3Uen1a9160
 wS5eS/AgLyIRYwt9RtGOzyAZFYDk5bUDY4Bce62dlJ8dBVJYhSKMRgLqcTwptbB42Ug7
 BlGmbRap0enJo6BxtWamzRLWezWF3V+0Cm/bA7WV7fTaUSenss9c57B9QuVOgzRp59O+
 6l7g==
X-Gm-Message-State: AA+aEWaMz2bw58UXvi7newqPVh0IRy6YXZT7YM04QdYnZVbVJMZF8JjZ
 ReIsG6tY8dXTZcYXEpALmwxNJtitC742l3qGt7Qc2ODkqXs=
X-Google-Smtp-Source: AFSGD/U+B4u9u0K8iYu5AAYyd2YLWrpekx7Q1deCHJyzNe5vxiK2OQjVRUOZ933hKqK6s//q4UwttxFX8N05zfQ234g=
X-Received: by 2002:a19:d58e:: with SMTP id m136mr12791626lfg.70.1543934807251; 
 Tue, 04 Dec 2018 06:46:47 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsvJkW5_hruVYzLX3g9_5scj9nnL240rOMQ+DSz70dqqQ@mail.gmail.com>
 <20181204125233.GA1519@arm.com>
In-Reply-To: <20181204125233.GA1519@arm.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 4 Dec 2018 20:16:33 +0530
Message-ID: <CA+G9fYt020CHvoH32KgdjKordVtG+VmriKEFqa1HTzWJTYf-nQ@mail.gmail.com>
Subject: Re: Linux-next: Build failed
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_064659_964193_FB047D53 
X-CRM114-Status: GOOD (  15.74  )
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
Cc: Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On Tue, 4 Dec 2018 at 18:22, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Naresh,
>
> On Tue, Dec 04, 2018 at 05:56:09PM +0530, Naresh Kamboju wrote:
> > FYI,
> >
> > The Linux -next build failed due to below warnings/errors.
> >
> > include/asm-generic/bitops/atomic.h: In function 'set_bit':
> > include/asm-generic/bitops/atomic.h:17:2: error: implicit declaration
> > of function 'atomic_long_or'; did you mean '__atomic_load_n'?
> > [-Werror=implicit-function-declaration]
> >   atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
> >   ^~~~~~~~~~~~~~
> >   __atomic_load_n
>
> Ha, I like that the compiler is trying to get us to use its __atomic
> builtins here :)
>
> Anyway, you're seeing this because of this previous error in Mark's script:
>
> .../scripts/atomic/atomic-tbl.sh: line 183: fold: command not found
>
> even though fold is part of coreutils :/
>
> Do you have grep? Maybe the diff below helps.

Yes. grep is present.
Thanks for the quick patch.

- Naresh

>
> Will
>
> --->8
>
> diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
> index 9d6be538a987..81d5c32039dd 100755
> --- a/scripts/atomic/atomic-tbl.sh
> +++ b/scripts/atomic/atomic-tbl.sh
> @@ -180,7 +180,7 @@ gen_proto_variants()
>  #gen_proto(meta, ...)
>  gen_proto() {
>         local meta="$1"; shift
> -       for m in $(echo "${meta}" | fold -w1); do
> +       for m in $(echo "${meta}" | grep -o .); do
>                 gen_proto_variants "${m}" "$@"
>         done
>  }
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
