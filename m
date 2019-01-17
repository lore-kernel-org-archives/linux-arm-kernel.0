Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:57:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FB620675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VgM1Qhze";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="O6YOuPxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FB620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Q8RNFCr+reIJ6gf+fUoweTOZzOIsyqaVnjbqQs9s00=; b=VgM1Qhzev+5CHq
	cOG4Ofnl80rKYolGvR7AGkfM+JpGqGmGfHp0zw16M8M5Ty7UJy+fJZz6AxmIyucqyHySmEwDHIFPd
	nkuTm5QEeX9IumUTzJdPCRNOgK9926NiM4whh4R/7SjQ+g7bm7YaH3Ppndmc7P4fhWpBKFqpYHwWO
	gZ72F2JPiS4hjKks2RAi7BI8SKTSRIDrgsGYkSy8k9c4CmKsiotgGZH+dU7Yq3g7n8tcUbnrtYx6P
	Aww6Q2n2rxDNqgApDAv4VJQ2hyf/h5yKlApirrzbSNuT8Xz+dyGDrPVIWRsYgiwjHXz6QaIK6Ok7F
	9KgtJeFzZVcBK1bG3LQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjwvu-0008Ig-0C; Thu, 17 Jan 2019 01:57:26 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjwvq-0008IC-FX
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 01:57:24 +0000
Received: by mail-qt1-x842.google.com with SMTP id v11so9709577qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 17:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8hf+ofgSsRS5t45iZYlUrALq0LlHYKreLgUYHny3V58=;
 b=O6YOuPxeg9LSor66Vb6PPawvMjF+bLGkWqJ3eH1LliKIo+5jbgmzK2QN7P8qPI0ykA
 6kCu17SfTW+GGVNd7oTN4WLLpejkNd5bWVBcf4ug947rp4wz+SnMhnBCEcdun09QRJBu
 Loe9vvYMEdeOypnNyLG6ZUkq4x2KJPrNiAm8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8hf+ofgSsRS5t45iZYlUrALq0LlHYKreLgUYHny3V58=;
 b=dNzHhMXQPK6CzviAbFt0GjCwbWd2OsemRzA07baU5jGk3RfzU8nPMuq+jxxw5jshzH
 uAdgxcVvWATGUWO+k+RGoHGFcvUY82lLDO6CImjlnnEGBMqqaGtByli3ZoMSls2Tp6Wh
 y9lZ+VBYa2gJ5Z0K5H6n1SaL/oAEuJFdFGPJcXvLT21alRFaIpzvvWw2heJDiZRn1x4f
 H9I2a68sJovp8/DHRlcmgX0uShsg0DFODfWgti6HlAEV1CSiZ+rln+C22gYeL/nk9Mnb
 dzJNyWoL5vI6TKJdddcHmLyJkdqqjCNA12wiC/c5XZTOYkW36m8rKsZ7ajWp4SIzRQPD
 4Adg==
X-Gm-Message-State: AJcUukemjFpSG2TBAGLAZ6Ag/VCIrmJdxKXf77/g8n/J4hvyZHXwDP4V
 dXl4Q327CvlnkjD+SOee/BNr225zAujopMk/Mhc=
X-Google-Smtp-Source: ALg8bN61lhbNxFwc1ARjGAmnrnKs2Mbk9pynH7KNswSOG0TKqsaJVyiLI67+wVdcAgOc5AHNnQAx9H4f84v7bYQVm4M=
X-Received: by 2002:a0c:e789:: with SMTP id x9mr9533669qvn.245.1547690240331; 
 Wed, 16 Jan 2019 17:57:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
 <a7b5fa54198e7fd0def33de3e7db36239a2e3da7.1546918172.git.xiaoting.liu@hxt-semitech.com>
In-Reply-To: <a7b5fa54198e7fd0def33de3e7db36239a2e3da7.1546918172.git.xiaoting.liu@hxt-semitech.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Jan 2019 12:57:08 +1100
Message-ID: <CACPK8Xdj1Cas8E+141f=ke99REhm-H-pgWE0GBwxXaZ996tCeQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: dts: dps650ab: add power supply
To: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_175722_765152_45F196EF 
X-CRM114-Status: UNSURE (   9.61  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, shunyong.yang@hxt-semitech.com,
 linux-aspeed@lists.ozlabs.org, dongsheng.wang@hxt-semitech.com,
 Andrew Jeffery <andrew@aj.id.au>, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 at 13:29, Xiaoting Liu
<xiaoting.liu@hxt-semitech.com> wrote:
>
> Add Delta Electronics power supply DPS-650-AB.
>
> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> ---
> v3:
>   Modify patch subject and commit message.
>   Add delta to compatible property.
> ---
> v2:
>   No change.

I tweaked the commit message to mention the board you were applying
to. Applied to the aspeed tree for 5.1.

Thanks,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
