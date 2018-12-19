Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E75EC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD00218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PG/xxlxM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfFb5K1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD00218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pY+s4fjcROfI4XH6DOzo5jmeSPHACSwyH2jtDdaWAeU=; b=PG/xxlxM4So5jf
	R5sfLEhBlW18zKuUVaoN1iSF5teEco58zjRFMf35Z8IR5oz+JkbsVrgod0v/UiV0A9UCO49dLDLpn
	YEVw66p4+s8HyyudXuT5C4ouU4oNjPvXaLGK5UHvJIKSWTZy1s1dFqnSXGT44kA63HEoMXsVH1FQp
	BSW2uapB88qdLS6Zs0wSnFWujejAzSpadMJyJ1/Qoby2hyTCg8UPxyikvGdEPpmvdU2KUGOY6zL+g
	GqIBflpK+DkSe74pFDC2XsUk7Kqky+Z+mV2CEpg6RiUJytCZbIaA2+jz2EP1fhDcaNi2ASf7FH15/
	Sb1epbQcpe2JkjMfZReg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZees-0001w8-LT; Wed, 19 Dec 2018 16:25:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeei-0000YO-Pe
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:25:12 +0000
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 24061218DA
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545236698;
 bh=ToLZrp4f+MWoAKXWfE3u0PBIjE7fElyAJL+tuW+N2fg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IfFb5K1mTnvg9fcl7xkP9cB01SU4QJEOzEBSy44yF2dOltjWYoiYNM8FuMLAZ7dbn
 TI9RtMK9XHVT9b6sgr3l7rRrdbfSlgUNDT6rQaLRS9RiClT1B8RTZEpxyBuyfyY36y
 manRr9YDXEC3bn6fYjRVOEQS/Hvy0tRK+A7WmOic=
Received: by mail-lf1-f42.google.com with SMTP id a16so15497787lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 08:24:58 -0800 (PST)
X-Gm-Message-State: AA+aEWYbddLg+m8QZ5N6pjmxratA8UaKWsCppdG8GgQhbvMAwbWTJoLO
 hq/2HxSTC0IoJ2l7VroOQj2sPJqcsclAeCh08z0=
X-Google-Smtp-Source: AFSGD/WbBkY6fbbtvOcginDxp+XpGUfEBoNEfzCOOju8eiMWJnsrHpMaO3zwGkpkxieOFartugGT3UIgFFZk5pYF1ak=
X-Received: by 2002:a19:660a:: with SMTP id a10mr14085124lfc.146.1545236696261; 
 Wed, 19 Dec 2018 08:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
 <20181219155704.15264-4-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181219155704.15264-4-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 19 Dec 2018 17:24:45 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdFSqsKswPHUFCRZ436yWX9evFzyAo75DNkU=fznppCAQ@mail.gmail.com>
Message-ID: <CAJKOXPdFSqsKswPHUFCRZ436yWX9evFzyAo75DNkU=fznppCAQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: s5pv210: Add node for exynos-rotator
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_082509_431241_8D518FFB 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 jy0922.shim@samsung.com, airlied@linux.ie,
 Seung Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
 robh+dt@kernel.org, kyungmin.park@samsung.com, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAxOSBEZWMgMjAxOCBhdCAxNzowNCwgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoaXMgY29tbWl0IGFkZHMgbm9kZSBmb3Ig
RXh5bm9zIFJvcmF0b3IgZGV2aWNlLAo+IHNvIGl0IGNhbiBiZSB1c2VkIG9uIGFsbCBzNXB2MjEw
IGJhc2VkIGRldmljZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5t
aWtvbGFqLmNobWllbEBnbWFpbC5jb20+Cj4gLS0tCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYy
MTAuZHRzaSB8IDkgKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykK
ClBhdGNoIGxvb2tzIGdvb2QgYnV0IGl0IGlzIHRvbyBjbG9zZSB0byBtZXJnZSB3aW5kb3cgc28g
SSB3b24ndCBiZQphYmxlIHRvIHNlbmQgaXQgZnVydGhlci4gSSdsbCBwaWNrIGl0IHVwIGZvciBu
ZXh0IGN5Y2xlLCBhZnRlciB0aGlzCm1lcmdlIHdpbmRvdy4KCkJlc3QgcmVnYXJkcywKS3J6eXN6
dG9mCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
