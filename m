Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B28C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:33:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E357520844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GyQ8txQM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJ/gBzIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E357520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2i767iDS1AtyrFrwetfX6BCO9u4eUGzrGS+Zl3yX0Ak=; b=GyQ8txQMnt1Rad
	YUiqn7lWCuNCWlw89mxT7Ziax/qRAA1Noa5mVhTexMaABHlxkTSOizieTbzYktWvsWuZ2acA6Yqyu
	xZW40IVPA1LZ+q4nCtb0O7mVfyqcfXB606RsZLasE0f4LSXrIZ5SmDASx/pirBSMSwGK6nyQEt3hx
	dnQmdkg3LlfNsU+o/agKuU4RklzcRcMZrdonxrOJU140V9Hv6tAI7gR0n3zJKIXQor260360df88M
	gL70lqr5SOIJjuoS9SKK81zxHUIZVg/Gqf673z8bYBMmblyHjk9C2lEVlBu90iGfkpJNpHgXn2NRQ
	56molBXV9+DgeFfYg1zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs6H6-00073e-VS; Fri, 08 Feb 2019 13:33:00 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs6H3-00073M-Hq
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 13:32:58 +0000
Received: by mail-lf1-x143.google.com with SMTP id j15so2541475lfh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 05:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zOKN2RtkqD3NhMxXTntaG9/up/T7KSnJjjnbyy1R1eQ=;
 b=hJ/gBzIBCLQhm2rPw3nICW4FI+YX9FDpAGBDmZblsvklPtVgQkqbeK+W9uXIsO6m1Y
 fOoPPn/tB5+fCM1fYzT2+zm1VK69ijYIk0FBrMzQy7MGGNwSU8yTQgDA6lccGuPnB3h5
 Y4MEDVCpU+vdENq/lAbTxaXZwU5i2Ah8cfcwkW61MouNQOkDNpBSr+Z7+laM+HSOl9HH
 yj0iDQ0qQM6Cbw4q2qFnRO27zhYYZ6zh707rHEVmeDSYWHUglGnd24Y0SYtNmu6I5A+o
 rDr/mfWB+NRWnaijrBNLaJYGaRaAkfbvRKzwODHfWUnak9R3hP9oIEuoMOQ4hiU+3xZ2
 X25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zOKN2RtkqD3NhMxXTntaG9/up/T7KSnJjjnbyy1R1eQ=;
 b=mMMEwplpBuqvu+hAdAMJ+r0q9Oe3kWOJmphLc7DRFOUcbm5yW+VtMmCZaw8B+w3YUd
 Bz4+JEKaFfYY1+4marHjtsZ7QRowNf8ZCY+awIx6hrpEGZPe382HrxCEAQJd2eC6szj7
 larGS8KwTUkP3BTve+3mw5p6jWUtwdJftUfEnE6+gsyK5IDA6yczYLLMdAWXTqnN5ATV
 Qj+YJofkoWV5PeJQOGyDcXqXwOZ0Fw01rCAWfKdjGJe/+BYciHlbMiC2C29YyX6POHgL
 GPKmDzyToEqTIgx8VpJOvC+iiSdWhnlEgGBGr2cCGm+osC3sT4hdhNsdCoAJ5HbRDHpl
 WzRg==
X-Gm-Message-State: AHQUAua1gG092AOIAiRznkKJmwJ6IzM/5UE++4JP+NobjXgUk5pHZVHp
 h7+KY7OxanwyLOtQur7q9JIzLftxp/IJBIe6zbHaPg==
X-Google-Smtp-Source: AHgI3Iaun5UChBVpgraPMeJiOXrr7LLPt7LegZUyY1EAUG1cB5RCgqZ5w6gktc+8ahXVjI1Rp1m/H6r2Vgq39tr+324=
X-Received: by 2002:a19:c502:: with SMTP id w2mr13201900lfe.168.1549632775616; 
 Fri, 08 Feb 2019 05:32:55 -0800 (PST)
MIME-Version: 1.0
References: <1549629187-3177-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549629187-3177-1-git-send-email-sugaya.taichi@socionext.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Feb 2019 14:32:44 +0100
Message-ID: <CACRpkdYgTWffL3RcW7Xs7ve=9HhYyndth7RDX7sedeXytCZC1g@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] dt-bindings: pinctrl: milbeaut: Add Milbeaut
 M10V pinctrl description
To: Sugaya Taichi <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_053257_590203_27DDDAE9 
X-CRM114-Status: UNSURE (   9.89  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Takao Orito <orito.takao@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sugaya,

thanks for your patch!

On Fri, Feb 8, 2019 at 1:32 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:

> Add DT bindings document for Milbeaut M10V pinctrl.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>

(...)
> +- interrupts: three interrupts specifer.
> +- interrupt-names: corresponds "interrupts" factor.
(...)
> +               interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
> +                               <0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
> +                               <0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
> +                               <0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
> +               interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
> +                               "pin-52", "pin-53", "pin-54", "pin-55",
> +                               "pin-56", "pin-57", "pin-58", "pin-59",
> +                               "pin-60", "pin-61", "pin-62", "pin-63";

As mentioned in the review of the driver, don't do this.

This is a hierarchical interrupt controller, so these
GIC-offset-to-GPIO-interrupt-offests should be hardcoded in
the driver.

If these interrupt offsets differ between difference instances of
this pin controller, they should have different compatible strings.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
