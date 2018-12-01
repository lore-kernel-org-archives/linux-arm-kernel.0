Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0815C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:55:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C23B20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LMWL8F6T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="wTfUF4r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C23B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Q3+pRfc7RDaQNDiTKC1DOhEwvXEqKdUEB1uN25G6w8=; b=LMWL8F6TLaXxIe
	t5suzwqOh8jjhfrDM1hMXam/1fGj/mxLTG7TDSFsGfd0o4C1syTMsLHYNcOuCDomk4cqwXNAGhmEf
	wcxIIrKNiSALIlWU0NTk68SRiGALPeOIHMl/KHciqIlnZ6b+dx1d/xSII4MlXp+9w77EZs5I85fCp
	6sF+aR8xQOtYqZwHQs0POsZ/TPal42Pho+YYfeGVm2BDd+skVtu+g7E+MNghitQVE2x8W33YBIsei
	d92QGd8RYxkiNvn+qXVC6QGQbyUp0TFmGL0QLVoc1sJYZ4qDfGfyMMRaP1YJeBosgLU8dUu1qubNx
	yvb2cDB2hSk7TKIieF+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT7bq-00073N-4D; Sat, 01 Dec 2018 15:55:10 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT7bj-0005zZ-ST
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 15:55:06 +0000
Received: by mail-it1-x143.google.com with SMTP id x19so3125394itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 07:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp-br.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q7ipvgREb/bsWNDedDd9AUPVcpHP5ldxyaEwOuXGuaM=;
 b=wTfUF4r7Maar/MJ7lXWUEsaL6pei+kfos6g4uq00AEL6Mb+v+obWXRFP1JQIJ9S+7p
 51cqbi86FGqfolIBwZ9gtOJtz0U9ELrIOuCT21Z3Z8g5nOF3ZIrX2D4Aln6rh3OVuEhM
 cvi6BKOTSxiqM9i3IKNjEanlVrJvyPIJKfku81XEyNtVZWxt4FolfdMQ9+zQxHMNJES1
 KbwwerAS0eOXu7Yzt2poRM+o4OVvTPw5TncAg5J09tFsm+ioLKGR/I2nyjmlGUx1xtA+
 mrrSIL1ctmDDy+Bg/xowU/EmN95oOjMbpkDyhA+U+S7Y5eOGNNJ44r7DzO+Uvo+h0DRO
 tqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q7ipvgREb/bsWNDedDd9AUPVcpHP5ldxyaEwOuXGuaM=;
 b=DdwpFJEfxqmxUOM/8EvjDypk6xcKqhlRQ+/SCnk9H5HfYnuJSNYJzxZpsqs7MyIsIW
 fd0zcWzb3Wxjd+dG7WrNs8gCamPfFuZ4qFECeMgpOrNGzAkBbiqFVi9OMVTF7gu/UmTX
 voDFu8GAWxr6Q+JDovy7zq/ZMKty4eo6dBJPIiXgCu2Lnyr8VAOk3+AoaWzIOKtwDxMP
 ZxJEZeXCKPUUZUZ435RwsLuSfqB3uac3klzCYRjyn/ilcjaN7FNK/uTkxVQUwZpNqrqt
 AxpaUQkZCYH3cGWGCzP/jO7yPlHSGeESdQytnNoonu/ijWchdl4o81eqrL+xshfB2Ec2
 1RBw==
X-Gm-Message-State: AA+aEWYA6eTIlbLT6P1y58xwHlFQq0UaVozU2mSxrwxcWF8sgpqh4QIu
 aEIseBr+gBXqEOaaipbMPKkoZJwy5bpVxGXVJaSZbA==
X-Google-Smtp-Source: AFSGD/UQclRV0BOwdmycvVJftTgGd/PLpTz6YZMy2SjvqjVCA68kMCMCUKTq5d9bIMferzTmmwP0H4oxuB/tyRItqe8=
X-Received: by 2002:a02:b015:: with SMTP id p21mr9221044jah.17.1543679690935; 
 Sat, 01 Dec 2018 07:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
 <9ea19805-de34-9286-e540-98b75e49f574@broadcom.com>
In-Reply-To: <9ea19805-de34-9286-e540-98b75e49f574@broadcom.com>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Sat, 1 Dec 2018 13:54:39 -0200
Message-ID: <CAHd-oW4XyMkJaRaQcO+7+qRf1Lm+D2aQ54-YRqSE-TFump8q7A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To: scott.branden@broadcom.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_075503_931524_BEAFC9F2 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: Milo Kim <milo.kim@ti.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-aspeed@lists.ozlabs.org,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, kernel-usp@googlegroups.com,
 Lars-Peter Clausen <lars@metafoo.de>, linux-rockchip@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Kukjin Kim <kgene@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 Joel Stanley <joel@jms.id.au>, Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-samsung-soc@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
 linux-amlogic@lists.infradead.org, Lucas Santos <ilucas.ms@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Support Opensource <support.opensource@diasemi.com>,
 Scott Branden <sbranden@broadcom.com>, Andrew Jeffery <andrew@aj.id.au>,
 linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Carlo Caione <carlo@caione.org>, Eugen Hristev <eugen.hristev@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 4:54 PM Scott Branden
<scott.branden@broadcom.com> wrote:
>>
>>
>> On 2018-11-28 9:53 a.m., Matheus Tavares wrote:
>>
>> From: Lucas Santos <ilucas.ms@gmail.com>
>>
>> This patch removes all license boilerplate texts from the .c and .h
>>
> I know other people don't follow the patch guidelines,
>
> but more info on proper commit message format in link.
>
> (Don't say "this patch" or "this commit" or "I changed") - use imperative present tense.
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>

Ok, thanks for the review. I'll correct that in v2.

Matheus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
