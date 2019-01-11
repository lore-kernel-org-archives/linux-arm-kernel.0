Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCCCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:46:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAD22177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="htg6AiRt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml7dfCHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAD22177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2PLSTYxdxEzyRwXHBrqmuw+8yHIsTgSNgedJA5lPDts=; b=htg6AiRtiXp6db
	Oc6SPsghyYbfkroUFi8T5DpulUpxplZnl6pvJyNZNY28quEX5fLPuJXkAvEdYKyXKAqWQBVpmtBcp
	5DU3CWFtPVm1eelQEfopH5mqHmV4mvCggv5AdQXNzfD63I1Ro3Yh8h2mG5nhtwZsO2dVCaLYxK+2X
	3cE4Rb6/DD2rKglD7L3BV8CHF1mYa03tpZyGn3dDI4ncTA63rM/pHP6negQxMcdBvdZggi0VwEdJ8
	3la9FEs6KTQB2Tw6+N+VpAIN1UVIr3CVzzckvdDmSg8eKEPb2Hz7ET/t5gZ5oN4EyDeZROW8cfPEv
	z/QF3/EZTWCE7f9+2NAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtOl-0005xj-Qa; Fri, 11 Jan 2019 09:46:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtOi-0005xC-MN
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:46:42 +0000
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 831612177E
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547199999;
 bh=uMEjfMSqnjC4fCVJMMPj18/F1l1sJACJ6bmQ0AGcTic=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Ml7dfCHmow21/DE7SBEP5YOJF1qpt2tndN2ujw2w+pD10o1p2lueRPM0c7cRpapse
 DmR9FxyVFYnlmOitS31BWIe+jRKYNcBUPB8HZvd3NPkXNtsvpff+m/errEzKCX/jYi
 q+BYrCBl9eQIkH+QI3dIhHJxyAKz4fKNXyXTd4X0=
Received: by mail-lf1-f52.google.com with SMTP id c16so10351767lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:46:39 -0800 (PST)
X-Gm-Message-State: AJcUukcDjADj7CiU1JAiCKaH2DTSiPcNyYJnQI1ARICilrrGhWzGX29u
 Vecwt8Yzu9GuE4LCpwSdU0B3byu7HBRP8y7RGzQ=
X-Google-Smtp-Source: ALg8bN7JOfJUWRedo42QQ45VUS0GyU10FwJUgBKqD0/QC0C3yKrFyPxWTsXxyLlgaZT6dSRWNHC6d4Wr6hxCzVgTVEQ=
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr8211983lfc.124.1547199997640; 
 Fri, 11 Jan 2019 01:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 11 Jan 2019 10:46:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdz-LfQ1-jPXB5Y7pVVVBDdH0Q=5xZJxvabjhZ-Ush+dg@mail.gmail.com>
Message-ID: <CAJKOXPdz-LfQ1-jPXB5Y7pVVVBDdH0Q=5xZJxvabjhZ-Ush+dg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cpufreq: s5pv210: Defer probe if getting
 regulators fail
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_014640_761896_50FF39E1 
X-CRM114-Status: GOOD (  18.26  )
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
 linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 linux@armlinux.org.uk, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAxMCBKYW4gMjAxOSBhdCAyMTo1MywgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoZXJlIGlzIHBvc3NpYmlsaXR5LCB0aGF0
IHdoZW4gcHJvYmluZyBkcml2ZXIsIHJlZ3VsYXRvcnMgYXJlIG5vdCB5ZXQKPiBpbml0aWFsaXpl
ZC4gSW4gdGhpcyBjYXNlIHdlIHNob3VsZCByZXR1cm4gRVBST0JFX0RFRkVSIGFuZCB3YWl0IHRp
bGwKPiB0aGV5J3JlIGluaXRpYWxpemVkLCBzaW5jZSB0aGV5J3JlIHJlcXVpcmVkIGN1cnJlbnRs
eSBmb3IgY3B1ZnJlcSBkcml2ZXIKPiB0byB3b3JrLiBBbHNvIG1vdmUgcmVndWxhdG9yIGluaXRp
YWxpemF0aW9uIGNvZGUgYXQgYmVnaW5uaW5nIG9mIHByb2JlLAo+IHNvIHdlIGNhbiBkZWZlciBh
cyBmYXN0IGFzIHBvc2liYmxlLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3
ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgo+IC0tLQo+IENoYW5nZXMgZnJvbSB2MToKPiAg
IC0gRml4IGNvbXBpbGF0aW9uIGVycm9yCj4gICAtIFJlb3JnYW5pemUgY29kZSBzbyBpdCdzIHNt
YWxsZXIKPiAtLS0KPiAgZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jIHwgMzIgKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0
aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVx
L3M1cHYyMTAtY3B1ZnJlcS5jIGIvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCj4g
aW5kZXggZjUxNjk3ZjFlMGIzLi42ZGY5NTk0MWJhOTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9j
cHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCj4gKysrIGIvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAt
Y3B1ZnJlcS5jCj4gQEAgLTU5NCw2ICs1OTQsMjUgQEAgc3RhdGljIGludCBzNXB2MjEwX2NwdWZy
ZXFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgICAgICAgICAqIHRoaXMg
d2hvbGUgZHJpdmVyIGFzIHNvb24gYXMgUzVQVjIxMCBnZXRzIG1pZ3JhdGVkIHRvIHVzZQo+ICAg
ICAgICAgICogY3B1ZnJlcS1kdCBkcml2ZXIuCj4gICAgICAgICAgKi8KPiArICAgICAgIGFybV9y
ZWd1bGF0b3IgPSByZWd1bGF0b3JfZ2V0KE5VTEwsICJ2ZGRhcm0iKTsKPiArICAgICAgIGlmIChJ
U19FUlIoYXJtX3JlZ3VsYXRvcikpIHsKPiArICAgICAgICAgICAgICAgaWYgKFBUUl9FUlIoYXJt
X3JlZ3VsYXRvcikgPT0gLUVQUk9CRV9ERUZFUikKPiArICAgICAgICAgICAgICAgICAgICAgICBw
cl9kZWJ1ZygidmRkYXJtIHJlZ3VsYXRvciBub3QgcmVhZHksIGRlZmVyXG4iKTsKPiArICAgICAg
ICAgICAgICAgZWxzZQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiZmFpbGVkIHRv
IGdldCByZWd1bGF0b3IgdmRkYXJtXG4iKTsKPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9F
UlIoYXJtX3JlZ3VsYXRvcik7Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgaW50X3JlZ3VsYXRv
ciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwgInZkZGludCIpOwo+ICsgICAgICAgaWYgKElTX0VSUihp
bnRfcmVndWxhdG9yKSkgewo+ICsgICAgICAgICAgICAgICBpZiAoUFRSX0VSUihpbnRfcmVndWxh
dG9yKSA9PSAtRVBST0JFX0RFRkVSKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVn
KCJ2ZGRpbnQgcmVndWxhdG9yIG5vdCByZWFkeSwgZGVmZXJcbiIpOwo+ICsgICAgICAgICAgICAg
ICBlbHNlCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IHJl
Z3VsYXRvciB2ZGRpbnRcbiIpOwo+ICsgICAgICAgICAgICAgICByZWd1bGF0b3JfcHV0KGFybV9y
ZWd1bGF0b3IpOwo+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihpbnRfcmVndWxhdG9y
KTsKPiArICAgICAgIH0KPiArCgpFcnJvciBwYXRocyBhcmUgbm93IG5vdCBjb3JyZWN0LiBZb3Ug
c2hvdWxkIHB1dCB0aGUgcmVndWxhdG9ycyB3aGVuCnJldHVybmluZyBsYXRlci4gVGhlIHByZXZp
b3VzIGNvZGUgaGFkIHRoZXNlIGVycm9yIHBhdGhzIHdyb25nIGFzIHdlbGwKLSBub3QgaW91bm1h
cHBpbmcgLSBidXQgaWYgeW91IG1vdmUgdGhpbmdzIGFyb3VuZCwgbWF5YmUgbGV0J3MgZml4CnRo
aW5ncy4KCkJlc3QgcmVnYXJkcywKS3J6eXN6dG9mCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
