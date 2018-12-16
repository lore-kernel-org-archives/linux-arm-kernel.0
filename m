Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:48:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A831217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OqJlatQH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqiU3yfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A831217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=a2mw7pS2Kvt2DlHAG8Nvla7cibZi6KHCz9LJtfymM24=; b=OqJ
	latQHC7Xz0/MIdHeLtYLyJVee5IJDq6vnscLBMKtm1PEB1bNOCaBjE5MI9FT/uumM3Qehv4iwkrkV
	AsnXhG5fZHfXbzZjpD5FBtnIMLTrw7GFQ0M3AG7CInMR5m3nUpuybc0zVW1+U/nA+DBjMhyIyyeCw
	Gf7p2F4GVgpZY3+51NXfky+4nfUC2sXUDz+CW5KDftTyv+PmIv1K1O/Hh1tX2sZqbidCfaU+MU38d
	lqRVj7hEjbZwdudte9eXgKRbGBrRezMOyN51lqYDVJsxZIpUeDjtJeQxxFI+KlGBDArGsCqWlQ5Xs
	Ts4Sxxyfczixu+C2SldmStj3DML5AQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYXiH-0008Di-GV; Sun, 16 Dec 2018 14:48:13 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYXiD-0008Bg-Mp
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 14:48:12 +0000
Received: by mail-pl1-x642.google.com with SMTP id e5so4910957plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to;
 bh=f18dgatpB3wRJ65lneIR+5EuDCU07Om7HwwqR4YA+ls=;
 b=cqiU3yfNqmAvzKBJvFBfA66XUcEpIPRHvlhviGtjCV06Z4L0El1su98WIquxjOw0Kr
 kfGbU/cMQ/9L30yPwZxYvb0eiZxWgoslhQJcqCvGnkGLBFvKg3Godp96Wt45zkoZNJST
 RGiNFesPxD2hNzIBuJDLKl0DzxVroCbofn2VGeVgdtAkih3i849m8T5/FU+U08ogLlS/
 62XrGOaHH86b//f1rF/HIARjKkkHquSWZR+koKIUNmEJwbXZsJ+tF4e48Bl6JtMPNyta
 i3kwLY/N4i9/aUwMQNAMipJVQ52PQa52cJcRF5sJU0fC2InV59sFKGXZjmnyanApvATu
 ThWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
 bh=f18dgatpB3wRJ65lneIR+5EuDCU07Om7HwwqR4YA+ls=;
 b=MvkPR/K3+Co/FO3LPKcZmjFt0WkWFODOuVWklQBGqk+EUUoU5rxLnWoOeqZZ/OBecE
 iJwL1TqjtBH3WbW62sGz6zm9DDkHw6ywk76Y6TspOw7qXkSEPE5DepnMKoBDe6xWZzbp
 8hzqgRN+lGR0lW73oI1gKxBGGlWrbKG8zTktpGHVE667yKhcbeLz2/arnVBI+TKLwlFx
 MuFU30qwwRRFFYBILipVO51cPp6arOajhhZMHBtZaAPeEB4siwsy7r32VocZBJRAom9H
 cnr8JofsD23Hmf8EK+GkOoHqXreY64Z0Cz3uFIwnIlMAHGSEmVnjQ4j+cGobE0Ne9VUn
 7Hig==
X-Gm-Message-State: AA+aEWZe+46P3VPnIzndVQBl3t+HJzvLrainH8q9yDqidUq25kwiQdjQ
 0/nc7UVBM6ScLYVm2S669eE=
X-Google-Smtp-Source: AFSGD/WxVK81bpJmJRjhJqrrbXnz2HUfv725wRvVoU5hWnnjPxyiwS+/miGMDU+tmRAtc+hbJuDL4g==
X-Received: by 2002:a17:902:8607:: with SMTP id
 f7mr9305980plo.123.1544971676827; 
 Sun, 16 Dec 2018 06:47:56 -0800 (PST)
Received: from localhost.localdomain (220-137-60-156.dynamic-ip.hinet.net.
 [220.137.60.156])
 by smtp.gmail.com with ESMTPSA id f6sm14059753pfg.188.2018.12.16.06.47.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Dec 2018 06:47:56 -0800 (PST)
From: Jian-Lin Chen <lecopzer@gmail.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Date: Sun, 16 Dec 2018 22:47:15 +0800
Message-Id: <20181216144715.7486-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_064809_773154_7A23691F 
X-CRM114-Status: UNSURE (   9.47  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Jian-Lin Chen <lecopzer.chen@mediatek.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Jian-Lin Chen <lecopzer.chen@mediatek.com>


On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> wrote:
>  static inline void arch_local_irq_enable(void)
>  {
> -       asm volatile(
> -               "msr    daifclr, #2             // arch_local_irq_enable"
> -               :
> +       unsigned long unmasked = GIC_PRIO_IRQON;
> +

Should we need a WARN_ON() to check if the daif_I bit is masked, or
explicitly unmasked I bit here?

If I bit was masked and someone calls arch_local_irq_enable(), they still
couldn't recieve any interrupt.


> +       asm volatile(ALTERNATIVE(
> +               "msr    daifclr, #2             // arch_local_irq_enable\n"
> +               "nop",
> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +               "dsb    sy",
> +               ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> +               : "r" (unmasked)
>                 : "memory");
>  }
>
>  static inline void arch_local_irq_disable(void)
>  {
> -       asm volatile(
> -               "msr    daifset, #2             // arch_local_irq_disable"
> -               :
> +       unsigned long masked = GIC_PRIO_IRQOFF;
> +
> +       asm volatile(ALTERNATIVE(
> +               "msr    daifset, #2             // arch_local_irq_disable",
> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",

May be a "dsb sy" here?

> +               ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> +               : "r" (masked)
>                 : "memory");
>  }


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
