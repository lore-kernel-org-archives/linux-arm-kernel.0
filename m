Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C112CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:53:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC9520869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KQN5Eyty";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUMgM7Lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC9520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qjU+WMCr+uC47idju5DH2UQEhqbdr58S5GR6Abc9XZQ=; b=KQN5EytynoCZjU
	pAS4WoMSDvJoPlHslSPIoMLfWp7Npdwigcaa0F0q6se8Ug0Ji10agDrJuksIL9cSCwfIAf/vvAliN
	mEpK3ek4JdnqLxtz12JsQ7aBDGfOVdkPHHwuHgewzjltHxuuCA9Ynq7D+TIKuDE+5PYBpENZJ2Qiv
	sGbdpafDMP0OCWsa8YoF9OsVu74CgFXnfN2MgZzBbRT351jIzh5kBxN6w+0R1h3VQQEy9ODqnFwV2
	KMMXuVaiRdUJaE9ltKIHSieuGugHXE5JnL5PgO8dAH7s1RjMHAaC1H/LezDQv7ElouskOaUzhF0Ip
	M6Y37YBOc/KfVYa7Yl2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs6ap-0006wf-RF; Fri, 08 Feb 2019 13:53:23 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs6al-0006vq-Qk
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 13:53:21 +0000
Received: by mail-lf1-x144.google.com with SMTP id j15so2588968lfh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 05:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rPNmJ15KEK8QlnNyQUI2whawGc1QMo6m2jIEISNaNE0=;
 b=yUMgM7Lo2ER9OkIyI9MiiM5OUgzU8i0hi0XWbOV5mI5iwZPcijQrRCjjJGBUx8XZCa
 FvkKQdnERlzbrrKjxdDN8RONPhTuOcFFl+FJff1y43YLC3vs7DhHmiRrWcEpnUv3KMPA
 Y5mhqTe/3KVigfV4e7syx+l2IbPbya18pApTA56PmHuo81TwPTCLJRsJKBr7biTacLVo
 9VYh6cg1cE6/i9bRB+9uluYEyYJtSfm8v/snddH9zLHXuYpAC/AW5cwPu4MdR/uXIKzR
 0xi1HX1h6LCAnjDdkwhwFi40j0a+yBd3lpkZcjzZW8vUMhklXvuAYN2xuxd7zoHNS/FH
 zQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rPNmJ15KEK8QlnNyQUI2whawGc1QMo6m2jIEISNaNE0=;
 b=pUkDq2ohua+zXRQ0o502eRWMPNdkPRgAP3Vs/E3G8dwvCavOg6T5GLB0+jGRi/Xp3S
 hf2QinjxRKoHHIFkFwxD+yApgl8cTc10RQun+dNrSZQTS5IGKZuMO3xgS+6T77bAHzjH
 Oupoo+UUsp6vL1tQy9CIUJNHtTP33zF1qVASgWuTojwRW/qLCpBUB8WQ+/U09i5VQFLs
 zluBdkrIB8qB7TF1w4QeqYsLIuNkvzaWCqDiRw1AFC+tBsk2QySzwjMKa+fhn12GwNJN
 +DcTNhhKAMX7RU2hPmUV6e0afoNvkNeL/KHPoUnyp6wtuI8fR6J73TimrK2E76x3DNFn
 9myw==
X-Gm-Message-State: AHQUAuaIeP9hpHVkemWwVK7UREFzGoEHxXdz9ju7GaQAo8zpLvt3xMkZ
 8S/kzhYSU/GRBTu+C5Yd8Q+DObXyYfx6F2Vfucm/Zw==
X-Google-Smtp-Source: AHgI3IaIrZMPapB0BgETZ1wjFbskiZhzO2E/nH+1osqKOjlDOpn74o8cVB4BavFg+AORqKDSsBLEj9lejIp3MmRee4A=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr14170440lfc.27.1549633997617; 
 Fri, 08 Feb 2019 05:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20190205195909.3565-1-krzk@kernel.org>
In-Reply-To: <20190205195909.3565-1-krzk@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Feb 2019 14:53:06 +0100
Message-ID: <CACRpkdbXZnYP0=BXqoSyr9=y4+WWWax+KYQ8MvcAUVyMVL652w@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: samsung: Remove legacy API for handling
 external wakeup interrupts mask
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_055319_898593_71017F65 
X-CRM114-Status: UNSURE (   7.83  )
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
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Sylwester Nawrocki <snawrocki@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 5, 2019 at 8:59 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Remove the legacy, ugly API of exposing the static value of external
> wakeup interrupts mask, because all arch-machine users where converted
> to use generic implementation from pinctrl driver.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Patch applied for v5.1.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
