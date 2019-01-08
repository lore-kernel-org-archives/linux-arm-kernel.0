Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2522C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7B6206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mO0V1gQZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5YjyzQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7B6206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s5QCO2je8ZkrJXI57UzRnf4MihojdPJmUlixsWTcBxg=; b=mO0V1gQZ4h4q2D
	TGEiiw+ZjPrG4HrfXHQcikk27WYnyVeSqp6kQLrI+/H5ovShWIsYQSbewROiKxfY5t04pCSGxH5Gs
	dcvqrEyFZg18dS9QCtDIheChVbKRwNdByI+Yu1KmOPvzdl0wiOstJofq5FOqXjjzTRqPxhv4rCo6Z
	yqToSN0Ckwquac3u/2TMKJhodfx+LNTghNrWd7821B/taxf+AsUAPWUDLnKdCz40+P/KQ7SjA/Fxd
	kgsXcOrLVMFP3wVRyBDxqfaZKNxPm+I23/gtXws8jN0FdMLFeZLvIJtatndK+PAPLIyx/8AP6CxF2
	znzqdWCpi+PDJbWTDxWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvrC-0008Nc-VA; Tue, 08 Jan 2019 18:12:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvrA-0008N9-IY
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 18:12:06 +0000
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C7947217D9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  8 Jan 2019 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546971123;
 bh=BQpvuW78ktDWmktZXBnmTMkVllcIV2yFx7pGbDIBTm8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=P5YjyzQChOhUWRz0H1anGqLNGN43Ty7AG+wIW5ZAJ6M4tqFDMwFhoRZ3X6UrlHUyQ
 UFCeh2LBRdf2OFz/+ZswDoONGWgxnH6JXcLwmoA8auEhKudn1Sg46G1QtDuRn/mrW5
 9fWqDi5hIHSYaTwAS5QcZw+/cMpgMK7Jil42TINc=
Received: by mail-qt1-f170.google.com with SMTP id u47so5406073qtj.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 10:12:03 -0800 (PST)
X-Gm-Message-State: AJcUukesFhiTy6MGDv3MK74lO9tJcgDyx8aDpmd6bkVaq13eyMp/wUi5
 1+Ce1jccMIK2+w/z0qYc0ueLatNRSoGG6qNiWA==
X-Google-Smtp-Source: ALg8bN6YNs9GINgxVL8lT6K2vS60Wb+xmgG/nWRtLVvJ3yvE9h/SiwmhRz5HmClmDwi/LtIiv0hjybsvIRF4K7sNMvE=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr2608181qta.38.1546971122996; 
 Tue, 08 Jan 2019 10:12:02 -0800 (PST)
MIME-Version: 1.0
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus>
 <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
 <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
 <6fd5ac6a-edb5-a600-3c10-b46a1c1d9906@ysoft.com>
 <f96952b2-7b19-5397-00a1-0fe9b5800dab@ysoft.com>
In-Reply-To: <f96952b2-7b19-5397-00a1-0fe9b5800dab@ysoft.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Jan 2019 12:11:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLRX2g1t-8YCqpZ5fd=-MyLPkgy88Gb=6ohEZbxWfS+LA@mail.gmail.com>
Message-ID: <CAL_JsqLRX2g1t-8YCqpZ5fd=-MyLPkgy88Gb=6ohEZbxWfS+LA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco,
 Hydra and Ursa boards
To: =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_101204_706552_333C43BA 
X-CRM114-Status: GOOD (  17.31  )
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

T24gVHVlLCBKYW4gOCwgMjAxOSBhdCAxMDowOSBBTSBWb2vDocSNIE1pY2hhbCA8TWljaGFsLlZv
a2FjQHlzb2Z0LmNvbT4gd3JvdGU6Cj4KPiBPbiA4LjEuMjAxOSAxNjowMCwgVm9rw6HEjSBNaWNo
YWwgd3JvdGU6Cj4gPiBPbiA4LjEuMjAxOSAxNTo1NiwgUm9iIEhlcnJpbmcgd3JvdGU6Cj4gPj4g
T24gVHVlLCBKYW4gOCwgMjAxOSBhdCA1OjQzIEFNIFZva8OhxI0gTWljaGFsIDxNaWNoYWwuVm9r
YWNAeXNvZnQuY29tPiB3cm90ZToKPiA+Pj4KPiA+Pj4gT24gMjkuMTIuMjAxOCAwMDoyNSwgUm9i
IEhlcnJpbmcgd3JvdGU6Cj4gPj4+PiBPbiBUdWUsIERlYyAxOCwgMjAxOCBhdCAwMjo0MjoxMVBN
ICswMDAwLCBWb2vDocSNIE1pY2hhbCB3cm90ZToKPiA+Pj4+PiBUaGVzZSBhcmUgaS5NWDZTL0RM
IGJhc2VkIFNCQ3MgZW1iZWRkZWQgaW4gdmFyaW91cyBZIFNvZnQgcHJvZHVjdHMuCj4gPj4+Pj4g
QWxsIHNoYXJlIHRoZSBzYW1lIGJvYXJkIGRlc2lnbiBidXQgaGF2ZSBzbGlnaHRseSBkaWZmZXJl
bnQgSFcKPiA+Pj4+PiBjb25maWd1cmF0aW9uLgo+ID4+Cj4gPj4gWy4uLl0KPiA+Pgo+ID4+Pj4+
ICsvIHsKPiA+Pj4+PiArICAgIG1vZGVsID0gIlkgU29mdCBJT1RBIERyYWNvIGkuTVg2U29sbyBi
b2FyZCI7Cj4gPj4+Pj4gKyAgICBjb21wYXRpYmxlID0gInlzb2Z0LGlteDZkbC15YXBwNC1kcmFj
byIsICJmc2wsaW14NmRsIjsKPiA+Pj4+Cj4gPj4+PiBBbGwgY29tcGF0aWJsZSBzdHJpbmdzIHNo
b3VsZCBiZSBkb2N1bWVudGVkLCBub3QganVzdCBTb0MgdmVuZG9yIGJvYXJkcy4KPiA+Pj4KPiA+
Pj4gT0ssIEkgd2lsbCBhZGQgYSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L3lzb2Z0LnlhbWwgZmlsZSBmb3IgdGhhdC4KPiA+Pgo+ID4+IEFjdHVhbGx5LCBpdCBzaG91bGQg
Z28gaW4gZnNsLnlhbWwuIFRoZSBmaWxlIGZvciBldmVyeSBib2FyZCB2ZW5kb3IgaXMKPiA+PiBn
b25lLiBpLk1YIHdhcyBwcmV0dHkgbXVjaCB0aGUgb25seSBwbGF0Zm9ybSBkb2luZyB0aGF0Lgo+
ID4KPiA+IE9LLCBJIHdpbGwgZG8gc28uIFRoYW5rIHlvdS4KPgo+IEkgYW0gc29ycnkgZm9yIHRo
ZSBub2lzZSBSb2IsIGJ1dCB5b3VyICJkdC1iaW5kaW5nczogYXJtOiBDb252ZXJ0IEZTTAo+IGJv
YXJkL3NvYyBiaW5kaW5ncyB0byBqc29uLXNjaGVtYSIgcGF0Y2ggaXMgbm90IGluIG1haW5saW5l
IHlldC4gU28KPiB0aGVyZSBpcyBubyBhcm0vZnNsLnlhbWwgZmlsZSB0byBhZGQgbXkgY29tcGF0
aWJsZSBzdHJpbmdzIGludG8uCj4KPiBOb3cgSSBkbyBub3Qga25vdyBob3cgdG8gcmVzcGluLiBT
aG91bGQgSSBzZW5kIHRoaXMgdXBkYXRlZCBkdHMvZHRzaQo+IHBhdGNoIGFzIHVzdWFsIGFuZCBj
cmVhdGUgYW5vdGhlciBwYXRjaCB3aXRoIHRoZSB5c29mdCBjb21wYXRpYmxlCj4gc3RyaW5ncyBh
Z2FpbnN0IHlvdXIgeWFtbC1iaW5kaW5ncy12MiBicmFuY2gsIHdoZXJlIHRoZSBmc2wueWFtbCBm
aWxlCj4gZXhpc3Q/IE9yIHNvbWV0aGluZyBlbHNlPwoKSHVtbSwgSSB0aG91Z2h0IFNoYXduIGhh
ZCBhcHBsaWVkIHRvIGhpcyB0cmVlIGFzIHRoZXJlIHdlcmUgc29tZSBjb25mbGljdHMuCgpTaGF3
biwgZG8geW91IG5lZWQgbWUgdG8gcmVzZW5kPwoKUm9iCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
