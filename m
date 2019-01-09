Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:22:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C89F206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ifuMbhFR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ITm+Bv5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C89F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CKwVIkYr6QiKaz5v8hbAQtsXw6v1+YrFz2+VxNqkXM8=; b=ifuMbhFRXDgXDn
	cCqhqp7gEBXF4XPYDkB45tAUaOhEQ2cV0aV2GopVLWjCL41QmtUrSSSt9Cu5I7ObPQLFCiqoj6JzY
	n1nsnsWYFzBcTAKuohhacPqT5X6CRWcSj7XXElCBEqQQef5ncXtpmVpnu0N4F6gybLbXyVilmmsSU
	+nYMWDLvKgjAV8wEXJT7JRNu9nd4S6ySuzAlXxWfFr1GqgqJVyX5XWkTfpIgmF9NlwhVLFn4OwJZC
	+wB2A1HJcaT4L8lbraPzV6JLFc2CgnM8LF6CrTcsa0BZXmm84cwcQBFXwMvz18ewWW7ZaysDWFY6n
	uxWCNwnSRujw91MgTS7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghMFC-0007G3-J6; Wed, 09 Jan 2019 22:22:38 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghMF7-0007E8-Ot; Wed, 09 Jan 2019 22:22:35 +0000
Received: by mail-oi1-x244.google.com with SMTP id y23so7679788oia.4;
 Wed, 09 Jan 2019 14:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/Pb4zmwAqNK8bxJNvAZVx+jbsqTTMUtyhRW+6I3cGaQ=;
 b=ITm+Bv5xnyNDE1P2q8/+ZwEo0qcux0lzYgTYtnliHVZvjlJYAlwo0SyxCBhrH2mzLy
 dVwZzsImCDQpdxFJ2I45feZqDqlrKOXlZCoTtHTGdSfTxOLv2DqI/9a9EMmhxaD8kFf6
 PiRcS1X/zI0CFTkCNwR6BuNKDXm9YytR0zWIwaEBBf+Lf2a8kpFmpML8KX3eJkk/N+zH
 +qD+QtZCD+rfFORfzpGczco/Swz+5tPi2uH3Mn74Lm6QcvGAH1wRy2QTHJAakiEyOGTK
 IDhLCXOIX9DUGF8nel3lEBRh3Y9vmx2w+tYZ6N94r/fyVtczyVRhVBCy4yjcBLcTFOvR
 Dl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/Pb4zmwAqNK8bxJNvAZVx+jbsqTTMUtyhRW+6I3cGaQ=;
 b=ISxLiDQb+CtHfyF+hbrY6FwNQOHXVyGKnw4jL6g8crVFrT9Ujmwuxxkm72arr28Fh8
 PQ+Nt8wz0/XFp6sOrOla/DaW/RRcg5T56PZFOEsXSGdXvJGhAtDu9qvWpmkFv629RGmm
 Dpsjm3PC5InV3NhzKfy053LxVyrN4exi8vIOz62d3rYIgjPl1XHue58LPtQLZIB7pVNF
 1HPp6xbta1IBn60S48rUrur5J9e/UDmeyZlc/QC9S+FUniuqc0pbhMTG93hH/o0bQeua
 2UXd55bXl6uI94GyoqpaeRxiqh0dN1wJ6s2QBk3y3cQNyjOz/mbQmRcsAJvsrsXB+XVr
 H87A==
X-Gm-Message-State: AJcUukc27UlGq0+VdVJaNqPw+DiAxlPq4Lg4SN5koA6FlhrcnjEa0rq4
 dYtdCm/XmU/Z4OrvSx+6mquwnPpJUv7qJUcjens=
X-Google-Smtp-Source: ALg8bN4d1mE1lHVXrpPE2JwmDUml36x95ILIh/Z/bupsnZMFqV7884sGqfrI3iuciMv8Ra2pjbdOOlgKuMwMKI913G4=
X-Received: by 2002:aca:4ace:: with SMTP id x197mr5261649oia.129.1547072552543; 
 Wed, 09 Jan 2019 14:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20181219002620.12138-1-khilman@baylibre.com>
 <20181219002620.12138-2-khilman@baylibre.com>
 <CAFBinCCbPbSQZeF1mzfBfLt+cJ0P=ajHznZM2prn600NO7G3sA@mail.gmail.com>
 <CAFBinCB393w2cBacB6c_79Xt22suWWfx5omEKmzBJx02vb3fKw@mail.gmail.com>
 <CACdvmAg3=GmcLOKJ33K6aGks7DRnityd4KiU30qwCb-YWz_EPA@mail.gmail.com>
In-Reply-To: <CACdvmAg3=GmcLOKJ33K6aGks7DRnityd4KiU30qwCb-YWz_EPA@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 9 Jan 2019 23:22:21 +0100
Message-ID: <CAFBinCD64ttcjq-aM_PJ4eAQcVmWk2+ptHUKznniPzALgKSOEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: add g12a x96 max board
To: Da Xue <da@lessconfused.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_142233_802793_6D4BB166 
X-CRM114-Status: UNSURE (   8.23  )
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

Hi,

On Wed, Jan 9, 2019 at 1:11 AM Da Xue <da@lessconfused.com> wrote:
>
> I would be careful about adding TV boxes from unknown manufacturers in China. The manufacturer can and will change part numbers willy nilly and cause a ton of confusion. They are assembled with the cheapest part at the time so the DDR, WiFi module, eMMC, and even PCB will change without warning.
this is why I sent an update with the actual hardware which was
available for testing at the time this patch written / tested.

do you have any suggestion how to add support for this device while
being prepare for future changes?


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
