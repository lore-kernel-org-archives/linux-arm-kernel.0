Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C0C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:48:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234442083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kWWY5k+X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCMS4jI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234442083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tDlhtb62GY9HN/2ypwWa+UrBM0cu6pav2ILqDHfE5eA=; b=kWWY5k+XTO7Mtb
	Ovrnbr9vKsSaWdgH/Aeh24CX7oWMYuVioTeCPUfF5fPQoZPyDoyk1g1WuEikO9g3k51p6wcbZ1DT9
	b9pVhQPMUCuFBTy+t1P5EzIxhReQkIu91f5CoKbvxd2pbSDiFK7yA1cvnGiBujo5jEXU2ybwbPRWC
	BeOYSRmhEp+gAvRTnAgDTHcJOVKo0mQhNNRDw5yAq8OLV69OqYkl9q6+goks/lbwV8RYpXsYHxxf+
	6dd4ICrJ7Ks/VKRwAA7E84IDfokYdD/QfK3geBH4eXMpAr9WnjSGU9gBWC98qr1xoNRphSLkABY8X
	vu+7+vfTdHwcEJqy3H2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVCkP-0001qR-1W; Fri, 07 Dec 2018 09:48:37 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCkL-0001ou-Db
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:48:34 +0000
Received: by mail-lj1-x242.google.com with SMTP id n18-v6so2998484lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=owIMGX0zemiqfnl4vXIAcdx2Vr7Uc7+3UuYHHK/Nyxg=;
 b=dCMS4jI+Y3Bst45CoAgAvpWA8BB4fyAbzFwoTc40H1nPD/1UXtXLDFCL0Ds+ro16do
 ejQTltkBHjx1BsTnJpNMVdNmASWVElFa7CVlF1KQjWu+aowrNHM+tpHM9dcXMirw5flH
 NEJZ2V7lWuWrbedVz+bE4RzgubffZM0bIgjnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=owIMGX0zemiqfnl4vXIAcdx2Vr7Uc7+3UuYHHK/Nyxg=;
 b=c8FHcr+C3Q6+RsbsGwi2bVy0dpO5WVNDGMR9YLlR2tn2y/HIHB1kMsfLIwENWnwcfk
 eUtiMkgQHoi2PlojvuFD3LGP8NRcTZI/dIsSt9Z6iIO1LhIFmhXj12Hvi5LUiDolfEBE
 1pl+xrdWVSWxhY/+vzYnoxkVt3NLhFz2IWtRJGYYO8Y05kOyctyYZZ74I3EbltIqtgID
 39ivRlpvRTDrRjCJVMa2ERlbxhIw5f2qjf8uaMxEjwhWaCKKktt2G+w/PTcz5vGgRn5O
 W4kaQvWLBfF2BwwAlduRoZDFYJY7hzueM8pAAZRAuYEHdjC6Eq+TcPu1ISCDiQRlf8JJ
 Pw2g==
X-Gm-Message-State: AA+aEWZgjEQ0OTgoBmJ3Q2KFaGHYq5KEedNNl19E/n8jmuRLdqn93nhN
 G0v10PNxSKo3esm82Des19oTkWASbHyXrRBezuy4zw==
X-Google-Smtp-Source: AFSGD/VijDAlpfR46oznn0VKGkuORUBAhviF4yCihbF8dcOrwpDLW00Y3r2VzwXC09WompECICdaNUxAn84X4tdRI0A=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr932812ljk.4.1544176101184; 
 Fri, 07 Dec 2018 01:48:21 -0800 (PST)
MIME-Version: 1.0
References: <1543338018-708-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543338018-708-1-git-send-email-hofrat@osadl.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Dec 2018 10:48:09 +0100
Message-ID: <CACRpkdaM1j7tXm+rekxWUOuzshfYxHf66mYQYtJLuHq=kpJ6Vw@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: mt7621: pass mediatek_gpio_bank_probe() failure
 up the stack
To: Nicholas Mc Guire <hofrat@osadl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_014833_476988_1069D7A3 
X-CRM114-Status: UNSURE (   9.56  )
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
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 6:06 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> The error cases of mediatek_gpio_bank_probe() would go unnoticed (except
> for the dev_err() messages). The probe function should return an error
> if one of the banks failed to initialize properly indicated by
> not returning non-0.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")

Patch applied with Sean's ACK.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
