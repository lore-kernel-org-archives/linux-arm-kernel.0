Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0C3C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:48:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B322084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHsfZAIi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uM6MvBg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B322084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:In-reply-to:Subject:To:
	From:References:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=imsNweWSXCsbrVNxEMfJM/ptvUpJR6lB3QNKjobTyLQ=; b=eHsfZAIiivToj7yeG718Tjk2w
	x4tb5tooYlJ2AE7YT66hPQuIstjOozCLx3oqbH4miFKia2/G1X0dRBHpHfsFs1NUGw8ApuZbKelVV
	7Nin8A8uNc7N8oqfgH98C57uUoaFJeoZd1dKXGejM0fvq5LLsjfqcULWiYkLmm+uqt7a1Dy38iwc2
	vjIYqB9v/DfYyMtsfQss5mZ+BiZkaEuXx0Iw9o4g1YZjCiEt6QrNGbuZqcag9/LCh86x2TsjTdAj0
	GYpxf8vFMXfC+y/4xvXpgo57ZXIGO+O4iKVgjLHfzc84Ocj3U0iwMrXQcqSeHKAn6NAmRc79nv5Mf
	+1l4utiUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glriz-0007GE-DI; Tue, 22 Jan 2019 08:48:01 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glrir-0007D0-1u
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 08:47:57 +0000
Received: by mail-wm1-x341.google.com with SMTP id p6so13264474wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 00:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=kZr0fYXLTDuQhA7Idwn8AXJc8cbOUQt42CeU5kkGDzM=;
 b=uM6MvBg20Qq29jwM8GsPMKR9cmQ2IwbVjzJWQRJbIKtfHk/YMlI/y9l2jhdRxNrUqC
 W8DULMM40djroBFBgxiSzwKtAEHM3HMJC3JaL45AS3w2xxCzGUv3A0oifxCuWiLK2Lmv
 Rvq1fZlE4RVqfoKaWZSXhGUa8dkkSF1pNCxqqf/S4UrRR+XJPeSXF3ydYKeZFbNLph85
 cUMAIK23+V846EyJbzly4lQp24CGWg94vAIqxxM9qSZUqGLkiBdpXyblmiQnwdRXgNwl
 WhZ1vvWDD8hZ3zhq1Xn2kHiR1ojSw3FvHROCgcNMjoRBKCToJG6N9tB/J2FynqZWpg8o
 crtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=kZr0fYXLTDuQhA7Idwn8AXJc8cbOUQt42CeU5kkGDzM=;
 b=ZiCkpaw+kWVycJbgSBgoBXcD8lEZM7J4JhPvn9y9fIr+VxeqRTbGhT7xsThmzWeIZq
 ipHBvau/49tI5sIdc8ys54rZkPzemenE8zmopFJ5kBNw47hg6uC5yImn/gbYg5GNpSDK
 zYk0z63nvsLkJneV1FUIw/U42nMTgjlxhKkk+5cXBG9hgFMGXYrhVDqIm31Z6197URG+
 3p2vwGhZFKSQayUHp8KxO/ofBRRnZtpyM7apbNh4H2IFFLliH2gAQ17h1hnexPPAxodK
 zplRd75g4zxGiF75ao+4LPcZybFPzQN701bsRBcoRrpIPl8GGFg+Tu101ES5+vduTn2Q
 l6BA==
X-Gm-Message-State: AJcUuke+nvXOyiwz07wvPv7Qolrlcp9o8tiEW+EHqqcis9W/xJ254da6
 5vhsnCErOwX16VJs+hveMO4xSGvOTmNVwy9UkKw=
X-Google-Smtp-Source: ALg8bN4hP9cUm8TfDSALBx3GgvgF7ZFeOYtqq7C86ZxIP4jA64gAuD4khKmkql26XdrLqVWmVWmNRA==
X-Received: by 2002:a1c:13d1:: with SMTP id 200mr2654672wmt.4.1548146870859;
 Tue, 22 Jan 2019 00:47:50 -0800 (PST)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id f191sm9370369wmg.12.2019.01.22.00.47.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 00:47:50 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190121171019.GA2903@bogus> <86imyhapl9.fsf@baylibre.com>
 <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
Date: Tue, 22 Jan 2019 09:47:48 +0100
Message-ID: <86imyh13kb.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_004753_160643_7F919C2C 
X-CRM114-Status: GOOD (  15.88  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Mon 21 Jan 2019 at 18:44, Sean Wang wrote:

> On Mon, Jan 21, 2019 at 9:29 AM Loys Ollivier <lollivier@baylibre.com> 
> wrote:
>>
>>
>> On Mon 21 Jan 2019 at 17:10, Rob Herring wrote:
>>
>> > On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
>> >> Add binding for Mediatek-based GNSS receivers.
>> >>
>> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> >> ---
>> >>
>> >> v2:
>> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>> >> Moved current-speed as an optional propertie.
>> >> Removed the status line in the example.
>> >> Added "mediatek,mt3339" compatible.
>> >>
>> >>  .../devicetree/bindings/gnss/mediatek.txt          | 39
>> >>  ++++++++++++++++++++++
>> >>  1 file changed, 39 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>> >>
>> >
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> Thanks Rob,
>> If there are no objections by others, I'll stop sending these two patch
>> (1/4 and 2/4) and reference any new patch serie for 3 and 4 as depending
>> on those two.
>>
>
> Hi Loys,
>
> Thanks for adding the first GPS device driver. It's really nice to see
> more device drivers added to upstream support.
>
Hi Sean,

Glad to know you're supporting this initiative.

> Do you mind send the series again with Cc linux-mediatek@lists.infradead.org 
> ?
>
The series already has linux-mediatek@lists.infradead.org in Cc. Does it
need a resend ?

> Sean
>
>> --
>> -L
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek


-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
