Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F045C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:09:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6063120657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qwHC+Iy3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UK4FSuyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6063120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eEjQ0XkRFJhMWgknb6oEyLjtNXrgzCO5BfMzexkhYtU=; b=qwHC+Iy3eew+01
	+wurSlhmu6xqa7wZzxf0z17hkc9v4mWnTmEYmlXJXisD9oUFfhjRCbfAMIOy+qnVRhzKD8WEj+M+j
	J43UF3S//iFiD1UW4dBl/RiFe90JdfOpxWJvxXqDsPKxjYAi/YLI41C3g6haNQR06ZVLrI5dmBPf9
	ws8c5O2adfs1Y+KuPPiTCiCBEZSd9W4hko8OLlDznSuwlByvQV2iHj9PdBwSVIcRe0M+HsLqvRapV
	Px57+0hJN58uPXi4rIu7psdrQol3dm7A1gDQsqrXbwn02pu3dRBmCgAKg0Hzj3kTK6uStyZcbmIKI
	d8BWGPg+ZSojplw25Trg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkD30-0002A5-BM; Thu, 17 Jan 2019 19:09:50 +0000
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkD2x-00029N-Jh
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 19:09:49 +0000
Received: by mail-yb1-xb42.google.com with SMTP id o73so3444283ybc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qe7NUhaOauVMHMbVmvcb9y61t5wbJ0dPWB9PLPVTivk=;
 b=UK4FSuywOA+U0Swg9Voygjxj28BHGHk/5iFcLo3SkApIegWZaXrpAT+73yUEbAQxY/
 fon1c6ftGSi9sS0xVvgLRwMoD6rEkpuMTE+RIMQ/Nr8ouBIodb1VSiV8PJzvDKmZbCiP
 5dffp0I4TZ2BOM50VIabdYfcI5LJR8HHRShnTkk0e8KRX6L41BghlD/s4NFH13yCuo7z
 RGaM5V2w0ie7f07OykvIgt2MA7QJcfGRTaMZ3PQWrIEfyNpBEmHIok+dbcSMgYRzPnoZ
 4JPTFUM+bFpAZEp9ENaxDD+uJBsEcCqtqzU1R1Kt+2VfxZS7WFUHtSBt2mzdwodaIY1z
 jCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qe7NUhaOauVMHMbVmvcb9y61t5wbJ0dPWB9PLPVTivk=;
 b=amFiVfKc0Jo+3S/Ubb/BD14OIkmrPawvOOuNAP4n05+eiZKqxcBdrOe+T47UAyoUvs
 RAVk96hBncksN01L6KQEqYRh4KDlEwqiIJjzEZEhBsV4jG93ni4y0j7IA9dPfl5uYoPc
 TzfEECjCMNMqRK0stKUMY5PCttFo3W+Cb3DHF97a+fPEedJhU5Su/+LZr66Eq3x9EIn3
 fhLud58Yq7Rndk8TX33dxTfl8AzkiFuPRs+Ci7AQ+DD5NY6whTScpRmzBLiBM31t5ivZ
 WGq3yCDxkwcj1mHMi8kmJ6AhRAS8vhzSxV/4TngpCfbTPxv833riKikftqDenoYrkesv
 U7zg==
X-Gm-Message-State: AJcUukdnnv+kOU5iGWFUQl61PHQlXbG5GHa3BkcQ4hPXt+SNNGZk4aYR
 dGZI5HVWPnOp3n8a/00dd942YJukHlGlaIV6WdZbGw==
X-Google-Smtp-Source: ALg8bN4W9AvA2U2fwcNHBAUpaLURSX1Sx0s7/VHk6pgUZPY83dNqFkQgrHIClaTANPfSi43TmCMJFuJAGi8wbrm/Qro=
X-Received: by 2002:a25:8685:: with SMTP id z5mr3246200ybk.247.1547752183617; 
 Thu, 17 Jan 2019 11:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
 <154775022743.169631.1716489383315213219@swboyd.mtv.corp.google.com>
In-Reply-To: <154775022743.169631.1716489383315213219@swboyd.mtv.corp.google.com>
From: Guenter Roeck <groeck@google.com>
Date: Thu, 17 Jan 2019 11:09:31 -0800
Message-ID: <CABXOdTfE+_q8DrRfPE1V+3pU7x5rLoOy7k5LYMrwd+xojsBWvw@mail.gmail.com>
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To: Stephen Boyd <swboyd@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_110947_668557_47A1CB66 
X-CRM114-Status: GOOD (  18.84  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Guenter Roeck <groeck@chromium.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 10:37 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Sai Prakash Ranjan (2019-01-17 07:19:42)
> > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> > index 780971318810..5dfd604477a4 100644
> > --- a/drivers/watchdog/qcom-wdt.c
> > +++ b/drivers/watchdog/qcom-wdt.c
> > @@ -245,6 +245,28 @@ static int qcom_wdt_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> > +{
> > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > +
> > +       if (watchdog_active(&wdt->wdd))
> > +               qcom_wdt_stop(&wdt->wdd);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused qcom_wdt_resume(struct device *dev)
> > +{
> > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > +
> > +       if (watchdog_active(&wdt->wdd))
> > +               qcom_wdt_start(&wdt->wdd);
> > +
> > +       return 0;
> > +}
>
> This looks fairly generic. For example, the Mediatek driver also stops
> and starts (but also pings after starting). Grepping for 'active' in
> drivers/watchdog/ finds more examples. Could there be some functions in
> watchdog core that do the common things like watchdog_stop() and
> watchdog_start() and watchdog_start_and_ping()? Or maybe a bit can be
> set during registration so that the 'struct class watchdog_class' can
> get PM ops to stop and start on suspend/resume of the watchdog character
> device?
>
> Nothing is wrong with the patch, I'm just bemoaning the amount of code
> duplication here.
>

Patch(es) to add the functionality to the watchdog core are welcome;
it should be possible to move the functionality into the core (maybe
to be enabled with a new watchdog API call). Doing it using the class
device sounds like an excellent idea. This should be straightforward
to implement, though the question of "should we ping on resume or not"
might be an endless source for bike shedding fun.

Guenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
