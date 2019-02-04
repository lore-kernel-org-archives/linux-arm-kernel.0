Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6601DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:52:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F4F2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rm0LBrJu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Cb2eESD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F4F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cO+oiTMLlLCMBPDaKQ0lwtn2zWJG9K49cPJiAwUvexc=; b=Rm0LBrJuWphqU4
	HECWI/AqwhN9tz2Glzh6O9VmbxNqW6DQ2Zj9KJzxXAatSydLslx2pQ7IxH5uzFCnwkI6S/xwMnOq+
	CkWRHQhzR/uZi1wFn7Psp7hB2U1lgL2rTPhQnhwAL+s+90wZ8cbWyJfp0/51DDfjwmTYa0Hd1aUfi
	HE/7TlxzHTvEorhvXH2ED5hGx3cyrGPOjxfj73bBTyGS6Gf/tpIQMGT9SmKVEcFeTtDQdPAsBxve8
	U86pcvV5m+FlVITedXiCTWxEoJ0MECQT1PaPzorJezYqcJGFK4wpCdiRYqG2W6MQ6GDlRggO3C53b
	x74rnmxg38NQZ3tJcTQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqefD-0004Jd-Jo; Mon, 04 Feb 2019 13:51:55 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqef9-0004GC-JN; Mon, 04 Feb 2019 13:51:53 +0000
Received: by mail-ot1-x342.google.com with SMTP id s5so12994676oth.7;
 Mon, 04 Feb 2019 05:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hX/Gv3eAPoFqfRH+eg7JFdfk4B9734x08+y90NP/qZE=;
 b=Cb2eESD5D+XNsn0ZoKHC+vPGpMJjt2COzGVp8vZfiOrnK/izxjGCH6YFprEkzQSlRy
 hQvqRcwNtfnk37LdhV1xsca0fx9pvRV/69Nlb/GJsnbNaRH6crJUFxN65teZMu+ABk+O
 J6v3G0q4TLG4Wqop4MDx556aUzKeeeWWRwb4Zzb/HDK911rF5x1mpsiad3REETUvt0RV
 OsBobzZ97EcF3p8KFpf7rXQS12o2jeGLe7Ij4F+o3SFxte53kb8yjNQa/i3w1tsoH3QK
 UxCpIeI0c7wbrLhM+jEF0zsIqnDs6TYpy5EMBOi589b/4+8iQq1bheeLbJqDQk1Dc4Da
 IsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hX/Gv3eAPoFqfRH+eg7JFdfk4B9734x08+y90NP/qZE=;
 b=tn3egtsgHo56EeIKsQb6Luxv3MfVAo+r48SRe8PNkSY4DkMTj826UiJlcghUhyhj8e
 WuDWqXu5uwR+BX1V0nt8H9Pnwb0JqURFbT1Yvh9UFBAGbQcJxuFYn13iZoz2b85M1hEK
 KXdEYLcU5DIBojJjVAi7ozU9FUgBESBtUumQ/lWO7ugAz+KQcqKTDs1UW4M6+AYe+T+J
 tL3GbyQ37X8ta68eylmBrxJDgIRvIW6JXf7xSbu0cgNB/edsMP2RI6C81jXmDGC4j6jn
 efEsDqQb+UkJb+g5Ry53FX6nEVQqMTAhZsXEKFnARy5T698Nip1YGFYJiyoF9ygfdNdt
 q1vg==
X-Gm-Message-State: AHQUAuY8hbem/sda0z5aE9lzuFTEF24ZRv84ZstCq9V12LbsdamDEPHx
 48zNbxGWZjSYaLw80BW0M0NnB6DydB1m9Rh30ow=
X-Google-Smtp-Source: AHgI3IZNFa42ANomdKRJBxYMahYuCaUmu8PVxmRLoI5CDbPN2G/jq6AufyAZFOQ+0I69yISqUV9k09JXdH3pDlahi48=
X-Received: by 2002:aca:58d7:: with SMTP id
 m206mr27349786oib.140.1549288310656; 
 Mon, 04 Feb 2019 05:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
In-Reply-To: <20190123151209.2080-1-linux.amoon@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Feb 2019 14:51:39 +0100
Message-ID: <CAFBinCC1xjqogcLm94gu+iLS_b_zB8eNEXL+4bYhog==zN0S+A@mail.gmail.com>
Subject: Re: [RFCv1 0/3] Odroid c1+ usb fixs
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_055151_931315_4D93B8AA 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Wed, Jan 23, 2019 at 4:12 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> This is follow up on my previous patches.
>
> [0] https://lore.kernel.org/patchwork/patch/1031616/
> [1] https://lore.kernel.org/patchwork/patch/1031617/
>
> As per Martin's suggestion and input I have tried to fix below issue.
>
> Fixed the phy power issue on the usb port.
> # cat /sys/kernel/debug/regulator/regulator_summary
>     USB_VBUS                      4    2      0 unknown  5000mV     0mA  5000mV  5000mV
>        phy-c1108820.phy.1         2                                 0mA     0mV     0mV
>        phy-c1108800.phy.0         2                                 0mA     0mV     0mV
>
> Fixed the OTG phy warning and initilizaion of usb0_phy
> # lsusb -t
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 1: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 2: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 3: Dev 4, If 1, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 4, If 2, Class=Audio, Driver=snd-usb-audio, 480M
>         |__ Port 3: Dev 4, If 0, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 4, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>
> Now hotpluing of usb device is working on odroid c1+ boards.
unfortunately it's still not working for me :(

all following descriptions are seen when looking at the PCB with the
40-pin connector on the bottom, USB ports on the left, micro USB
connector on the top right.

my test-case is:
- power-cycle the board
- enter u-boot command prompt
- gset GPIOAO_5 out high (or replace high with low)
- measure

I checked the voltage at RT9715EGB (U19) with a volt meter:
GPIOAO_5 HIGH:
- EN pin (bottom, left): 3.3V
- VOUT pin (top right): 5V
GPIOAO_5 LOW:
- EN pin (bottom, left). 0V
- VOUT pin (top right): 5V (not sure why...)

I also checked the voltage at Q5 2N7002W with a volt meter:
- gate (bottom, right): 0V
- source (top, right): 3.3V
- drain (left): 0V
this is always the same, regardless of whether GPIOAO_5 is HIGH or LOW.
however, with Armbian booted (which uses some Amlogic 3.10 kernel
where USB works) I get:
- gate (bottom, right): 0V
- source (top, right): 0V
- drain (left): 3.3V

what do you get on your board?


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
