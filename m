Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A2AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:52:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311A82086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lxVqmt8K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="q1pgoOHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311A82086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HZHb3yjJTguahvpj/QHQLVenC1rXspP3mXdCHsO0X5U=; b=lxVqmt8KeozFH9
	RQJLSKfVqtq4DExUK74N0qWuiMa+VBvbs9tqvFhJGAvt4MBcdoxVrpghoENC6U5+i2YJMX5h2voWP
	mWHyxQZmHDRmhCpdr13XbHdXj0N0FxI1sINRSbY4BFcNJBj/w0xjaC/DQkYEwURQVD6bd4Z5hp1zn
	KdxYdEW7GGBipxJJsLi41pRzr8rzXvR6p8Ag6gYhw1SfXqaOjTFUmWoYS6i5odW1KxylhtBNdh2JH
	CCBM4ZTKYzyz3V4WxwEWdPZCK5N1yhVkbBqloQaZJ6pjVWxsEuLvCvtzCQ3DCttsQXRmZR6S77V6E
	+kUJU6KICpcMR6ZVA9Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIls-00027Y-6G; Sat, 12 Jan 2019 12:52:16 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIln-000266-Qm; Sat, 12 Jan 2019 12:52:13 +0000
Received: by mail-oi1-x242.google.com with SMTP id r62so14484484oie.1;
 Sat, 12 Jan 2019 04:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rc8PgVwzxQsHlZQUrvGoUgiJPD5Df1DMbVLjyQh0zEo=;
 b=q1pgoOHotLgRiITJMwR3Nr21zMoGSFOGtz6P5PnhJRSfFw8BXzxKwQpM2T1Qc1ZMlr
 SixSB9PBF882HCXbda+ZBauuRJ5F829xkYrydd192rBQpzSjrvIRkR3y0ptL17E+y9i7
 nAefVELdfy25SJ9Dc16gwjRS/SuTXGMtIs9vf+z9t50lEMByk6Ro2a8pLUyJXGweN5P/
 vpCj3oyB37wwXAf+TSEePtAo5o9FTBcAn2jhCcfB8frDfwBrLw8vZ3ipYcCq7DrXluyE
 HloibFgd30nkhG2XuOLMNtt1WrGvBfe/R8J/ObRRi4naLp8OIf3A9Zx4qu9IV/JPRyEk
 UNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rc8PgVwzxQsHlZQUrvGoUgiJPD5Df1DMbVLjyQh0zEo=;
 b=ijJTPDmlyZllBr0Vb60B+d5Q5u0ykbgbopSCZVv9dEH2LJfsQrvjiTLKoAOJjJqUO4
 k67oUqbz8WIkg1vbVbNMf4R2Y0dRJBZXJKeebi8QZSx2t7mN4A2U7lKnOXZK5TxzLfq3
 cXkAf9dCzUFLgw9NvWGQeupSr83zmvj/kP6jnyI0XoaGYXHfljP2EYi5WSyJK/PhEnG9
 eshzzZ2A1xJx6xSEqUEOdHhP0RL7oglgA0fB/ooeh6u3E/4E5ECV7/mwyNqSrhd2+lqz
 BR6FjgIx33Mh85CrQGl1efXePMQMM43r7TicKmGgqs/O9W0oCna7YVg2GogEEF58uF9t
 lrxA==
X-Gm-Message-State: AJcUukezJZswbf9GIHgZoDgXk1RlF963wuer7iC1b/JIwD88REIf94tx
 WOKXYDhhEitbf7I4tmqm0Ov2q5khGCSySusaKO8=
X-Google-Smtp-Source: ALg8bN4s/+TIOtaCGkyhh7CyvpozXsXOtaZQJBwt7+upDR/L+/pzeM+4SuHESOQYRYmAIP/g3kFWjvWzYSNapsi+MGg=
X-Received: by 2002:aca:4ace:: with SMTP id
 x197mr12016181oia.129.1547297530740; 
 Sat, 12 Jan 2019 04:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
 <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
 <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
 <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
In-Reply-To: <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 12 Jan 2019 13:52:00 +0100
Message-ID: <CAFBinCCKeb+wGJ4h_PfsT-Ms8AtLmNSwStTpeMqA3shkySjGkg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
To: ben.dooks@codethink.co.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_045211_871313_8EF8DE78 
X-CRM114-Status: GOOD (  14.59  )
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

On Tue, Dec 18, 2018 at 12:48 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ben,
>
> On Wed, Dec 5, 2018 at 11:15 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > > [resurrected Ben's patches after 2 years]
> > > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > >
> > > Just checking if the change of author is deliberate?
> > > not sure how to do >1 author on patches like this.
> > I changed the author on purpose after seeing how much I changed
> > (compared to your v4). this is also why I added you to the CC list
> > however, I left in your copyright (just like you kept Carlo's
> > copyright note) and MODULE_AUTHOR
> please let me know:
> 1. whether you want to be the author of the patch or if you're fine
> with my name in there
> 2. if you are fine with both of us being listed as Signed-off-by or if
> you want me to switch to Co-authored-by
> 3. about any other concerns you have
>
> I would like to update this patch next weekend so it can be reviewed
> (and merged once all is fine) for v4.22
gentle ping on this one now that the holiday season is over.


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
