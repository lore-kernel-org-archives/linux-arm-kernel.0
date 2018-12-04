Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB03C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:05:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC67214DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fw+R5XXJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ijLQd8HI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC67214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VzL71Vba49abfqecoRk/1w3GlijVbBUgajhwixPD1a4=; b=Fw+R5XXJ0tqgNf
	UTuYMRKk71HvFl0jMyH/+iiAy/Js71Spzyht75DG+Su7gUQpUW0VQI+9CsJeze13aB3U8NcZPREjZ
	X58/C36MfyEX3+hcZ8Qr19MGJ672egryvJToEwz37cTsnaDGJMjAxyhTZA34YYZAZucLQSy30Gheu
	+rr7Rp+fF69GM3q6dLs32SiD0xbRsfRoHblNSPG1XfkLpDDjaRDY0lm6lGSKyYGtXS4DVW/Ulz9BV
	5KcGI7yZc4JKdbY8pU4Ulmd0SRnmHomhBpUfpAthbaHwFmcOKNUIQ5ZAjfZ1lnmR7Xh6BjnIxndFi
	4EtglnW0/+EWh7mVc3lA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8Vm-0002Eo-Fj; Tue, 04 Dec 2018 11:05:06 +0000
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8Vi-0001cp-Sn
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:05:04 +0000
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id wB4B4UCv012332
 for <linux-arm-kernel@lists.infradead.org>; Tue, 4 Dec 2018 20:04:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wB4B4UCv012332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1543921471;
 bh=eL67Uj5IhKBkjKKZusu33I1zE9zzfzV4DKOJhGN7Jn0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ijLQd8HIw1UwNB4zNpZTKzdO9pAZdWMKdC/S8EW7P8NsE5arLrziSX0Z21NVNNkl2
 VUBqZk4vwTWjzkjImYkqLvB6S1QL6G9I/LmWH6DoUt0s7L8jmWtk+JvVcuNNt5LMSk
 7AS6DlZWisdvMC3oVrV6FKDWJiwTIfV0XdYVYlsKAJft/D76cA51JbDquu4ez5fHsz
 WHRCFok/iORpEO2msRVWpXSRojEs2O1NGcuPN2mWtDO2twEaQQhiiDjEqHK4aM9g79
 gCKFYq0kGETpbH/MWeNQOaxRj445ajlsKsY9p53V43UQgUID1Wxo6zlwfTq72TfmZ4
 Bey/ChYlttEkA==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id p74so9546232vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:04:31 -0800 (PST)
X-Gm-Message-State: AA+aEWaaOcJ6Ief//OR81NwTnTclLzau8bkDAD3E+XP57P/SSCSIWD/x
 j/xxZ/OAbNdw9H0tCgRatg511NXEFspxX5Tt3bk=
X-Google-Smtp-Source: AFSGD/UTeE/f5hDFkGuKSPNuphdZP4laGDJfXNsMEUGG9EVvN1ZWTAzA01HS2Wy5gKrklcimH/SYXEZKeLh/RnbDJMA=
X-Received: by 2002:a67:485:: with SMTP id 127mr8854607vse.54.1543921469732;
 Tue, 04 Dec 2018 03:04:29 -0800 (PST)
MIME-Version: 1.0
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
In-Reply-To: <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 4 Dec 2018 20:03:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
Message-ID: <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_030503_279363_4C08F72D 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, sugaya.taichi@socionext.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,


On Fri, Nov 30, 2018 at 5:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sugaya Taichi (2018-11-18 17:01:12)
> > Add Milbeaut M10V clock ( including PLL ) control.
>
> Please give some more details here.
>
> >
> > Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > ---
> >  drivers/clk/Makefile   |   1 +
> >  drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++++++++++++
>
> And this is different from Uniphier? Maybe we need a socionext
> directory under drivers/clk/.



This is always a difficult question,
and I do not have a strong opinion.


I am fine with moving the files to drivers/clk/socionext
although no file would be shared.


FYI

UniPhier and Milbeaut are completely different platforms
developed/maintained by different teams.

They happen to live in the same company now
just because Socionext merged the LSI business from Panasonic and Fujitsu.

UniPhier originates in Panasonic, while Milbeaut in Fujitsu.


Thanks.




--
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
