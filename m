Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DADC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:11:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A82218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A93CbFkV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTbMwTpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A82218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AeMZndkDnWIHSikj/hoU5yMS4TrJf1K/6soJQ0WpmZI=; b=A93CbFkV8ngYec
	DKn7I1O8V2bNV8YRB4oFDOWnsW5Csd86CcOTcjjwAvNrf/XIvFysayGPdvpd93GmmnFqwkx14kmtQ
	rhZQe4Wgoh4wBjMuFL4dgg2aigTbWDBXtjUrPNj/87zsiPfnNfwOd1akjXF149kObU+x1V4PfNrHq
	cb8qd33uv/CbjqQ/UsKyPLMCbgRCYRsaFyT9QdyjY90PqNhfoPudPjWg/+mEVoZcHCZdk3ANjOGgR
	SEz4N0axP/MeoaGNSdrImbF92MyLwPVah2IiPebyhvQzaON/MGZCPBpWCHdj5ZmqNdhnow+dn4sSI
	6uDoU/8W+wd9G1YQ6cxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpVmx-0004DT-Gj; Fri, 01 Feb 2019 10:11:11 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpVms-0003mj-Gi; Fri, 01 Feb 2019 10:11:08 +0000
Received: by mail-wm1-x342.google.com with SMTP id t200so5612254wmt.0;
 Fri, 01 Feb 2019 02:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tQss5XY1in0Ch/QSiFhhlFeW8ftdKCddtzhbVyHetU0=;
 b=LTbMwTpNJLvXx/kUQ2ixglM++Tghi/f5C4rp0sXDrPdYubeRsnIsfXICQnd3WdExtK
 jWO8gO4h/HviPrwG6EoSCgHaH95mJgG3y9yx4FVXM2RwSVmEp5DoW0CX2dFvWz6/1Q6D
 FJT5Mj13JqveiDN5193vuZ/qfCdqYuAUbi0WJXPxf8NPR5HPkkj/pc6pbFfJLp0BzPIf
 9i6WGZW6GuqaItTZH8s3QA00fbQA69sggtcX/aWNMR2mG87G+YnO4FULMvXmHXZ90bP/
 qcWgQNu6guUsLhH/cl63QtllAbtu7nbjf05HYTu7IEXzdPYmTUWyetsCp4wxjLnvdDrh
 T/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tQss5XY1in0Ch/QSiFhhlFeW8ftdKCddtzhbVyHetU0=;
 b=KU/KYRw350Ya6qzLMxOg/S5/mf4EbclqbJxDgavGuO0olj2H7nnIhh/DkEIjt6nbiq
 kGjKxoLPaOLSKDcQApYfCnS90Vx7EXMXcgC5lL85z/eVGfDDWaCfIPN3ZMRXRaUCOeQs
 ed4B3EL8l/RQVWXBTIQsNKpEoEa8pT/Ne60fSWVS/BeDZNA/fxYN2IEgP8BwkB/32V1n
 B1oNWcONgqUlFreom2rfigMwwijYmFVqC1X7JhBZxEbWvkpAgNXkWmERJC21b4frunpL
 7oG2K8Gjc3t9Fj+ENY5hvudLkS31ETlwuNOUl1H/FIl3KRyKOQVI50bKDvTIFL+IaNK6
 dlzg==
X-Gm-Message-State: AHQUAuZlg7QcvTaHww7vFWWtHvgWOI3rgw8NnOvQr6l1oV8D3jHKkSkY
 Q9HhqozRz8AcAXY7qT1jT3w=
X-Google-Smtp-Source: AHgI3IbvCrZ4NBeOKvJJ40HFzb9DFFcEuxv7ALtQ8RFl9Pdmum1itt+Ujoi9Yx6NFhcl1YRtDuuSuQ==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr1763632wmu.52.1549015859665; 
 Fri, 01 Feb 2019 02:10:59 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
 by smtp.googlemail.com with ESMTPSA id a14sm711892wrr.13.2019.02.01.02.10.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 02:10:58 -0800 (PST)
Date: Fri, 1 Feb 2019 11:10:56 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Julien Masson <jmasson@baylibre.com>
Subject: Re: [PATCH] tty: serial: meson_uart: Add support for kernel debugger
Message-ID: <20190201101056.GA10039@Red>
References: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_021106_568468_298E50DE 
X-CRM114-Status: GOOD (  18.50  )
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 10:59:22AM +0100, Julien Masson wrote:
> The kgdb invokes the poll_put_char and poll_get_char when communicating
> with the host. This patch implement the serial polling hooks for the
> meson_uart to be used for KGDB debugging over serial line.
> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> ---
> It has been tested on "Le Potato" board:
> https://libre.computer/products/boards/aml-s905x-cc/
> 
> Kernel command line arguments:
> kgdboc=ttyAML0,115200 kgdbretry=4 nokaslr kgdbcon
> 
> Kernel modules:
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_FRAME_POINTER=y
> CONFIG_KGDB=y
> CONFIG_KGDB_SERIAL_CONSOLE=y
> 
> Warning: for single step instruction I had to apply this patch:
> https://lore.kernel.org/patchwork/patch/562423/
> 
>  drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 8a84259..49b20da 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
>  	}
>  }
>  
> +#ifdef CONFIG_CONSOLE_POLL
> +/*
> + * Console polling routines for writing and reading from the uart while
> + * in an interrupt or debug context (i.e. kgdb).
> + */
> +
> +static int meson_uart_poll_get_char(struct uart_port *port)
> +{
> +	u32 c;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
> +		c = NO_POLL_CHAR;
> +	else
> +		c = readl(port->membase + AML_UART_RFIFO);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	return c;
> +}
> +
> +static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
> +		cpu_relax();

Hello

Perhaps you could use read_poll_timeout() ?
This will also permit to handle the timeout case.

Regards


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
