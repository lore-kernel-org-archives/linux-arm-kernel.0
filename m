Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA745C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:53:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B626020869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LgOxhLkp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5Ye/g1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B626020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HM1o9KT8BEgbcLw6YaynvKJbylYmY06kwW15JdJiyOY=; b=LgOxhLkpvPj2md
	EKrsRB5LMg1EQVEsngKm90mmjU5q+Y0fDqYRiZ1xjbX/FxeC7Uk9ALDn+z1BZ5NWhDAS/rGKb9abL
	FGHWa48J1H9L/zmnvEV6ReskfJ8qXJSmsbzxC5Rl/0V39LDBsfkdaIoXz0tUTRaHmeKo5aT6sgJl7
	HrrVOuf9VD184rjOxO5aQIbZT+VCjfljprNK/peRWTgpZAbxLu3FgfOZXF5+DsJHN5s5b0bOKE4Xl
	yZC2yePZCOBBEGnDJrXWSybanN7NkRiMMPW9SvtXE+Orw7x4fYFxtTUiVRBYwL9IhppmYWj94g6Ye
	RAeLsQ7PWimWwwvjbF1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpr2y-0002rX-DX; Sat, 02 Feb 2019 08:53:08 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpr2v-0002rD-F3
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 08:53:07 +0000
Received: by mail-io1-xd43.google.com with SMTP id r200so7795943iod.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 00:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4pFOoei9xHRTkuVGj2aLd4yUTKUmq7LmRLqh2yQAnTM=;
 b=O5Ye/g1LTp5jS6TqYOqEauyXGQ5QqHVhpHziJQ3epgb/hqpgPJ73mCXuffBvLj2sm3
 h6RDy4gqgjKbgbCeVgroVwFw9DpNQxcDu/kjDTZa7/AXTbLqYLK9DUkTHV9VpPYeSf84
 EjbVXwnD9580PbCsu5uaWvOLTaC++z599DUo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4pFOoei9xHRTkuVGj2aLd4yUTKUmq7LmRLqh2yQAnTM=;
 b=QsW33H118lzz11mo/bTHIribrMPqWKDvejDkkdNAUX1BQ3YVRbj2nWVcIBkF18WvOH
 Z/xC778UAnV12dfXwxB1GfcZINN/o1LGh/nWHx3Risn6/A1gnBGYM+T5aori1rvwWEmt
 RUXVgnbXRBqcWG3cLPUhhGaI5/8HgPrdHfXD83mz/Hr2U/pg4elm+bDFZA+Qog+OW1dB
 H483+1ITKGgXRebuXg0L/5w2kPnN9BbokvLVbZCCo8eJEhsqkVXzh7hJhH+wF4fZSBPK
 nxnyRGz793q7dB9jQdQXJtQIX4ZiwB2ZAxJ5ct3WQAiflRU9pLE69CMH7zv4YYXB6Bwo
 X9kA==
X-Gm-Message-State: AHQUAuYZNppTVQZ7ZOzgy9qzr3x+z7vVJdkNhDPQzCF9bbm8oeTB0k7x
 OLt14/4MBhwjEvvCq/2DqUtFVSJC6jSbfxqh6EzSuQ==
X-Google-Smtp-Source: AHgI3IaTz7qaudUtUQE904d4v9f4e17jSgSkgy4FizAAGwAaJx+1cX+qahaR4O4jhVP937PKRUANlihiEUcumfzv+co=
X-Received: by 2002:a6b:c8c9:: with SMTP id
 y192mr23969712iof.183.1549097583792; 
 Sat, 02 Feb 2019 00:53:03 -0800 (PST)
MIME-Version: 1.0
References: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
 <3722223a-4f06-3e1c-86ca-542289c7c918@hisilicon.com>
In-Reply-To: <3722223a-4f06-3e1c-86ca-542289c7c918@hisilicon.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 2 Feb 2019 09:52:52 +0100
Message-ID: <CAKfTPtDcHC=gbKciUVWb6_q=qyEcBZNnYpQ_VvYo0EsbST41BQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/hisilicon: fix SDcard detection
To: Wei Xu <xuwei5@hisilicon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_005305_511156_B9988801 
X-CRM114-Status: GOOD (  17.63  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wei,

On Fri, 1 Feb 2019 at 18:00, Wei Xu <xuwei5@hisilicon.com> wrote:
>
> Hi Vincent,
>
> On 1/14/2019 8:24 AM, Vincent Guittot wrote:
> > The SDcard detection of hikey960 is active low so cd-inverted is wrong.
> > Instead of adding cd-inverted, we should better set correctly cd-gpios
> > to use GPIO_ACTIVE_LOW.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Updated the subject as Leo suggested and applied to the hisilicon tree.

Thanks

> Thanks!
>
> Best Regards,
> Wei
>
> > ---
> >
> > SD card detection was not working on v5.0-rc1 but patch
> > https://marc.info/?l=linux-mmc&m=154637189021211&w=2 makes it work.
> > Nevertheles, latest changes in of_mmc_detection makes possible to have
> > a correct DT config.
> >
> >  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > index 71bfe41..dc314e7 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > @@ -665,8 +665,7 @@
> >       sd-uhs-sdr50;
> >       sd-uhs-sdr104;
> >       disable-wp;
> > -     cd-inverted;
> > -     cd-gpios = <&gpio25 3 0>;
> > +     cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&sd_pmx_func
> >                    &sd_clk_cfg_func
> >
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
