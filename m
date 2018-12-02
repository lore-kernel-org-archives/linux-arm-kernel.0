Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:55:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1090820881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="URSjpNO0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Rx8SBlLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1090820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oi2IC/45cOxZBfFr551QHe7UNpS2aPe7W6HU44w0tes=; b=URSjpNO0vUzwyf
	vy1TFeKdOiXUVn4Um7eQ5Qw4m/3ZlCSiQQUH3z27o0CBh89eqi5G5uuZGHCp6Z/Qj/pvgBJBGK2s3
	w6dcXeD7ikcNXMMLmtiW4PI/HNnL0LE/8odjpuRaIPJRjNCp4xsmhKdOKOnA3xZEw8OWjhLUM7LUN
	2DgnOqgGkssI9hWiHtqv3C/2kMsGZwjuzg3cjT6nYVB1Fg3URTD6iOmq7SyeOKZbS1R+6qV2If4Z1
	bsqspxrYWwPhmjgHcljeKLRHJZnBgUbi3p8GM8hfo9GkmQ4k4RYQR9le5YWzMBiP6EaWu0H5wpiWb
	voC/BbtmtxJoWdlUvGyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZht-0001jc-Uw; Sun, 02 Dec 2018 21:55:17 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZVp-0003y3-Ed; Sun, 02 Dec 2018 21:42:58 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so10137635wrs.10;
 Sun, 02 Dec 2018 13:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v1FNrPYfWMF3/vBQtyNC2xejvYpCaQUsX5uXu6fwKsI=;
 b=Rx8SBlLChYpA1IXqetgitpRqkTb9nY7sFJpn4/5eFmjAUhTnHQu0BtA0E5rhCjJ0zu
 e8NJfHczroVmvcedNvlnmUHyYngPz4kY1hf/sig+ts7nfW+x6//TDUqE7WGOhk/oIlpo
 Qsn0a4LJw4yf7HKokuxFg7XzP1PC1vCZ7gQJmSDLeJjjBbZU8jVToqR/76d2REnZFkXw
 yXmN2GqcX1Sn8Agzdv2eUgxudO6ClNxn7YDdoYKHnCsP/M6vk+GlOX3mtVO9GPhmKRT8
 71pthcQA8nDnXGItjDZwl/YG1usCxpAiO0+6oMNXcfJPVSW//uaHkPJSqEBr/VQPfEx+
 EQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v1FNrPYfWMF3/vBQtyNC2xejvYpCaQUsX5uXu6fwKsI=;
 b=eNbXBWzDD8l0B5dIZHey50RAJzEbmv5HyYbgSSMFLQ9KPGSZbJ0D5yi50sVWvApfqK
 kmuuC0Xz7ls3YUt5VvIQHRzONfLlgMXOA+7B3Ek2EXaUhUnb1DqLWGuqjlsLTVUFFDsr
 OyxiOWwdMB6EVvc5PUjqriZHID9l3SJSl2EvJgELPLO9RC24l0OvTj2l2YhZvlZ6GbDa
 hMKCm2f3sAx7gkVyhP9NsV+cc8mHArUWG1YR0giTinGe2zWWvNKPlmzEqfSVk2KLS4Q0
 VGKjUFWq6lfYfxVUzThVFXi9grRCzsCZjvVRub6duISJoJB/05/smAv777FFf6APh0I2
 Q+eQ==
X-Gm-Message-State: AA+aEWYRQnQ6GaFJLtkIu016UYYEKJLZ0gq8495vTLXMY+ruF7OueALi
 1OdGMZSrE9Ypm3f4q8E+PwqI/XfC
X-Google-Smtp-Source: AFSGD/Xf5ccIaKr/r81nR0nHttMVPKYxQP8sDDbrOT9k1N+ZAW62Nih0l5FYNS30Ircux4C5dbThkQ==
X-Received: by 2002:adf:900f:: with SMTP id h15mr11731230wrh.18.1543786957114; 
 Sun, 02 Dec 2018 13:42:37 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
 by smtp.googlemail.com with ESMTPSA id a18sm13073110wrp.13.2018.12.02.13.42.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 13:42:36 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
 narmstrong@baylibre.com
Subject: [PATCH 0/3] - clk: meson8b: add the (read-only) video clock trees
Date: Sun,  2 Dec 2018 22:42:17 +0100
Message-Id: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_134250_165613_9295903C 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: sboyd@kernel.org, mturquette@baylibre.com, linux-kernel@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is the Meson8b variant of Neil's series from [0] called "- clk:
meson: Add video clocks path".
GXBB and newer use a -- vid_pll divider IP block which doesn't exist on
the 32-bit SoCs. Instead the 32-bit SoCs use three simple dividers,
a few muxes and some fixed dividers.

I used Neil's GXBB patches as initial reference, together with Amlogic's
3.10 kernel sources (drivers/amlogic/display/vout/enc_clk_config.c): [1]

With Jianxin's help I was able to get the clock tree into a state where
the code is now able to recalculate the frequencies of the video clocks.
I am using the clock measurer as "expected" values, together with the
data from enc_clk_config.c where all the dividers are documented. My
test protocol on Meson8b and Meson8m2 is attached below.

One note for all brave people who look at enc_clk_config.c from
Amlogic's 3.10 kernel: some frequencies seem to be doubled there.
VMODE_1080P is defined with hpll_clk_out = 2970, but it's only using
the following PLL parameters: M = 61, N = 1, FRAC = 3584. At first I
though that there's a pre-multiplier like on GXBB, but after digging
deeper into the code I don't believe that pre-multiplier exists. The
reason for this is for example VMODE_1080P_30HZ which uses
hpll_clk_out = 1485 with the same PLL parameters as 2970 MHz. However,
since the current code can recalculate the frequencies correctly I will
leave it to a future patch to solve this "frequency doubling" - more
work is needed anyways for actually changing the PLL's frequency (as
there are many bits in HHI_VID_PLL_CNTL2, HHI_VID_PLL_CNTL3,
HHI_VID_PLL_CNTL4 and HHI_VID_PLL_CNTL5 which the Amlogic 3.10 kernel
is changing together with the M/N/FRAC values.


[0] https://patchwork.kernel.org/cover/10670657/
[1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/drivers/amlogic/display/vout/enc_clk_config.c


1080P / Meson8b Odroid-C1
- u-boot:
-- odroidc#video dev open 1080P
-- mode = 8 vic = 16
-- set HDMI vic: 16
-- mode is: 8
-- viu chan = 1
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 148497596 +/-4807Hz
-- encp 148497596 +/-4807Hz
-- encl 0 +/-3125Hz
-- hdmi_ch0_tmds 148500000 +/-4807Hz
-- hdmi_tx_pixel 148497596 +/-4807Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 148500000 0 0 50000
-- cts_encp 0 0 0 148500000 0 0 50000
-- cts_encl 0 0 0 148500000 0 0 50000
-- hdmi_tx_pixel 0 0 0 148500000 0 0 50000

720P / Meson8b Odroid-C1
- u-boot:
-- odroidc#video dev open 720P
-- mode = 6 vic = 4
-- set HDMI vic: 4
-- mode is: 6
-- viu chan = 1
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 148497596 +/-4807Hz
-- encp 148497596 +/-4807Hz
-- encl 0 +/-3125Hz
-- hdmi_ch0_tmds 74250000 +/-3125Hz
-- hdmi_tx_pixel 74248438 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 148500000 0 0 50000
-- cts_encp 0 0 0 148500000 0 0 50000
-- cts_encl 0 0 0 148500000 0 0 50000
-- hdmi_tx_pixel 0 0 0 74250000 0 0 50000

480P / Meson8b Odroid-C1
- u-boot:
-- odroidc#video dev open 480P
-- mode = 2 vic = 3
-- set HDMI vic: 3
-- mode is: 2
-- viu chan = 1
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 215996528 +/-6944Hz
-- encp 53998438 +/-3125Hz
-- encl 0 +/-3125Hz
-- hdmi_ch0_tmds 26998438 +/-3125Hz
-- hdmi_tx_pixel 27000000 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1080000000 0 0 50000
-- vid_pll 0 0 0 216000000 0 0 50000
-- cts_encp 0 0 0 54000000 0 0 50000
-- cts_encl 0 0 0 54000000 0 0 50000
-- hdmi_tx_pixel 0 0 0 27000000 0 0 50000


4K2K30HZ / Meson8m2 M8S
- u-boot:
-- m8m2_n200_v1#video dev open 4K2K30HZ
-- mode = 13 vic = 68
-- set HDMI vic: 68
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 297000000 +/-10416Hz
-- encp 296989583 +/-10416Hz
-- encl 296989583 +/-10416Hz
-- hdmi_ch0_tmds 296984375 +/-10416Hz
-- hdmi_tx_pixel 296979167 +/-10416Hz
-- hdmi_sys 23998438 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 297000000 0 0 50000
-- cts_encp 0 0 0 297000000 0 0 50000
-- cts_encl 0 0 0 297000000 0 0 50000
-- hdmi_tx_pixel 0 0 0 297000000 0 0 50000
-- hdmi_sys 0 0 0 24000000 0 0 50000

1080P / Meson8m2 M8S
- u-boot:
-- m8m2_n200_v1#video dev open 1080P
-- mode = 8 vic = 16
-- set HDMI vic: 16
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 148500000 +/-4807Hz
-- encp 148500000 +/-4807Hz
-- encl 148497596 +/-4807Hz
-- hdmi_ch0_tmds 148497596 +/-4807Hz
-- hdmi_tx_pixel 148497596 +/-4807Hz
-- hdmi_sys 24000000 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 148500000 0 0 50000
-- cts_encp 0 0 0 148500000 0 0 50000
-- cts_encl 0 0 0 148500000 0 0 50000
-- hdmi_tx_pixel 0 0 0 148500000 0 0 50000
-- hdmi_sys 0 0 0 24000000 0 0 50000

720P / Meson8m2 M8S
- u-boot:
-- m8m2_n200_v1#video dev open 720P
-- mode = 6 vic = 4
-- set HDMI vic: 4
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 148500000 +/-4807Hz
-- encp 148500000 +/-4807Hz
-- encl 148497596 +/-4807Hz
-- hdmi_ch0_tmds 74248438 +/-3125Hz
-- hdmi_tx_pixel 74248438 +/-3125Hz
-- hdmi_sys 24000000 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 148500000 0 0 50000
-- cts_encp 0 0 0 148500000 0 0 50000
-- cts_encl 0 0 0 148500000 0 0 50000
-- hdmi_tx_pixel 0 0 0 74250000 0 0 50000
-- hdmi_sys 0 0 0 24000000 0 0 50000

480P / Meson8m2 M8S
- u-boot:
-- m8m2_n200_v1#video dev open 480P
-- mode = 2 vic = 3
-- set HDMI vic: 3
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- - clkmsr:
-- vid_pll 215996528 +/-6944Hz
-- encp 54000000 +/-3125Hz
-- encl 53998438 +/-3125Hz
-- hdmi_ch0_tmds 27000000 +/-3125Hz
-- hdmi_tx_pixel 27000000 +/-3125Hz
-- hdmi_sys 24000000 +/-3125Hz
- - clk:
-- hdmi_pll_dco 0 0 0 1080000000 0 0 50000
-- vid_pll 0 0 0 216000000 0 0 50000
-- cts_encp 0 0 0 54000000 0 0 50000
-- cts_encl 0 0 0 54000000 0 0 50000
-- hdmi_tx_pixel 0 0 0 27000000 0 0 50000
-- hdmi_sys 0 0 0 24000000 0 0 50000


Martin Blumenstingl (3):
  - clk: meson: meson8b: fix the offset of -- vid_pll_dco's N value
  - clk: meson: meson8b: add the fractional divider for -- vid_pll_dco
  - clk: meson: meson8b: add the read-only video clock trees

 drivers/clk/meson/meson8b.c | 746 +++++++++++++++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h |  54 ++-
 2 files changed, 789 insertions(+), 11 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
