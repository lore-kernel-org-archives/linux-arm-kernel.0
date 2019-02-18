Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF00C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:32:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41D6218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vm+yGB+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41D6218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9X4HHJnADSehYvoXDLLYTOHs5U8IQzhjRzX45qGUka8=; b=Vm+yGB+G8DCivO
	NgYK93y1BVwowiCgQAJQUvCtcHltRCkkGJgubUC4nRFafXjfevzjKam4ZiV+7kDc/6wm6q58wxZkn
	BOUuHtUvw/JK8ui/bzAiyGodO7q2HxTvIcDSFZybd7s8+ykDzkF0q1Vwb7gSvsIGR9Jwp5coOZS0U
	9J0Tw7Hl8IHo3nkVFIT7T5d6PfK2MwQO3O8AuNwfGeH1tjmwOTXgXhhVQqr7WJC6s77dWC5dc+z74
	f2olQpm16YyWLHHr5h1usWirFFA7OQwHcj0xDmfuYX1BIdwLpmEg4rUSCsh6AV4RqTarazMOAWds5
	ELvRvAqsMwLMgx8MlMTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvZep-0004AB-VU; Mon, 18 Feb 2019 03:31:51 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvZem-00049q-9T
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 03:31:50 +0000
Received: by mail-ed1-f65.google.com with SMTP id p27so5067730edc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 19:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y1jbZK2oK+T+9k9VdDasqi0vOffyrkQfUDkEzJRzB2w=;
 b=DacH5JOaI0YfZ0LfZTlk3RFljvaNKVsINZFj/2BnTQ95CbZzTgu32iuSuv7gati9dW
 EC3zW/OA8FnOG/GdS3PHeBXrzhVafesSA0hdDeHd4DPbL8f0xctAE/k6kvLsA5o8q+4L
 E1TvkHPVbsn9P96HC48VslPNre79bBmKJJ7SuZ0MnNClufIZ5ztnV9pLSFH1FSriOcy7
 HeHd/IPKebaap6w+XgWETRc0RtpWvbW7A4vVdZ31IW0CL92JaUa6049Qe5LS0HARKzfw
 uiuH0VefGfkYZZooLD0IhnzoCqur6//twSXSW2iYyJ6od2GxcYo304XgCwQEHRh3tvkx
 luPg==
X-Gm-Message-State: AHQUAuav/DwrSjE5cwEyHMBmyo6XHolGJ9z9IPR2DQC8ULHhNbGpiQHu
 yn0/m7nRyxZ0WscTLBH3TiFGPokowuU=
X-Google-Smtp-Source: AHgI3IZcV4b4+2x7pTS+0rnVrmDKCAiTc1ZbyYig8FwGtFC3r96K3MYFwDPHO0ht4ZfK+oHLTLPQcA==
X-Received: by 2002:a17:906:6c8f:: with SMTP id
 s15mr5766764ejr.133.1550460706066; 
 Sun, 17 Feb 2019 19:31:46 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51])
 by smtp.gmail.com with ESMTPSA id g24sm1714971edc.67.2019.02.17.19.31.45
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 19:31:45 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id q1so16700225wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 19:31:45 -0800 (PST)
X-Received: by 2002:adf:efc2:: with SMTP id i2mr14684795wrp.44.1550460704807; 
 Sun, 17 Feb 2019 19:31:44 -0800 (PST)
MIME-Version: 1.0
References: <641301f26ac895e39b15d62a2ba069b853ab5b09.1550178066.git.rask@formelder.dk>
In-Reply-To: <641301f26ac895e39b15d62a2ba069b853ab5b09.1550178066.git.rask@formelder.dk>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 18 Feb 2019 11:31:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v64u-3bei1X_P+bandmnPqvMrShEq_mniEzm4DdEn29CQw@mail.gmail.com>
Message-ID: <CAGb2v64u-3bei1X_P+bandmnPqvMrShEq_mniEzm4DdEn29CQw@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: Fix AXP806 dcdcb copy/paste bug
To: Rask Ingemann Lambertsen <rask@formelder.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_193148_330705_EBAEDEE7 
X-CRM114-Status: UNSURE (   9.77  )
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
Cc: Olliver Schinagl <oliver@schinagl.nl>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 5:24 AM Rask Ingemann Lambertsen
<rask@formelder.dk> wrote:
>
> An obvious copy/paste bug was introduced with the conversion to sybolic
> register masks. The result is contradictory output like this:
>
> vcc-dram: Bringing 1100000uV into 1450000-1450000uV
> vcc-dram: 1450 <--> 1550 mV at 1050 mV
>
> This patch fixes it:
>
> vcc-dram: 1450 <--> 1550 mV at 1500 mV
>
> Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>

Acked-by: Chen-Yu Tsai <wens@csie.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
