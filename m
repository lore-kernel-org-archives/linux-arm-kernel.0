Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FEAC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:17:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CCB217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cAPsHBk/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="HNjYi04q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CCB217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HXeduQE58IF1kyWHrYJyhN0pKB90oXiUsh07AZVYZdU=; b=cAPsHBk/Pj4kPe
	vo1VWVnZIxmQYZw4GuWVjNy+9JJxG7zo5A72IDCq5gBlV6OZg+lTwzzxPl277+uSr2EKycubZ0G/P
	xnuPLIJGMHRFOCWnKCUOe6KIQ5gsHITh28HE/I83ZBCT7hQ+WSJ9+GNsrJp0qfaPY5EpE5+UJ2zTN
	Vop2bTnWMOtElRpwYYy1AjSfNY5qfAgB2O/KD9c3Mtjf3JUknGJpa3PUrbX/O6YZleCTh9WKBSgXj
	Ze8rAEs/FuYhurpVUzEgWi6znNPAIKBTa5qdiG61uGNHabeUBtHoR/I/hyUou9lPhJ/tV4N+W/z67
	ti+BJMwHd1iEJW6AgUqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsY7w-0001KK-M8; Sat, 09 Feb 2019 19:17:24 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsY7t-0001JT-FO
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 19:17:23 +0000
Received: by mail-lf1-x143.google.com with SMTP id n23so4944656lfl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 09 Feb 2019 11:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OgD5Wl5TJQIQJG3EWlvjDgLdlSUmVzFVqDCAbkP63GA=;
 b=HNjYi04qTzmurepLAa2ni4S6rJEcJtkpsspGQZZCMcIah2slGQHPlvV/wFcLFy17pA
 otsjiR4bkMUm/ADOvCkeGLxtsq3uSyLZ1CQMrT0hfWG8yp+P3BwB3zDEuYkALDetJcub
 0ZqGrgNOucras23Q9QX5I7AIBfYmL6ClqycCSrD5Sl5VXjk5Fxz8DlBDlwD+phQblLmz
 KgzwoNeySXWr7XAjzBBF3IvGVHm4kaTcvDv5SY7paJ7G0Fh85fTxBmvrPZ0l3I9VPBYc
 lyKpRszf4sKWdjAzg6lIUldh5AHAspSO3/RAmaxksO96XF+zdvXnv6IFGjqlBaGuz6hV
 wmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OgD5Wl5TJQIQJG3EWlvjDgLdlSUmVzFVqDCAbkP63GA=;
 b=FEsf94L1/SmV9EpJjAxfcT7BB0nu61aFVx3ux9EY+1PyTNIvuwSObaH+yJQPcads4g
 uY7+UJox8cugkk735ROMCl3v4zmb9TKnAODsHZsjCe8ipbDEZGxcOZqRF8gZzIin6dFD
 hTSBV+7ZjPaa6tv2nTKyGVUaKZkmQSkXrDJ4/CIKQIWgSb8ycypj+XOQ9RgTkzxgx2v/
 Fc15efMj9qv7A8vaTtBaJCDgvGzlaQyo4XPsuHiQ7SZY0/+KMo7DJ65ImELJ2i7npl3K
 sM20CkhcC6lIoD9lNZXGE8IP1Q1rAoh9UhOpDwxgldZCM03rWlwg6irf+pm6O5JtUO4D
 P4/w==
X-Gm-Message-State: AHQUAuajwsLLomQsHKRBUDB52zp4aX+mPB2vyVaDqkfrbpTajwZxOup3
 sfkkvLRXb6vY/QYN6l2u2Flr1w==
X-Google-Smtp-Source: AHgI3IY9GG9sRnYRWqmMww+kWy7wrRfd4J9ctTC3DR5NsYWujFelyL6p274R1ImsAT1jM3W15m79rw==
X-Received: by 2002:a19:da1a:: with SMTP id r26mr9523835lfg.2.1549739836443;
 Sat, 09 Feb 2019 11:17:16 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.183])
 by smtp.gmail.com with ESMTPSA id e132sm1246793lfg.22.2019.02.09.11.17.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 09 Feb 2019 11:17:15 -0800 (PST)
Subject: Re: [PATCH][next] can: at91_can: mark expected switch fall-throughs
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20190208184444.GA28484@embeddedor>
 <8402d6f6-dff1-eb99-3bd1-051b4f6f24f0@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1db2edde-5e21-6eab-d643-ae257ecb311b@cogentembedded.com>
Date: Sat, 9 Feb 2019 22:17:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8402d6f6-dff1-eb99-3bd1-051b4f6f24f0@cogentembedded.com>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_111721_520013_84B8E8BD 
X-CRM114-Status: GOOD (  16.69  )
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

On 02/08/2019 09:55 PM, Sergei Shtylyov wrote:

>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> Notice that, in this particular case, the /* fall through */
>> comments are placed at the bottom of the case statement, which
>> is what GCC is expecting to find.
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/net/can/at91_can.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
>> index d98c69045b17..1718c20f9c99 100644
>> --- a/drivers/net/can/at91_can.c
>> +++ b/drivers/net/can/at91_can.c
>> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>  				CAN_ERR_CRTL_TX_WARNING :
>>  				CAN_ERR_CRTL_RX_WARNING;
>>  		}
>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>> +		/* fall through */
> 
>    Why do we need this comment at all? Just remove it, that's all.
> 
>> +	case CAN_STATE_ERROR_WARNING:
>>  		/*
>>  		 * from: ERROR_ACTIVE, ERROR_WARNING
>>  		 * to  : ERROR_PASSIVE, BUS_OFF
>> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>  		netdev_dbg(dev, "Error Active\n");
>>  		cf->can_id |= CAN_ERR_PROT;
>>  		cf->data[2] = CAN_ERR_PROT_ACTIVE;
>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>> +		/* fall through */
> 
>    Again, we don;t need it here.
> 
>> +	case CAN_STATE_ERROR_WARNING:
>>  		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>>  		reg_ier = AT91_IRQ_ERRP;
>>  		break;

   Ignore me, I misread the code...

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
