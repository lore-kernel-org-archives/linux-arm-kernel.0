Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA87DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:22:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A261320870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gvAZrP/x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGR4Bqs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A261320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ks7D4GG1gQV2/Um10bA5Blo4YeEc2vzxs5M/Sg/8UOM=; b=gvAZrP/xBBzKFD
	71/IDecCAX4gp4dTwYSAunAntEhqUbNWeOWyfD89eOHFO283VUUxg/+V7EFn2rN9PkJ9EfozxHQp1
	NH+dwDkt/igl8D+dYJ2B/O6k2fv55101RHwvRCQoL9S7qXmJoq7MzVgiqQaSF3S+ZOJCG+tknG4hX
	Tcoy5o/9muTQs8cB5AU9weK4fggBREYT91tTQ/dQ0mA4wnOPFFzDCt21gEC4GrR83eW5ghmqOSBlM
	ZIQIQfcZVQS82AkosKF5V7Au5cyYNASsRHTjleMDKBxuyrKquHqteVNpO4y7fvadrDs5feMNYVTS8
	zerOzcsLB5FP1owj2vYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvpu-00084O-Dv; Fri, 11 Jan 2019 12:22:54 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvpp-00083J-Rz
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:22:51 +0000
Received: by mail-lf1-x144.google.com with SMTP id n18so10674892lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 04:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FaSKI4nvhnbCZeyaDFHOR9LECZaCcGkEr9VUMXpihjs=;
 b=RGR4Bqs55LDe2TRrIBM0sivajev4ckMbJz60bum+N3t8J5V0OYgvMrxPdCh8XArzVZ
 GzEKM4FI3pWPLZn08nMyJmR6MSqOBNEDTnarPfdU+/mz2HlRO84XPv5p8vx26GT0qDg7
 1ymKhg0PKGjgu1CFBl7cWe5gbuo5o47Erwvos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FaSKI4nvhnbCZeyaDFHOR9LECZaCcGkEr9VUMXpihjs=;
 b=q8KtqILIXVh+SysfmIAXqDzssUE9U1NWkrg+YcqLaY4fTNwakJZ6tK7JN1MC+2zCXl
 TRFCd8XnNkxLFfNXe7ApI06KiQ6XFD3C9b2NsyAEFZ4lrg3m9+0GriNkx4FVVVhMGzUa
 g+DqwL5wEF8isbr68LojEpxiQOy1v/fEDpzWdcyuTYDZ1fhDi9MW8fcvxXh5vHw/W6od
 I/Y5nH3qt46H8BzZ4oyWRe/mK1dWKM8EPj57mlHEFRxTnllv1EQxYq8A+7Hdjt6BKOBk
 UhBapDV+hXjW4jOkUnD6a+YjkJmzrEivb1dCwdu4B6o2Hxnz6heEewl8Rx57101ecRRu
 0T3A==
X-Gm-Message-State: AJcUukcCLEewYsMTqgh2vioE1UUV6HqYAM+SPSOteC6ykLhDGTkmQm8b
 TH/VkWgX7PR8j4Epu9YzozJmP7oCK4cDEKnrirj9Vw==
X-Google-Smtp-Source: ALg8bN49feO5dRHaTMUjkeNJP6CeQUf4AHE8OSPU96hXwEc7Ey6nRm936iiUJb8D3SK9XuI1uAlStmaswkDqCM6UZ/U=
X-Received: by 2002:a19:5154:: with SMTP id f81mr8414427lfb.96.1547209366534; 
 Fri, 11 Jan 2019 04:22:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546621488.git.gustavo@embeddedor.com>
 <84a16ed64a29984b11c34b4f31cdef0758ffbfb2.1546621488.git.gustavo@embeddedor.com>
In-Reply-To: <84a16ed64a29984b11c34b4f31cdef0758ffbfb2.1546621488.git.gustavo@embeddedor.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 13:22:35 +0100
Message-ID: <CACRpkdaEP=nnE5SQE0OZ7Mi_VCnVn9AK9bGu2tJ5XR3+uFHfvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: integrator: impd1: fix NULL pointer dereference
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Nicholas Mc Guire <hofrat@osadl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_042249_926681_2EBB42BE 
X-CRM114-Status: GOOD (  12.11  )
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
Cc: Russell King <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 4, 2019 at 6:18 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> There is a potential NULL pointer dereference in case devm_kzalloc()
> fails and returns NULL.
>
> Fix this by adding a NULL check on lookup.
>
> This issue was detected with the help of Coccinelle.
>
> Fixes: 684284b64aae ("ARM: integrator: add MMCI device to IM-PD1")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I already have a patch fixing this from Nicholas Mc Guire, just that I
forgot to push it upstream. I'll fix, sorry for not applying his patch
earlier.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
