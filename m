Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA40C2F3A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:10:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD542084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UAcZHLCg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MnMqVWFJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJlOjeQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD542084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tTJtHxky8zcEv5CyZAbPQlBxJFDPzZBgqnEND6Z+AO0=; b=UAcZHLCg15T+3+
	3fgJEozDqOZacFzRJuBL160EVYRV6b3awGj4op+fsnvMd+DI1/3Vrx5t/QIRxzP4YHq9unoht8sZ0
	nLOlN9CCftWc4Lg9ubQl5dEry5lyaf0SGerQZlwc+LlXTWL8OD8JLg89uUsZ7jpXXAS0LfIsLcOWq
	J3kHeXk3b/O8JwlmrZpRRkSK8flC8JyOIpwyd8MQazZp4147AYgRqocmiRybhnHCp3cApHg12Ueuj
	ZNRq1CEKZgcyPsV+ChkcmfSnEHFDYzkxCh3rhGFcGoUeRC0E6h8m/wR2axNpnpkkklZQKMwX5lu7A
	m00GyyyEmtmKzwDwqIBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZLh-0001Pl-OK; Mon, 21 Jan 2019 13:10:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZLf-0001Pd-Q4
 for linux-arm-kernel@bombadil.infradead.org; Mon, 21 Jan 2019 13:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3EeLM2bfVfLftD58aFio/sg6q76UU5TTU3Y31ZR3sPI=; b=MnMqVWFJA/UGYt4XrOwArk6vq
 OTuX+Qs+m7gVdR5LZI0eJOkWKZk/lcFM7gVw9GmEm4ZtkkLSDFqSmPEgX55YSdVXKsD0B9abtLZyV
 kTliBpFRPNbvlAsDJ4K5rbX27YZuXP2kuvTdNWpfEiqvnZHhVMJek2zdWfVfJ40Ojsb4WIVq0B7zj
 eyuchBN9QtZLTWlVG2buF+TY/ZVAfUQBsCWeMsGNw56WnJu0kGLy/jIHt3XEOjvJ4vGLSu5lnWfUh
 gppQTZBSeEvnnBFA2C9BhKIPkgTculNP5dd9LS+7KFXgZwL56dnYVd3IltxcnL8WVhfxg0Pvc3JiU
 0o6oJNxTg==;
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYk4-0003Nf-OY
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:31:53 +0000
Received: by mail-lf1-x142.google.com with SMTP id p6so15407855lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 04:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3EeLM2bfVfLftD58aFio/sg6q76UU5TTU3Y31ZR3sPI=;
 b=cJlOjeQWSojr7oBNPAtgpLYAKCO+ednN4XaimBVTjx+5U227C+U0EfKzj30NYqAqAK
 N7ONmtl47L6wasIbcqCRMirRDt07ovYKXTecDTW7fqlGkQGkY7z8mQ1YeTntKg6FsI0k
 nxEgw6t86xCXqg7IY/nbTAZ8wdNMpuRhDV9nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3EeLM2bfVfLftD58aFio/sg6q76UU5TTU3Y31ZR3sPI=;
 b=hFrn8rkC2Vk7QbhZuaR20VX7urhYKWgVHJAoBJmyW3S70Yhfga4n8fuXEXV1ICKnmS
 dkMZTZScaxYylo2cuB7crwmiTDGm4s6UEobSR15KbkvtsPx/NvOFBQLTX4CegxNU5cCQ
 ashiEHWz1Ovk0zVY2TZnVryiXRVJH3Ex0NBwuScSCcnTR+gnLBk21Y62/Xd4p/XtR1hN
 Vi8CBgERAfs0BXEKYSsUmXxj+Z+pwc7+4EwUCCzFTsEnoBh0QmHG8R0GuL4ZXkaAFmsB
 tA6OxxCtWvcKMY+P44eAPGhH6UHdAnL00R5bkNwEwXsvX3A92oPegusL58KjTmdIriYP
 FegA==
X-Gm-Message-State: AJcUukdi2bJm7BLtJKgvoI23RLH008ys+UQ+IfOgkloXnbOWVwEiicun
 zre98OPhAEcQbVu5nK1FNP41wU/wRoyWDE+jCBwnXQ==
X-Google-Smtp-Source: ALg8bN5PkY6EhjizsFHiHZsVsNbReFkhjGmS5Nq6UccxGc7IrzOvDhdQy0bzE4YQp2H3WF5Mn3eDsCtGckCGjBQD1nk=
X-Received: by 2002:a19:5154:: with SMTP id f81mr19006734lfb.96.1548073903502; 
 Mon, 21 Jan 2019 04:31:43 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdaUp+EiS0WL1uJ7wbi4Gtj9yBqR8KwcEK+uYY=hDXEq6A@mail.gmail.com>
In-Reply-To: <CACRpkdaUp+EiS0WL1uJ7wbi4Gtj9yBqR8KwcEK+uYY=hDXEq6A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Jan 2019 13:31:30 +0100
Message-ID: <CACRpkdYj0U2Wr0b=eWLHD3JOao+=5GuPBtqjr7OhBVZHvaSfGg@mail.gmail.com>
Subject: Re: [GIT PULL] Nomadik DTS updates for v5.1
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_073152_893562_4476E4E9 
X-CRM114-Status: GOOD (  15.15  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Did this get dropped or postponed?

Yours,
Linus Walleij

On Fri, Jan 11, 2019 at 8:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi ARM SoC,
>
> this is a DTS update for the Nomadik, it adds the display
> and DRM graphics.
>
> Please pull it in for v5.1/next!
>
> Yours,
> Linus Walleij
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/nomadik-dts-v5.1
>
> for you to fetch changes up to cffbb02dafa374fea7adf9f79b009fa1d14c2531:
>
>   ARM: dts: nomadik: Augment NHK15 panel setting (2019-01-11 20:14:43 +0100)
>
> ----------------------------------------------------------------
> This add the new display driver and DRM driver device
> nodes to the Nomadik NHK8815.
>
> ----------------------------------------------------------------
> Linus Walleij (1):
>       ARM: dts: nomadik: Augment NHK15 panel setting
>
>  arch/arm/boot/dts/ste-nomadik-nhk15.dts | 85 ++++++++++++++++++++-------------
>  1 file changed, 51 insertions(+), 34 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
