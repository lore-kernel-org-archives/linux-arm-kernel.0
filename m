Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2961AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:02:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AF820838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PfgLDRSC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9v8zyRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AF820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ue3DwYH/JEj3e5jgASHcGWb1jW5zk5MoGOyunWE4zOw=; b=PfgLDRSCav1/jy
	qGGVBaihKaR63cUMT1651vN2iQhEAAijpxlwYI4CIuiWgRlqAm3OCSaDWSPU12yJhaNNrmR0ABMoA
	1sc8DGEx0VBnfbsKBBFuXJG4znYKV/lTuO7uHZ/pUMZa4o1jJq+oUybOSjKDqldwvChGE0ISbb5HP
	FDMR+fcrzbhA5phG2Rno6Ywd+/7a3TTQ4QxRoynZzYrZuSnYgZVe3XJ+hEkRcioL+y7zVaW7ede3v
	bDiQULJGTbP908npdaYYlC4JBBuow0mMnvNLDgtXyD5xswxh7stY+JVpaRqKRum9sEsOaxojxq7Ae
	tVrfyzfrPKbZnq/k5X6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwxM2-0004Uz-CX; Thu, 21 Feb 2019 23:02:10 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwxLz-0004UR-Uh
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 23:02:09 +0000
Received: by mail-ed1-x542.google.com with SMTP id m35so219293ede.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 15:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NprLxaSLXIjf/D4KgK5zBo9zDu/x6coN+Jsn61LfvRU=;
 b=m9v8zyRf+NLUExNfRS0ILQJFoX8qlMkwNJHHMTGkCvlhlQeRzU9X/VxkNDXziFfmuz
 dLd3vyqL+BVJA1qQ+G3mXqfXvNxU7VHQUjhZy+lgcY0Uf/hlTAF8e7D5djD4XKrYBjLN
 //PnjUR4tREMtE1jdHGwANjCSPNibd8efnD9WHz1BJeEitu2NJbvoSOqdoTJJ+EZFPSb
 bSMslnZEim0GUPZaiugN2mNhZyGK7ezqh8UwIBp6d3Dv4wUrkmoSRv3fv0b3aZQJxjGT
 6QIAzP+SY46lss7wk7WKxlEwmKUhApqS0KHd+wEWUIvSdiUK2d5s43EfhwjhH4zNmZLG
 WWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NprLxaSLXIjf/D4KgK5zBo9zDu/x6coN+Jsn61LfvRU=;
 b=bDpsksDkBT/o0MtX9jvk2Uf2Jep9EegALgCVQImnTiDtSo/mR4ILwGt/3qGRpWOC+V
 bODjcqcwVtb7pVdtXjXivCGSMTeIZJQkxZXSEnt7yebOleEw9LMwD5qHs/LtUuxjrQjT
 pz1sEF0OvgSJSjzJJSReqYTG3QfhcACiCGoaeI8hJ+zzmqK/y1DjAugIEUxVluQQTGiw
 afBFL/IOJemCA4TMWNDaXFxTh9eVKGoMojNBtHZ0Ad2HAnZ8ytVFC9+qBix6KqR80JbL
 PE2Q6IN8891UdMC0wNrgpqeSnqBSMh7cV2M570XpY8Pznrn/n+WT5QCJZgl1X9LEhn1H
 KhyQ==
X-Gm-Message-State: AHQUAuZ4qHSgmQ/brxVLLF0bHUzfxXieq+D6FAFGhlhx/DJWfiVmtwcL
 g3NchRzF5xKSXyaZEQ2c0kuyaFXHy/hHxLjNzqI=
X-Google-Smtp-Source: AHgI3IZKjeppeJuq/RuCDi0K+UxvV5qAwzLOLz9bGthT4Fqmf9ds2Hm99L0CyI0PM8fUXrvNVgShWMK11CEitRk4VXk=
X-Received: by 2002:a17:906:f1d8:: with SMTP id
 gx24mr622251ejb.227.1550790125458; 
 Thu, 21 Feb 2019 15:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
 <20190220094841.11129-2-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190220094841.11129-2-thomas.petazzoni@bootlin.com>
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Thu, 21 Feb 2019 23:01:54 +0000
Message-ID: <CAEzXK1qhFrjtM=BdA2tXt_YR4DhD095vGVJPWa_4-=kOeG-FGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: pci-bridge-emul: Create per-bridge copy of
 register behavior
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_150207_990410_96DFB3E2 
X-CRM114-Status: GOOD (  10.90  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leigh Brown <leigh@solinno.co.uk>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGVzdGVkIHBhdGNoIGFnYWluc3QgVmFuaWxsYSBrZXJuZWxzIDQuMjAuMTEgYW5kIDUuMC1yYzcu
IEl0IGlzCndvcmtpbmcgcHJvcGVybHkgb24gYm90aCBrZXJuZWxzLgoKVGVzdGVkLWJ5OiBMdWlz
IE1lbmRlcyA8bHVpcy5wLm1lbmRlc0BnbWFpbC5jb20+CgpPbiBXZWQsIEZlYiAyMCwgMjAxOSBh
dCA5OjQ4IEFNIFRob21hcyBQZXRhenpvbmkKPHRob21hcy5wZXRhenpvbmlAYm9vdGxpbi5jb20+
IHdyb3RlOgo+Cj4gVGhlIGJlaGF2aW9yIG9mIHRoZSBkaWZmZXJlbnQgcmVnaXN0ZXJzIG9mIHRo
ZSBQQ0ktdG8tUENJIGJyaWRnZSBpcwo+IGN1cnJlbnRseSBlbmNvZGVkIGluIHR3byBnbG9iYWwg
YXJyYXlzLCBzaGFyZWQgYnkgYWxsIGluc3RhbmNlcyBvZgo+IFBDSS10by1QQ0kgYnJpZGdlIGVt
dWxhdGlvbi4KPgo+IEhvd2V2ZXIsIHdlIHdpbGwgbmVlZCB0byB0d2VhayB0aGUgYmVoYXZpb3Ig
b24gYSBwZXItYnJpZGdlIGJhc2lzLCB0bwo+IGFjY29tbW9kYXRlIGZvciBkaWZmZXJlbnQgY2Fw
YWJpbGl0aWVzIG9mIHRoZSBwbGF0Zm9ybXMgd2hlcmUgdGhpcwo+IGNvZGUgaXMgdXNlZC4gSW4g
cHJlcGFyYXRpb24gZm9yIHRoaXMsIHRoaXMgY29tbWl0IGNyZWF0ZXMgYQo+IHBlci1icmlkZ2Ug
Y29weSBvZiB0aGUgcmVnaXN0ZXIgYmVoYXZpb3IgYXJyYXlzLCBzbyB0aGF0IHRoZXkgY2FuCj4g
bGF0ZXIgYmUgdHdlYWtlZCBvbiBhIHBlci1icmlkZ2UgYmFzaXMuCj4KPiBSZXBvcnRlZC1ieTog
THXDrXMgTWVuZGVzIDxsdWlzLnAubWVuZGVzQGdtYWlsLmNvbT4KPiBSZXBvcnRlZC1ieTogTGVp
Z2ggQnJvd24gPGxlaWdoQHNvbGlubm8uY28udWs+Cj4gQ2M6IEx1w61zIE1lbmRlcyA8bHVpcy5w
Lm1lbmRlc0BnbWFpbC5jb20+Cj4gQ2M6IExlaWdoIEJyb3duIDxsZWlnaEBzb2xpbm5vLmNvLnVr
Pgo+IEZpeGVzOiAxZjA4NjczZWVmMTIzICgiUENJOiBtdmVidTogQ29udmVydCB0byBQQ0kgZW11
bGF0ZWQgYnJpZGdlIGNvbmZpZyBzcGFjZSIpCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFBldGF6
em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
