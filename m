Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63256C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:11:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7E6218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GCGAmfit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7E6218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WasEnF1naXS778ba21dUu64nP8KrgDQNVDk9hgL+lpg=; b=GCGAmfitG3pnJu
	DPwD2EEvE7EmdYPjVSA9Bu+YXnrUJFrY1kUajmadCvQZgoNWkqw1DjC7qZ6EephHT8Wde4SH3GlVZ
	mGuKtwy94jps9V3Zn0DnXVfo1DfbKaUi/rSvVD/TppTnk6MqKYiWOuG7dcfbA2EAiU+ZG+Nrg+Irk
	gv97q2xDqiFhRcZCYEt/FH0z3yNwbIkp3+lyR190GuoL5oRw0cghVHID2zUNprw6vRbCQqTRwSUK/
	esUqBJdJzlcnZ6HS3JKq0JRtO/4xsB8aUpQSxHyGnMeNqL/0Sf/zFG/RYWZWKFu+Bh9SAqGb8gTlp
	E5C2hp5P59fxdFAYMbpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpGoU-00067R-Rv; Thu, 31 Jan 2019 18:11:46 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpGoS-000675-1Y
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:11:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C435A78;
 Thu, 31 Jan 2019 10:11:43 -0800 (PST)
Received: from [10.1.25.162] (e121487-lin.cambridge.arm.com [10.1.25.162])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C52693F59C;
 Thu, 31 Jan 2019 10:11:41 -0800 (PST)
Subject: Re: [PATCH] serial: mps2-uart: Add parentheses around conditional in
 mps2_uart_shutdown
To: Nathan Chancellor <natechancellor@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190131180627.19944-1-natechancellor@gmail.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <6ae1916a-c18f-d2f2-705a-549c4468f81e@arm.com>
Date: Thu, 31 Jan 2019 18:11:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131180627.19944-1-natechancellor@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_101144_091646_F6755D62 
X-CRM114-Status: GOOD (  19.79  )
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
 Nick Desaulniers <ndesaulniers@google.com>, Jiri Slaby <jslaby@suse.com>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/19 6:06 PM, Nathan Chancellor wrote:
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
>  	mps2_uart_write8(port, control, UARTn_CTRL);
>  
> -	if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
> +	if (!(mps_port->flags & UART_PORT_COMBINED_IRQ)) {
>  		free_irq(mps_port->rx_irq, mps_port);
>  		free_irq(mps_port->tx_irq, mps_port);
>  	}
> 

Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
