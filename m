Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A91C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:48:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2D52145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qikcenA6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LnP2TPxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2D52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4+wqZn/zhH2t9gNui0PdVTD9v/LnJy7IC+h7JfAalzI=; b=qikcenA60ZR1jx
	sbTHBgU42pTnnA0P5RVki/pTQr9uO4PJzPWDIw+UCS8qBXaZBkIfar9dy8pqXPqWPvXB94bDpppBr
	0/d9T6ZuOVaaJh/2G2m789bCx/bL4lu/6zg+Gp6Q64Oz3m1vuW3s5epiEn/kPeeewQKLvA5mYo34D
	yAPvjR8K81q8Jpy6imVakomIJ+Qe0rivNLvEiakOlmONmGAKhxZPBWJhSxZoXVz+cmSnkFOFnzEuT
	l3NqGHprWTbUU7AaFENtP2bjXvm5xlz1Y4WFrwWg3g06n578D731fDMpAhy/GpCaUYGkiWcCLBM7E
	4mE8GY11lG/bHPi1pgOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ2cj-0003N3-Bq; Mon, 17 Dec 2018 23:48:33 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ2ce-0003He-SV; Mon, 17 Dec 2018 23:48:30 +0000
Received: by mail-ot1-x343.google.com with SMTP id a11so13916966otr.10;
 Mon, 17 Dec 2018 15:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rt7CdRQssFR6XPEPPXiILF4IcZMbBsZnZ/kJsmQYXDs=;
 b=LnP2TPxdt7Tual/++38WGq5Y7xCiAY8oRDzCDoH7fo+aw5XbfLmfqSligXTECc9WER
 i6SUD0p0eoxdrcGvniU6JzjCwdS+cPa4A4EY1M8oENIfTAOOhgEpjbNyO6Z5zpcizagp
 W55Ovf1E3Jy6iomn23NZabRyEc93k2EDZDveeLSukEWjv7xB6PnKcSEtBcSVYZdCLfgU
 NP2yzh8mpHrPMLn9C+5jJ9Wb+LgEKXi6grW6Y/3DSZJHGRb84io1D0bFPZTEcZ/U7O9k
 421QmfExwvYLKZz0mYJ0AAZm+DIT87yc/PrWTiYVCNuKamRS9gX5b3McaunpnniNKfDR
 6cFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rt7CdRQssFR6XPEPPXiILF4IcZMbBsZnZ/kJsmQYXDs=;
 b=atxm0bR9qfhLG4RAduMbcHT/vMaHNhf6kYUxmJBBIHWaMjqPr9z03KifPJiGS7DUOl
 poSSZiFUk7TOnrvljmCtT/MJ8uisj5YLcSnQJ3C0RZMdoh/JzJzLlTe2UCcVIfB9HxVB
 OTiV3hrBiKuJbQCCrQjH+Jug72ie3dl1ypNaNgsdsqBeD+2XzceZJw9hQE8Mtmz9NKZh
 kUzc46B9kKq+4yVxoxv+7aX5YeNOuwZWK3PXJOCWeRkm0MZ91tiG5VowTg8fpCnfaXm0
 ouVrdP0RdLTwqYqgtJgtbIPyED3W9RDEB/EIPCAZElPZ5rQa6Kwsz0Xx0zRPhF1ZNXYy
 4SVg==
X-Gm-Message-State: AA+aEWY18DIrSS6uEeS63tNNRhVHg8JzpMRkuF/eInTtXW4+fDDgneUj
 Tn5HJuwN0SXwjfqoNp2NzhF3QMLUcBnWIllvByteRETf
X-Google-Smtp-Source: AFSGD/WgOUrjzw3r7cF0wdB9sAFysppeNnwH1UIZjLX5ZG2xx0bUQIN6nohG5gztj/9cysAu5C7Ipj2FwmLigttYsSo=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr11457998otl.342.1545090496291; 
 Mon, 17 Dec 2018 15:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
 <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
 <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
In-Reply-To: <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 18 Dec 2018 00:48:05 +0100
Message-ID: <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
To: ben.dooks@codethink.co.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_154828_929211_A4EA201B 
X-CRM114-Status: GOOD (  11.67  )
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

On Wed, Dec 5, 2018 at 11:15 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > [resurrected Ben's patches after 2 years]
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > Just checking if the change of author is deliberate?
> > not sure how to do >1 author on patches like this.
> I changed the author on purpose after seeing how much I changed
> (compared to your v4). this is also why I added you to the CC list
> however, I left in your copyright (just like you kept Carlo's
> copyright note) and MODULE_AUTHOR
please let me know:
1. whether you want to be the author of the patch or if you're fine
with my name in there
2. if you are fine with both of us being listed as Signed-off-by or if
you want me to switch to Co-authored-by
3. about any other concerns you have

I would like to update this patch next weekend so it can be reviewed
(and merged once all is fine) for v4.22


Kind Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
