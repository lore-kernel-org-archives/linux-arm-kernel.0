Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A796C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:15:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD0E2192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MmFJEsNM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYQGDJKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD0E2192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FcMDPnztLb+wpOClh8GFkq3k/Y0Ct7hbTmVcm7lvR9E=; b=MmFJEsNMRvYdiO
	ot8/Ss2f4wTrRrtQdvRo7gfe/frV75g+6OLZBtqo0ar3KUClZDWGPHYgNbaTGDMC474FkiCTHfWJ7
	j6DxPAzKwPQ1M1ka7tDy0v1NbokOI6KX2Wf5dSCkoiLvESY2HOJCTFwtDgvLGZ35cFrlKyXkOxz98
	DXyGW0Kx6uGkts0qksGd2nALQtCdRCrdxDgP6A4ClBlGymCGNpSdGSkzsNHfvyqtI0YOHfyWdZsBJ
	4ueE+yC0xHSsq7pzmNjxmAR4kplPM13fpxJHnMUKeaaveaCCMp8HG2dE5QW4jkZQjEGgSc7Lc5o1V
	HtUKbWtg0mBAI/BmF0tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsWE4-0001BV-IH; Sat, 09 Feb 2019 17:15:36 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsWE1-0001B8-OP
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 17:15:35 +0000
Received: by mail-ot1-x336.google.com with SMTP id s5so11100084oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 09 Feb 2019 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9qChTi8SMBRLveg4fnNK/KJaekdRnZ4Y1/Qtmevu4po=;
 b=iYQGDJKIi6yDRqyzS8+OE/Kuyehsr0k9FGiuwPrhae7zCTglVdwQpBj49ixSZiIGUN
 2+6uq0/zR2rcklOcD/UGJdt21qSxl5Wyob4hz+84XgnWLoUTTxRQSnyUGaMouqXozo6l
 jZCoBcl90BOpNTdh4+4RwehQgX/5H20i47bfcmizyi0ZbvF0zAqV7U7MVKIFV95W8wdC
 uq3roS1P9PLuB7v4CIJFuVfPlaZpyhq/XTl7p6fU9YoQIv87WKYaIsWeVAnQhB/R8B04
 WRgQaN5iYFNNMKJ2SRonwQWJtjn7rvR/UYsgawYksQCH78QFo4bbKAfoc0RcebpBqyMz
 rB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9qChTi8SMBRLveg4fnNK/KJaekdRnZ4Y1/Qtmevu4po=;
 b=t5+If5oE3KhkrgXyU6J2aKkY5uHH0Pf6hUoH67Yc/Dq12SrA72D0YYSQGwG/8aiVWY
 wPXf10YMpVfFpUme01+sz7wxJiw+dShbfVy3eE6JzzmhqnkBm/0QTpeXQKbzHEaUEH0M
 nlfe2ClQG7J0bkpw7FZw9PpeTeikP7xdUtWfImCCvTEJuw4u5ouwxlRXm2SL5eYm1FrL
 mz95LQaJ9Y3lb5aM/YNh95oos7SDWqgSq3bwibWbQbiieGfOp4+pW9B/UnjfPIh5qMew
 hrAhC4W+8X/aSOHpmN0rzrPZUU+2lcE5vloqcge7wEmsY4qdkwbac0gqYvUyUq/gXzU1
 lSoA==
X-Gm-Message-State: AHQUAub5163WRUkH7ILOf5UMq2ix+A/6OaVlyDUYgYxptAwPq2WxwUgH
 HkippXjYiNBFxZ1mHxr2zyHGOENaHRWTsxKhgL4=
X-Google-Smtp-Source: AHgI3IaA970Ri472vY8MkUlG+2VTHxFxWhi9aTOtj7gH6nRmvJHl6WmbPWb4qjoave8CTBhtaeq3oXA0p56R+2NcVMI=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr11361589otl.196.1549732532189; 
 Sat, 09 Feb 2019 09:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20190207225211.GA17552@latitude>
 <CAOMZO5BH1Su=tKD8vV8+-i_0a_4fNDQKbk0q6DX5TZWYezeH9Q@mail.gmail.com>
 <20190209162449.GB2061@latitude>
In-Reply-To: <20190209162449.GB2061@latitude>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Feb 2019 15:15:20 -0200
Message-ID: <CAOMZO5DrtgQzjY7_9SCM_NKbKPxQyHBQNN+pmUPrqtFkARPdUg@mail.gmail.com>
Subject: Re: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock is
 disabled
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_091533_797409_CF2A6E8F 
X-CRM114-Status: GOOD (  12.25  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Michael Turquette <mturquette@baylibre.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU2F0LCBGZWIgOSwgMjAxOSBhdCAyOjI1IFBNIEpvbmF0aGFuIE5ldXNjaMOkZmVyCjxqLm5l
dXNjaGFlZmVyQGdteC5uZXQ+IHdyb3RlOgo+Cj4gT24gVGh1LCBGZWIgMDcsIDIwMTkgYXQgMTA6
NTA6MjhQTSAtMDIwMCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToKPiA+IE9uIFRodSwgRmViIDcsIDIw
MTkgYXQgODo1MiBQTSBKb25hdGhhbiBOZXVzY2jDpGZlcgo+IFsuLi5dCj4gPiA+IEkgdHJpZWQg
dG8gY29tcGFyZSB0aGUgQ0NNJ3MgY2xvY2tzIGJldHdlZW4gaS5NWDUwIGFuZCBpLk1YNTMsIGJ1
dAo+ID4gPiB1bmZvcnR1bmF0ZWx5LCB0aGUgaS5NWDUwIHJlZmVyZW5jZSBtYW51YWwgZG9lc24n
dCBoYXZlIHRoZSB0YWJsZSBjYWxsZWQKPiA+ID4gIk91dHB1dCBjbG9ja3MgZnJvbSBDQ00iLgo+
ID4KPiA+IFBsZWFzZSBjaGVjayBUYWJsZSA1LTEwLiBDQ01fQ0NHUjMgR2F0ZWQgQ2xvY2sgTWFw
cGluZyB0byBUYXJnZXQKPiA+IE1vZHVsZSBmcm9tIHRoZSBNWDUwIFJlZmVyZW5lIE1hbnVhbC4K
Pgo+IE9rLCB0aGUgdGFibGVzIHNob3c6Cj4KPiBGb3IgaS5NWDUwOgo+IFsxOjBdIDAgaXBnX2Ns
a19yb290ICAgIGVTREhDdjJfMQoKYW5kIGl0IGFsc28gc2hvd3MgdGhhdCBhaGJfY2xrX3Jvb3Qg
aXMgY29udHJvbGxlZCBieSB0aGVzZSBzYW1lIGJpdHMuCgpUaGF0J3Mgd2h5IEkgYWRkZWQgdGhl
IGFoYiBlbnRyeSBpbiBteSBzdWdnZXN0aW9uLgoKPiBbMzoyXSAxIGVzZGhjMV9jbGtfcm9vdCBl
U0RIQ3YyXzEKPgo+IEZvciBpLk1YNTM6Cj4gMeKAkzAgQ0cwIGVzZGhjMV9pcGdfaGNsazogYWZm
ZWN0cyBpcGdfY2xrIGFuZCBoY2xrIGlucHV0cyBvZiBFU0RFSEMtMSAoZXNkaGMxX2Nsa19lbmFi
bGUpCj4gM+KAkzIgQ0cxIGVzZGhjMV9wZXJjbGs6ICAgYWZmZWN0cyBpcGdfY2xrX3BlcmNsayAg
IGlucHV0ICBvZiBFU0RFSEMtMSAoZXNkaGMxX3NlcmlhbF9jbGtfZW5hYmxlKQo+Cj4gVGFibGUg
MTgtMyAoT3V0cHV0IGNsb2NrcyBmcm9tIENDTSkgaW4gdGhlIGlNWDUzUk0gc2hvd3MgdGhhdAo+
IEVTREhDdjItMSdzIGlwZ19jbGtfcGVyY2xrIGlzIGVzZGhjMV9jbGtfcm9vdCwgc28gdGhlIGNs
b2NrIHN0cnVjdHVyZQo+IGRvZXMgc2VlbSB0byBiZSB0aGUgc2FtZSBoZXJlLCBiZXR3ZWVuIGku
TVg1MCBhbmQgaS5NWDUz4oCmCgpUaGF0J3MgY29ycmVjdC4gVGhlIGVzZGhjIGNsb2NrcyBzZWVt
IHRvIGRpZmZlci4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
