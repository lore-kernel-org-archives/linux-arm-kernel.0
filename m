Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B46C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:44:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD74206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OYH5Xmce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD74206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j/+N2RkIwgV1z3vDVCDmgBmbsy/iQkjzbyeGfF6dMjQ=; b=OYH5XmcenaJc4i
	ApwdUVh7YlCI4ezCeWQl2lWajSu6z1Xi8pEfybALYfS0ZwGRerihMp+Vi0pLGYHa7B8c09LSbO/G2
	A9b937GLSNttcu3gM7TtnX8SL3oQeIBqGx8yHFqIKDKreedAbhDgcMwInJ3Zcslk5lx+2bhroicIT
	Vj+g4xd7yU/SNsfmVbDDCmjZdDuKZLVTh9mY+oViMKW0FNDN9TsmjrzAoL1snyydMcDQGffFwEcJp
	FzzI6+vC+ZUvytguZiD0Ab938RJT2R0M7xslUup8fhbKZNcITo/DknBvW/dk1rshaFalJWeaa0fiq
	d+MX1Na4HfWTGcaVBD7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYHjr-0001bi-Nk; Sat, 15 Dec 2018 21:44:47 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYHjo-0001bF-7c
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 21:44:45 +0000
Received: from oxbsltgw08.schlund.de ([212.227.220.152]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5max-1hVyym2lQ3-017Fkd; Sat, 15 Dec 2018 22:44:27 +0100
Date: Sat, 15 Dec 2018 22:44:25 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Olof Johansson <olof@lixom.net>, Horia Geanta <horia.geanta@nxp.com>
Message-ID: <1541367377.58314.1544910265605@email.ionos.de>
In-Reply-To: <20181213064803.kd7p7fzsegu6nhnl@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
 <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20181213064803.kd7p7fzsegu6nhnl@localhost>
Subject: Re: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:CXHA/4H+L35AWB0iF35FI+uoDYiE7M6zREdFHgDx/A1YQ1kFPpn
 2xz7ih7E0z0mwKIKXuhnzRvm0sIsYJNVWg4vNHYZv3XG/E8kJoypxmjvx8zc+6zWG0GKTvY
 uE+l2Lga0xQKgxrPuCQHqz66U1PG1gEEozSUZ+iUgef0JfvJYKCpaSBg/5MVXDf+oq4B18n
 obPWQq0dxqqCWA0Zb5yog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RwBoitGoNXk=:FAnutHj56fy5c0oKCE2Nmz
 BFJKTmaVPREr+B64XW7p7RF4xHYQ2lQfhdyuNZLa2/Gdn/rab3+ozqIBmxsbtf2XDh2Z+UFjM
 KTF348GK6DCKRlLRxV16AKCXApvOCDRJ/Fa7e6XCRM9YSrdcWeS9vrA5q9QB1Z+U9rz9S0ibT
 SIZtNKeuPy6Hpql+uCM509GWz0PYUeadqP/ZsRxxWj+18s6UE/N65EWobz3VBszw+OViwbr7A
 H5yvBYFThPh9t6pSApLJPTvpL+miwTKgxMg5djyUZBxW/Ij+7LtbGh8Yau95nor+OgrkDzYRg
 lvNxR4pu3nSCNtyC3wb33xeS7NN844LcEA8NKMaakurSbpEDECYSrwsjETs9o9hOfIS3lYh/x
 UKsyHf9TNsSmS3pzOHcKOVVLBEqcinjmPZzOSAJM//pO1Z5tyvdRPTL9LBPrXNvcbbvTpA8XY
 E3IVYtsLIA/dJu8Fm15cGjtBeZjyfVuLTtj0oCp3yEztqoxD0LiQa/JI7hSVjpIDpnO3E4Arv
 rgX6nuho5vkONGIoWXmoReHVrv19BbOFO/l7UaWl7LxwZIX96p43yqhdp4Wrxx81qbma4SKy+
 WKxgOVTXkDXOdyik7itlr85axg6r73SMx07UQlhp+s9ZRGZqNum012qayHtifHBiiThNE+Hbt
 tl2N3Oe3dGru5ghWpbqlAs1tU0l2fopfNcOWJzwjJdocKAXMJ9KxhvwrL9JHHo6eEUQ/Ut0sS
 GlCRAIIsYcfZ6fG7/4/36nz5eQVpAGzX5Pu+ebY9au4A+CZ8ilJiA37hg7U=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_134444_576699_1D9688D4 
X-CRM114-Status: GOOD (  13.20  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, arm-soc <arm@kernel.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, LKML <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgo+IE9sb2YgSm9oYW5zc29uIDxvbG9mQGxpeG9tLm5ldD4gaGF0IGFtIDEzLiBEZXplbWJl
ciAyMDE4IHVtIDA3OjQ4IGdlc2NocmllYmVuOgo+IAo+IAo+IE9uIEZyaSwgTm92IDA5LCAyMDE4
IGF0IDA2OjA1OjI0QU0gKzAwMDAsIEhvcmlhIEdlYW50YSB3cm90ZToKPiA+IE9uIDExLzkvMjAx
OCAzOjExIEFNLCBNYXJjIEdvbnphbGV6IHdyb3RlOgo+ID4gPiBDb21taXQgZTgzNDJjYzc5NTRl
ICgiZW5hYmxlIENBQU0gY3J5cHRvIGVuZ2luZSBvbiBRb3JJUSBEUEFBMiBTb0NzIikKPiA+ID4g
ZW5hYmxlZCBDUllQVE9fREVWX0ZTTF9EUEFBMl9DQUFNLCB3aGljaCBkZXBlbmRzIG9uIEZTTF9N
Q19EUElPLAo+ID4gPiB3aGljaCBpcyBub3Qgc2V0LiBFbmFibGUgRlNMX01DX0JVUywgYW5kIGJ1
aWxkIEZTTF9NQ19EUElPIGFuZAo+ID4gPiBDUllQVE9fREVWX0ZTTF9EUEFBMl9DQUFNIGFzIG1v
ZHVsZXMuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEdvbnphbGV6IDxtYXJjLncu
Z29uemFsZXpAZnJlZS5mcj4KPiA+IFJldmlld2VkLWJ5OiBIb3JpYSBHZWFudMSDIDxob3JpYS5n
ZWFudGFAbnhwLmNvbT4KPiAKPiBJIGhhZCB0byByZWRvIHRoaXMgb25lLCBhbmQgd2hlbiBJIGRp
ZCBJIG5vdGljZWQgdGhhdCB0aGVyZSdzIGFsc28gYW4gZXRoZXJuZXQKPiBkcml2ZXIuIFNob3Vs
ZCB0aGF0IGJlIGVuYWJsZWQgYXMgd2VsbD8KPiAKCnRoaXMgcGF0Y2ggaW4gbmV4dC0yMDE4MTIx
NCBicmVha3MgIm1ha2UgbW9kdWxlc19pbnN0YWxsIiBmb3IgYXJtNjQvZGVmY29uZmlnIG9uIG15
IFVidW50dSBtYWNoaW5lOgoKREVQTU9EICA0LjIwLjAtcmM2LW5leHQtMjAxODEyMTQKZGVwbW9k
OiBFUlJPUjogRm91bmQgNiBtb2R1bGVzIGluIGRlcGVuZGVuY3kgY3ljbGVzIQpkZXBtb2Q6IEVS
Uk9SOiBDeWNsZSBkZXRlY3RlZDogY2FhbWFsZ19kZXNjIC0+IGRwYWEyX2NhYW0gLT4gYXV0aGVu
YwpkZXBtb2Q6IEVSUk9SOiBDeWNsZSBkZXRlY3RlZDogY2FhbWFsZ19kZXNjIC0+IGRwYWEyX2Nh
YW0gLT4gZnNsX21jX2RwaW8KZGVwbW9kOiBFUlJPUjogQ3ljbGUgZGV0ZWN0ZWQ6IGRwYWEyX2Nh
YW0gLT4gY2FhbWhhc2hfZGVzYyAtPiBkcGFhMl9jYWFtCmRlcG1vZDogRVJST1I6IEN5Y2xlIGRl
dGVjdGVkOiBjYWFtYWxnX2Rlc2MgLT4gZHBhYTJfY2FhbSAtPiBjYWFtaGFzaF9kZXNjIC0+IGVy
cm9yCmRlcG1vZDogRVJST1I6IEN5Y2xlIGRldGVjdGVkOiBjYWFtYWxnX2Rlc2MgLT4gZHBhYTJf
Y2FhbSAtPiBjYWFtaGFzaF9kZXNjIC0+IGNhYW1hbGdfZGVzYwoKQWZ0ZXIgcmV2ZXJ0aW5nIG9m
IHRoaXMgcGF0Y2ggdGhlIGlzc3VlIGRpc2FwcGVhcmVkLgoKU3RlZmFuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
