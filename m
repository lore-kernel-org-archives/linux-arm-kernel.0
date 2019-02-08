Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C14C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:55:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E832C20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S+aHO3R3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Cg1l6b4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E832C20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oUgokmkOIKdscN6RrAeLmxRDwKF17SGBV5OHvlXhxGk=; b=S+aHO3R3DjrUfB
	+I9K8MApnQW9wNdHfl+kBAtXMeHnU+zK0fe/34jXQ6vxAE6IPVCJzFRpupGXedkkwPCu7CjLgQdtw
	bPyUSTVxIcB+2nfUFx+PW3/FoZXmudPdtra0AtT0qcBotYcO+daXZK9CISPmrN0Yn4R3LZQEFZx60
	zm7a1DggPKc9W1HmZy952uJVWKoWzMPUmGHlj9LkTpuCFlnXori1DBXjKQSHifdvYlEd4vJZ5K5F1
	4BXUgZWftxnzKOaKL7BIr4x2oHZo+6gbU7vtnz9/1/lVm3fh9wZDK2EmeVBBT9L4Kw9fqRkJWOHgF
	gpG1KvaAuIvnO0Znqncw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsBJG-0007Nl-E3; Fri, 08 Feb 2019 18:55:34 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsBJC-0007Mu-6R
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 18:55:31 +0000
Received: by mail-lf1-x143.google.com with SMTP id p6so3341388lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XiteZo8Dtisf9sBZ5R33A8wf4o38A0lZEBIHXvTzJ9g=;
 b=Cg1l6b4JeF9uMd+SPEbccXJpaiL/4eUCyXBa9z+8oVhMPGcVliWFeJcD9KdoIX2qtw
 eNcvEWFH4JAtHX1Qo9zmIyAK00dqJDoaQvFCL9G5A/uD9PJKFG161rNFoCzynzud4mHn
 V5SFhqzwELlDLu55y0k/jmv0z5fkYGmVnfPd6DcWvN7TPbKS0PvVPBIXnjC1ddO4VMxs
 pETfZAkabwzIA3GTpTOXubU2UDvp77l8VAGlXW2WlpIRhzNKDyuemQD3AJ+iU390/Cgh
 fUn3UarG9c5I9tqmZNHKh0a9KqQJzWnwHJf9KkBTiiqQFLYCrpfqahRfZW1xANpnxRuO
 HUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XiteZo8Dtisf9sBZ5R33A8wf4o38A0lZEBIHXvTzJ9g=;
 b=REpMIGnq/biXfEmY2mcbGy6Cn5FYq7+bVDwCbKgQHOU9gfCg5KQwlOTmjzHQa25GLg
 cccXelKTrE1Y8YNk+IQTm7h3kCJ9w58VnA7hqI10eghVx3D+5Pys55rsFtwpv6hMLOVL
 sS+hLsaEpriunwmgGhkdQqa+bLDU1fB7uW6/kA5FU8Zhp1Eb0PdxZmSRj1Y1mQeSyygb
 LP8Y0i6P60dvxcjGxFThADv+oyefBH+rhTZp/aH+q2H249jZ/j3SZtBbfs8oMm6OhZwe
 nBzQpP34kaafYgGqeXoL8pdWeSbnkzNlWA+3X8ypqGi4lo05w02yWaqdbtWz9ASlDTn3
 6A4Q==
X-Gm-Message-State: AHQUAubFhLIQjlG/y0E4LDi+coLFF6DOoRnNiSUhrCp7wqCqxdfu4/er
 Lfo9J9doYoVKCN4ytltn8zTL6A==
X-Google-Smtp-Source: AHgI3Ib8vk/f8Tk+5uCSgXDU26DWtFjBJcQfx8VKUihWbf2UJQf3Fw9q2XybnZxziBDXoVhEohrG6w==
X-Received: by 2002:ac2:41cf:: with SMTP id d15mr14236373lfi.14.1549652128101; 
 Fri, 08 Feb 2019 10:55:28 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.160])
 by smtp.gmail.com with ESMTPSA id m10-v6sm545895ljj.34.2019.02.08.10.55.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 10:55:27 -0800 (PST)
Subject: Re: [PATCH][next] can: at91_can: mark expected switch fall-throughs
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20190208184444.GA28484@embeddedor>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <8402d6f6-dff1-eb99-3bd1-051b4f6f24f0@cogentembedded.com>
Date: Fri, 8 Feb 2019 21:55:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190208184444.GA28484@embeddedor>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_105530_402952_92A709AE 
X-CRM114-Status: GOOD (  20.13  )
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

On 02/08/2019 09:44 PM, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> Notice that, in this particular case, the /* fall through */
> comments are placed at the bottom of the case statement, which
> is what GCC is expecting to find.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/can/at91_can.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index d98c69045b17..1718c20f9c99 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>  				CAN_ERR_CRTL_TX_WARNING :
>  				CAN_ERR_CRTL_RX_WARNING;
>  		}
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */

   Why do we need this comment at all? Just remove it, that's all.

> +	case CAN_STATE_ERROR_WARNING:
>  		/*
>  		 * from: ERROR_ACTIVE, ERROR_WARNING
>  		 * to  : ERROR_PASSIVE, BUS_OFF
> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>  		netdev_dbg(dev, "Error Active\n");
>  		cf->can_id |= CAN_ERR_PROT;
>  		cf->data[2] = CAN_ERR_PROT_ACTIVE;
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */

   Again, we don;t need it here.

> +	case CAN_STATE_ERROR_WARNING:
>  		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>  		reg_ier = AT91_IRQ_ERRP;
>  		break;

MBR, Serfei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
