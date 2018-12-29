Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:18:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1A2218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SqvYuykf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bVJw7CmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1A2218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Oqp7Oc70say0CJ64fVZdlj+PrP7aDXeOTb3kpvLnxo0=; b=SqvYuykf6PmW89
	UX0nRdmWIQ7j4ibXeY+uSuECvZIe+HO8hqqUnJgBugnOgNL1lYP6XPjoRYhqRsm21Scj5lL14WYGs
	hLivKjOvqxU1Rz+HYEyqL+9x8uTmvgkdou7ew0utbHVA1vlc1KrrrKv5R1PMa0lrbjyt0kKptECEn
	tGyrMr2CmFC3C5GmJn/iw+DSd/KZ8ZExMIm4T2Y1WNb7OYi8pqc3Fd+gTPxLFWGV6CUum/7/jDAJU
	J4Q0LkLclIqPY+W5TiaDeKEJtzSlAetI8VCsPHjQc2BMMdNffoVldI4ABQJ5UMTrw7gG2xJ/SwAtJ
	QBeE760Yhw5phDxcbdMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd2KZ-000732-Eo; Sat, 29 Dec 2018 00:18:19 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd2KW-00072H-La; Sat, 29 Dec 2018 00:18:18 +0000
Received: by mail-oi1-x243.google.com with SMTP id i6so18433703oia.6;
 Fri, 28 Dec 2018 16:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/On4rl9nC7fHOxodibFe92k7SNjM00V6xHIulJ25/jA=;
 b=bVJw7CmI3eIc3IjaAZPQRqsrJcGKGho8tU7ysgOaYEyrgOYUONb+GS3cKNBawnSoJ8
 9bQeXGZBUYF+7Ij6H3fkYG2IeGihWOwhjtlarmY1J5YtkAcp7xgenYo8rPud1rtmQOxI
 bl6dSKUhX9hTZnuTq35FGvRuD9Q+InmV3AAHxAtBaL+HHMepnHHKf8DuaUydB1hBZSxn
 nQ/WwA+EEP5+rFoJ99hpF9cLd7VD6ozsAZPOTGo84S556REIjFENI3w+iWHYMBGg/M8I
 WdU/lvjlDATGI/WeAX8yPym/+ZWQX0E24L0zDQudZo3MFBy441J/LUYQkiXiB2LjKT5k
 0LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/On4rl9nC7fHOxodibFe92k7SNjM00V6xHIulJ25/jA=;
 b=DPV4hMu4d7u5tx88ef98VbiUsy4tO0SemrsS6c2iz4Eodx9CVPjJaINEzgM+os8rHS
 KVZOW0qBPy7MIuVv5EomGpeJ4lO7AefgP56NfeYr4hy9vAjsZ4Kx5YC8aAVEBcwEOvEX
 vGe8L+p71ed8XUD/R1b57kSc794u9OTHGnD1ITaqXAEWktYc7FQBGuJZ7GXqVsTbVg7f
 wiD3DNxa/M9RS39W/EwBsrdNuWfairx76ZmJdmeRv2c2s1gTNNVl7cilwH5K1pkUI/cU
 /5Fw5ITAxPO0J3A+pKlWiFEeNTTsHHCAkNd9ZF/aHTtomztJJ/Gqyi6eM0LJy9qBv7mu
 8JOg==
X-Gm-Message-State: AJcUukf8D8gqBFyxAjhnRPiwEr5sXlXCeUOpumAXi+xRbaMWEetxjgK6
 OWO5qwEN4bl/LzMHGybIy7gLDOyH8OfL/LevfaM=
X-Google-Smtp-Source: ALg8bN4kZ9qH4CKHPn3NRj1kjj+2giJc1xhESoNNtMUbOQobOaaokUruVgWuguOWuGdVRasSE4ZkTZUSRxNOsoJP78o=
X-Received: by 2002:aca:34c2:: with SMTP id
 b185mr19655201oia.321.1546042685526; 
 Fri, 28 Dec 2018 16:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20181207105231.25593-1-ccaione@baylibre.com>
 <20181207105231.25593-3-ccaione@baylibre.com>
In-Reply-To: <20181207105231.25593-3-ccaione@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 29 Dec 2018 01:17:54 +0100
Message-ID: <CAFBinCAbOdPnsH4TLLBmMnR5tS+jHfHagWudVLjaH6X89vtgDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm: dts: meson: Fix IRQ trigger type for macirq
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_161816_733711_C65B8526 
X-CRM114-Status: GOOD (  13.89  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, ingrassia@epigenesys.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

On Fri, Dec 7, 2018 at 11:52 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> A long running stress test on a custom board shipping an AXG SoCs and a
> Realtek RTL8211F PHY revealed that after a few hours the connection
> speed would drop drastically, from ~1000Mbps to ~3Mbps. At the same time
> the 'macirq' (eth0) IRQ would stop being triggered at all and as
> consequence the GMAC IRQs never ACKed.
>
> After a painful investigation the problem seemed to be due to a wrong
> defined IRQ type for the GMAC IRQ that should be LEVEL_HIGH instead of
> EDGE_RISING.
>
> The change in the macirq IRQ type also solved another long standing
> issue affecting this SoC/PHY where EEE was causing the network
> connection to die after stressing it with iperf3 (even though much
> sooner). It's now possible to remove the 'eee-broken-1000t' quirk as
> well.
(disclaimer: I was not able to reproduce this bug without your
patches, but I didn't run iperf3 for more than a couple of minutes)
I did test your patch with and without my "Meson8b RGMII Ethernet pin
cleanup" from [0] which shows that there's another performance related
problem:
1) before and after your patch receive speeds were fine (above
700Mbit/s and no transmit errors / retries in iperf3) but the transmit
speed was bad (<200Mbit/s and >1500 retries in perf3)
2) transmit errors (when Odroid-C1 is sending) are not occurring
anymore after my patch from [0]

thus I believe your patch is fine, especially since we already have
IRQ_TYPE_LEVEL_HIGH for the dwc2 controllers

> Fixes: 9c15795a4f96 ("ARM: dts: meson8b-odroidc1: ethernet support")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I wonder if Kevin can send this as a fix for v4.20


Regards
Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009665.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
