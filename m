Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85D6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:07:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D5620652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MvjArTHq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E+q7b8HW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D5620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CS2kBGki3SSM+6twZ96G2ITSyAJawqbiqUFitQ3ewq4=; b=MvjArTHqIt0lK6
	TPWP3vPEUfwYPS+X37XqcvrZXsr8Fb6Nh/qNC6/FsorQzw9JRpXb+C380N4Nq0cZVRq1ferj1tX1P
	gJyQKiXTy7T/XtpK9QfOKCL63pcU37WTAm/YBCTtsxPYz0Z+EIxRrNbLeC5DNkvFje5dCvUknVGqs
	c/KLERdWvJmiVGzTU+ADKIxmS26aAdCFghgQvcFOkGFkPpph/JmnYbnGWZXj97tNx3R8A5j/cIMR/
	HeLJKYRL1C1hOGe5IQnKGnOHAqO1K7HRg7+gy6PleU53Xvhv91GJh+vP3yGqa/UZLqoON0mAht3Kw
	g+ETiuCgwK4xEjdT06wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1Cv-0005Qd-6u; Fri, 11 Jan 2019 18:07:01 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1Cr-0005PZ-G9
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:06:59 +0000
Received: by mail-pg1-x543.google.com with SMTP id w7so6603233pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 10:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=ACZB9pbeqBIvrYvuEXePFduGuriD/CA6USMjiG7thKE=;
 b=E+q7b8HW6EP+D6nSsTB3J7mwxcMm5soGymr6UXASZormskMyLfoaSo+hB/V5GG0VIG
 PL76YqJNFfR2BQSFXAU9OgHn1iIUE/WTW9XU/cbRNcFNn+5blyPHsyenkxppNxXavow/
 r345zndJDDEpHXNLGJQTzD3t0NZhmS050yAXhaXq1BfST2FDVUJEgMuGT+vjuww6vONR
 Kfczcv2EmYVHd0p0Z9bLX/zyXjLcib+gMwefiKRRXJrHh+0jP23EujJYAwjk0FQakuFn
 YbN56Cr9cW9SbJBWDKk8GMM1gzX+nuvxODcEXfRtqKEMK2IAR52VHgawW1741f/yebHw
 VIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=ACZB9pbeqBIvrYvuEXePFduGuriD/CA6USMjiG7thKE=;
 b=ADDHUEzsBiDzjfS6rQ5rWzB1Gify//7RGQ4w98c/FVT5UJmh8gV3mCC8fY8gvB3G3/
 vWVBqEOdI7EIxHh+ouvTTT8CArTOcR5hf4ay3rcWw9YXQPkT2l+fzoOn4qgL8wvswQCS
 R5dqmovaynPRp/SjPnOj2JYTq3cSuEEIs0IcmXJTlUooKb0FmnyEVaPFI1H8Y5kc+0iD
 pC8nBIi0et1wLcMGHPw0hCXx0OSFfSorSwta8vK5gof6hZCsHMMoS2qFPpjnS2SqicsJ
 YT3L/K8y3bm0XX+HIiGkCbkBW0tolYjXK+8+hqC3L4ha4CEczp2bVvorxUHHoJHRZNLt
 p6fA==
X-Gm-Message-State: AJcUukfG853EjBRSnXYKtd1FyzSk58jtX9bT6K6Pdfi1SShL8oaVIKr3
 7OAQEeOp3hSjRD1QblHMshkZ0g==
X-Google-Smtp-Source: ALg8bN6/OAGR7txSiU6HaLabGbbm6+2p9rGJeejz94cdvYoNoBbAlwk+Dy+GyaSa2LKtMRUCSRTYuQ==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr15726375pfc.209.1547230016137; 
 Fri, 11 Jan 2019 10:06:56 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 m67sm110315606pfm.73.2019.01.11.10.06.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 10:06:55 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Emiliano Ingrassia <ingrassia@epigenesys.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 1/2] pinctrl: meson: meson8b: add the eth_rxd2 and
 eth_rxd3 pins
In-Reply-To: <20190111100915.GA1716@ingrassia.epigenesys.com>
References: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
 <20181229143556.27339-2-martin.blumenstingl@googlemail.com>
 <7hzhs8ovag.fsf@baylibre.com>
 <20190111100915.GA1716@ingrassia.epigenesys.com>
Date: Fri, 11 Jan 2019 10:06:54 -0800
Message-ID: <7hbm4noypt.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_100657_565921_A810C4AA 
X-CRM114-Status: GOOD (  17.15  )
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
Cc: linux-arm-kernel@lists.infradead.org, jianxin.pan@amlogic.com,
 linus.luessing@c0d3.blue
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Emiliano Ingrassia <ingrassia@epigenesys.com> writes:

> Hi Kevin,
>
> sorry to bother you.

No need to apologize.

> On Thu, Jan 10, 2019 at 05:08:39PM -0800, Kevin Hilman wrote:
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>
>> > Gigabit Ethernet requires the Ethernet TXD0..3 and RXD0..3 data lines.
>> > Add the missing eth_rxd2 and eth_rxd3 definitions so we don't have to
>> > rely on the bootloader to set them up correctly.
>> >
>> > The vendor u-boot sources for Odroid-C1 use the following Ethernet
>> > pinmux configuration:
>> >   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_6, 0x3f4f);
>> >   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_7, 0xf00000);
>> > This translates to the following pin groups in the mainline kernel:
>> > - register 6 bit  0: eth_rxd1 (DIF_0_P)
>> > - register 6 bit  1: eth_rxd0 (DIF_0_N)
>> > - register 6 bit  2: eth_rx_dv (DIF_1_P)
>> > - register 6 bit  3: eth_rx_clk (DIF_1_N)
>> > - register 6 bit  6: eth_tx_en (DIF_3_P)
>> > - register 6 bit  8: eth_ref_clk (DIF_3_N)
>> > - register 6 bit  9: eth_mdc (DIF_4_P)
>> > - register 6 bit 10: eth_mdio_en (DIF_4_N)
>> > - register 6 bit 11: eth_tx_clk (GPIOH_9)
>> > - register 6 bit 12: eth_txd2 (GPIOH_8)
>> > - register 6 bit 13: eth_txd3 (GPIOH_7)
>> > - register 7 bit 20: eth_txd0_0 (GPIOH_6)
>> > - register 7 bit 21: eth_txd1_0 (GPIOH_5)
>> > - register 7 bit 22: eth_rxd3 (DIF_2_P)
>> > - register 7 bit 23: eth_rxd2 (DIF_2_N)
>> >
>> > All functions except eth_rxd2 and eth_rxd3 are already supported by the
>> > pinctrl-meson8b driver.
>> >
>> > Suggested-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>
> For both patches of this series I gave:
> Tested-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
> Reviewed-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
>
> They were in the answer to the cover letter of this series.
> I note that they were not included in the commit message of the first patch.
>
> Did I miss something or did something wrong?
> Please, let me know.

You did everything fine, I just missed them.

I've started relying a bit more heavily on patchwork to collect
review/test tags, and right now it doesn't notice tags to the
cover-letter, only to individual patches, so I typically add those by
hand, but in this case I missed them.

Sorry about that, and thanks for the reminder.  I'll add them and
repush.

And, while I'm thinking about it, I'll request that feature to patchwork
developers.

Kevin



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
