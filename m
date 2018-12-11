Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E865C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:35:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569C520811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KWuBEV3k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be9Ha95H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569C520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6T5bJ2prbenW/NFcoAXexcKGR3l6EuQ5qUnx+mkqFkg=; b=KWuBEV3klMUQTY
	P0kby8865ZOrkm1nTwH6SmtTfb/508CTqNmQ899ssKmSxyn3MuGNMglqLlBFaXRx8QHnQWwb84kWy
	BMIc12VPE/JACZV+toIUyqTIoeyAmbwDcQpwLjqGHCAjXwo6NSgKlt+p2wfbR8/jFvpIKq3R44Ns3
	3058W4y+ygLeBoAVnqqTuKS4Jfa9oYVpIumqSL4/iSoXhCedFErF11fDspIazmcGhc8/NWIs3Oqhv
	dAV+A3OMw/hbZhKvhjzz3jJ/eAit5IfVwgcCvhI5gRZJKGRnWPezKbKQlQbDX3kjvU7eGq6z/6rDc
	u7gBsD5v1UrX7T92/Omg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiC4-0004II-C7; Tue, 11 Dec 2018 13:35:24 +0000
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiBy-0003dw-7X; Tue, 11 Dec 2018 13:35:21 +0000
Received: by mail-yw1-xc43.google.com with SMTP id d190so5423851ywd.12;
 Tue, 11 Dec 2018 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VQMczdnW/bz6Jv0F/+WTrvBHIfG20dJetXJVT+1ao/8=;
 b=be9Ha95HG2UBgzE0JMn5jsYyQynyzfDjxwqK7Y5OC5khOJav3v8nkX2HazmhKtYCh/
 uBa8Hv15TRhaAilfo/07ntKNOeQ1dCloyFDM4PP7fmEinQKQ1bnSy2nibbhElRSaDDV+
 Dd6t5gK7iiwOn7eyzT5Kw7eKdnuSwduJjOfsilcDZ9QT1oY9aMen5+DAwnZAxiT8ZU4L
 8XYygAdaID+SQmgFaDsutCR+RlsEXPqeSAdVNS3zJAcPdI46b5cTHODeW3pO3kAC5/dg
 FsoezXVdtjxPYiVAKHxzbtpDr7y/3Q8r1i5+ggKEfWIv9FkhfUYd/rqqAKOdyirBDoJV
 oRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VQMczdnW/bz6Jv0F/+WTrvBHIfG20dJetXJVT+1ao/8=;
 b=YaRld5oii9K386/jHfnrVoQj+JPhTgp08i7EyafTnCJLl5SP6eEy4NiyGvZRdTFVyA
 saPFgYNzVUggaRAJwxo+RoWyZC8NbJc+YQiBn8HPi1sJwoKphhIWgPWFkVYqxyoBtBQP
 rV5DvLmE1wJV3YLd2cg6rAQaw14rynjfIMvsUTtryzakSs0clvfItX+sjzA9aKALBEh1
 mUqlR/76UyAD5kusuhg8rUHrK6iVdVANOAaZVNNQD1bg3Y59sU9XLsMI+ozABbGz/wic
 knxxBZWEpa3XaQlF6iUV9yPz56qnbKLSfAIfo0AveaJONonxCJ4IDYo4MXHQXVb5Kgif
 ti4w==
X-Gm-Message-State: AA+aEWab+OAYABOKvJRRTZLszrQNejGm0/ujlVTbQeR2g41KRSiXgf0w
 BfGvHMO72yXCKmp+7aU7pqi5UHlpjdpuuaEjmRnMxQ==
X-Google-Smtp-Source: AFSGD/WLY3Rc6ZuFJgGDiebQg730gHSaz8BTrNG9Nyt2I8UqYNGyIy59MSQQBgjwVB828ZMugOpcO+c++BChG2Oulg4=
X-Received: by 2002:a81:3685:: with SMTP id d127mr16785697ywa.71.1544535306447; 
 Tue, 11 Dec 2018 05:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20181205130243.5810-1-richard@puffinpack.se>
 <2530200.jDlzaWghUx@phil>
In-Reply-To: <2530200.jDlzaWghUx@phil>
From: =?UTF-8?Q?Richard_R=C3=B6jfors?= <richard.rojfors@gmail.com>
Date: Tue, 11 Dec 2018 14:34:55 +0100
Message-ID: <CAHB-PjnCPyf7+7_UHR1V2WM2AeYA8ZscLU9AS9O-u6aohqGVxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: dw-mipi-dsi: Support MIPI_DSI_DCS_READ
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_053518_817287_E0E8B491 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Richard_R=C3=B6jfors?= <richard@puffinpack.se>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Heiko,

On Fri, Dec 7, 2018 at 3:58 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The Rockchip dsi driver got converted to use the generic dw-mipi-dsi
> bridge - will be part of 4.21. And there the different methods seem to
> be implemented already.
>
> So this patch does not seem to be relevant anymore. Please wait for 4.21-rc1
> or check linux-next, if there is still functionality missing.

Thanks, I didn't know about the conversion, but it makes sense!

BR
--Richard

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
