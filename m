Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F46C2F3A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CC42084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YrA0X7IU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF2COheU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CC42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q4xPmMlGx2RH4rMc+R7lmX1/qusuLMrnhI22sDQdKLA=; b=YrA0X7IU82wTPT
	84WJYE/TZRp6FDWzTIjuVjc4u9+l7jiAAjQS7yCJYJLta1L7ABa1pHP/YApSSFI3r7lyqx7rPgB+8
	+OdFABf7Bfldfv/3a1GH6MauJoHMeicb/EQoFroHUYhRdZ6ILeXZ3SwOfDHo5MT4gCowHv3XqPM/S
	XyXCjGsTw2VDiQJpHc9WmdWjTl8rG1siDwmkJgO4BdwD3IUjEfHs3BnmgSNV7SkUwbdnWPP+hvh09
	fGBEY/wrQhKyA6MfluC7iHSTNtj7GXx/Ek3aVKzhTS+C0DM7Yst3iXgaFI4C+toeZwftJl1NIT4kI
	bH/M3MWlrpSdLHY9nJ2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYnO-0003zr-Um; Mon, 21 Jan 2019 12:35:18 +0000
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYnM-0003zK-Ch
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:35:17 +0000
Received: by mail-ua1-x92d.google.com with SMTP id z24so6831555ual.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 04:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k+MSaycj/9KITYA6lfk8QZCRSnahwfifAXAEb5FjW38=;
 b=UF2COheUoysXjsRSEAmwWvy5ArpkdNfz58fuMsj0CWoKN6ba9PggydnGg8dWNnxGdD
 6xNV8hqPBGouluqMMVwCAfevMbvLnz4CkE/80V/tbf82hpdrnJ2eOhqlyJ560TEoeviv
 hS1PZ5IowjEB0S8s0cb0k+voFynUWiRACHTllvcoiQXgdAeZwPkp0wmy15M9i8bzcj8f
 xpMDexfrQSPWWR5ZuTjWHqb6unZrPRJeCqMpfCJ0DER/WUX69ez/UNghdh4iwX5ulSQb
 +uvO8W9H7y7pfSdTKxQGFCs/6HBfoKY939BGG/zfFk/Rq1zuEq4iDiHE7nlofiqJJKaG
 j1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k+MSaycj/9KITYA6lfk8QZCRSnahwfifAXAEb5FjW38=;
 b=q5ZsreKsbK8fE+51hUv460/FMcK4qnc0ict79MtQqY3OYv7QC5h4HIbBTsli8HPBsh
 n06e4NBDz/vTdaitJQR79gTigdhB+d4l5hbolNXqW2dN4A87/3q9tx4zPPr4Vy/pw5f3
 Exgui80/CjaJvXB8poepeP3sHCvt9oZhHlwDgfUQ7IMifAbsMXPPo5hV95zhGH9F3zzR
 v3sj6nxAs4HLJZiOW70Lble3n1hdRITFT7KyxvKO8Sudphjt2qM/3RMlPdyZvY3O5Yja
 L8jjlbb5VEZV6mVBUYi+XKwScIi1cviI/2d9sB2JOpWpaqsluD0NRmKjGZQtxE8D3rVU
 KPVQ==
X-Gm-Message-State: AJcUukcAF0qL7LwScVat0AHfytRWgQ7KsSaH+FF04q4xqvXQ5pR7TX28
 1yKzkVxL6NL2Zy2gK0ctYR5GduaMBATScfM6ECtYvhhx
X-Google-Smtp-Source: ALg8bN7BTMgsv7iqj35UyxppTuxv/Y6UFsAvIzIcZL9zuwtmFozpjinsnmWFAZjBSG8GUGYxUb3A1UBWwOOmUHTeENU=
X-Received: by 2002:ab0:4802:: with SMTP id b2mr12152078uad.47.1548074114497; 
 Mon, 21 Jan 2019 04:35:14 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
 <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org>
 <CAOuPNLiNtPFksCuZF_vL6+YuLG0i0umzQhMCyEN69h9tySn2Vw@mail.gmail.com>
 <57ff3437-47b5-fe92-d576-084ce26aa5d8@codeaurora.org>
 <CAOuPNLjjd67FnjaHbJj_auD-EWnbc+6sc+hcT_HE6fjeKhEQrw@mail.gmail.com>
 <1ffe2b68-c87b-aa19-08af-b811063b3310@codeaurora.org>
In-Reply-To: <1ffe2b68-c87b-aa19-08af-b811063b3310@codeaurora.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Mon, 21 Jan 2019 18:05:03 +0530
Message-ID: <CAOuPNLgM-aV51_L4WzwSGPQ4daVqWBgs8mQ8Gdw-f4Kdmadx1Q@mail.gmail.com>
Subject: Re: Need help: how to locate failure from irq_chip subsystem
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_043516_454516_45B8E2B7 
X-CRM114-Status: GOOD (  17.07  )
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
Cc: linux-pm@vger.kernel.org, kernelnewbies@kernelnewbies.org,
 open list <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 5:23 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> On 1/18/2019 4:50 PM, Pintu Agarwal wrote:
> >>>> Could you please tell which QCOM SoC this board is based on?
> >>>>
> >>>
> >>> Snapdragon 845 with kernel 4.9.x
> >>> I want to know from which subsystem it is triggered:drivers/soc/qcom/
> >>>
> >>
> >> Irqchip driver is "drivers/irqchip/irq-gic-v3.c". The kernel you are
> >> using is msm-4.9 I suppose or some other kernel?
> >>
> > Yes, I am using customized version of msm-4.9 kernel based on Android.
> > And yes the irqchip driver is: irq-gic-v3, which I can see from config.
> >
> > But, what I wanted to know is, how to find out which driver module
> > (hopefully under: /drivers/soc/qcom/) that register with this
> > irq_chip, is getting triggered at the time of crash ?
> > So, that I can implement irq_hold function for it, which is the cause of crash.
> >
>
> Hmm, since this is a bootup crash, *initcall_debug* should help.
> Add "initcall_debug ignore_loglevel" to kernel commandline and
> check the last log before crash.
>

OK thanks Sai, for your suggestions.
Yes, I already tried that, but it did not help much.

Anyways, I could finally find the culprit driver, from where null
reference is coming.
So, that issue is fixed.
But, now I am looking into another issue.
If required, I will post further...

Thanks,
Pintu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
