Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BDFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:03:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5490218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ew2u+vy3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkgm+xXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5490218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jwdn58B6hMGGatsLAlgsk/lFhf4nMvupfu4oKkzI58c=; b=ew2u+vy3f1DIGl
	IHknjoN1I2hMozJIf5lTLsQMLCfbh2rM19oiNjY2o7V3YkRykUeQcsSjTtFnd2Ng6jfyL6vP8Fou9
	LNZ0GKBaCR045osJVhPFJ0rKRpF9ijvULYwzgOuLJ/CI4zCPo20SFIEiENZtwb/HNfVsTSAk3373W
	M/L7L+xtaxa0nnRKcNsSImLsyL6ZyOEAuWXMLOXUuAEnknIar8LKT/cjw2gST9fApdkdZJAYdZsTM
	MX/h/QrxlvPGLbeo+6Qr9kpUuPvUJWBXtIb8bLZG6DeOGE+xy1W3QgDvou2vEnXfeHVBmPI9EHs0T
	YPgoc8Qay0apbksC9o7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaGiY-0000jo-9x; Fri, 21 Dec 2018 09:03:38 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaGiT-0000h3-VA
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 09:03:37 +0000
Received: by mail-lf1-x144.google.com with SMTP id v5so3360580lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 01:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kMDNDJEbhmw6cJ1gaXs4EtD5SDcFjmkJQrMnPqLksaw=;
 b=dkgm+xXZk74Cg2BNDCm/20NQdtrWMwIe0yoKv4DArWUbA22TL3cuEXSr9/CNqSHNVw
 mn5eLVbGIs56liR+SE1pEw2i5Odhz2ETGTAH/tJoXcBHFuAYmvUrTu57WR7JT2UX9hs/
 l+LuzaxwiUn9sq0tG688SBhVLLbwEY46BvoH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kMDNDJEbhmw6cJ1gaXs4EtD5SDcFjmkJQrMnPqLksaw=;
 b=NKMRLEN3LbXIafthT6A9mZOqWc/7jGZWrsEjwIKIwTRBIxQBSwk+KOMxu19iIJEZlA
 k4L2a/wxzgXKs/eio/MaAyxikMZmt+ZYW1w3aqe5XjN6cADr6RtmXLjFSKNjbS0J2Snc
 ftg5ik8flEC7I2IOqBUO6kDq6av2c6ME5N6+EuBHjlK7rL3508gRyCreFAbvevr5PU0M
 rGRj6k4VFDUaX+msJP7u63D/IcOKicQZCd3GrfsgDjUy/AlgLFzytCKWEoaWzljAEmCH
 h9ekF2ewMMmhOoonOWp5VLA+f+lDCq7fg/E5btQXv2h5i2BFXfKZnQOFkB6KOFjltyWn
 mCNw==
X-Gm-Message-State: AA+aEWZwC/8VE+atS0GRSECgj4rTq5hMl5m58NpoLXxu2EgywtNdW7e2
 nVOAzTyhMMEhin3zvcVr5w0gNZv8g/ZvOecKueGq8g==
X-Google-Smtp-Source: AFSGD/WWHVd8zr/biKpKvHjmEj8TL5SWd9I6l53as8Xl+0kFHieFSstFXwVpLi6wMvEseHQRjbY3ODdLwJcmc1Rlkfg=
X-Received: by 2002:a19:5601:: with SMTP id k1mr781748lfb.99.1545383001128;
 Fri, 21 Dec 2018 01:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-8-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181219164827.20985-8-wsa+renesas@sang-engineering.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 21 Dec 2018 17:03:09 +0800
Message-ID: <CAMz4kuLv_s6t6n0OfRP8EW3=z8QD0ezn2=45sKg9aXJs5Agrbg@mail.gmail.com>
Subject: Re: [PATCH 07/10] i2c: sprd: use core helper to mark adapter suspended
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_010334_000783_F7DC69E1 
X-CRM114-Status: GOOD (  15.52  )
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
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 Chunyan Zhang <zhang.lyra@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-i2c@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wolfram,

On Thu, 20 Dec 2018 at 00:48, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Rejecting transfers should be handled by the core.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Great to see the I2C core can handle this issue.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/i2c/busses/i2c-sprd.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
> index e266d8a713d9..961123529678 100644
> --- a/drivers/i2c/busses/i2c-sprd.c
> +++ b/drivers/i2c/busses/i2c-sprd.c
> @@ -86,7 +86,6 @@ struct sprd_i2c {
>         u32 count;
>         int irq;
>         int err;
> -       bool is_suspended;
>  };
>
>  static void sprd_i2c_set_count(struct sprd_i2c *i2c_dev, u32 count)
> @@ -284,9 +283,6 @@ static int sprd_i2c_master_xfer(struct i2c_adapter *i2c_adap,
>         struct sprd_i2c *i2c_dev = i2c_adap->algo_data;
>         int im, ret;
>
> -       if (i2c_dev->is_suspended)
> -               return -EBUSY;
> -
>         ret = pm_runtime_get_sync(i2c_dev->dev);
>         if (ret < 0)
>                 return ret;
> @@ -590,10 +586,7 @@ static int __maybe_unused sprd_i2c_suspend_noirq(struct device *dev)
>  {
>         struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -       i2c_dev->is_suspended = true;
> -       i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -
> +       i2c_mark_adapter_suspended(&i2c_dev->adap);
>         return pm_runtime_force_suspend(dev);
>  }
>
> @@ -601,10 +594,7 @@ static int __maybe_unused sprd_i2c_resume_noirq(struct device *dev)
>  {
>         struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -       i2c_dev->is_suspended = false;
> -       i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -
> +       i2c_mark_adapter_resumed(&i2c_dev->adap);
>         return pm_runtime_force_resume(dev);
>  }
>
> --
> 2.11.0
>


-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
