Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4158C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:05:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A85218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gEkyjUS0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lerh3YpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A85218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3aN2lZuFXEJLyblPfdBDx+l2JfBhOFfz7u2DmySkj0Q=; b=gEkyjUS0aFVD1e
	n9xIyIn2Pc7Rl2LQWoUdU0W4qFJYMfRMpC79B3FWcnmfpzgiyhFSJ3yb5vwjkHO31WRcvcgpgsbZn
	nH2smAQJpxRwRFG6sxk+DbrQzpUmM+S9cOa2BJOj51lsPWP71nnx6HiHfRHvRhuMvVZewuRThXx4l
	Nj8jfhG7DfWVVxrmOSjDiMH78hfsNYfNPU5PsuxPKh/6MaN1bmbu8i6T5/IELawpQPzpLKsUH/gLO
	n5B1BxrAMmVyxRUuUZI6foh/3cWrZngi49JprnS+cPxoAiijLuL6LG0Xy8GRzs+cUkFhZ0ESvmpF8
	r6KGX7omG2AJKbblJMww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyrOz-0008VQ-D3; Wed, 27 Feb 2019 05:05:05 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyrOw-00080o-FL
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 05:05:04 +0000
Received: by mail-pg1-x541.google.com with SMTP id r124so7342665pgr.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 21:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y6MKlThRi7iocLXrinu5vt4XQ93V36AlWjL0gnRGdjg=;
 b=Lerh3YpVKS+TbKb7D5L+/YZkEV7c0elTvkZLzLswUS3OuddSSSALZt2OsuwEhP7mt1
 0K2DXwHYJOARFOK/nYU69pTvk+S71YnyiW/rfx9LcD2LoNDgq412CZ95PJUveBn7q8cq
 1B10F903IwKwYklQJu1wgtnce8TPFZOq1Hj7MXSAsnpRFzuEvW1h15icilKLlhKNQdJP
 RqSJNY3qUUsNFUcCgM//omJvAARDOmq28749F+rBbc9F8scRMgyyO1OCt4Q7Oj35FR9U
 0mCwmCJ3L8Tazh23uT+Q+pOfy33TSA/+kQ8Rka/p20anRZSCkhv2LbwjoTDmnMSZTIAv
 ZAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=y6MKlThRi7iocLXrinu5vt4XQ93V36AlWjL0gnRGdjg=;
 b=m4RaxY8I6HcejrSqpWwC3YSvwoO7AmI/u0/JMx1FV0nXxH6a+lXDBZTsCzXXX/1VEp
 JPGlvEqfoykVJYOfqPQxKn49XJt0aEwenfPDSAyJ5kfCiJZjHKG7985io8bFiZm4xZgl
 oCHRPeLfAmrrM4tBRyEpOt3P8YVj6/xOCqJ22vBp57eFV4URYm6kdDv/MHC1TGTlu9z+
 hXysosHP2OJBSfxNiSJ2q/rnwdtzt9NsSErgNE1mEp5BrlgBa6cap+2uo5BoOd4d7ZU4
 zc7S93PTnleclYz2Vwb9aTL4CdFW16LfFKRylbF+IVhQkhYH/jq8PZjz+83eDFPi/wBd
 GZuA==
X-Gm-Message-State: AHQUAuY7aU6hzB4DJsFwV6nbcN/I3aqTadLJCGHSjDBns5L7xMg8z8fS
 G/aOFzI74nLEYrUwQ6uBtYecGAiO
X-Google-Smtp-Source: AHgI3IZPf3U7OZDjidVGvyIeHfc+Hc7asT/pKyMuT0nkCVPVpbbdMLrIY3yg74oOiw94ciocVlVT5Q==
X-Received: by 2002:a65:5108:: with SMTP id f8mr1153951pgq.441.1551243900258; 
 Tue, 26 Feb 2019 21:05:00 -0800 (PST)
Received: from [10.230.1.150] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id h64sm28585378pfj.40.2019.02.26.21.04.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 21:04:59 -0800 (PST)
Subject: Re: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
To: Patrick Venture <venture@google.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, joel@jms.id.au, andrew@aj.id.au
References: <20190221222537.137331-1-venture@google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0KEZsb3JpYW4gRmFpbmVsbGkgPGZhaW5lbGxpQGJyb2FkY29tLmNvbT6JAccEEAECALEF
 AlPAG9YXCgABv0jL/n0t8VEFmtDa8j7qERo7AN0gFAAAAAAAFgABa2V5LXVzYWdlLW1hc2tA
 cGdwLmNvbY4wFIAAAAAAIAAHcHJlZmVycmVkLWVtYWlsLWVuY29kaW5nQHBncC5jb21wZ3Bt
 aW1lCAsJCAcDAgEKAhkBBReAAAAAGRhsZGFwOi8va2V5cy5icm9hZGNvbS5jb20FGwMAAAAD
 FgIBBR4BAAAABBUICQoACgkQgTG1xCm8ZqD+Dgf9HhhzqvJYIPomNeg+ll7/TbzWb871E+HQ
 TaufJQFQwLEbgdFSZO2uj4UqfDpCyTwtHTVMJogWt3pCAE1sadeIY8OlT6918ofKIl8AiHj2
 BlfL7ASZ5wzkRMt/4TZoinq9O1tPEynb5G6PdZTV3UQtmSGnpt2EOu7KtRJsnThBiXoOO9TJ
 Asg4vXJ0ZM1y/MPhQlZbPCHQZFe1gaVWBPLGnLyWyeprqgSLWHaGqrUhlfK1sLuJK1bjYDCI
 NetK0pS4cA4ZJgogr5FrtV64R19zLl02mt/Yj7rAmjC3ZBuwVi3V35kD8Kd4d9QM2apsiILV
 bzGbtVCSUgvxI+1SsJEm3bkBDQRTwBvBAQgArGvvWip77T4xgJztZp9YRylAcVTC9gtx0Gg6
 eYk/EPANGm9TkuGpI++T/Il2H2TjFQNC7eubWohbYj0+6Tmf8nP+VmyobDxPXcMrK7x4xy9o
 D+Kub2Vf0SXbsM8fL/SqzGbFWZSm73L1L4GZoxvYIz0i7LExYSX2u5YVLaMBaH9HwKt2cvr7
 MuTrRHtcbOZImoXT29g2UnoF1uwxYNeRhZY/lRvVkkY0lDipPuDwg3SpfHMtCybPq1uAswQd
 gEbHzRsEXwCR1OF3pIuGt4I3tSEhH/k1caqi0BlqjbGUOkku44xC2gf1ZU267FBBkdV3yJ/7
 KnrJEnkMCYhS3kII9wARAQABiQJBBBgBAgErBQJTwBvCBRsMAAAAwF0gBBkBCAAGBQJTwBvB
 AAoJEJNgBqiYLw9VDRUIAJaTef6hsUAESnlGDpC+ymL2RZdzAJx9lXjU4hhaFcyhznuyyMJq
 d3mehmLxsqDRvHDiqyD71w2Bnc838MVZw0pwBPdnb/h9Ocmp0lL/9hwSGWvy4az5lYVyoA9u
 14UIzh0YNGu6jr0isd/LJAbHXqwJwWWs3y8PTrpEp68V6lv+aXt5gR03lJEAvIR1Awp4JJ/e
 Z5y12gQISp0X8xal9YhhDWER92YLYrO2b6Hc2S31lAupzfCw8lmZsP1PRz1GmF/KmDD9J9N/
 b8IehhWQqrBQjMjn2K2XkvN75HnAMHKFYfHZR3ZHtK52ZP1crV7THtbtrnPXVDq+vO4QPmdC
 +SEACgkQgTG1xCm8ZqC6BwgAl3kRh7oozpjpG8jpO8en5CBtTl3G+OpKJK9qbQyzdCsuJ0K1
 qe1wZPZbP/Y+VtmqSgnExBzjStt9drjFBK8liPQZalp2sMlS9S7csSy6cMLF1auZubAZEqpm
 tpXagbtgR12YOo57Reb83F5KhtwwiWdoTpXRTx/nM0cHtjjrImONhP8OzVMmjem/B68NY++/
 qt0F5XTsP2zjd+tRLrFh3W4XEcLt1lhYmNmbJR/l6+vVbWAKDAtcbQ8SL2feqbPWV6VDyVKh
 ya/EEq0xtf84qEB+4/+IjCdOzDD3kDZJo+JBkDnU3LBXw4WCw3QhOXY+VnhOn2EcREN7qdAK
 w0j9Sw==
Message-ID: <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
Date: Tue, 26 Feb 2019 21:04:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190221222537.137331-1-venture@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_210502_584553_6388AE74 
X-CRM114-Status: GOOD (  18.62  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/21/2019 2:25 PM, Patrick Venture wrote:
> The ASPEED AST2400, and AST2500 in some configurations include a
> PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> in the BMC's memory space.  This feature is especially useful when using
> this bridge to send large files to the BMC.
> 
> The host may use this to send down a firmware image by staging data at a
> specific memory address, and in a coordinated effort with the BMC's
> software stack and kernel, transmit the bytes.
> 
> This driver enables the BMC to unlock the PCI bridge on demand, and
> configure it via ioctl to allow the host to write bytes to an agreed
> upon location.  In the primary use-case, the region to use is known
> apriori on the BMC, and the host requests this information.  Once this
> request is received, the BMC's software stack will enable the bridge and
> the region and then using some software flow control (possibly via IPMI
> packets), copy the bytes down.  Once the process is complete, the BMC
> will disable the bridge and unset any region involved.
> 
> The default behavior of this bridge when present is: enabled and all
> regions marked read-write.  This driver will fix the regions to be
> read-only and then disable the bridge entirely.

A complete drive by review, so I could be completely off here (most
likely am), but have you considered using virtio and doing some sort of
rudimentary features (regions here) negotiation over that interface?

If I get your description right in premise maybe emulating the AHB side
on the BMC as a PCI end-point device driver, and using it as a seemingly
regular PCI EP from the host side with BARs and stuff might make sense
here and be less of a security hole than it currently looks like.
-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
