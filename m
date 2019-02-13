Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255B5C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:10:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60E62147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K7sQM3jV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TvE1QsMi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vTx+7WRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60E62147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w5xkBfrJWaPJcypkgtB+tXAccg4E8faazJDi2MdrZOM=; b=K7sQM3jVsIsKDC
	TalqRFxfJep/+XYKUSKSYqQtTNreRJvCqiokue6nu/YEAw2XyFJ2gXOiwTwZPVJ5kj/NauGiJ07K0
	UBzpkwC0ABCWRueySNZ2ZLskebq6oPRQJ7cW6ppU0CzASmFCInMGq6bbcfiMiOuwpFtn1CMTchAQ2
	+NnzeSWHZ+ho7wX+XwktuLqDaVoDCp6Gw8d7BjOZ6w+tALJPymloiQPOa6hYFrrUGichL7ALrE91z
	qhlMV56MhZZ9+wfS/3oiwmm3I/yk7nd2Mvwsk6Gr2XI2iIwzmW9iV/YQU8IScmjRK22XvGoiDDmbK
	pfGnciF+7lnT1/Wx1U5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrV7-0007bL-Sy; Wed, 13 Feb 2019 10:10:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrV5-0007b0-UJ
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 10:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i6eF9degw0aTd+4/dVJSO1fMB/yLMvBoJbOjltxcH7k=; b=TvE1QsMi6+V4Kz1RREOkT/pNfC
 Oewhu3/GJbGuR2nggzVkRKyEu1OYEXvvx9yKYOjQq9FQtH348he4VRENFMeY/xHuzGki4x+xdLFlS
 nLtNEoBHbil4xd6Ktx7lQqbGtgtiRCm6AgytQEMznNxBKECPZGW/EUFFaJ8HAErvejFxGk4FAjq1u
 gpS2y2+3tTTVpXz+nb2Rpnve55pQLjqEtGeffLiAosIGQPrbLl0XhFg2Xo8ueisnkt2PdVUc0sTN9
 Awmx0pzy2cU/F5NShDNYply34yI9bZP7H/ariYRZ3yc4M9sPe1zA5AgELtQOJ41XZMMY5jGgXk0dw
 D9fFuM1A==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqPO-0003nG-AM
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:00:49 +0000
Received: by mail-wm1-x341.google.com with SMTP id m1so1540139wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 01:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=i6eF9degw0aTd+4/dVJSO1fMB/yLMvBoJbOjltxcH7k=;
 b=vTx+7WRm/6gvhKb4qUbZPcnEq4JOM0D4gC3suHkbVGgBYY/SxVNlPR5ouxYJi4DKfZ
 /0KHpt32GG2nKJiVF9EJC1FKiI4ydM7HucJHFi5t0bv9XymUq5y3r4p0bLfD+udKbhtK
 BxJESvE5RioHwSkScQlcktCg6e9neT74hWMU5aLD5oB4UMyyC27VUhg8MMO8JiaY33De
 HgOsP483wuOUm++WKZqu2SDDhZu17AnRuZSm7fUTEbC9VSWJ+tZkZrv9eNB/+075jPXi
 qcQIebs8dVAt/WwRqSs3JVi2N7uaGtO6M2taAMoqhviF3lBxfAMOz6psqiQEkvn15KXL
 mYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=i6eF9degw0aTd+4/dVJSO1fMB/yLMvBoJbOjltxcH7k=;
 b=KBIiMyRTcdrRlhybPSyKxCT6OVN+wzR/gW3Cbc1CINXKmzEJn7dRubfQmrA5ReyvPg
 qvA+R61XtJehBB3LAPlbFwjUk5aOnfEXXUdox8jDs2j1HSVJJkgERiwlIzHXDCo0c6Gb
 9I3bGOKas4tHQ9lOmMrWdU1NsEMhJVNymhg6rG1QlPwqiaYqTSiMqFFPKm7WizKupnhV
 T5vg4uq6XWp4vPP229lkWRNx6RxlUmQJSXKH1YAhNoFyXvWpz6q8bNp8I5AEVzWSYKky
 Xv4IHiePUJWpD98C2h5n/fXsqOXfWyOfYobdL6Q5/gKH9T4NE2eNJq8zq1wm8DTlC3sR
 5wsw==
X-Gm-Message-State: AHQUAuZqzxxAx7xAsQtltd4yccX3dLSptFWmDX139dTQiux/DI80gGaN
 hene82/10aufUIi/ni2HfFgbM/VsxtyeMw==
X-Google-Smtp-Source: AHgI3Ia/KHLt062kojIKsrw5vz5nUDjBQGD+cxiRdsrg/kU8ZSGCkWHZhRxscU5GQyZ3qX786cLAkw==
X-Received: by 2002:a1c:a885:: with SMTP id r127mr2594453wme.74.1550048438497; 
 Wed, 13 Feb 2019 01:00:38 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id o2sm7966176wmo.33.2019.02.13.01.00.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 01:00:37 -0800 (PST)
Subject: Re: [PATCH v2 0/2] clk: meson: Add G12A AO Clock + Reset Controller
To: Jerome Brunet <jbrunet@baylibre.com>
References: <20190212162859.20743-1-narmstrong@baylibre.com>
 <98eaeaca26bc83db1a8d1f1362b56e3a32073bb3.camel@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <4585c4e6-1d43-ac1a-48ae-24b931fe7614@baylibre.com>
Date: Wed, 13 Feb 2019 10:00:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <98eaeaca26bc83db1a8d1f1362b56e3a32073bb3.camel@baylibre.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_040046_417405_715754EB 
X-CRM114-Status: GOOD (  18.06  )
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
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/02/2019 09:38, Jerome Brunet wrote:
> On Tue, 2019-02-12 at 17:28 +0100, Neil Armstrong wrote:
>> This patchset add support for the Amlogic G12A SoC family Always-On
>> clock and reset controller.
>>
>> This adds support for clocks on the Always-On domain like :
>> - Always-On UARTS & I2C Controllers
>> - CEC Controllers
>> - SARADC source and bus clock
>> - Infrared Decoder/Encoder bus clock
>> - USB 32K reference clock
>>
>> This also adds resets lines for :
>> - Always-On UARTS & I2C Controllers
>> - SARADC, Infrared Decoder/Encoder
>>
>> This patchset depends on the ("clk: meson: rework drivers dependencies")
>> from Jerome Brunet at [1].
>>
>> Changes from v1 at [2]:
>> - Moved unused bindings ID out of the dt-bindings header
>> - Added comment about CLK_IGNORE_UNUSED
>>
>> [1] https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com
>> [2] https://lkml.kernel.org/r/20190204091331.9298-1-narmstrong@baylibre.com
>>
>> Neil Armstrong (2):
>>   dt-bindings: clk: add G12A AO Clock and Reset Bindings
>>   clk: meson: Add G12A AO Clock + Reset Controller
> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 
>>
>>  .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
>>  drivers/clk/meson/Kconfig                     |   2 +
>>  drivers/clk/meson/Makefile                    |   2 +-
>>  drivers/clk/meson/g12a-aoclk.c                | 454 ++++++++++++++++++
>>  drivers/clk/meson/g12a-aoclk.h                |  34 ++
>>  include/dt-bindings/clock/g12a-aoclkc.h       |  34 ++
>>  include/dt-bindings/reset/g12a-aoclkc.h       |  18 +
>>  7 files changed, 544 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/clk/meson/g12a-aoclk.c
>>  create mode 100644 drivers/clk/meson/g12a-aoclk.h
>>  create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
>>  create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h
>>
> 
> 

Applied to next/drivers for Linux 5.1-rc1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
