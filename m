Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B52C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:36:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291D32184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="irBXv/XJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291D32184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m0tMLcfROEecJU5nP7gKazpGcoW+PWrY74MeoQlZvS4=; b=irBXv/XJ9wQINz
	LXgfzurmPKDJPnq98txLzbOtDKE4gDvQCPX0NUioHeNS2HVWrFWAQ8bodJpz3YeuOcse9/M9zRpWY
	+Z+qJxsyCWdEdnw0QzpCPaiM52y3QoFpTrfKIbiMJdhrkC/i91o8Jz409RS/272uEaRH/J7bNyE8U
	mHX3DvXQ5lvH2GLS7c8FEP4eaW4XHbaGDu4MdWyq0CHRevbJA+EVhDV76q12CQ9DJpOLwShPNW3Fi
	bgRUhgxt86cX3OTIHpebjlw5Z9LKPv7NHyGRbTdeEriFnoflTFDhR2zz23QAus/6d7vqbS3Gc+FWX
	7znczgnzxClm5HTOylkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxXM-0004g5-NM; Wed, 30 Jan 2019 21:36:48 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxXK-0004fm-5E
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:36:47 +0000
Received: by mail-qt1-f196.google.com with SMTP id t33so1295389qtt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WOHzBf4U53bGhuSbz/Q7E5TYtOmAFdhtzIMcmJ4Hsbc=;
 b=OeZOya5+gacZ2pruyijrVtF/AzkH5yuuF6yfwowDxEX0tQ2DOm9MD4jsYsEgQ1n/6D
 jCGNTSmwTFxeiMTdmqQJjroCcxPwPNul5Rad3SzzIh7TQUSxs5IN/ivdCkemUTRloukp
 mosYH1QJT/F73QWou5G0Oe6BkS+BTmbEbxYYG73FRkw0J6pRey7bWEbLfSA45NhQZm6c
 sZ0iWPk27+K+PhkBFQU0Yj2J7x8Rohn4MMaqDI3fupHEdcphPzTw8IOYyvf7AqYzSkQ7
 B5jOH7USXheUQs3DSMoEsvkXcBDy0Hic9VyFdAoe3wOc2qiycJFXXX0SNMD5j1P0go4v
 yLSw==
X-Gm-Message-State: AJcUukfMNvD2qn9IeBuTHOsg/T72bv2X7veGutEl4O5/i9UjE/BhdRgO
 +X4GjEdDZA/wDYnjxYX4lSEusdEHWhTLw0WP28RrJg==
X-Google-Smtp-Source: ALg8bN7FF7MGREdoBfgiOrPgKTdV9FbK0dZfeyP+LlxGStPEriKTRlEzhjzBVtYgfqhROmnRDhSGMZopySPl/gvzk8A=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr31467515qte.212.1548884203905; 
 Wed, 30 Jan 2019 13:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20190130165449.GB19556@e107155-lin>
In-Reply-To: <20190130165449.GB19556@e107155-lin>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 22:36:27 +0100
Message-ID: <CAK8P3a2JgHaLZ2kHGy0AGb2w9N6G-Y6h-ECN=ZDrKgg2Z74UDg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: vexpress: updates for v5.1
To: Sudeep Holla <sudeep.holla@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_133646_204563_3BC2BC40 
X-CRM114-Status: UNSURE (   8.77  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Kevin Hilman <khilman@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 ARM SoC Team <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 ALKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 5:54 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> ARMv7 Vexpress updates for v5.1
>
> Couple of simple changes to add dynamic-power-coefficient information
> for CPUs on TC2 and fix tuple used for uart and mmci interrupts with
> lists.

Pulled into next/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
