Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94262C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:36:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5736721019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CCbGeWBY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gT2FkW59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5736721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ablXkLuyA4hDMd9GtYCWOV90OacQGkA6dgvyRQwpy08=; b=CCbGeWBY7F84sj
	/rfw7wIa97bRYlJo8vW5TVszoWQauxPfmtouPHtwD1TgtJ3aEGC9SdQL3ArWuOmGByqB81G7PST8V
	FtqGOxbpEVnlOocLegoIVZZpSff99E+LthsOIr0Gsl5BDgsnq/JuLDxBmyNywowoD35JzJLqiaMSj
	msJ6c6w7tygQH2q18wREF5QKrMbnwVfHgrIJCdZeqrzaecfEqnp3JtL3Ae4OAdPxV2BGBm/cUeVdw
	OACDWPs0nYMUMVj1tx9S2WHi6+kmbulm6Eaq9KZyCkSGC2ylTRHZqPKPW1By3Il5kLMBXr7iP52Ey
	R9ybX5uJn6WG33jPE4ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSUv2-0003xs-R3; Thu, 29 Nov 2018 22:36:24 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSUuj-0003gX-Fv; Thu, 29 Nov 2018 22:36:06 +0000
Received: by mail-ot1-x342.google.com with SMTP id k98so3372442otk.3;
 Thu, 29 Nov 2018 14:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DukSES9nIA+KfDf1puvdV4R2vgz+jX9tXlxVkF6zqxo=;
 b=gT2FkW59EHxkCZKEKap8F+hiAzyJB+ffyvRdL9yFZP+wO1IDxZJgGR3pLPogbHbzhJ
 L9wtxQY4+2GjwPHv5kHLW25KgtQsgRmhDtxnz571IHBRpj4WHNLwXsCmvfkjzvoV9zvJ
 5oDQBR7hx2iCkMvEnts0h4qGspDE1pW6u/wFoMptcOZptPD2H+cd39hsJ43Z4JNZcsfy
 kmOtAkvDaM8McWdqgaaDFPlnJxe8+nC2dEb31hKCwkignpO8LdVSaXsZTvfxsuUjxao2
 fwPzrWZkVJ3Us3cfzMBshgzwQF7gaatNncX0FV1bC5rv4SVAruIVFW7Gru9qDLkXyGhf
 z6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DukSES9nIA+KfDf1puvdV4R2vgz+jX9tXlxVkF6zqxo=;
 b=LJ0x+XPDwZrvYusvQowkogw0LnTLAbn4szKNK6F9kdPB1to1Jyg0kNxEU6sUtnPx+3
 8K4ISIE4LmjHNRLCbp5+kq9okTmTJvOFdgpm4vNfBS1wyh8fHusZpZRIFPKu6SioNUTF
 jgqlQ7TDhedjU0LmTB76y0JNbFY4+pSErQTOb38/jT//nCawDunHcrRVPGts5KGG201R
 zEHd246sojlg9WlvfJNePnKrBT9Txl7FPUroJqE6/K6eBmXJ8T/oCZMFCjI7vbIGoRnt
 Xrk1ppzqJPsBlmyVsZTserYk+JNzASATPkYn/ecsR6raRcMCyn7zcBMtxPWhHhicqlg8
 b62w==
X-Gm-Message-State: AA+aEWb+wLBzvF2PSyAckIPIssfkjHCSBqGbxZsO4S5eRBv+NqjZN43c
 8lsUpLznldJPpt73Mm1FCxa+OfjVYqaZ9hTTED7GHnSk
X-Google-Smtp-Source: AFSGD/Xk6GgdOlB724d5Nua9zRed9M7On2rBkIvPgxcmUTXP7vTmD2s8ZGTHYLNvqgtA3S146y97m0LJ0Ol7TZRoXPs=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr2208672otl.342.1543530952687; 
 Thu, 29 Nov 2018 14:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
 <7hh8g0d8tg.fsf@baylibre.com>
In-Reply-To: <7hh8g0d8tg.fsf@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 29 Nov 2018 23:35:41 +0100
Message-ID: <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to
 built-in
To: khilman@baylibre.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_143605_526151_45272F75 
X-CRM114-Status: GOOD (  13.88  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

On Thu, Nov 29, 2018 at 1:30 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
> > voltage supply of the CPU cores (this regulator is typically called
> > "VCCK").
> > Now that we are preparing support for CPU frequency scaling on Meson8,
> > Meson8b and Meson8m2 we should build the pwm-meson driver into the
> > kernel so we can configure the CPU voltage early in the boot process.
>
> Can you explain a little more why the configuration of CPU voltage
> cannot wait a bit so this could be properly probed?
I was under the impression that cpufreq-dt would still initialize even
if the regulator is not ready yet. however (after reading the code
again) this is clearly NOT the case.

there's still a benefit with this change: your Odroid-C1 in your
KernelCI lab would also be able to change the CPU frequency (so in
case something breaks we could spot it there).
will you accept this patch after I updated the description to mention
that it's for KernelCI test coverage?


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
