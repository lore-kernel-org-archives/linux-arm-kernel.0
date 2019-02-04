Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9369FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:51:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E472082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mli+T/CG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9M36Bgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E472082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Fa/YSf6Wm0CNKZPAEUeaykL8EtIsl3llvnBJDi4IvM=; b=mli+T/CGS7fsvs
	LjLkp6rafmBT0nKnbk+0kGdS7LTj6w+phcDf+EblhTUOwnX2d7sTCjXHsPDXIzPSeOpyBGik7ycM7
	OFl9amXTyE2ek0IO+8EplFr0dzKoS0gjA9BUubnvmheNQt09CXQ3t8Wv5/a3ASN9O0IftLaExB6UO
	7278lGSWbgFPVuDFY4xDn4ZH51m0LHKAZoksd1HdZpFh5uk5ndkBNGeXJYbKT6/VpMOdn0wi7ABug
	TgrAgsdLnfzpU6msn/p3GK2pT/tche5CoV88tCfyvOLrttIdaoLUhORkMjqROyV1rDCWJNKaWr5Ja
	kJuaODk/wrpnWlYvCXog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqjKo-0000S1-Jc; Mon, 04 Feb 2019 18:51:10 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjKY-00008S-Kv
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 18:50:56 +0000
Received: by mail-ot1-x344.google.com with SMTP id t5so1621235otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 10:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VUSJMRMoL///tnXUDh8PA+XtkKvAHiao1x+dhxDRYXg=;
 b=u9M36Bgv31cdjqlXYd+iT6gNsgp0O6I/O9JJrolmg8/wUWxzVuAsWZn80FRBdSI2xw
 iHiidG7iMOuHDufxIkQClt7SWIBP84gFGRXNbfJ3vBMm8GURCpjAf50i/RHFbZ0NNbRi
 4vcegjeJUpjJ/hf3SGIZ/OsLL2PRLKjnqp3qt5oEEVEI+bgmL/KtUCaVTqUXStJ1b4LA
 7BA5eaKarOKM8NVm4EgidNDCMBGmickRHkt24P2UV1nCZ+7SWJ8E2gOMhNB7BUnME5X5
 RcCYOGvxk+dfMA4CoeCRs6/Ls0Ldnm3DnuSFmdy1b6taGdz6YijGMXzDg1andY6YXjfm
 fu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VUSJMRMoL///tnXUDh8PA+XtkKvAHiao1x+dhxDRYXg=;
 b=sPOg+gA1ELzrc/Ri4Ds78BYn3f2tQJRiwdA95FuycEse2ZBTuSH5TRkz5ZF61ibaIU
 Iq1NrtTQHoUjRnp0GY6tUwYs0oEJoJWqc4LQhokAvPjOZLB20s7aKeAF/1CKGVpqkRyt
 g+dmDkeedl3t5RmoYy6zU6fITW2o/37MIDOwhDDY+gCO3UM7hh1tn3DtCX03WUGdFsdd
 7FrCnNIyQ9qdxr7vjLnB1Yn+reg6F9cicgRMzReeA6VToXc+qYK7rq/ec3OL6cQeERZj
 JX+hiF5DC5HSDena4sO/vlvUFXTK6hIELgljFy5Hu5a/iiaw2ZLuR9SbfbZ9T3rDDWM2
 OSXg==
X-Gm-Message-State: AHQUAuZagFzIr2MnQwSdwrglnGTQNEHSjtUZpFGHI5ogImt7jLKA0Yyq
 W0j7EtwD/92g5KKGppjA0iXxg2BhdnboRx3k/MA=
X-Google-Smtp-Source: AHgI3IYAkfXVUg8CbrEK7m/if9+lw+RRTL+YtJQwhPQih6oDAt1SbCvvWo4aX/NGtCRszMa3RqnKkUHEA5j+AipxEt4=
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr426437otk.221.1549306213187;
 Mon, 04 Feb 2019 10:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-7-anarsoul@gmail.com>
 <20190204142036.vd42nvyjnjr5yeoi@flea>
 <CA+E=qVfTfJ9E29gz83tdVGx5_KGWSQVJOAxKTzC+-n7=gdj0cA@mail.gmail.com>
 <0F6CBEA4-6DB6-40F1-A2FD-65101AF64F1F@aosc.io>
In-Reply-To: <0F6CBEA4-6DB6-40F1-A2FD-65101AF64F1F@aosc.io>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 4 Feb 2019 10:50:17 -0800
Message-ID: <CA+E=qVd7yh=JNZSvrfY4Diu+VJWFK6yLUJ5MavBcZ8Cftn6f-Q@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH RESEND v2 06/12] drm/sun4i: rgb: Add 1%
 tolerance to dclk frequency check when bridge is connected
To: Icenowy Zheng <icenowy@aosc.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_105054_728607_172AA161 
X-CRM114-Status: GOOD (  11.69  )
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
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 8:29 AM Icenowy Zheng <icenowy@aosc.io> wrote:
> >> IIRC, from the previous discussion, HDMI had a tolerancy requirement
> >> in the standard. Do you know if there's such a thing for eDP? That
> >> would solve the issue for all the eDP displays at once.
> >
> >I don't have access to eDP standard - vesa.org says it's available to
> >members only.
>
> Try out to grab an old version?
>
> I remember 1.0 is open.

I can't find anything regarding dot clock tolerance in DisplayPort
specification.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
