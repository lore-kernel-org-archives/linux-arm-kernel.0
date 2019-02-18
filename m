Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18445C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:59:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8256208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="szEuQin3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWBZCA5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8256208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eOcqKVV4ZB9i58Eiu+PQT3GkSPHR48yjoLfnIpeGOM8=; b=szEuQin3n/5i6S
	ULR6T2jcHz8puxSlz++TthK8tF4EEjPdGl4QTQOnVNeda53HyaRMMtOWBVXDsJanqRIw4wSZ5kaXk
	vOihc6LGfM0SAlTcgjJTVq0nAQOHX4rk+eUvdRGvpH3pLPGoeWx8B4vXOE/k61wcwEBbEVUNHBvBy
	W8Jkm1rx9V2QyMrOp8/9JB9V8nNnVBydHfy4isjF207afndvhMWRGBeZjDIU/NpUcKJIkhGnObZLb
	lI9Me7wWk69sEx9ukKAcoi/RxhFld4/wCC+wXd3BJsd1b3NmcJb3N+D3mUR3UWAGHIgxEiU5KUYwh
	OauADKsTokHGukMyb7HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvdpm-0005fp-Ne; Mon, 18 Feb 2019 07:59:26 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvdpj-0005fP-Cu
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 07:59:25 +0000
Received: by mail-wr1-x441.google.com with SMTP id n2so5041599wrw.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 23:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UFe9jHX1HoWKU6FMk5WMii4IqtK2zof/9fuLaWJERV4=;
 b=HWBZCA5pfGGENevoLmdMKxYCCXasF0r78JIHjqLOuLTtdQdw/g6i5Pg8FV0MSjfFnU
 SCUuacO6uSw1lzOqn4P+LQYDgf5ppcFBYO0ZACKVSI5PIsnVFVniQlWKhGTavSbbNmqn
 02ag7wchNxBw7bxIhetlvvb1Em5PW55J0/v2obfTi/+Y6qozA9VIm9ktvPiLUcve7Ai+
 438saAYNPgr1ocPhyLhs5R6RpiwxTv5vUmvGOeWPi1E8S5psHCsf+JQbQ7bc17+8R02Q
 1CfUgzXcsR2VGsIsqfdccUis9xU7PZc3g9V1HCTOc5p27JUva1f/85vUmBRExQ8apvS0
 xsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UFe9jHX1HoWKU6FMk5WMii4IqtK2zof/9fuLaWJERV4=;
 b=NdxFZxegMXC2NGBAxbYwWdBoVE9WoUXpRdsYrlxRuFKYNcphIqZoGPrrNjJfoUH7My
 NxQ6j326kzo9lGWTMQbwiXkNovtFY1djTbJBq8XuqbHPSgusvHgqUoNPG8BBAH/IeNnr
 lE6dIa8N7/R5hwMaKALBkcmTn5abQce5jhLAsO9sJLydYzQKOo0GOT4/lzD1Uo4k9E4P
 utekdphihVCuF6CvkQeLqx5IP7vUi20FzC+WCyg2+eLEzaFZYM/KTtElN2V+3U5OBYn2
 K934QSkYlTP+aw2cGyx408hR1seRDtBN7qMtbzpfJcG4vYwkLShbDCv0MfrJLB+8TWpr
 eAzw==
X-Gm-Message-State: AHQUAuYBnOgfOOWS7BOHKJkta/6RfpMCDXH/OfFAAQpqGm7BMY2ugsgr
 jYHYwK+YAoNV2vWbiB6onNdRLaN8RKAOfxCdZ7o=
X-Google-Smtp-Source: AHgI3IZgCo+GoduJYr+RXl7qY26d13sbMdRcyVlbVNRfmJd5jyZrmSXQV5by647b8pIYR6W0F5ShsSqc0d65HOcfk4w=
X-Received: by 2002:a5d:4147:: with SMTP id c7mr16597764wrq.235.1550476761629; 
 Sun, 17 Feb 2019 23:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20190129195214.30272-1-sxauwsk@163.com>
 <CAKfKVtELqoNNJB0qB88ghGoVrdV2-Ez1DjvmT3dZifntdV0GQg@mail.gmail.com>
 <2019021615501780626817@163.com>
 <CAKfKVtGu3dzSR71-Rsp8SR8nq8-XhY5FrgDvxv9iu_L-TyL5+Q@mail.gmail.com>
 <2019021815163582329937@163.com>
In-Reply-To: <2019021815163582329937@163.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 18 Feb 2019 13:29:10 +0530
Message-ID: <CAKfKVtH7Sui0RWTk_unh3vfbtC7b_CnqAjmMF5s3fPHccRnYsw@mail.gmail.com>
Subject: Re: Re: [PATCH] i2c: cadence: try reset when master receive error
 interrupts
To: "sxauwsk@163.com" <sxauwsk@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_235923_956793_978F3854 
X-CRM114-Status: GOOD (  21.10  )
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

On Mon, Feb 18, 2019 at 12:48 PM sxauwsk@163.com <sxauwsk@163.com> wrote:
>
> Hi , Shubhrajyoti
>
> >Hi ,
> >On Sat, Feb 16, 2019 at 1:21 PM sxauwsk@163.com <sxauwsk@163.com> wrote:
> >>
> >> >Hi Sxauwsk,
> >> >
> >> >On Wed, Jan 30, 2019 at 3:13 PM sxauwsk <sxauwsk@163.com> wrote:
> >> >>
> >> >> When the adapter receive error interrupts, such as NACK, arbitration lost,
> >> >> cdns_i2c_master_xfer return to the caller directly instead of resuming
> >> >> the adapter which resulted in the adapter being out of control.
> >> >>
> >> >> So when driver detect err_status then try to repair and fix it.
> >> >>
> >> >> Signed-off-by: sxauwsk <sxauwsk@163.com>
> >> >> ---
> >> >>  drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
> >> >>  1 file changed, 7 insertions(+), 5 deletions(-)
> >> >>
> >> >> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> >> >> index b13605718291..e10048d7524a 100644
> >> >> --- a/drivers/i2c/busses/i2c-cadence.c
> >> >> +++ b/drivers/i2c/busses/i2c-cadence.c
> >> >> @@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
> >> >>         cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
> >> >>                           CDNS_I2C_IDR_OFFSET);
> >> >>
> >> >> -       /* If it is bus arbitration error, try again */
> >> >> -       if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
> >> >> -               return -EAGAIN;
> >> >> -
> >> >>         return 0;
> >> >>  }
> >> >>
> >> >> @@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >> >>                         id->bus_hold_flag = 0;
> >> >>
> >> >>                 ret = cdns_i2c_process_msg(id, msgs, adap);
> >> >> -               if (ret)
> >> >> +               if (!ret)
> >> >>                         goto out;
> >> >>
> >> >In case  the Arbitration error happend  the cdns_i2c_process_msg would return 0
> >> >and we will miss the check  below.
> >> >
> >> >Am I missing something ?
> >> >
> >> >>                 /* Report the other error interrupts to application */
> >> >>                 if (id->err_status) {
> >> >>                         cdns_i2c_master_reset(adap);
> >> >>
> >> >> +                       /* If it is bus arbitration error, try again */
> >> >> +                       if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
> >> >> +                               ret = -EAGAIN;
> >> >> +                               goto out;
> >> >> +                       }
> >> >> +
> >> >>                         if (id->err_status & CDNS_I2C_IXR_NACK) {
> >> >>                                 ret = -ENXIO;
> >> >>                                 goto out;
> >> >> --
> >> >> 2.19.2
> >> >>
> >> >>
> >>
> >> In cdns_i2c_process_msg process, when detect arbitration lost error return -EAGAIN to  cdns_i2c_master_xfer,  not return 0
> >> that mean cdns_i2c_process_msg  just go out ignore error check and  problem occur, So we should do something when arbitration error detect.
> >
> >Arbitration lost is fine how about other errors like NACK.
>
> >> >>                 ret = cdns_i2c_process_msg(id, msgs, adap);
> >> >> -               if (ret)
> >> >> +               if (!ret)
> >> >>                         goto out;
>
> Yes, you're right,  This place I should't make any change,  perfect solution!
>
> >> >>
> >> >> -       /* If it is bus arbitration error, try again */
> >> >> -       if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
> >> >> -               return -EAGAIN;
> >> >> -
> >> >>         return 0;
> >> >>  }
>
>
> >> >>                 /* Report the other error interrupts to application */
> >> >>                 if (id->err_status) {
> >> >>                         cdns_i2c_master_reset(adap);
> >> >>
> >> >> +                       /* If it is bus arbitration error, try again */
> >> >> +                       if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
> >> >> +                               ret = -EAGAIN;
> >> >> +                               goto out;
> >> >> +                       }
> >> >> +
>
> Maybe Just remove Arbitration lost Detect part from  cdns_i2c_process_msg function,  then add to cdns_i2c_master_xfer,  Do you think?

I agree.
>
>
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
