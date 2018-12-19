Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7747AC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:39:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC3E218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ms7dRjLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC3E218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yf9Cww7Xe4dPu1Opk59jx9gFrh13HTtZbuMZprowx54=; b=Ms7dRjLGkzWI3K
	6fWZEiU4vr/o+E5pDcCMpJVCww0gptQUBMfFeNLgyRfxup150D+RiRH4Ya0TZeCUBg2pzaanUlj3S
	knF6ivg44PM1d4qTLDEYgUIhN05F+dZeBCVPuIl7aY33wT9Y+7/yZo4Q8rS7SwG01giKVnOEXrwCT
	HDc7Q8tGm0q2h+5Ru3JgEpaMMG7flcMXYQWLCjvmBHMTvzCdF+7Zqt6e5oUaWWpYn1gsHfLSeO6aT
	u3Jvegu/5xtTEZq/OZPHGjRpWFtLBpe4INSe/T5mmWdBt1UQYTWcVEdQA2uqfulDxxXRNp+S82fEP
	8W+EKihnCs+UQkZUv/dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYKB-00027P-Ei; Wed, 19 Dec 2018 09:39:31 +0000
Received: from mail-vs1-f66.google.com ([209.85.217.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYK8-00026P-5m
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 09:39:29 +0000
Received: by mail-vs1-f66.google.com with SMTP id p74so11861326vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 01:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TuCpSMpWIEaYjQlh0UJtISg8gGP4dUwfsuw6wy6uFmw=;
 b=bF9u7wRsOFq2FX6P97f7G+Zy/FNwJwq1OXJ3T3gyd3VHDhVpdj3n0CHw9IgOt6P3gW
 edP7HWg2+PaUqnHF/rxh8C75S9ooDCpc1PG0pB+7tvX7UaDP17SDKchWW19HHonCFIPK
 c9C7XyeNeDiMsGJ1Ty1vwAdo6k85vRjBX6CdufYULJTDVbFhxjif3rQwKcT5ofu6fMFw
 25pY8S9kDTqPkL6jGAtQAyKKzClDkyA5dtQ1Y7p5ZGfwAQbvpZ//qC+ETBUxx4OOMDV0
 fstoiGzG5hanyXoFmpIx3NVZiz9ehjYcj2zgBWhXy1b3FwKKJPPJxuKQTPXX6gKcDajY
 wYSQ==
X-Gm-Message-State: AA+aEWb4fXZkf1v6fXXgUxCcfJamMBXeOqPu+74z3LYTjYAEtWw6UVEa
 aoLqBhikMucnm4u26VM/NBJSnQr85cWYzbbO+2jLEihv
X-Google-Smtp-Source: AFSGD/XijFguxsVpS8nAuQ/qBpS26KM2u/bsI7OaRhAOaAO3LpAu/iQ3iPUGkeFRZ8K+nBru+5U/MrJaNIDf8FE7tOs=
X-Received: by 2002:a67:c202:: with SMTP id i2mr9058755vsj.11.1545212356638;
 Wed, 19 Dec 2018 01:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
 <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
 <20181218233354.pie5i3lvrrhq5q2c@ninjato>
In-Reply-To: <20181218233354.pie5i3lvrrhq5q2c@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Dec 2018 10:39:05 +0100
Message-ID: <CAMuHMdWH-bh=cfZhxrD6MYfqFUYroai5WbyYZ6+H4MQeubN=PA@mail.gmail.com>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
To: Wolfram Sang <wsa@the-dreams.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_013928_214306_5E32805C 
X-CRM114-Status: GOOD (  14.88  )
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Peter Rosin <peda@axentia.se>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wolfram,

On Wed, Dec 19, 2018 at 12:34 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > +   unsigned int is_suspended:1;    /* owned by the I2C core */
> >
> > When more stuff is added to this bit field (which always happens at
> > some point) updates to all members of the bit field will have to use
> > the same root-adapter-locking, or we will suffer from RMW-races. So
> > this feels like an invitation for future disaster. Maybe a comment
> > about that to remind our future selves? Or perhaps the bit field
> > should be avoided altogether?
>
> Changed to bool. Thanks!

Does that help, given bool is smaller than the CPUs word size?
Is it Alpha that cannot do atomic operations on bytes?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
