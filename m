Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D8C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:57:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CF520827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DSzK5QeD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpUQ6y2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CF520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/D8G4xXq/QvYBq9xuyIshKQpKxSqGCqESRBzLIqZnLw=; b=DSzK5QeDDbBxwe
	7VomoxL5CvM74oLXPp2BL+x9bUe++DeTktiboQf7COFcsSRzNCpqyEv4Gd2ZxVVhspfLAp/IIs2bA
	V5uyp0Zf2svOgTmOqhrV9+vPLZQN+Bf+QEUXqdjmg0OLvDShild14hv3iJr2IP9oHuLma4yNmNZdZ
	hrL/5YZyRjXzhTN12bKbnwS2bAHXCMRqhzzaqvNPry+VG4biIjxLkMn0yOYpORLCJhVd7conLiiUL
	QBytY60oTeIb5Uvq1LDqhtUW0h4H0v5yOsws+jDPyHuwxRoQz4GB6VLqmYI3jKIf96FhqgyGh2ZjR
	Av8NUD6SInUMlZlGBQpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggsoT-00087M-Q3; Tue, 08 Jan 2019 14:57:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggsoP-00086u-RH
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:57:03 +0000
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5316620883
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  8 Jan 2019 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546959421;
 bh=ermArLtvls1wgNieOXTgJ3O6kO3RHBy5b15Gt5oH92U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GpUQ6y2ek6S+NtAqULX25wso+Zx9r5VH60GM1xJvBV8IY1YsNv3HA2T364NsHU4QF
 tFBGvFCuhfp8K1jXv8hHujG+C4Un9VOLmz2puBM3s9oZ7xKAc/AdZj6HQ+E8n1njIO
 n0WNGeRKdxx3H1uziedWt+1L75JEF5jUAjqFEhD4=
Received: by mail-qt1-f172.google.com with SMTP id l12so4608369qtf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 06:57:01 -0800 (PST)
X-Gm-Message-State: AJcUukdFvz8e9THZ8GKJ6bp9q1hb2oaXS0VXYNQNzCLQjYu7dRTScJ5L
 yYYfUsaycpZPOM1oE7b1IDzIHQvWfKPPCZmwMg==
X-Google-Smtp-Source: ALg8bN4DTMPwuqi6GrKoOjHsoXa/AUhAr7ZBhJzYYrOtIh6+jPTcCnmr+EZ6HYQtZevVA99ege7oDhlPWDFgZ6rKDiE=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr1882981qtd.257.1546959420549; 
 Tue, 08 Jan 2019 06:57:00 -0800 (PST)
MIME-Version: 1.0
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus>
 <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
In-Reply-To: <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Jan 2019 08:56:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
Message-ID: <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco,
 Hydra and Ursa boards
To: =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_065701_906106_3097721A 
X-CRM114-Status: GOOD (  13.03  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gOCwgMjAxOSBhdCA1OjQzIEFNIFZva8OhxI0gTWljaGFsIDxNaWNoYWwuVm9r
YWNAeXNvZnQuY29tPiB3cm90ZToKPgo+IE9uIDI5LjEyLjIwMTggMDA6MjUsIFJvYiBIZXJyaW5n
IHdyb3RlOgo+ID4gT24gVHVlLCBEZWMgMTgsIDIwMTggYXQgMDI6NDI6MTFQTSArMDAwMCwgVm9r
w6HEjSBNaWNoYWwgd3JvdGU6Cj4gPj4gVGhlc2UgYXJlIGkuTVg2Uy9ETCBiYXNlZCBTQkNzIGVt
YmVkZGVkIGluIHZhcmlvdXMgWSBTb2Z0IHByb2R1Y3RzLgo+ID4+IEFsbCBzaGFyZSB0aGUgc2Ft
ZSBib2FyZCBkZXNpZ24gYnV0IGhhdmUgc2xpZ2h0bHkgZGlmZmVyZW50IEhXCj4gPj4gY29uZmln
dXJhdGlvbi4KClsuLi5dCgo+ID4+ICsvIHsKPiA+PiArICAgIG1vZGVsID0gIlkgU29mdCBJT1RB
IERyYWNvIGkuTVg2U29sbyBib2FyZCI7Cj4gPj4gKyAgICBjb21wYXRpYmxlID0gInlzb2Z0LGlt
eDZkbC15YXBwNC1kcmFjbyIsICJmc2wsaW14NmRsIjsKPiA+Cj4gPiBBbGwgY29tcGF0aWJsZSBz
dHJpbmdzIHNob3VsZCBiZSBkb2N1bWVudGVkLCBub3QganVzdCBTb0MgdmVuZG9yIGJvYXJkcy4K
Pgo+IE9LLCBJIHdpbGwgYWRkIGEgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS95c29mdC55YW1sIGZpbGUgZm9yIHRoYXQuCgpBY3R1YWxseSwgaXQgc2hvdWxkIGdvIGluIGZz
bC55YW1sLiBUaGUgZmlsZSBmb3IgZXZlcnkgYm9hcmQgdmVuZG9yIGlzCmdvbmUuIGkuTVggd2Fz
IHByZXR0eSBtdWNoIHRoZSBvbmx5IHBsYXRmb3JtIGRvaW5nIHRoYXQuCgpSb2IKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
