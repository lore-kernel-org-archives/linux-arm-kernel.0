Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1ACC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:11:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8F121904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QvgZWqrO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GPVCVZAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8F121904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HLxdcs2kwg9re/bzJwnnZZMRt1pcxXhvF3v42MP9BqU=; b=QvgZWqrOSpY1qI
	SIrkMOdtYQVp5gPbDmbfuvMHmZCvba5l6RTlADTN5JQml1Y7PIg5Veq3j4DibinO4lTjfMNCGsQb8
	6m5LHf8EXCQG6xMROMl9P/1tRItydVr61+b3Rcn221vx3SgqVpSJuXdQ+RiOrLslMa0bH+kghRQDw
	de+S+vvQWQG0Ql2bxavqCUoHm3bVWS8iE+CH9Di2RRTJOAjbS8AOkrhndogqeEGEcraSlb4TgsIPq
	5EEdHjQtTYgNgXBQJsm43D5ExpzThtsKiBaJpgWv7j7z0eipt6ffjnjZp7iDyZhGPYjLjLC0tuuZz
	KvPsHWjEd+g1OCwNvlmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlL3-000453-EK; Thu, 07 Feb 2019 15:11:41 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlL0-00044Q-8K
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:11:39 +0000
Received: by mail-wm1-x341.google.com with SMTP id r17so193163wmh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=1Uwwg9nLiHV0sNyKWuMQpb+u5rQNp1/DEHna6HgOtUk=;
 b=GPVCVZAg+/LBCFmAt8FdqOl+kCQ7bzQRHivENkHLLDsXGkoXC4EQ14tXsuHiUqLykR
 a4hZ78G7aYUrskEfXf15t+Ex0JFQurVWskpEfIawYwZhZKzCj10cuWdfP9kCcoj/jIc4
 5N+SzUHnvujLph6chwQjom2J+G6jX9LZvy8aVMtq8gW8vOu9NwW1JW7+hI6hDfTmyNtt
 cgDdWcOl6p6Bx0ImZl0IiiFrGGQ/iF0HjIYEhqczWhJ2qB9WSajNlyLbdVB/WqHmoclr
 OGQmnluAvyYbyn3iXl780ufioptvQ8xSAukXxXcgSuz0/bCu+vPTUiGh9j4DcSGr32bl
 YHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=1Uwwg9nLiHV0sNyKWuMQpb+u5rQNp1/DEHna6HgOtUk=;
 b=N38laiwWFaodfiQHL0Ea5hcOD0rBZYxnCPhsPfLvszbE511WF2VTGtlFvoytVfplXi
 3Z4pSOn05lQthdbqBXhUX23wI5BQCEdjwAexohB3rPAqj7ueUgQ1pjb6k41cJ3zueL76
 ENBsx4/TWF7ay4v7bx7MKxGEn2Io52lKb9NOhT3FB0h6eY/WP4Gpzsk8PH63t6yOL1K4
 LrYBlNnmrVQzIiNZDRa1TPl/I8a0z+W63St/hK+bk/4S9fhAfBvkHNYamCr68C9CaYkk
 iz6t07TSdnCo+lo54SOv9kUyyuoD43BavLGAZlXDHltC/lHyc881xShVfGbIcjjUYait
 JJ7Q==
X-Gm-Message-State: AHQUAubwmXKJ0ktaYLkYbvHUHlh62Zl+TG8ZqgPafAXzpVyHsTEKrYQ2
 qh3KWtTqixn+QYEFjVDiMR/JGQ==
X-Google-Smtp-Source: AHgI3IZrWNwrZmdcBEdPshlxOJzdBIXDneiPR4oAfp+6+6a8rdHXFSZimNdpaGcmEe/TgVWu5yhRmw==
X-Received: by 2002:a1c:ef11:: with SMTP id n17mr7733770wmh.112.1549552296549; 
 Thu, 07 Feb 2019 07:11:36 -0800 (PST)
Received: from boomer.baylibre.com ([2a04:cec0:1103:b081:462c:a008:349b:2f3a])
 by smtp.gmail.com with ESMTPSA id
 z11sm37119374wmb.45.2019.02.07.07.11.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 07 Feb 2019 07:11:35 -0800 (PST)
Message-ID: <8852692ccf2903e93459e3347a0a072d37e5a84c.camel@baylibre.com>
Subject: Re: [PATCH 0/2] clk: meson: Add G12A AO Clock + Reset Controller
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Date: Thu, 07 Feb 2019 16:11:33 +0100
In-Reply-To: <20190204091331.9298-1-narmstrong@baylibre.com>
References: <20190204091331.9298-1-narmstrong@baylibre.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_071138_313783_C539D601 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-02-04 at 10:13 +0100, Neil Armstrong wrote:
> This patchset add support for the Amlogic G12A SoC family Always-On
> clock and reset controller.
> 
> This adds support for clocks on the Always-On domain like :
> - Always-On UARTS & I2C Controllers
> - CEC Controllers
> - SARADC source and bus clock
> - Infrared Decoder/Encoder bus clock
> - USB 32K reference clock
> 
> This also adds resets lines for :
> - Always-On UARTS & I2C Controllers
> - SARADC, Infrared Decoder/Encoder
> 
> This patchset depends on the ("clk: meson: rework drivers dependencies")
> from Jerome Brunet at [1].
> 
> [1] https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com
> 
> Neil Armstrong (2):
>   dt-bindings: clk: add G12A AO Clock and Reset Bindings
>   clk: meson: Add G12A AO Clock + Reset Controller
> 
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
>  drivers/clk/meson/Kconfig                     |   2 +
>  drivers/clk/meson/Makefile                    |   2 +-
>  drivers/clk/meson/g12a-aoclk.c                | 448 ++++++++++++++++++
>  drivers/clk/meson/g12a-aoclk.h                |  15 +
>  include/dt-bindings/clock/g12a-aoclkc.h       |  43 ++
>  include/dt-bindings/reset/g12a-aoclkc.h       |  18 +
>  7 files changed, 528 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/g12a-aoclk.c
>  create mode 100644 drivers/clk/meson/g12a-aoclk.h
>  create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h

Nothing out the ordinary, just a minor comment on the bindings.

Acked-by: Jerome Brunet <jbrunet@baylibre.com>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
