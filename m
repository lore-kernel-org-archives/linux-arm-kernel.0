Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B8CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:46:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343DD2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tp31uGpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343DD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3SfL7XiNEHcTG01ky5RjCrHYFjo+NoGrnt4FcRquGN4=; b=Tp31uGprMnoGYm
	+4i8qA0jJ7w9Ps5R4Bi2v7UW5N+KbBCEg9x+9uBAEpMIF3uFM60xC3KkDiC3KP1BACkiyag1nITnX
	7z2c2QnaVhsisYIbbkRHlzpMBq1pVkhoK/mk1vgPbJllheqg9WZ7U+hWhyJ39PmmK7tED18iwstYT
	hs9Ko+UbzwghItdsQyLUooiJQdmjBtbfVFjJwAoiN2/afXQYMcAqsH7C1UR33Jcb/5YbDjSORZpEe
	Ocmjdfkh8sULbXTq+eo91Nnt/GVvNwdfI+o3tx/olL7WIQh2iQ8GEDL8hZ+B8lajZKLxsfggI92Tg
	+L0iTej80R9Fn80F9w+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghx8z-0005aM-CC; Fri, 11 Jan 2019 13:46:41 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghx8w-0005Zh-0K
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:46:39 +0000
Received: by mail-ed1-f65.google.com with SMTP id y20so13118651edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 05:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pUA/PcXRiLWKAGT4dUBVJTHpTyI6a9FA+BaQwVjmR6U=;
 b=n8PLzqY59OU8wwTNE0aVII4KeWSRHmlYSzAxFSSms4hY9wsnOpVsd7rxmC0L8nbJnV
 1a8smqOy2behoqIt+frO83J8cPp6bAgee7hBFxTTmahrwbjKFJjxTx5CNw06bm+jomeZ
 rZtv7UkAhS8FrxarfKbZhSKa2RO93wWmYul0GMLnkmmpeDryzVAOQuPbY5TH7TUpN0Wc
 17ha8MXP9shawkTvIinaMYxUJUz0ysmq2ONRV77/NDQ0yCIvP9YHZp8hH3cQBgRwrzFA
 xkemdyLCnx9hCzIwuA4UPAUCmJuAuq6RHv5g5qCQdgsrfhzmneZhxcYl3vKBlSBYJCvJ
 R4Xw==
X-Gm-Message-State: AJcUukfXssc7Pjoxji/y3+/GfNun1hpszIFIfbE/7WCL69/la4DIcNfk
 w9wH8QstHiHF1vV0yTOdD7BtfR1YmEY=
X-Google-Smtp-Source: ALg8bN6eDkAAVg1rzWCiesKekxRet9Jy6TWPFP9q4fAE/Z7k0rJM9RykYoN7+9blqcKPGQoooRG+lg==
X-Received: by 2002:a50:a642:: with SMTP id d60mr13486274edc.290.1547214395271; 
 Fri, 11 Jan 2019 05:46:35 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com.
 [209.85.221.48])
 by smtp.gmail.com with ESMTPSA id z2sm2621285edd.4.2019.01.11.05.46.34
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 05:46:34 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id l9so15203612wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 05:46:34 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr12959026wrv.87.1547214394542; 
 Fri, 11 Jan 2019 05:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20190110082633.6321-1-wens@csie.org>
 <20190110152632.hdlo3h4e7yzzjtug@flea>
In-Reply-To: <20190110152632.hdlo3h4e7yzzjtug@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 11 Jan 2019 21:46:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67h3W9-aeN+Y62af=g+RjZiKwi_pw-VYstTds7R13ox4g@mail.gmail.com>
Message-ID: <CAGb2v67h3W9-aeN+Y62af=g+RjZiKwi_pw-VYstTds7R13ox4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Increase size of regulator array
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_054638_046600_7CB388D5 
X-CRM114-Status: GOOD (  19.50  )
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
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 11:26 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Thu, Jan 10, 2019 at 04:26:32PM +0800, Chen-Yu Tsai wrote:
> > On the A80, the pin banks go up to PN, which translates to the 14th
> > entry in the regulator array. The array is only 12 entries long, which
> > causes the sunxi_pmx_{request,free} functions to access beyond the
> > array on the A80 and the A31 (which has pin bank PM). While the
> > accessed data is still valid allocated data within the same driver
> > data structure, it is likely not a pointer.
> >
> > Increase the size of the regulator array from 12 to 14. This is a simple
> > fix. While we could have the code take into account the fact that R_PIO
> > pin banks start from PL, or maybe even dynamically allocate the array
> > based on the last pin of the pin controller, the size reduction probably
> > isn't worth the additional code complexity.
> >
> > Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> I definitely overlooked the R_PIO case, sorry. I guess the proper fix
> would be the first alternative one you suggested, and we should take
> the pin_base into account. There's no need to store twice such a large
> array for this case.

OK.

I wonder if we should try to get rid of pin_base though, at least as far
as the pinctrl core is concerned. In other words, in our description we'd
still have PL0 == 352, but when the pin is registered, PL0 == 0. This is
OK since each pinctrl device has its own numbering space. And it would
match up with what we use for GPIO.

It would also be better to nail this down one way or the other if we want
to use the gpio-ranges property.

Either way this would be a separate patch.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
