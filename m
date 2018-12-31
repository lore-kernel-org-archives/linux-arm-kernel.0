Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CE0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380F520828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LThrYruO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgowp8Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380F520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l/Z8ypDII38fZPVAikxOGVgAPPFPPK1NHhWnlEZafYY=; b=LThrYruOzXLHSU
	Y6ZIT/3cXGcae4MbzvQiD/2PxIcbxtYZWcrsbn2kmBscaSimYh5kuhRjJq2df7LkbYdWSn9fufYwI
	sPjHrzl+H1I3gU2oq6aIFgECP/Ay7w7xqUFg0NPCCPghwhZ8qTS9fTl3kd+p5V0w+i50wNpp3gLGh
	w7GBFOnujvMk22oLu5ofyy+EUXg9FGnBz5PQ7qCg7VG76HQCowbYSvt7Q5QdE0QgC9wgrSRxD11yF
	5E+9BIxpSU1B7eaNamok4Gvq2Jq7vpLsVjQi32G3ggxzJoxbcZbilwpPDzqjlvuS58a3BimU5UJqO
	/wufzuQRNyqwEO4UeCBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdxWa-0007PR-Vl; Mon, 31 Dec 2018 13:22:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdxWY-0007P7-0O
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 13:22:31 +0000
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C52E21783
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546262549;
 bh=SgtGQGygrDknb3zb9QF7SAu8yMjnCQvFcz0e+I9UV7w=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qgowp8TbjugfV6nKM9LiX6g7tiJ8G9XatRolEL/EKLfy77gR1WL3r2akXVK4l1Tpn
 CJLt0W/u2snPOXE+EAQTuTO/VZcTGxHDhl1MZRq/vjjGHln5CCrk11WyIvdWvobYZZ
 Y+VE77ufWzCwoZlL6JHxP86WnhFkFr5uMg7I/p3g=
Received: by mail-lf1-f51.google.com with SMTP id c16so18298203lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 05:22:28 -0800 (PST)
X-Gm-Message-State: AA+aEWaw7SWKpXCm6GcBncbmPGauLG1x3fdBtZJ2hf3iuLZEC4KAxqqV
 SoPOpHCfisdw6Nhulsx/NVBMmR00Sb87yxjNVBs=
X-Google-Smtp-Source: AFSGD/XQescy37sCegt46wGjXaHK6DW3kDaslrOBNrVOfIeY5k/m/xsqQLv1uqrZkNh0MGtp8SQLoKJpMUcHifkUzG0=
X-Received: by 2002:a19:10a4:: with SMTP id 36mr18217949lfq.60.1546262547132; 
 Mon, 31 Dec 2018 05:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-7-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228161819.18931-7-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 31 Dec 2018 14:22:16 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcksbbOLpRBpbq33e5FtOOBZXNZCa0wA=TCn5vCSfQH3w@mail.gmail.com>
Message-ID: <CAJKOXPcksbbOLpRBpbq33e5FtOOBZXNZCa0wA=TCn5vCSfQH3w@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: defconfig: s5pv210: Enable more drivers present
 on Samsung Aries
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_052230_303183_E5760990 
X-CRM114-Status: GOOD (  17.73  )
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
 xc-racer2@live.ca, linux@armlinux.org.uk, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyOCBEZWMgMjAxOCBhdCAxNzoxOCwgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoaXMgY29tbWl0IGVuYWJsZXMgZm9sbG93
aW5nIGRyaXZlcnM6Cj4gLSBpMmMgc3VwcG9ydCAodXNpbmcgczNjMjQxMCBkcml2ZXIpCj4gLSBz
NXAtanBlZwo+IC0gczVwLW1mYwo+IC0gZXh5bm9zIGRybSByb3RhdG9yCj4gLSBwd20gc3VwcG9y
dAo+IC0gcHdtIHZpYnJhdG9yCj4gLSBmaXhlZCByZWd1bGF0b3IKPiAtIHN5c2NvbiBwb3dlcm9m
Zgo+IC0gQXRtZWwgbWFYVG91Y2ggdG91Y2hzY3JlZW4KPiAtIEJyb2FkY29tIEJDTTQzMjkgYmx1
ZXRvb3RoIG92ZXIgdWFydDAKPiAtIGRtYSBkZXZpY2VzIChzbyB3ZSBjYW4gdXNlIHBsMzMwIGRt
YSBkcml2ZXIpCj4KPiBEaXNhYmxlIERFQlVHX0xMLiBJdCdzIGN1cnJlbnRseSBzZXQgdG8gdWFy
dDEsIGJ1dCBpZiB3ZSB3YW50IHRvIHVzZQo+ICBpdCBvbiBBcmllcywgd2Ugd291bGQgbmVlZCB0
byBzd2l0Y2ggdWFydDIsIHRvIGdldCBhbnkgbG9ncy4KPgo+IFNpZ25lZC1vZmYtYnk6IFBhd2XF
giBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBKb25hdGhhbiBCYWtrZXIgPHhjLXJhY2VyMkBsaXZlLmNhPgo+IC0tLQo+ICBhcmNoL2FybS9j
b25maWdzL3M1cHYyMTBfZGVmY29uZmlnIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL3M1cHYyMTBfZGVmY29uZmlnIGIvYXJj
aC9hcm0vY29uZmlncy9zNXB2MjEwX2RlZmNvbmZpZwo+IGluZGV4IGEwNzc1OTczNjlmMS4uOTUx
MTk2YmRmMDA4IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9kZWZjb25m
aWcKPiArKysgYi9hcmNoL2FybS9jb25maWdzL3M1cHYyMTBfZGVmY29uZmlnCj4gQEAgLTEsMjQg
KzEsMjQgQEAKPiAgQ09ORklHX1NZU1ZJUEM9eQo+ICBDT05GSUdfTk9fSFo9eQo+ICBDT05GSUdf
SElHSF9SRVNfVElNRVJTPXkKPiArQ09ORklHX1BSRUVNUFQ9eQoKVGhpcyBhbmQgZmV3IG90aGVy
IGxvb2sgbGlrZSBlZmZlY3Qgb2Ygc2F2ZWRlZmNvbmZpZy4gUGxlYXNlIHNwbGl0CnN1Y2ggY2hh
bmdlIHRvIHNlcGFyYXRlIGNvbW1pdCwgYmVmb3JlIGFkZGluZyBuZXcgZmVhdHVyZXMuCgpCZXN0
IHJlZ2FyZHMsCktyenlzenRvZgoKPiAgQ09ORklHX0NHUk9VUFM9eQo+ICBDT05GSUdfU1lTRlNf
REVQUkVDQVRFRD15Cj4gIENPTkZJR19TWVNGU19ERVBSRUNBVEVEX1YyPXkKPiAgQ09ORklHX0JM
S19ERVZfSU5JVFJEPXkKPiAgQ09ORklHX0tBTExTWU1TX0FMTD15Cj4gLUNPTkZJR19NT0RVTEVT
PXkKPiAtQ09ORklHX01PRFVMRV9VTkxPQUQ9eQo+IC0jIENPTkZJR19CTEtfREVWX0JTRyBpcyBu
b3Qgc2V0Cj4gLUNPTkZJR19QQVJUSVRJT05fQURWQU5DRUQ9eQo+IC1DT05GSUdfQlNEX0RJU0tM
QUJFTD15Cj4gLUNPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJT049eQo+ICBDT05GSUdfQVJDSF9T
NVBWMjEwPXkKPiAgQ09ORklHX1ZNU1BMSVRfMkc9eQo+IC1DT05GSUdfUFJFRU1QVD15Cj4gIENP
TkZJR19BUk1fQVBQRU5ERURfRFRCPXkKPiAgQ09ORklHX0NNRExJTkU9InJvb3Q9L2Rldi9yYW0w
IHJ3IHJhbWRpc2s9ODE5MiBpbml0cmQ9MHgyMDgwMDAwMCw4TSBjb25zb2xlPXR0eVNBQzEsMTE1
MjAwIGluaXQ9L2xpbnV4cmMiCj4gIENPTkZJR19WRlA9eQo+ICBDT05GSUdfTkVPTj15Cj4gK0NP
TkZJR19NT0RVTEVTPXkKPiArQ09ORklHX01PRFVMRV9VTkxPQUQ9eQo+ICsjIENPTkZJR19CTEtf
REVWX0JTRyBpcyBub3Qgc2V0Cj4gK0NPTkZJR19QQVJUSVRJT05fQURWQU5DRUQ9eQo+ICtDT05G
SUdfQlNEX0RJU0tMQUJFTD15Cj4gK0NPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJT049eQo+ICBD
T05GSUdfTkVUPXkKPiAgQ09ORklHX1BBQ0tFVD15Cj4gIENPTkZJR19VTklYPXkKPiBAQCAtMjcs
NiArMjcsMTEgQEAgQ09ORklHX0lQX1BOUD15Cj4gIENPTkZJR19JUF9QTlBfREhDUD15Cj4gIENP
TkZJR19JUF9QTlBfQk9PVFA9eQo+ICBDT05GSUdfSVBfUE5QX1JBUlA9eQo+ICtDT05GSUdfQlQ9
bQo+ICtDT05GSUdfQlRfUkZDT01NPXkKPiArQ09ORklHX0JUX0JORVA9eQo+ICtDT05GSUdfQlRf
SENJVUFSVD1tCj4gK0NPTkZJR19CVF9IQ0lVQVJUX0JDTT15Cj4gIENPTkZJR19DRkc4MDIxMT1t
Cj4gIENPTkZJR19NQUM4MDIxMT1tCj4gIENPTkZJR19VRVZFTlRfSEVMUEVSX1BBVEg9Ii9zYmlu
L2hvdHBsdWciCj4gQEAgLTQ0LDIxICs0OSwzNSBAQCBDT05GSUdfSU5QVVRfRVZERVY9eQo+ICBD
T05GSUdfS0VZQk9BUkRfR1BJTz15Cj4gICMgQ09ORklHX0lOUFVUX01PVVNFIGlzIG5vdCBzZXQK
PiAgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVOPXkKPiArQ09ORklHX1RPVUNIU0NSRUVOX0FUTUVM
X01YVD1tCj4gK0NPTkZJR19JTlBVVF9NSVNDPXkKPiArQ09ORklHX0lOUFVUX1BXTV9WSUJSQT1t
Cj4gIENPTkZJR19TRVJJQUxfODI1MD15Cj4gIENPTkZJR19TRVJJQUxfU0FNU1VORz15Cj4gIENP
TkZJR19TRVJJQUxfU0FNU1VOR19DT05TT0xFPXkKPiArQ09ORklHX1NFUklBTF9ERVZfQlVTPXkK
PiAgQ09ORklHX0hXX1JBTkRPTT15Cj4gIENPTkZJR19JMkNfR1BJTz15Cj4gK0NPTkZJR19JMkNf
UzNDMjQxMD15Cj4gK0NPTkZJR19QT1dFUl9SRVNFVD15Cj4gK0NPTkZJR19QT1dFUl9SRVNFVF9T
WVNDT05fUE9XRVJPRkY9eQo+ICBDT05GSUdfUE9XRVJfU1VQUExZPXkKPiAgQ09ORklHX0JBVFRF
UllfTUFYMTcwNDA9eQo+ICAjIENPTkZJR19IV01PTiBpcyBub3Qgc2V0Cj4gIENPTkZJR19NRkRf
TUFYODk5OD15Cj4gIENPTkZJR19SRUdVTEFUT1I9eQo+ICtDT05GSUdfUkVHVUxBVE9SX0ZJWEVE
X1ZPTFRBR0U9eQo+ICBDT05GSUdfUkVHVUxBVE9SX01BWDg5OTg9eQo+ICtDT05GSUdfTUVESUFf
U1VQUE9SVD1tCj4gK0NPTkZJR19NRURJQV9DQU1FUkFfU1VQUE9SVD15Cj4gK0NPTkZJR19WNExf
TUVNMk1FTV9EUklWRVJTPXkKPiArQ09ORklHX1ZJREVPX1NBTVNVTkdfUzVQX0pQRUc9bQo+ICtD
T05GSUdfVklERU9fU0FNU1VOR19TNVBfTUZDPW0KPiAgQ09ORklHX0RSTT15Cj4gIENPTkZJR19E
Uk1fRVhZTk9TPXkKPiAgQ09ORklHX0RSTV9FWFlOT1NfRklNRD15Cj4gIENPTkZJR19EUk1fRVhZ
Tk9TX0RQST15Cj4gK0NPTkZJR19EUk1fRVhZTk9TX1JPVEFUT1I9eQo+ICBDT05GSUdfVVNCPXkK
PiAgQ09ORklHX1VTQl9PVEc9eQo+ICBDT05GSUdfVVNCX0VIQ0lfSENEPXkKPiBAQCAtNzIsNiAr
OTEsOSBAQCBDT05GSUdfTU1DX1NESENJX1MzQz15Cj4gIENPTkZJR19NTUNfU0RIQ0lfUzNDX0RN
QT15Cj4gIENPTkZJR19SVENfQ0xBU1M9eQo+ICBDT05GSUdfUlRDX0RSVl9NQVg4OTk4PW0KPiAr
Q09ORklHX0RNQURFVklDRVM9eQo+ICtDT05GSUdfUFdNPXkKPiArQ09ORklHX1BXTV9TQU1TVU5H
PXkKPiAgQ09ORklHX1BIWV9TQU1TVU5HX1VTQjI9bQo+ICBDT05GSUdfUEhZX1M1UFYyMTBfVVNC
Mj15Cj4gIENPTkZJR19FWFQyX0ZTPXkKPiBAQCAtODcsNiArMTA5LDcgQEAgQ09ORklHX05MU19D
T0RFUEFHRV80Mzc9eQo+ICBDT05GSUdfTkxTX0FTQ0lJPXkKPiAgQ09ORklHX05MU19JU084ODU5
XzE9eQo+ICBDT05GSUdfTkxTX1VURjg9eQo+ICtDT05GSUdfQ1JDX0NDSVRUPXkKPiAgQ09ORklH
X0RFQlVHX0lORk89eQo+ICBDT05GSUdfTUFHSUNfU1lTUlE9eQo+ICBDT05GSUdfREVCVUdfS0VS
TkVMPXkKPiBAQCAtOTYsNyArMTE5LDMgQEAgQ09ORklHX0RFQlVHX1NQSU5MT0NLPXkKPiAgQ09O
RklHX0RFQlVHX01VVEVYRVM9eQo+ICBDT05GSUdfREVCVUdfQVRPTUlDX1NMRUVQPXkKPiAgQ09O
RklHX0RFQlVHX1VTRVI9eQo+IC1DT05GSUdfREVCVUdfTEw9eQo+IC1DT05GSUdfREVCVUdfUzND
X1VBUlQxPXkKPiAtQ09ORklHX0VBUkxZX1BSSU5USz15Cj4gLUNPTkZJR19DUkNfQ0NJVFQ9eQo+
IC0tCj4gMi4xNy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
