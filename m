Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E0C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C9B2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AVAZwYn/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCO16ajq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C9B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kLsrT3BsIbF+kYvcuSMA2sGok9TAuZJz75CLEHov85A=; b=AVAZwYn/9GTjk1
	2SZUqh5i20irVDYAJ1b8Qymd10qedGvblpNZvQv7KzvS+/UCX9Bq3NjK9A7KXboWt1Dijyn3a1sjV
	qNNPFvdVyWig0C5JN2x8vTi8/Rn+0hf2igzO0kcqKaVqRFQWAt5G8sTmD4yn6CyHhaAoH+jTCW+SA
	MNonkvzedzFAQfcW9uzosQHmI3oPQihO95Tk1mAuSX6ktjLaFu4LaNqYnl1eKcchQ5cG4MiYUyQ3u
	X6u1t5DnlHC/vYOUOovfyejXHj1sKCMITPO0swMkMKt+GXkN/iDL6zOt1wF3d3/hXszUCXwUQnMN5
	uyU9aD/j2Bf4nROJVjUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRyG-0008HX-Fb; Tue, 29 Jan 2019 11:54:28 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRyD-0008HE-8g
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:54:26 +0000
Received: by mail-ot1-x32e.google.com with SMTP id k98so17620924otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 03:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eUDJPzJmUcC5k5nPZ7aRNKhFFZ0kgXfliFV7Lb7YUBs=;
 b=gCO16ajqe+1st5N1lmDBzQDm1vKfBFO8fsS+Qlg4UqXMQRvgKtWU1USK+/PYGo5a11
 eCmwJYvxLZf9dikZksJGn4SiP4MwKyw9AP981WVI3Dtq1lMSP5h2N84nL7yEY9rkegcM
 V8m3442MmFGc8nV+6K0NC8cLrFFEaIQbDoXlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eUDJPzJmUcC5k5nPZ7aRNKhFFZ0kgXfliFV7Lb7YUBs=;
 b=d6ZoY/ldENhkMloHepvWJm7j9t39CyZKJB9ZUmnUj0AhFFDVIukSM1R5OYjjw42Vw7
 AtJRqGrIlbIJ2XbvyiSn2siuvdhCKRzBxc+PfeDBjEDY08S1pD6o8NHr//RMCjOtFtJP
 /ZhGkdj5P8gvoJSQGYCQSi3Mprv8iaJEV06X5hv/yu+JzGQM57gWYyOOApizTAmwxANW
 0WYpBPCyACXw5OVbrWzLRS5F2N+tunrZlortgQD1mqXQ2fFYiy04Zh0bIU50zRhXhpH1
 Jt4uWq66V46p5tU0hToGhoZSdiAozKQ7mhkhn3EIafNoMr1kni1uCG/rt6OU78RiQjCy
 b/WQ==
X-Gm-Message-State: AJcUukfbL+1LOm1hKEvtrONKmq2MhrPB72p47Aqp4XydNmKjA9P+VCnN
 2FqCKJ9oKJ0nNWhe8a+t9BJmLukYb5g70SF8g92Q1Q==
X-Google-Smtp-Source: ALg8bN780PtRjwCdzaurxtpBZc/QsC9o/lLyTNd3gzyE36H9FpYJ5lanyiEammZGVO/daahjzcdCeenJclaSBDX8u80=
X-Received: by 2002:a9d:5a81:: with SMTP id w1mr20197697oth.317.1548762863953; 
 Tue, 29 Jan 2019 03:54:23 -0800 (PST)
MIME-Version: 1.0
References: <87va27n2l8.fsf@linaro.org>
 <20190129114609.GA25983@lakrids.cambridge.arm.com>
In-Reply-To: <20190129114609.GA25983@lakrids.cambridge.arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 11:54:13 +0000
Message-ID: <CAFEAcA-_ShbUthqPSPgEPmV0EeRUO85n=sC-+76gRAH830co_g@mail.gmail.com>
Subject: Re: Kernel boot regression with PAuth and aarch64-softmmu -cpu max
 and el2 enabled
To: Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_035425_310869_4ED5F52B 
X-CRM114-Status: UNSURE (   9.83  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 "open list:ARM" <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyOSBKYW4gMjAxOSBhdCAxMTo0NiwgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRA
YXJtLmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBKYW4gMjksIDIwMTkgYXQgMTE6MDg6MTlBTSArMDAw
MCwgQWxleCBCZW5uw6llIHdyb3RlOgo+ID4gVGhlIC1jcHUgbWF4IGVuYWJsZWQgYSBjb3J0ZXgt
YTU3ICsgd2hhdGV2ZXIgZXh0cmEgZmVhdHVyZXMgd2UndmUKPiA+IGVuYWJsZWQgaW4gUUVNVSBz
byBmYXIuIEl0IHdvbid0IG1hdGNoIGFueSAicmVhbCIgQ1BVIGJ1dCBpdCBzaG91bGQgYmUKPiA+
IGFyY2hpdGVjdHVyYWxseSBjb3JyZWN0IGluIHNvIGZhciB3ZSBpbXBsZW1lbnQgcHJlcmVxdWlz
aXRlIGZlYXR1cmVzIGZvcgo+ID4gYW55IGdpdmVuIGZlYXR1cmUuIFRoZSBjcHVpZCBmZWF0dXJl
IGJpdHMgc2hvdWxkIGFsc28gYmUgY29ycmVjdCBhcyB3ZQo+ID4gdGVzdCB0aGVtIGludGVybmFs
bHkgaW4gUUVNVSB0byBlbmFibGUgZmVhdHVyZXMuCj4KPiBKdXN0IHRvIGNoZWNrLCBkb2VzIHRo
aXMgZW5hYmxlIFZIRT8KCkl0IGRvZXMgbm90LiAoV2UgaGF2ZSBubyBpbXBsZW1lbnRhdGlvbiBv
ZiBWSEUgeWV0IC0tIGFzIGFuZCB3aGVuCndlIGRvIGltcGxlbWVudCB0aGF0ICItY3B1IG1heCIg
d2lsbCB0dXJuIGl0IG9uLCBidXQgdG9kYXkgaXQgZG9lc24ndC4pCgp0aGFua3MKLS0gUE1NCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
