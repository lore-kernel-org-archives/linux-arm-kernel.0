Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE15C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:17:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2016020811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mqu67ZQw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b1aRZWN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2016020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KHRibiPbZd1DXM4WAlI/FqoJ7UUOFjycrLFsEUEU/Ts=; b=Mqu67ZQwTmVReO/jbGSy1ZvQw3
	mOWNsWLjfM0tQ0ZPKjTu4fYqW5DY/bdSE87rkzvDwxTc5uT/dIOVed/p9nvZ1mh8OBlet8Bj5Kmj2
	91c2VfOlED9il5Be43RiuPJYRVvbolEQ8mgStZxSWy3MNBz3YyQfV0l8ocXYMq4TWFuCFhMttbnoD
	5WZlO0v5MG1nkQ+8oZ4ZAgbo5oUrE7uKdaxGvh9bThEPMim3M/Du8K9OAOYeOa7Ny+fhBDpcLW15h
	V6/wXJ3cE0J3VCx8Aa80srnIH496PdHgfM1av31RjBsecOSxUMonjVKEWVEbXsW5u0euQ8UMhy09i
	ShB7MK3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpU0w-0007FQ-EV; Fri, 01 Feb 2019 08:17:30 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpU0s-0007Dj-0a
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:17:27 +0000
Received: by mail-wr1-x441.google.com with SMTP id p4so6037725wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 00:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=hMhn/HTa/qYSZQG2pgokIUdkGkKp08wdGnM7svsUcXE=;
 b=b1aRZWN16i8ymJT6jms0uhE+xBqyzSWZD37o/CnUeqlfRnPgZZ1elzHfXkwdHL6kHC
 u7VEJ+4w323rnwkUfgE4FuUQgYWAcXmEzJd6uTkan+vZo3Brr9JVIxlgRZSpapPzOUkW
 TvL0p2SaIVS8dc3EuWc97ZlfpnEMjt6NhrrUYJ196yd+3/wMSSZGENSluhKFH6Hbsa3H
 KPmGh4UJxdNpS6NJEudlkjgCXFzzZsFy6rHw8tMni8fFVHLHMC/d/d93WF7CDGOH+oYf
 qBZGG9DqTvgOO08q8YvFrhM1lJHe5DuaCpPflSOwPWrjzVLuzRcexNakQprsuMoTYXJG
 E5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=hMhn/HTa/qYSZQG2pgokIUdkGkKp08wdGnM7svsUcXE=;
 b=DafulafAphjJQHkw0JXCJFiy80YDko3ZYY5kXjKoenj0wodZSInA3yy9CArOBkD28L
 UaTKZyz1jJPOx+UppPv/BpiCdauUCIDHI6nPby7C15g+StaaGc+NJrnTio7RWJ4MfMah
 8P8aJFP9bEcXcXFy6heTgfAU1OGlpqLFk7jg9qIAOrm5JzsPJouJaIgiXpmsCIj/O2ya
 0HrGfpGBoduBP/UEn6759408+WBSPLBA7P6fyKb3H3LMFMM1ToupCYQdv+mGxDm+YQjX
 zuKgG0bVF5+e+scFA7G17ZkmwuukMzbsyjYSuP+SI74vZt5n1r+QZaD+hdtcJBD5nkKc
 3qYw==
X-Gm-Message-State: AJcUuke5DEC2Bil7bOLXmZwdrFPzUlq9v7Lgs3pZLg1ijhUYIN7V05VY
 YpnJXw422Q6FhJ4UBARpmsAlhg==
X-Google-Smtp-Source: ALg8bN5Zd5spjX/pV23rK/hUUGJ7dFezrvWFGyZNbqRuiuoalGir3/lBABKAOBYZczT5UM8Y1QPvXw==
X-Received: by 2002:a05:6000:1251:: with SMTP id
 j17mr36437112wrx.315.1549009041493; 
 Fri, 01 Feb 2019 00:17:21 -0800 (PST)
Received: from localhost ([2a01:cb1d:12c:8800:1e45:34e8:9e5f:f03])
 by smtp.gmail.com with ESMTPSA id v133sm1810559wmf.19.2019.02.01.00.17.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 00:17:20 -0800 (PST)
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-2-git-send-email-lollivier@baylibre.com>
 <20190130154851.GA25794@bogus>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add vendor prefix for "GlobalTop
 Technology, Inc."
In-reply-to: <20190130154851.GA25794@bogus>
Date: Fri, 01 Feb 2019 09:17:18 +0100
Message-ID: <86womj3ott.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_001726_082619_5F4EDA85 
X-CRM114-Status: GOOD (  12.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Wed 30 Jan 2019 at 15:48, Rob Herring <robh@kernel.org> wrote:

> On Mon, 28 Jan 2019 17:37:58 +0100, Loys Ollivier wrote:
>> Add globaltop vendor definition.
>> 
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> ---
>> 
>> v3: No changes
>> 
>> v2: Alphabetical order
>> 
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

Oops apologies. I'll remember that for future submissions.

-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
