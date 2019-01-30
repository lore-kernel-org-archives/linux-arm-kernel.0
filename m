Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56947C282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:59:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251212087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DOLzgAHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251212087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SFNiktMsTVExPCST69gCQPIdUjoGLfJtpjiR/dSi9Bs=; b=DOLzgAHp2c2zkX
	OI7Yn08YpYxAV9q1+2OkTbiuRgKOEnVi7eaE1VsE5nZfdRLoL9V+jari3pbzpFzIXKixFWY6lurWf
	2hi1ztLJB1did5WgBiLJtFRbT4T5YGsRzch9Z8pCwNQrEjMgm4Na3unligeEEppvHrrkzLrNyEWpE
	rEPwr/9S/kybS9BtTaYf0REQXUoqO2rnajrSwkyhIr4j4tcuWXJyQ8Eru689W1Qtm4R4nyxSbIqa1
	O6WbcQoJhemifaMg9pnpXNB3TmkUqZ0FBQHggafNK9QcexP8D3oCU8ICnD0lWuOau/cF5WCGbIRtw
	ubl06j8rIJX3puV7Ng4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goli9-0002ts-Ay; Wed, 30 Jan 2019 08:59:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golhz-0002jr-9s
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:59:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 745CCA78;
 Wed, 30 Jan 2019 00:58:57 -0800 (PST)
Received: from [10.1.29.142] (e121487-lin.cambridge.arm.com [10.1.29.142])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78D133F557;
 Wed, 30 Jan 2019 00:58:56 -0800 (PST)
Subject: Re: [PATCH 1/2] serial: mps2-uart: move to dynamic port allocation
To: Greg KH <greg@kroah.com>
References: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
 <1548425597-38175-2-git-send-email-vladimir.murzin@arm.com>
 <20190130082753.GA24317@kroah.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <0bea8e14-9ade-aed4-c41e-f02ab0b81d24@arm.com>
Date: Wed, 30 Jan 2019 08:58:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190130082753.GA24317@kroah.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_005859_343333_80D44D9F 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
 sudeep.holla@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/30/19 8:27 AM, Greg KH wrote:
> On Fri, Jan 25, 2019 at 02:13:16PM +0000, Vladimir Murzin wrote:
>> Some designs, like MPS3, expose number of virtual serial ports which
>> already close or exceeds MPS2_MAX_PORTS. Increasing MPS2_MAX_PORTS
>> would have negative impact (in terms of memory consumption) on tiny
>> MPS2 platform which, in fact, has only one physically populated UART.
>>
>> Start with converting existent static port array to idr. As a bonus it
>> make driver not to fail in case when no alias was specified in device
>> tree.
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  drivers/tty/serial/mps2-uart.c | 47 ++++++++++++++++++++++++++++--------------
>>  1 file changed, 31 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
>> index 9f8f637..6da0633 100644
>> --- a/drivers/tty/serial/mps2-uart.c
>> +++ b/drivers/tty/serial/mps2-uart.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/serial_core.h>
>>  #include <linux/tty_flip.h>
>>  #include <linux/types.h>
>> +#include <linux/idr.h>
>>  
>>  #define SERIAL_NAME	"ttyMPS"
>>  #define DRIVER_NAME	"mps2-uart"
>> @@ -397,7 +398,7 @@ static const struct uart_ops mps2_uart_pops = {
>>  	.verify_port = mps2_uart_verify_port,
>>  };
>>  
>> -static struct mps2_uart_port mps2_uart_ports[MPS2_MAX_PORTS];
>> +static DEFINE_IDR(ports_idr);
> 
> You forgot to call idr_destroy() when your code unloads :(

Hmm, but code doesn't unload since ce87122911f8 ("serial: mps2-uart: make driver explicitly non-modular")
or I'm missing something?

Cheers
Vladimir

> 
> Yeah, it's not an obvious design pattern, I think someone will fix it up
> someday...
> 
> thanks,
> 
> greg k-h
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
