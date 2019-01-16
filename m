Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA82C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:06:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6083220840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DMWU2Be8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UjC4u3gJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6083220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wcGO42XeE3CWvzzMFuKo+R/uow9XzCHv8d7sMudDVmI=; b=DMWU2Be8Uklf5WzoLRlSDlK2S
	wNggt+0XPk2tOOc5kUfczybx+K18nh3Yg7HoE0g+8lnQij8RVPYGVSAJTo7VCAyXQLzTVEmeeGmsp
	P4OFPyPHnXFLjB4LztN+sqlg/H2LTQuwweZhav0X+QKh/TBXC84Qetc7HgkC1VU69RXl1VYqMiILx
	h3cNiEjMGxEtrwI9jAm9lOHbGZ3kHODMNBl8ET62UouUylQqk86IBlzulzMJxMt05B+PcBzviclbh
	txC6nA6AvSNExa2f+aixY4IK2H2BZaMMoGSsSKt/7mNB9qIFCq62uoxcUoDl8cU+u3OOafjFE4/lC
	jU2H5RnpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjpaH-0007ua-2c; Wed, 16 Jan 2019 18:06:37 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjpaD-0007ts-6C
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 18:06:34 +0000
Received: by mail-pl1-x641.google.com with SMTP id w4so3385632plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6K39/QLGsaxRZ05/uOSjLCq/5EeuHt4nUThhnw2J9PM=;
 b=UjC4u3gJvHmJ8Nm6G4D2Mncd9VrNDtydzcTRD/MLw16xOenz0Y1lg19c1ZkEnuwXoG
 pAUQdrHEeTzAG3+xOXM53AGGgV0lJ3STh/CJu3PxNQUYu0HN17oHsIJ8et2JJVMp/rPp
 dkqxEm8AZkTL0G+Us9AfP1jxRiW7bOc/QTuuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6K39/QLGsaxRZ05/uOSjLCq/5EeuHt4nUThhnw2J9PM=;
 b=J2WU8WFHV6WM8/CgTVgKOaTJYBTYacis6bizI4FDIaCjCkRSCSTep8l+NmKIPuBuh0
 je5XLqMUlMbHxhSl+cGQ84pta9h5c583v/esHJVWhSXQ+a/3TFzmNNc17xU+KbWLnJLl
 IL7xRenwrJwLsh4rmQmQOhAnp/y1nXzsrVO1fvhWYHYBWQhO368GH0IH3+xITis5e+J0
 CQKDj6owlV3xuHpOWpo2WWSRS3DGCL/tB7Fv9saeNB8xNrFCqEq0f/iN18njL0v5ZSy2
 jbpmfHvD9+F4KkUjJgc7iMmxoHuj/ZLxP3bGkjm9NWbzj+oqsAMOzNPae8c4YuP+3bdJ
 50Qg==
X-Gm-Message-State: AJcUukeedjOlpVp3eI55LhPJS9RTHaHLVys07MqRjkcfgJKOpb8miQ0m
 2sPjLMUdyoUuRqOHCIoI+/LCSQ==
X-Google-Smtp-Source: ALg8bN4ZCT4p2HOk1lg+UmpMu5Fwovrgm8xmlayH0mdHa31bk3nQqLRZSmow33lepw0hz4hTm0mlUw==
X-Received: by 2002:a17:902:8b88:: with SMTP id
 ay8mr11254413plb.55.1547661992181; 
 Wed, 16 Jan 2019 10:06:32 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id d68sm9467672pfa.64.2019.01.16.10.06.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jan 2019 10:06:31 -0800 (PST)
Subject: Re: [PATCH -next] soc: bcm: bcm2835-pm: Make local symbol static
To: Wei Yongjun <weiyongjun1@huawei.com>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Rob Herring <robh@kernel.org>
References: <1547617457-60066-1-git-send-email-weiyongjun1@huawei.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <50481a6e-53de-96ef-11c9-421568d7b7e5@broadcom.com>
Date: Wed, 16 Jan 2019 10:06:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547617457-60066-1-git-send-email-weiyongjun1@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_100633_234383_27C55B30 
X-CRM114-Status: GOOD (  18.09  )
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
Cc: kernel-janitors@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Looks good.

On 2019-01-15 9:44 p.m., Wei Yongjun wrote:
> Fixes the following sparse warning:
>
> drivers/soc/bcm/bcm2835-power.c:556:32: warning:
>   symbol 'bcm2835_reset_ops' was not declared. Should it be static?
>
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/soc/bcm/bcm2835-power.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
> index 4841295..9351349 100644
> --- a/drivers/soc/bcm/bcm2835-power.c
> +++ b/drivers/soc/bcm/bcm2835-power.c
> @@ -553,7 +553,7 @@ static int bcm2835_reset_status(struct reset_controller_dev *rcdev,
>   	}
>   }
>   
> -const struct reset_control_ops bcm2835_reset_ops = {
> +static const struct reset_control_ops bcm2835_reset_ops = {
>   	.reset = bcm2835_reset_reset,
>   	.status = bcm2835_reset_status,
>   };
>
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
