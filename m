Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C59C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E4C20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RPxBS/Cn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf+J9fHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E4C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oCqDD3gyWa9FQktfTHBn6LGBSvuH57XlsXgdirIwMgo=; b=RPxBS/Cn1YNOz7
	/ZJNZsr6QJLOtxV0aa2WI/vv+kllPZcwkdUVi9IXPpua+GevnMgyOL/zSib+DG1eeb64SH0o5PgCU
	p9h5hTMaI8CUOxIm+WpdMrQifESWAS7iBx0vz2JWGHndGHi4T8Wp3O2j0EQNjK9zsS+6B6qB6iAIf
	AfazipQGAFLjPELH30T2sjVa/a3eRCzmsJA6l5hhHx8qY9FQx+ZAvYb3DC9Voe5cItRKiX3EOGFOE
	+suiPVlrl+M1oAf2jtpHwHSPzDNvvIs1JDkOak3NVxvLqi63LfJjYQbgol9gFFnWSxvNfLj/C/Hhi
	kERbN5ViIMZUCRTgo9Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHbP-0002zc-SA; Tue, 04 Dec 2018 20:47:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHbN-0002xj-E3
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:47:30 +0000
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C202720879
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 20:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543956438;
 bh=zW2Y815AcZCf0dgxrKDpK82uj+u2eUm7+taADcR4F3g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Yf+J9fHKQNJIzKa+yJgOcllqPKrKvbcWv1eDibC9JJhJbRYjnxEF+U7y5S+quThyo
 qwA52cmoNPrk0nyzKPGt4ErP5dPvVymrOEyzoa3XTNx7Z678P0CyZAFb57TLXJmVTc
 9qVh2UWs2DsnbqtJnB+/smDFq5PtQ5v54SR9Znl4=
Received: by mail-qt1-f172.google.com with SMTP id v11so19774783qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 12:47:18 -0800 (PST)
X-Gm-Message-State: AA+aEWarVRAbx7lLsNzs4oNAJ2fMh/tq8nHvamNpZ78NRBRRfLZUZkIV
 rzsTRoOGpYzqfdONxDFRR22y1b+8z3E1K+meXQ==
X-Google-Smtp-Source: AFSGD/U0v5VvRDsJZq3H0UgVtV9j/5z3guMvn0taHNIw1h5mWpwY6201yjtXxc4p2L+Rpns8t0VbXdVR62ttHa6k9jk=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr20489067qtd.257.1543956437975; 
 Tue, 04 Dec 2018 12:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
 <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
In-Reply-To: <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 4 Dec 2018 14:47:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Em=7NeBCwkZyzmAfG8po-2E9SfO_Ukf0+h1CqH_3vxQ@mail.gmail.com>
Message-ID: <CAL_Jsq+Em=7NeBCwkZyzmAfG8po-2E9SfO_Ukf0+h1CqH_3vxQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add support of STM32 hwspinlock
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_124729_489148_A752509A 
X-CRM114-Status: GOOD (  12.92  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, devicetree@vger.kernel.org,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBOb3YgMzAsIDIwMTggYXQgODo0NSBBTSBCZW5qYW1pbiBHYWlnbmFyZAo8YmVuamFt
aW4uZ2FpZ25hcmRAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBMZSBtZXIuIDE0IG5vdi4gMjAxOCDD
oCAxMDowMCwgQmVuamFtaW4gR2FpZ25hcmQKPiA8YmVuamFtaW4uZ2FpZ25hcmRAbGluYXJvLm9y
Zz4gYSDDqWNyaXQgOgo+ID4KPiA+IFRoaXMgc2VyaWUgYWRkcyB0aGUgc3VwcG9ydCBvZiB0aGUg
aGFyZHdhcmUgc2VtYXBob3JlIGJsb2NrIGZvciBzdG0zMm1wMSBTb0MuCj4gPgo+ID4gdmVyc2lv
biA0Ogo+ID4gLSBhZGQgTGluYXJvIFNvQgo+Cj4gR2VudGxlIHBpbmcgb24gdGhpcyBzZXJpZXMK
Ck1heWJlIHlvdSB3YW50IHRvIGZpeCB0aGUgMC1kYXkgZXJyb3IgYW5kIHJlc2VuZC4KCkRvZXMg
YWRkaW5nIHRoZSBod2xvY2sgdG8gdGhlIGludGVycnVwdCBjb250cm9sbGVyIGRlcGVuZCBvbiB0
aGlzIHNlcmllcz8KClJvYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
