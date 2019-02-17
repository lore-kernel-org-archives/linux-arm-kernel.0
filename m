Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC2DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:05:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514A12190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bNNJjDJv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bXWSjfbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514A12190C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Px/gkOtiNtzMb0Bju6eXevv9b1Z/3XSD/NsAF14zd/s=; b=bNNJjDJvt5eNkA
	HhU3PStw1DTUKWaMcorT+zZyPuzZryWdc5UY6KyuIIFIfIRsK+SjqO/y/HH/0hV7zuK/+sZyB2Pg8
	8SnDZRllxcpvUL/hvhiqdqNc23BzaPtickfL2r2iDLXveVElH1D3vtvxTo/lTyvr5TD50SDHk5lIn
	0zou6KCVsaSTtCtVqSsnK3jw1hEcELEliLADL0/8xuu2OjwfQe0x2jKj+unNVzYEf8Q78B3nXY13K
	sxG0iUU6USb1dnqTew1vEG7tg014Ho2S+OsEo7S1lt1xgnUQP7whZqmx9Xps8rO+h7wUlcEpg/gwr
	2wDWsqcaiZ4B7Pyxab+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvN4N-0000rg-1s; Sun, 17 Feb 2019 14:05:23 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvN4B-0000hW-Sc; Sun, 17 Feb 2019 14:05:13 +0000
Received: by mail-ot1-x343.google.com with SMTP id m1so24124867otf.5;
 Sun, 17 Feb 2019 06:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Irbxz5UeO3Yco6GVrPGA5A1f/mmKGpA1Ukp1VIsq7c=;
 b=bXWSjfblnC0bH/NMx3wzPy3xqq29XwZEq8aaVLoNpObtfJSBxCrqpc3343hDI/joa9
 RBY8PITjpi7zhvKeYx1OlYXd9J6GJyfy86WP3LlBMYJtNq8gDvB2eCv4MrlX/k/kQpHv
 b4ZHSYaAtdJ/r3bOL1EqbhctmXuOsOIBc7MBeJOL/QuCX9xNjahq0mS+0QYEDxTA6XVQ
 qtrnjsny4uvmFlBndjNdyLFsxmJ5u1n4Lcyi3R4xMRoQ6fLGzdk99KUzpRw5BoWVDF3G
 +FpS5oy+1L9VL80SswDUZ/K0uglriOo6FgzMaoktWAxR3oSpSrwUf3SbVz16TWuOdZou
 swvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Irbxz5UeO3Yco6GVrPGA5A1f/mmKGpA1Ukp1VIsq7c=;
 b=kjdvCKePO2ppyQq00I5z0E74P4z0kMtQQaan7UtH2vzhXgdtFkW6/g0Tyv45+JsMj4
 rOf8vLXnH37+3CWxbBc3zmarxb0x41rUZxmG9CqOVpfRHxeVf7YDjoDVUtAMCgg8SD30
 DmLEYNp9HyBKBQjOJuI38H+M0eihtN+nX6aMT6eE+WytsovRM6JOFdYRUZNByJSzR2CL
 qJbpZqwIVw1C5bDTGodvl+2ChNiz4uWW7kA5FF0CviastQvVN1kcZUsvVQjHQ6kfhNxd
 q3Ud6GTa3H1DzSnSinFsWd28tk2UwRI9ldD5wJ4JtN+J34YncJt0Cz1A56j0KLPBUcQq
 s2Sw==
X-Gm-Message-State: AHQUAuZYTag2Z0al/X0n0OuYhIj6pRpdMIom2u4ODFCQeLCY1bm6idAt
 90x8D9mTSYo1N3Rv94DVKZtB3LPCRBhfMnDTgKY=
X-Google-Smtp-Source: AHgI3IbgJ9E+SKHb/sALqp8UtIHoNkh42ujd1vUsb3m6bL7VCxv/BPUSmyZWwr0Ea4Sy9dOUG6UCfC3zPxIlCjD/lU0=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr12165392otf.131.1550412308763; 
 Sun, 17 Feb 2019 06:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20190209002641.9105-1-martin.blumenstingl@googlemail.com>
 <7h4l94k655.fsf@baylibre.com>
In-Reply-To: <7h4l94k655.fsf@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 17 Feb 2019 15:04:57 +0100
Message-ID: <CAFBinCAyWECka-kNxeM58prN8ArBW4ASwJL31umEJr7p4nAGYQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ARM: dts: add the clock measurer on Meson8/Meson8b
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_060511_918619_2981DFB2 
X-CRM114-Status: UNSURE (   9.32  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

On Sat, Feb 16, 2019 at 12:02 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > The 32-bit Amlogic Meson SoCs also have a "clock measurer", just like
> > the newer 64-bit ones.
> >
> > Add the node of the clock measurer to meson8.dtsi and meson8b.dtsi
> > so we can see the measured clock frequencies in:
> > /sys/kernel/debug/meson-clk-msr/
>
> Queued up, probably for v5.2, unless I get one more late PR in
> (unlikely.)
that's fine for me - thank you!


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
