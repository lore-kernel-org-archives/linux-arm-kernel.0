Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9048FC31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:29:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5821D2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NjbK0TR5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bPItQ11I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5821D2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:In-reply-to:Subject:To:
	From:References:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=neggchQInAjuvh6oLyGH9hCi/UXfxR4/IgEsSzPpYSo=; b=NjbK0TR5QVyZ8dvOJpSzn7Zd4
	YtrMnIbuf7N0Fi7V+awhKRKXmdZ4evTTqPdHMxDd2ThKUmbtAO738l3kVsJ/2eLp2QbCJ0Px0JJ9J
	O2YgpTHwtbJCWQwVyOMWkhrEjfhPmsfwYBdKGySzR61B99DtLwZ9SexwlaRFXCXb4kenCKTib3uJb
	abveWh8RmEBJ1ETt637HcbX4tC8MrHFwDvAm4XuimvEbiE6vobl9WS0p1rAB5mMMH7rAjXlnr6k28
	s/folYffUi2EPdBAShuiUPqWwmpqbVZbviy4W80qWoAuztsyVfv07+3PrhP33DwTFzyqIvNeWg88k
	bWCvhAIHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldOF-00083F-8d; Mon, 21 Jan 2019 17:29:39 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldOB-00081w-9a
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:29:36 +0000
Received: by mail-wr1-x441.google.com with SMTP id t6so24289021wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=fevEhq1ZsnQYiONWisKFgrF2FMIWgLVBZ7cBkGFWRzs=;
 b=bPItQ11IUHbzpz1QxTtVdytwKZ6VWQGLR1BKJlsmQpd1iF+RkD/0fAmDud7Z+VsRXL
 aZAqRuQ4llXIAUAuPCmlNCSReP/t8k8OglRq6+mEllr31JCvZdicbWT8v0m8Nn8vprUy
 /HeEXzeWBau0iG+u+RJQT/0cVF64sxlEKbbQkdkYBoPQ1XdsYXdnb2tBDHVQS75Up+Zl
 G8FT1zIcbXuJFjG2sSvtz03LmBo/08f0a07mjrAtair27m4IDrKZmAAUG7hdBd12Yfqx
 EE20FgB5kE3xCovE5j2+t5Eom3iiW+3vvQe+4AzmP/Xfhft1H5NJlCKZV1v6j2BjibUd
 D0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=fevEhq1ZsnQYiONWisKFgrF2FMIWgLVBZ7cBkGFWRzs=;
 b=OMOOQocPVI2Srtn3rj4spncIztrjai2TBxyS9ll8IxhJ7q2G3vn/6XIyexWWJvG+35
 m6y6jK9KmVQfv8UuvNZf0I/Ik5t0SkmEZKuI1zrOwAYfKlRKafolN4Si8ctd3jP7YGMB
 7Wt3xLxLuFYeNDU/w4pUKN7sFgcxvYZ46nrvILlgOM9ky39xJ3/6llMvawaLsiVaXkfs
 MvjknqqATHNOmcL8eUGLV2z+kjCoAnsIGJvqga9N70wvANJ3Qm54j8e74eI6fDpegDhq
 EJNgbL71J7009fqUzNWcCpajaSRGpRS+LL2HtR0SRWNmfhRlSMla3hqULI0tt3ZmRE+v
 UN3w==
X-Gm-Message-State: AJcUukdToTB4JUkBNcCnsGFYlqHCpHtg7Ky5fkMi5JgKaWn0oiGawyj9
 IAHX6P0kSxeiJlfmkDml6q8mUg==
X-Google-Smtp-Source: ALg8bN7tpv/auSIsJ0/uj08hI1z/+4n+sDSx17gm5FI5xX5pj1+MbZykBPpq3Rv5o3PcpmbODvDkWQ==
X-Received: by 2002:adf:9168:: with SMTP id j95mr28466115wrj.217.1548091772762; 
 Mon, 21 Jan 2019 09:29:32 -0800 (PST)
Received: from localhost (amontpellier-658-1-219-17.w109-210.abo.wanadoo.fr.
 [109.210.118.17])
 by smtp.gmail.com with ESMTPSA id s5sm32686088wmh.37.2019.01.21.09.29.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 09:29:32 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190121171019.GA2903@bogus>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <20190121171019.GA2903@bogus>
Date: Mon, 21 Jan 2019 18:27:14 +0100
Message-ID: <86imyhapl9.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_092935_332987_3F7AD9A3 
X-CRM114-Status: UNSURE (   9.94  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Mon 21 Jan 2019 at 17:10, Rob Herring wrote:

> On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
>> Add binding for Mediatek-based GNSS receivers.
>> 
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> ---
>> 
>> v2:
>> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>> Moved current-speed as an optional propertie.
>> Removed the status line in the example.
>> Added "mediatek,mt3339" compatible.
>> 
>>  .../devicetree/bindings/gnss/mediatek.txt          | 39 
>>  ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>> 
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob,
If there are no objections by others, I'll stop sending these two patch
(1/4 and 2/4) and reference any new patch serie for 3 and 4 as depending
on those two.

-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
