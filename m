Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0589FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC7321901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k7QWxpId";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWnjly4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC7321901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LepwQ5M/BXDovfuqWmA4jyTmEnK/e+l84EGX/X5GfNs=; b=k7QWxpIdzVt+DP
	PEU9amsXpOYr+17UgK8tGViuU7a0RpF9YAq5wNV+97ANdLzjmfa0srMcxVGav+j9vWplmYjNxqVJk
	yWRKUt5t+WAT0uhvnQ+CWTnWEgCv5HsJKlgL67++84VC55Q8RBh275C5rqUH8ogJy+QXG9Br83Oh4
	A3/zbGUeZ9+Y26FNl2MxBDvTomP1LfbZ6yekrMwPQiZCsFXiZzbYzo9FcKT58o2oyLeSUTlXX2YiC
	0KKiB1locF+NpqSKnEtrqIxMf6X3S9RJkafAmB4w1QjmsENh1BYQTOYqrPXwZvvVYrwJYCZpYspGw
	dU9KCD6PkdUFBYe/T6Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqzm-0002zL-AO; Wed, 13 Feb 2019 09:38:22 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqzZ-0002sl-BQ
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:38:20 +0000
Received: by mail-lj1-x242.google.com with SMTP id v16so1376447ljg.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 01:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=diTfoAa5QUfTzyCKudm3waVERUH6mf8lPhS8olEIfwA=;
 b=GWnjly4m3L0IPD8SDnUMVRj095jutzkbt+WpZ4AyR75rL3aN1aeilvTWTZknhajSTO
 +exUHWeBQE4QHYcCwzlJQbUnHfYteFTcOLvIVyVUmqNv2mbJZ8CO5B+Aeoj9Tr/cycRm
 JKqxvK+fRwkn5FWypypefqhiNarWhMvklhU03TI4sgoUxW0X3sTP9EQ3LVkLq7TJvNXy
 2KawqSEBABa3QDDw7unRB/p2zuFivYfS7qTCwUraKb+06dzISxdpgUDOQ6RobeEgjT6h
 6+BEs/vTUVi6l4ZUrWyxMhIV2wlFpEiN9BT6zGvQkY8kKKoSM3XBqPzK2t63eChCL1EE
 vmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=diTfoAa5QUfTzyCKudm3waVERUH6mf8lPhS8olEIfwA=;
 b=CBGdxYa5H+hnASTcL3/7pvN7B/oGskRqwD4i62/u+pp0H48XEOlEUX4d2Os/C38KaN
 XTcxV6lqCGBtbI6Ull1R9Zy/khen5rHiSPpHe9xGhRUHf+ovYuRfFPZGPIKUVoeXkFTN
 LUQqAbqe87Md20Px7p8wupEDvlJW+ilb/3/auQYjNeBevTpX4Vgh3MEH0g/vGR194osh
 8zY0RnjIQZz7S6O4/SmTD7IYKr76iXVcbIQjGecma7a3i4dSUYQty8STzqvRbQVnr2pJ
 DHe2759RDt3mfUadxuiumXYiiiJNpRbTCh5tLUiUtfZtV/4xnYZ0L+msci3X62fb/pDO
 ckjQ==
X-Gm-Message-State: AHQUAuZcD2MD6NvivpceVe9laBMGhOT9FXLkoma39WR95Yg8u9TQrK6d
 lIcogel630Hk4ClTYzL7LYBBgPgYkq1oFdEQ6KN0DQ==
X-Google-Smtp-Source: AHgI3IZ+FvuvTd0D4WtEj7MZhxu41YRPzxL1ogMPwCR5y2mnUKndGUmf0teqhdLj+kLcleGt0/NDay4QAwlsHrjnXhs=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr582828ljc.97.1550050687163;
 Wed, 13 Feb 2019 01:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20190208104046.21817-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190208104046.21817-1-thomas.petazzoni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Feb 2019 10:37:55 +0100
Message-ID: <CACRpkdaSbcHAV=3NHYRujC7xEvVcbLJpV+k5sHdvFsRpYFsCbg@mail.gmail.com>
Subject: Re: [PATCH] gpio: zynq: properly support runtime PM for GPIO used as
 interrupts
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_013809_571106_43FECBC7 
X-CRM114-Status: GOOD (  12.65  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Michal Simek <michal.simek@xilinx.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 11:40 AM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> The Zynq GPIO driver currently implements runtime PM by:
>
>  - Enabling runtime PM support in ->probe() and letting the runtime PM
>    reference counter drop to zero at the end of ->probe().
>
>  - Increasing the runtime PM reference counter in ->request() and
>    decreasing it in ->free().
>
> However, the latter is not sufficient: when a GPIO is used as an
> interrupt, ->request() and ->free() are not called. Due to this, the
> runtime PM counter remains to zero when the only GPIOs in use are used
> as interrupts, causing them to simply not work.
>
> To address this problem, this commit implement the
> ->irq_request_resources() and ->irq_release_resources() hooks,
> ensuring that the runtime PM counter is properly
> incremented/decremented. Since we override the default hooks, we keep
> the existing behavior by making sure they call gpiochip_reqres_irq() /
> gpiochip_relres_irq() respectively.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Patch applied with Shubhrajyoti's review tag.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
