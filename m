Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB90C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:55:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891D620851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oCNDTCee";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EDPH/Ejq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891D620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CntbE50BfrX+/Ykhwgpouhy1l+PMEc71MAZo2JU0yEk=; b=oCNDTCeenmfghE
	DTZ/S7ZNV4MXMQrzmjt89S/t319aKFgTneC6eQ32VtDNY/nuIGMxFb2ZHxwJsj5FNz2eesxjlazm9
	DN/Ou0plGjjcBGwL8YLHusjUzJO18tNRxFRaqHqKy7yxMEmfjB7gR7V5tuCGAlwcTK/U3NAey3r35
	/7RtES0VXAJk1Wb229KcGscSkyqJGadTM0qhZyeilHKRxI2LACsAFzYxAqe5RkcQN4UaI3lO1Vnz4
	oDMLACK//F5Brscen/b+29STtTsgKjPxSzckojHQg0bV8GaXPPyn2dinAChaMoiS/ATTBlsAfGswB
	SnY6flsOk2CMx5M6TysA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkDlY-000377-Pg; Thu, 17 Jan 2019 19:55:52 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkDlU-000364-0E; Thu, 17 Jan 2019 19:55:49 +0000
Received: by mail-oi1-x244.google.com with SMTP id v6so7183220oif.2;
 Thu, 17 Jan 2019 11:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZwkThDduw8Zlsc/W56oIyWFtaj4xtkcsB85ZsOHlCOE=;
 b=EDPH/Ejq5/AmP/QHtC6e5X4k5utFnkrmxc8nj+1iTzjzJPGam1qPeW22tK/aRez9xZ
 rI5qj8ht2/VWHiEDgWZgXRwWg7uD6MO/ngHXCMsbshuZt82+YVIfsS5iw5Wtmet9G/VE
 J876FsQl3+hLhxYFSygV/5q7Fs6sr+hOT9+2J4Hf0nFb6H+WQplBdyjpw6b61GV/LdAA
 vWtdjH2NHhRDpP34VY+FX+CkI0wF9z+ZcrCQtZq9GzMcA/Kq6+MauXzpebBLNmMqmgxr
 vgnPBv4sIyTb+zePWrcbJ5qQNKL+NeRiFRNbgqc447KO6zGq4blo4zlI3XZhBcc3zvO7
 /BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZwkThDduw8Zlsc/W56oIyWFtaj4xtkcsB85ZsOHlCOE=;
 b=hyYKDv72e+iPYfrLupg5gJeVOIf7FzihX5aQVgY1b4aWwT3DDOAowyzLyDtM/H3mp0
 PxC5zadTfWvgITX4Om292zNqGQXC/39M2aJRpZcyM7BIA8AiE4nUIUVoWKd3+YqoQk6P
 vL4MNZcpA6r+z5Afnlmj9uBN3oEgg0olsYPscVcLTvNhyX6jx+Bz0C9z8BC70Ujm0Jpp
 FXfV29BuQkNmuXhyqFkKjzFaOt8uJGujSZ92q7+9AhNoFkv4YhQzSzhekrFYdR8F3hcb
 81yQTWr/HgfqZmkOMF5dJ9JBX5MAoci0yPzEuDE8CBVvjuFUZON89mOcAcwsTUt6s/El
 5SfQ==
X-Gm-Message-State: AJcUukdJyyVyYBYUR9A6bYTzFDm9jdLzIgu97IWJoNeP3vZwzcoCpPGc
 LOSaSHnwHRu5N1b6OFEH+iPasXGp9rNYoilfUI77iIEq
X-Google-Smtp-Source: ALg8bN4DH0NPXRv1Ck1PPpIld0ShPy/9PrlbAwoRF5cXEAvsHU8uGx+O6tuvIo+VTzlwWkxIE0K13lr06jOFThRTARI=
X-Received: by 2002:aca:3586:: with SMTP id c128mr343754oia.47.1547754945802; 
 Thu, 17 Jan 2019 11:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20181219002620.12138-1-khilman@baylibre.com>
 <20181219002620.12138-2-khilman@baylibre.com>
 <CAFBinCCbPbSQZeF1mzfBfLt+cJ0P=ajHznZM2prn600NO7G3sA@mail.gmail.com>
 <CAFBinCB393w2cBacB6c_79Xt22suWWfx5omEKmzBJx02vb3fKw@mail.gmail.com>
 <CACdvmAg3=GmcLOKJ33K6aGks7DRnityd4KiU30qwCb-YWz_EPA@mail.gmail.com>
 <CAFBinCD64ttcjq-aM_PJ4eAQcVmWk2+ptHUKznniPzALgKSOEA@mail.gmail.com>
 <CACdvmAhi92uLcBfzoJeqkC94np8t7wg7ivb3dz11cTvAO5D60w@mail.gmail.com>
In-Reply-To: <CACdvmAhi92uLcBfzoJeqkC94np8t7wg7ivb3dz11cTvAO5D60w@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 17 Jan 2019 20:55:34 +0100
Message-ID: <CAFBinCDfEFH_9pa_ATm-k5OaYMQwVfiGzN6d5dF5dMDGYbqHxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: add g12a x96 max board
To: Da Xue <da@lessconfused.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_115548_071143_7445AD6B 
X-CRM114-Status: UNSURE (   8.86  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 7:54 PM Da Xue <da@lessconfused.com> wrote:
>
> Hi,
>
> To be on the safe side, I would add the PCB revision number and WiFi module name.
my PCB states: Q5X2 V3.0 18393

> Most of the WiFi modules are from Fn link so simply denoting the AP6356S may be sufficient to distinguish future PCB revisions and wireless modules.
our .dtbs mostly don't care about the WiFi chip (because it can be
auto-detected using the SDIO ID).
however, Bluetooth support on these modules is different because a
different WiFi / Bluetooth combo chip manufacturer also means
different dt-bindings

regarding the .dts name so far we have:
- meson-g12a-x96-max.dts
and your suggestions:
- meson-g12a-x96-max-ap6356s.dts
- meson-g12a-x96-max-3.0-ap6356s.dts


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
