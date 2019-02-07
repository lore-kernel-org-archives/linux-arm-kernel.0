Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA59CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:04:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A14221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="giuZlcVi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E1cC3KC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A14221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/m4MH7ZGAh3DV2wroUEhonP2Fh23mlM094gXIGeSKyU=; b=giuZlcVicWzxhHOLR1xfTh1H6D
	K9E+ebUZPMi0vSc1b4APmxFmKHZYw5L9Tefm151YJA0/bHf3RPcEfYyVgB66F4F2yoW+OWBFro5AK
	bSGXoqxlKbT0QwA0aYTM74EKw52JNOo+YaK8OmRsOFTC6+WzYZEtyJuKv8+KsPetp3geIW5+UtNpS
	oJ5eLE3A+gj+o0woZtswl/BD0vmq1h+S4jZfTKKTgexiysn5Efn2vfaTvhgmlwrsmokakkdyOEGWY
	fob23Di7sca4IjVUIXXA91iOp24sJWe+Zhai1C85p4mzFZ8Du5mdxDV8duksxpEfvaMssllxD+EZD
	KHIbWTgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grn6T-0000Pj-Qp; Thu, 07 Feb 2019 17:04:45 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grn6P-0000Ow-Qw
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 17:04:44 +0000
Received: by mail-wr1-x443.google.com with SMTP id z15so674239wrn.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 09:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=bfb6XdLQBuwV8OQUhWtqHzyKLHZ6Wl3/PspPxQktHO4=;
 b=E1cC3KC5QRuzfMjm1loXWevDg4KYVtgl3C0NpApKqGDrPpTX+j6U8q4W2Gru3QJgMi
 KbWkVGm25qOxJkitEwOi2Adso7QZat2OA4xqSR66ywHFhgAxKVYi340a56QJiS6Mh5oK
 7OCp+o77YsLTMqyv8/p3/eU8XHoBm3Nbb9jsFGnhg+z0a6mpU5dMP0V4ZkDRdVHLMdxr
 0s5CnDv6H+TPcYldNp3dcHf8DX0rsyvfvSn6fDTh6rFzb5UVAuhNY7pvQAJPNOB6azz4
 +ulsoy72uQhm+MW7BRqD169R2LzOcM2/ERBAo54dPVjmpk/iNoT9XAkSTAmArloFUd6I
 MOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=bfb6XdLQBuwV8OQUhWtqHzyKLHZ6Wl3/PspPxQktHO4=;
 b=YzCodhDEm24vvsGoSWzv6/lIi4UyClUHLMg3XN8RoTmQB/5a3tYi4umWdSTgXrj0a+
 wnt01iUuXFOqLXzinwMUo+QdSU8lfdkf7Dz91IkFY13F+5+UxAKsrYfslwOGxu+LEHVD
 1vkItddGfMkN1h555VYe56pQrcCr/AXeTwjrraZ4EMHIZD/QlpTcf1WD+OANrvLR1VjD
 a970pud6e57UcjeYeiL1dHHAge0RJlt7bF4Jb5I1AqZ2Yv+xhzWhMz2xMp4zPm12b94a
 aZLzd/als2wKmdZa9qNZryKN60ls+CzWHITLQP4nM0yKGrXPjCrlB5MfzBUofqLuqN+P
 UNww==
X-Gm-Message-State: AHQUAubkc7G75PVRT2bwUVwY9Q9iEGE8x03BQcb5OA177nbcW+b9gCpa
 tU0HbmbHOs2/qfktMHS8QqLlmg==
X-Google-Smtp-Source: AHgI3Ia5ui10ccrWbMmNQ/NJuuZmQ4YiNUr8ipyoy9mGTvpoCHQmNJubTEfhMAbo16y4L3UcRANGiQ==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr12577380wrv.287.1549559079224; 
 Thu, 07 Feb 2019 09:04:39 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:a0f9])
 by smtp.gmail.com with ESMTPSA id g67sm38726172wmd.38.2019.02.07.09.04.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Feb 2019 09:04:38 -0800 (PST)
References: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
 <20190201101056.GA10039@Red>
User-agent: mu4e 1.1.0; emacs 26.1.50
From: "Masson\, Julien" <jmasson@baylibre.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH] tty: serial: meson_uart: Add support for kernel debugger
In-reply-to: <20190201101056.GA10039@Red>
Date: Thu, 07 Feb 2019 18:04:36 +0100
Message-ID: <86lg2rv8bf.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_090441_924196_17BF02D7 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Julien Masson <jmasson@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Fri 01 Feb 2019 at 11:10, Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> On Fri, Feb 01, 2019 at 10:59:22AM +0100, Julien Masson wrote:
>> The kgdb invokes the poll_put_char and poll_get_char when communicating
>> with the host. This patch implement the serial polling hooks for the
>> meson_uart to be used for KGDB debugging over serial line.
>> 
>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>> ---
>> It has been tested on "Le Potato" board:
>> https://libre.computer/products/boards/aml-s905x-cc/
>> 
>> Kernel command line arguments:
>> kgdboc=ttyAML0,115200 kgdbretry=4 nokaslr kgdbcon
>> 
>> Kernel modules:
>> CONFIG_DEBUG_INFO=y
>> CONFIG_DEBUG_KERNEL=y
>> CONFIG_FRAME_POINTER=y
>> CONFIG_KGDB=y
>> CONFIG_KGDB_SERIAL_CONSOLE=y
>> 
>> Warning: for single step instruction I had to apply this patch:
>> https://lore.kernel.org/patchwork/patch/562423/
>> 
>>  drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>> 
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index 8a84259..49b20da 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_CONSOLE_POLL
>> +/*
>> + * Console polling routines for writing and reading from the uart while
>> + * in an interrupt or debug context (i.e. kgdb).
>> + */
>> +
>> +static int meson_uart_poll_get_char(struct uart_port *port)
>> +{
>> +	u32 c;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +
>> +	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
>> +		c = NO_POLL_CHAR;
>> +	else
>> +		c = readl(port->membase + AML_UART_RFIFO);
>> +
>> +	spin_unlock_irqrestore(&port->lock, flags);
>> +
>> +	return c;
>> +}
>> +
>> +static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +
>> +	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
>> +		cpu_relax();
>
> Hello
>
> Perhaps you could use read_poll_timeout() ?
> This will also permit to handle the timeout case.
>
> Regards

Thanks for the tips Corentin.

I tested with a poll of 5 usec and 1 msec of timeout.
I had to use readl_poll_timeout_atomic(...) since I'm in atomic context
(spinlock).

I'll send a v2 of this patch.

Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
