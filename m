Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F36C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:20:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD86F2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N3Zwc7vf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUjd7shu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD86F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NlhbHvFAkTXqchNypouhWwDrXw1Y6sA67Az/L41gI48=; b=N3Zwc7vf2u9A/ah9GLPz5DSed4
	l7pbBkF88TVd4f+0raqv5AJCBs2VZRz/Zgf7Rm3vWtOboFxLyW0p0Z12ZRgceU1iREYmijQcNOj6M
	n6avaQGEXlkHbx187V1BQiuQQxT3ZY1vfB3Hd76ao0PG2tennV5HRKlI0FY1yI1rM1ZH6arkRHbBm
	Qbh7oTAF1oQVuVybmgeUuVIR5YO+4Lcy3k/YuHLxTljDPxVmHCMDiA3jgO/3VkkAMie2/W2b4D/MY
	Ybou1jnsthl36GFUG5Oadl7VMz2bFbBjvcTJPyy8Qk1ndn2KcIqdSYzjlrA0dfWa2+l1cruFJzJaI
	wEYO8uJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWVma-00055I-2s; Tue, 11 Dec 2018 00:20:16 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWVmW-0003p8-Na
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 00:20:14 +0000
Received: by mail-pf1-x442.google.com with SMTP id y126so6204504pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 16:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z6+ZnDSyNgKAS36CRMr4Bg3CB7Muy7fFJWZZ1+yYjJA=;
 b=YUjd7shuoW7jrwjYHgBFH7a7XHPfy5wpL1WCBZxgxrxDFaco5mO65BKl0iOcsalnm0
 +3qRevKUeRFzHcUYhxtlYAY9CPfePj5jrLbj+O9X1dDJ70KwRKptkjrqxD9LeM8CZIHF
 CsBpQXNWQ/Fe8jzH1u19MJIIITCdJ2Fz+JUiWgELD7CE2yPBVhAq0XmWqb0Aqgrmnpw+
 1hOgOmKuug526tB/5LwmooFRacjWertcrvNXunmEnbmLPd+VMqNu2YFnaDpKeV6mPPQd
 yWuUGhVkDZjSnVnCKB1tl4hj1zWIDiugtqAgoIRh7Dg753m7WKn93oHIUGDdR6V9MGz4
 jtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=z6+ZnDSyNgKAS36CRMr4Bg3CB7Muy7fFJWZZ1+yYjJA=;
 b=pLFGBmHxSAlUh0Qdv4TeyRDB8K1a3YIarNSi8Mb5uxLkyXR03e58RE+3AdpWUafJQD
 6rRxKU/y4+Xo/y62275oifZVA9rLtruHvSHZcq0F/Fc9PSbRboQcA7Mnc1RLjLtTAPBC
 Rn1dHcus+cZhnGewinxhwgESaQq6rWBAdSUHA1yqLWqUQzEiXQjogMrIteBadhr27fPZ
 oTQ2hg7vm5Z6O35PsS9OEWAeHiEpa+zecwmKHB6xtQZ5Dml3Vfg80CTCBmw7WTFZrwJF
 yAsnod7sKmXQU3j7TApSC4GgwiJod2uR7U5Fz5ZXmZBopTXyjGrtedT0ERNG47S3yUqa
 7MjA==
X-Gm-Message-State: AA+aEWY7P/aEMbcbb7rKkvyObl1RrOoyAqtE70k+AzvFg48Nb3pbVDNG
 kh3cnGIM1ZaP2J3l/XI1ABuKKUQN
X-Google-Smtp-Source: AFSGD/VeS50in40UTycNVr5uLmXupLuhIO61eCAWxvB/dTemK+/QlSjSW5/p8C3MrBA75sBuBzsfHg==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr12637626pgb.56.1544487601051; 
 Mon, 10 Dec 2018 16:20:01 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id r12sm13546871pgv.83.2018.12.10.16.20.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 16:20:00 -0800 (PST)
Subject: Re: changing arm64 kernel link address
To: Frank Miller <frank.miller@crossfieldtech.com>,
 linux-arm-kernel@lists.infradead.org
References: <CAB_0SN8Byw9q8b0sGarVU-YRqFuZd0jGpnYd_yPT-DCrN6ZZbw@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <5dbfba02-c6e1-a943-510d-eaa22f2127e8@gmail.com>
Date: Mon, 10 Dec 2018 16:19:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAB_0SN8Byw9q8b0sGarVU-YRqFuZd0jGpnYd_yPT-DCrN6ZZbw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_162012_794607_7021C0B1 
X-CRM114-Status: GOOD (  18.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On 12/10/18 2:41 PM, Frank Miller wrote:
> Greetings,
> I'm trying to build a kernel for the Intel/Altera Stratix10 socfpga
> which includes a quad-core Cortex A53 processor.  The hardware we have
> has its physical memory located at 0x80000000 and I am trying to link
> the kernel at that address.  I have tried making modifications to the
> . address in the arch/arm64/kernel/vmlinux.lds.S file but to no avail.

It should not matter to the kernel where your physical memory is as long
as your bootloader is properly configuring the memory controller to have
your physical memory operation by the time the kernel is loaded/running.
The address you are trying to modify is likely a virtual address, which
is independent (almost) from the backing physical address.

The physical address where you load the kernel does matter obviously,
but is a detail your bootloader can likely abstract on your behalf. Then
when the kernel is booted you need to make sure you do describe your
physical memory correctly as well, typically through Device Tree judging
by the platform here.

> 
> I'm not sure this is the right forum for this question, but I thought
> I would give it a try so please advise me if the email is
> inappropriate.
> Thanks,
> FM
> 


-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
