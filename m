Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33007C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:33:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03FF92184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M0MzxmUr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsuBJSSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FF92184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LXBQ9uOtC7CXGMAmCAUzEeDPQaesqXRasfoLFW8fr1M=; b=M0MzxmUrEl9P3d
	YkiLNgWVJOc+KG8LPX6us9D3KRmbFNYFoOawstq1HkSzauG/Q+QxhC72yn1H8bQeFaobmheap66md
	fVfJjf5jqE1WXl7WRTT+RJjQZoffPfXRLNmZ4pnRC8Qwlxs1i9vYQfO5IF+/mxAHWy2ERRaA3uWmg
	7JNJsuewe7L2nngM/fwag/v5l7QE0gmjnbrgCFuHCJ9EI4kLsqeuLjbvImGTgNArAMI9VEszYqJEG
	3HUsGfbr/9+zK6khE1LbqolgbS7J85wk79ucSV4TCWi5BKEud0A+TUKu5CzGieU5iEe9Bp5kUey3d
	NCSaguADYPEh4iElB2Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvcUh-00039g-Sw; Mon, 18 Feb 2019 06:33:35 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvcUe-000394-W3
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 06:33:34 +0000
Received: by mail-wr1-x444.google.com with SMTP id f14so17050981wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 22:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vHCudiFBm/jzc4dvlgpQ6a7QXYNqY+987pMivWSoyZk=;
 b=MsuBJSSIeGgjQ4zYmV+EZjNnmbGHHojlgGczNswkGXwu0B4rIDZPxsA/6sw8qgKGGf
 cl4UfWzzTI6FuCdus+pjdvyCvxRCBy0piyk4m2aLS3397+CFimVmpr5SZY35RMkLnZOR
 +h4xvo2/wVfLE/slwcsV1/l/P8a3C5btMH9vojNYTxKRno7Vdrtbzd76TD9488etd4QG
 clA+74fnpq0udhTPc6J2HuFx6cpthej1G+53oSbXt90fLUAKlfpOgQc+uYXbSZfUiYkP
 YA5GLZT2YKm4+nNjBVJbgd1jokCfFKqSd4MSUjQTughbcKQAtPKZ7DBSfw7ffEEjStu/
 3yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vHCudiFBm/jzc4dvlgpQ6a7QXYNqY+987pMivWSoyZk=;
 b=JJ2qY0cmHSa/DeT1eDVv6LVUhq1lzVeWhaiCJZ1DQaztR8rS2DwvndJt6mlW1aJUjD
 ANnOM5SDKpT7D/3T4FGkoPkjZzezigwSzfnoSInQwrnv3TV3egr81FbHye2Ui+I7Vmvo
 mlU+DEVwXY7GnJbYTrifk9zAH7/eQP8nijdlIbyyVCZEbKlRNOnVCRcj6NOC4M7cKfcT
 7HtqY/ARSQz5FBsCaV/aq0fWTtEI53OrTVSyAu/psA4GFkEVHL0DKQnJ91M+oi0Ovv3W
 puPJkPLp8e1LNJt3/AzM5/iCUbFvHkvglALQuFdAcwNTJr0+f9vhLENyHECn1u5kGYJe
 j7KA==
X-Gm-Message-State: AHQUAuaME4j/2hsTvidfzMqo55SgqBnrviF+UuUxTmcFXAbiCiPa+DkC
 VDd7J7oyMTKk2Fiu+FsAki3CTuZEZaRb/Bs6HKE=
X-Google-Smtp-Source: AHgI3IZcK0dDAbxkgTlyAFkQYAFnhrQ7YmZYsv9JLwv9GzCKowKM7c0tSc7Z7lD7up9wZg7Gm57L1zDnbjgxin31PrU=
X-Received: by 2002:adf:cd87:: with SMTP id q7mr16476213wrj.92.1550471609085; 
 Sun, 17 Feb 2019 22:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20190129195214.30272-1-sxauwsk@163.com>
 <CAKfKVtELqoNNJB0qB88ghGoVrdV2-Ez1DjvmT3dZifntdV0GQg@mail.gmail.com>
 <2019021615501780626817@163.com>
In-Reply-To: <2019021615501780626817@163.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 18 Feb 2019 12:03:18 +0530
Message-ID: <CAKfKVtGu3dzSR71-Rsp8SR8nq8-XhY5FrgDvxv9iu_L-TyL5+Q@mail.gmail.com>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive error
 interrupts
To: "sxauwsk@163.com" <sxauwsk@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_223333_055424_017E3EA7 
X-CRM114-Status: GOOD (  20.39  )
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 "michal.simek" <michal.simek@xilinx.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ,
On Sat, Feb 16, 2019 at 1:21 PM sxauwsk@163.com <sxauwsk@163.com> wrote:
>
> >Hi Sxauwsk,
> >
> >On Wed, Jan 30, 2019 at 3:13 PM sxauwsk <sxauwsk@163.com> wrote:
> >>
> >> When the adapter receive error interrupts, such as NACK, arbitration lost,
> >> cdns_i2c_master_xfer return to the caller directly instead of resuming
> >> the adapter which resulted in the adapter being out of control.
> >>
> >> So when driver detect err_status then try to repair and fix it.
> >>
> >> Signed-off-by: sxauwsk <sxauwsk@163.com>
> >> ---
> >>  drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
> >>  1 file changed, 7 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> >> index b13605718291..e10048d7524a 100644
> >> --- a/drivers/i2c/busses/i2c-cadence.c
> >> +++ b/drivers/i2c/busses/i2c-cadence.c
> >> @@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
> >>         cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
> >>                           CDNS_I2C_IDR_OFFSET);
> >>
> >> -       /* If it is bus arbitration error, try again */
> >> -       if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
> >> -               return -EAGAIN;
> >> -
> >>         return 0;
> >>  }
> >>
> >> @@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >>                         id->bus_hold_flag = 0;
> >>
> >>                 ret = cdns_i2c_process_msg(id, msgs, adap);
> >> -               if (ret)
> >> +               if (!ret)
> >>                         goto out;
> >>
> >In case  the Arbitration error happend  the cdns_i2c_process_msg would return 0
> >and we will miss the check  below.
> >
> >Am I missing something ?
> >
> >>                 /* Report the other error interrupts to application */
> >>                 if (id->err_status) {
> >>                         cdns_i2c_master_reset(adap);
> >>
> >> +                       /* If it is bus arbitration error, try again */
> >> +                       if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
> >> +                               ret = -EAGAIN;
> >> +                               goto out;
> >> +                       }
> >> +
> >>                         if (id->err_status & CDNS_I2C_IXR_NACK) {
> >>                                 ret = -ENXIO;
> >>                                 goto out;
> >> --
> >> 2.19.2
> >>
> >>
>
> In cdns_i2c_process_msg process, when detect arbitration lost error return -EAGAIN to  cdns_i2c_master_xfer,  not return 0
> that mean cdns_i2c_process_msg  just go out ignore error check and  problem occur, So we should do something when arbitration error detect.

Arbitration lost is fine how about other errors like NACK.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
