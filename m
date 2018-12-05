Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A268C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:15:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0113208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1Ze5SPG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jnnMQP8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0113208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wb65e4UpJjS7/VHzqbj/3Or9t5s/1focJ01qDUg5A7w=; b=F1Ze5SPGL1k42/
	J1Zo4SPmS8N8VZQ/mbfzGrKhbASBgBOhfWJUZnQt9+Ipd35Mn3E24+4EqTbjmzlvfOo0LjEKOjDZe
	4bWgyBVNwroIxlxx/TmktV2jcikuq9MpD1vKsT9anRNKckykdTucrGlBQSx/FKA/nuYx2t2t7pc7M
	ASCS48LsLP2Y675odM+2MMFpVKgkhZ9g1PVweYPs+N7XNHk4guo1wu9yHg7R1+MkdDVeH+s3DROJP
	jovP4VXyjZgVTO5D4RqKcPlkBO3H1NFQYGYzRCrGZeqrWnzo3PWTZP6F56fr0g1Bf0JgrwadIqzkK
	hZ7YB3MbbDAWPtcBZCMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUfS9-0002MX-6E; Wed, 05 Dec 2018 22:15:33 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUfS5-0002Ki-MB; Wed, 05 Dec 2018 22:15:31 +0000
Received: by mail-ot1-x342.google.com with SMTP id v23so20166378otk.9;
 Wed, 05 Dec 2018 14:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FtEa9PBuCkLtNZwRds2jfJnsDI0pLbrd9HokepXLzIQ=;
 b=jnnMQP8CkWcBbAFMMMMun/VLwdRvosfr4S62E21gB4iop0N0pPO5Dm4MayblGdjD1z
 atH13EfFmNUEJDpa6ipuSwyj/nBo238xiFD/hhojuwFBoQKhtKO4x4IKYJ4MqK+M80Eu
 BIkNDySF4HJGKd0IRTvF1qj7T0spgT2QnW23zzIcLovjBsJqMsieHg+ZybQpDSXsByNU
 SGS+Jtt+KdEehdyea1tp4kGsEox4i9hUNi56dvgxmmWELWA1QXK40W0hoQAM7uRjp6+A
 pENm8oPz1SCaBciW3c6MZKSeY1zfjhs8yq4dlubk/c09lwK7j4PY1id20pZv+88aElHG
 RbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FtEa9PBuCkLtNZwRds2jfJnsDI0pLbrd9HokepXLzIQ=;
 b=SwxlDUL9aU1zqa90pPJhaIZCL9VHq4aT1+CdwEep4u3PgoXtqAE/fH3U6N/SwGK6MU
 gR6Ig9sihinNZPgeWH/95pBxQhYFhDSZIbcuou5fQAbUy1z7t1pwuDBwi9Z9mTF1r0Tn
 i/lxmKNKcSSWdJYU850QG5SI0UAE52ZUI4LrPZAXVsVakbA3/6X4CNPN76j21pETSYJW
 cmPP73haDS0O0uFkAPk8vFDx+NLnme77DltBGJtB5ggmpSTowhQilanAdGA1rs52wvZz
 ze7vCBC2Cj/Wd3W21t5H1dm4opoKgvdGDid2WDJvnOyk/YiTyDKJk6GyGL0aeVSjnNjc
 wmfA==
X-Gm-Message-State: AA+aEWYRdzbl0KGMQn+DtoydxEtLdyS/fx1yMGHFUHaEhYnxE7RwdJgh
 lzauJUTSl8CLM0nfHuBeVSx1cNIH7PnptsW5+8g=
X-Google-Smtp-Source: AFSGD/XcV4MbePvWOb/dsxZgutiYAyVS/wpqVtPdL69MIJ5A68Aehd82v1ROx4a2yNL5rvPVO0xI3B0E+jm/w2eikBA=
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr166037otq.348.1544048118115; 
 Wed, 05 Dec 2018 14:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
 <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
In-Reply-To: <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 5 Dec 2018 23:15:07 +0100
Message-ID: <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
To: ben.dooks@codethink.co.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_141529_720283_EEB7CD3B 
X-CRM114-Status: GOOD (  17.34  )
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
 alexandre.belloni@bootlin.com, ccaione@baylibre.com,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ben,

On Wed, Dec 5, 2018 at 2:36 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 02/12/2018 22:08, Martin Blumenstingl wrote:
> > Add support for the RTC block on the 32-bit Amlogic Meson6, Meson8,
> > Meson8b and Meson8m2 SoCs.
> >
> > The RTC is split in to two parts, which are both managed by this driver:
> > - the AHB front end
> > - and a simple serial connection to the actual registers
> >
> > The RTC_COUNTER register which holds the time is 32-bits wide.
> >
> > There are four 32-bit wide (in total: 16 bytes) "regmem" registers which
> > are exposed using nvmem. On Amlogic's 3.10 kernel this is used to store
> > data which needs to survive a suspend / resume cycle.
> >
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > [resurrected Ben's patches after 2 years]
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Just checking if the change of author is deliberate?
> not sure how to do >1 author on patches like this.
I changed the author on purpose after seeing how much I changed
(compared to your v4). this is also why I added you to the CC list
however, I left in your copyright (just like you kept Carlo's
copyright note) and MODULE_AUTHOR

if you're uncomfortable with this author change then please let me
know so I can undo it for the next iteration (which I need to fix the
issue found by the kbuild test robot).

in any case: thank you for your work on the previous iterations of
this series - that made life much easier for me :)


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
