Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1083FC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:21:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BF220B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CDGhGyrb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cMUomSxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BF220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YH+b0kWs7nyUA4k85Fu56+T2rbADjKefy0IVphdqDqY=; b=CDGhGyrbrvXbl+
	2qMA22Vm4QkYeqlJ7YxI4KKyf5j2TO0tERhB/PXpRI0u4Db+vrcOYLptwgXGQxp+mZRC2iZdiIqEW
	xFuXx3QcYJJOshR3xb4o9woN7sOiHNzpsQenbEd4/jzJRXdjxsYCf249jSXpzr6tLoSSsZXPvDN/p
	FFlnyk2I02yKweKTkSlzlO8N7OZipYLGlEZJrQsqyoNcD3J7w5tchhZHt2LH+wbSFmtAm/2rlIKVj
	jPn1hh78ZvWeuE46jQaSe8aoq9P+6iFxdaSOCGxT18FZRRJD4/AdsMGGWjJphX7hnesMO/sOYtwOS
	JP+CALRVjmklMzvn4L5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpGxo-0003Xg-FO; Thu, 31 Jan 2019 18:21:24 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpGxk-0003Wu-BP
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:21:21 +0000
Received: by mail-pg1-x542.google.com with SMTP id s198so1709090pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UIv7GZVd6Iq4DP1nNjOoNKOEOGE89AtKkvrJYpzQidU=;
 b=cMUomSxI9BN0AZ12R6NATTEiVWcuoxg0O+T6SxaIEKMMTPmJOjEkyA1mK9Pb9LN5RN
 LYFhg3buy6KzL1LJUz/q090F+FuTV0ctG8548apgsxYGjd9wdX5221MqR+ppIBwl9qQ7
 QuEgSQgHt9XuPK8ClcM3l4yrHCK28oN6kpXgAX4rv5UyWRPELsG5LjQ/IpJEBX+p4PXe
 ex8AFhBzR+Ji8yn1fjMvfzZU1bQ8V98t+4Lt8eGi3ypBKFbJkQ/nr/Wvicr6L8SWGkLN
 GTcscroVyfGxXqd53AeCin7AgJ6gL7/akIJOHBGZytqHQ99ULQwg6LINI4Os7LZzNCp7
 S5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UIv7GZVd6Iq4DP1nNjOoNKOEOGE89AtKkvrJYpzQidU=;
 b=ACHAF7I/FwXozxc7KnKQCtLYDRFDDuIapaGB0HBPKk4Cf4I/tTotVH05lTTk5xiWOO
 c6VH7l7mWcjcMselI3AHBw0knPIjIKhS4y5bcFV0OkE5FfJp7PTyBmBenyKvUh58gKVx
 8U49pxaevBVkZfK8ZTEB1Fj8CJ7Jp80k1e+5EpDTcDvtel26SKRLP2ezBOKrMeZXgGUL
 KsrDfe+LsiVIWaUJ2eaP8bg2IO5/5LTPCbO/mvBsJVJoDiGyEUAHZLJxqkU2ljvPikc6
 EJEbBT9X7UkUCImCWZ8za30SM0UKg1KsgF2cukPcrK+naSyF6zHak4tTIq7pD4Y1f/uC
 I7NA==
X-Gm-Message-State: AJcUuke0AePDJ8c8RoJ82uD624zhAmpQNeU41rJKkyKhAnEtpcumd3Mr
 G+pj3ZV3kUqyIO/E13lOWBga1+i68QdAc5+BS0AgfA==
X-Google-Smtp-Source: ALg8bN6fu/Hb7In2TvKsI9Z6tPx1iYdfuYXCq/N6S81InB0ETR9475EVKusvoQX+NBUcDjztEFW7c/TydUfXoDComPA=
X-Received: by 2002:a62:b80a:: with SMTP id p10mr35632082pfe.32.1548958876430; 
 Thu, 31 Jan 2019 10:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20190131180627.19944-1-natechancellor@gmail.com>
In-Reply-To: <20190131180627.19944-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 31 Jan 2019 10:21:05 -0800
Message-ID: <CAKwvOdkHyfUOSNYD22adGtBfPeHA=HMGk5oM5R-9QP2u6uK1Rw@mail.gmail.com>
Subject: Re: [PATCH] serial: mps2-uart: Add parentheses around conditional in
 mps2_uart_shutdown
To: Nathan Chancellor <natechancellor@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_102120_412903_95C8FA20 
X-CRM114-Status: GOOD (  17.33  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Vladimir Murzin <vladimir.murzin@arm.com>, linux-serial@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 10:06 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/tty/serial/mps2-uart.c:351:6: warning: logical not is only
> applied to the left hand side of this bitwise operator
> [-Wlogical-not-parentheses]
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^                ~
> drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses after the
> '!' to evaluate the bitwise operator first
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^
>              (                                       )
> drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses around left
> hand side expression to silence this warning
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^
>             (               )
> 1 warning generated.
>
> As it was intended for this check to be the inverse of the one at the
> bottom of mps2_init_port, add parentheses around the whole conditional.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/tty/serial/mps2-uart.c
That function currently has the code:

if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
  mps_port->port.irq = platform_get_irq(pdev, 0);
} else {
  mps_port->rx_irq = platform_get_irq(pdev, 0);
  mps_port->tx_irq = platform_get_irq(pdev, 1);
  mps_port->port.irq = platform_get_irq(pdev, 2);
}

while shutdown has:

if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
  free_irq(mps_port->rx_irq, mps_port);
  free_irq(mps_port->tx_irq, mps_port);
}

free_irq(port->irq, mps_port);

So port->irq is always assigned an irq, and rx_irq & tx_irq are
assigned only if !(mps_port->flags & UART_PORT_COMBINED_IRQ).

Yep, patch looks good. Thanks for fixing a real bug here, Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/344


>
> Fixes: 775ea4ea2fd9 ("serial: mps2-uart: support combined irq")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/tty/serial/mps2-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> index 4404eb7d118f..587b42f754cb 100644
> --- a/drivers/tty/serial/mps2-uart.c
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -348,7 +348,7 @@ static void mps2_uart_shutdown(struct uart_port *port)
>
>         mps2_uart_write8(port, control, UARTn_CTRL);
>
> -       if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
> +       if (!(mps_port->flags & UART_PORT_COMBINED_IRQ)) {
>                 free_irq(mps_port->rx_irq, mps_port);
>                 free_irq(mps_port->tx_irq, mps_port);
>         }
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
