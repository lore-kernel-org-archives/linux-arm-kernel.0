Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4BEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:25:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE34C21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gIvyUzbc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="htge0fQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE34C21B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2VW6ZSf3MU1gfc/Vif3VR9rzdy6sGFcIWyjFK6x6tYo=; b=gIvyUzbcTFsKN2
	w94HneT1QAGG3E2Xgt+T6mDLfXqIOHj2qg7qALQCVvltXpQlFMZc01mVVuKp7izVW89tf/aoCIR4I
	IngeYuNvl5YNN1diQ5gVlbIywgskQqp7opsj4ou6YR0mi2CENZF3SqJU7fUrICSfNJMBizkX3HDbj
	XAmDKgF67BU3rotVzLl+pnMkU3IhIfPj1sQ3ZcLUO3+/EvSjuSmIqhsg/KbynUvoMNb9hdm52PIZ7
	iD5bhNnm74JquIAumAmomZds0hu+whh+C+lDWZyH84S85I2x6rVCk7xNBD9G5WIIJR3UwG/WouUfH
	Q1VqbKaRKe86I/LEPc7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guj73-00035d-Kx; Fri, 15 Feb 2019 19:25:29 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guj6y-00034r-4I
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:25:26 +0000
Received: by mail-pl1-x62a.google.com with SMTP id c4so372194pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pfUp5ku+6fj+x3YogObjg6zT9GmAYNVP+Wb6MscecPs=;
 b=htge0fQvi0b5t+blxFUTtZFfds1La4YTBZiOgDJ022C7DXydsfTMqlfKY678831nHU
 HmLsxozYBIc7/baB7MwArQX5oyAwk+oMPxIzcymu+9z7RbbFsNMREqc8XBimdwvMp/TO
 s5MDJe0E0tp0JXUhTpHoXLPu++lzByoAOh89ENMO/xmDDIf1VskqXEPPAAY4O5jGdM5s
 EwLZ2ADhUZ0rlW3mKrIXNiFfNfOQejVRx6ecVCVLhqt51X3Qb0S/tdMIEuM7F8xn/vfO
 pT8p7CdKeG1hhQl6QHs/DPE8OJ9nbkFBT6riUV+Y754bdGT2SAsxmq/wTNulnv6Ub4qy
 G4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pfUp5ku+6fj+x3YogObjg6zT9GmAYNVP+Wb6MscecPs=;
 b=nVXZALXlEwWVMiJ6eMPEfaep4GfrGqdQgrqpW3SnskFo6Zn3sHegIqXzI9qZP7J35N
 RQ+xm2txqsgnfG6P0HcTHw3Z51fc0yDGEUSFK1LE71RlLs/0RIkd72/i5KpWQ6Dtu8NR
 IcHyt6WqfIedGpRJDclncmrG3cyUX2AXGKcHL0HMvJkcZtHoR6FO3T9rQPP01xgmVzaV
 A/551g9Nm3aNW0mtB4+XUW5BQmmunNK7KtUVQ/fUMXuVQeQNzzzVS5gIMCUNQdrK9BD3
 WQaqXTZ4JNJjqLlOkYWgVLGmKLjhWaHb6SoppkV8y6sqi+TFBb7v3SYK4zi3NCxvQC5F
 C4rw==
X-Gm-Message-State: AHQUAuYyMDjHL6+VtdPXyARMIvbS95PSmZYbHOSTLiYAR7lSptpse+D/
 KUrBSW0CItewaKUQdH0CqX9H3a37x5j4mAVdHFX5Ew==
X-Google-Smtp-Source: AHgI3IZqvDGiZ2Lliz1c6KZlqDD8STWYenxZsYpENamTZnfj9SJwKLUso7VtTb0omZveMvUGtyrqZVMHEDXSMWOcjQ0=
X-Received: by 2002:a17:902:bb89:: with SMTP id
 m9mr11676032pls.320.1550258719940; 
 Fri, 15 Feb 2019 11:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com>
 <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 15 Feb 2019 11:25:08 -0800
Message-ID: <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_112524_190226_2819F579 
X-CRM114-Status: UNSURE (   7.95  )
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
Cc: Sandeep Patil <sspatil@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Provided that we stop sending Clang enablement patches to -stable:

What does that mean?  We're trying to provide clang support back to
4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
