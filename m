Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF358C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:01:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D9520657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BxhMF/gF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNViYEPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D9520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dT4zVPeexAxo5f1O57g4gdkW1pBS7AoiBjIq/ClaipY=; b=BxhMF/gFlYUuSY
	ReW3w2ybnWC3O40CLbOtcJniKZiD0jT/7eURX3/pOgS2gvmYJEB8T93PL+erS0hM9rpdYGJlLclm/
	aNvCREzdGV/tcz7mGzgZ4CamR4G8awFf6C8H0D8rNtNmV8FgX0y2jLTayg20HUmjTF7z0ucRwJAGE
	UYEiorTWKa9B4pvzyvl8A6h/o1GI2KTcESt/a/npojhtQIxADqyKaVOex43jd+jiglKhIgfvQpNWM
	dsflogXz63TsE+3U0QQI3lZZEArFulfz2vVoDIrDLMqjLhlKV2gxBmP56WJHZ1Jg5qBRxF5cmFQVR
	t5DLVkH4JPQXJJch6Fww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghULO-0007Q7-Tk; Thu, 10 Jan 2019 07:01:34 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghULK-0007Pf-Um
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:01:32 +0000
Received: by mail-pf1-x443.google.com with SMTP id c73so4872393pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 23:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=3X7FWpHmTVcpHXfgsAheG4ZiQ9OG79ixvLWK46B7wSw=;
 b=XNViYEPWf8Ouq/4k2irBaaEcoqwsVhgKIY45nC1h2Bm8Yz4QELiRbOjf+D961Quc3R
 VBZRqtiAMKQJSpuoVMF4g2UzrHIFRKvzBkXtQy/KMToUErbaVt8FMX3Q0OKRM7mKU5r/
 tQuwR8MMlEfBunUgdj7RNnx62fA11dqUYIwVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=3X7FWpHmTVcpHXfgsAheG4ZiQ9OG79ixvLWK46B7wSw=;
 b=Mwx06i6Gke5aC6UyBndqO15PKR5EWZ+9bFIyTVkWoOGe0EuCsiCXEUvU6LRRNxRXTG
 kuSaSBO4Zf397UC2xZ1g9FlHCYyZTD2Z5I+UItA0PgeIcruIUJtyb6kjcl3W5ZlXK1Au
 Vj1v67X3ookJqiuBMvrB9sbGCp2uwWiA6W/F8X8pv110GpnzC82ppjWRFbJ91g5kwtBT
 PVdDP68DkAkntZnQluBLChJ1wKonMG1KFG60oXPZ99+QgoOShIaygO+TxJNF38mTV/zs
 HyU3xm93kgMFdEnbUpfNUMcl3TRRV9xs1l1z48pRxzin21CLxwXrFzYSF/BcXyeneSF3
 7+pQ==
X-Gm-Message-State: AJcUuke8U6ZVjMoiYDZBOrGQeoSF7eO+zFl+HVDwifWgzs22JJC8swHH
 JuPznsUSzkT709PsuisnmeQ52g==
X-Google-Smtp-Source: ALg8bN7vWeNi5PBVQFiiWICw8G/6yLGRvwYizy2YCiPR4JORhVVenJWjrAlcK2J1duvFSb80jtdz5Q==
X-Received: by 2002:a65:62da:: with SMTP id m26mr8407142pgv.278.1547103689853; 
 Wed, 09 Jan 2019 23:01:29 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id i5sm15187414pfg.34.2019.01.09.23.01.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 23:01:29 -0800 (PST)
Date: Thu, 10 Jan 2019 12:31:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 3/4] cpufreq: s5pv210: Defer probe if getting regulators
 fail
Message-ID: <20190110070127.ymukpnbabjr5n5fe@vireshk-i7>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_230131_001558_9D488B44 
X-CRM114-Status: GOOD (  19.15  )
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
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 linux@armlinux.org.uk, krzk@kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, kgene@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDgtMDEtMTksIDIxOjA1LCBQYXdlxYIgQ2htaWVsIHdyb3RlOgo+IFRoZXJlIGlzIHBvc3Np
YmlsaXR5LCB0aGF0IHdoZW4gcHJvYmluZyBkcml2ZXIsIHJlZ3VsYXRvcnMgYXJlIG5vdCB5ZXQK
PiBpbml0aWFsaXplZC4gSW4gdGhpcyBjYXNlIHdlIHNob3VsZCByZXR1cm4gRVBST0JFX0RFRkVS
IGFuZCB3YWl0IHRpbGwKPiB0aGV5J3JlIGluaXRpYWxpemVkLCBzaW5jZSB0aGV5J3JlIHJlcXVp
cmVkIGN1cnJlbnRseSBmb3IgY3B1ZnJlcSBkcml2ZXIKPiB0byB3b3JrLiBBbHNvIG1vdmUgcmVn
dWxhdG9yIGluaXRpYWxpemF0aW9uIGNvZGUgYXQgYmVnaW5uaW5nIG9mIHByb2JlLAo+IHNvIHdl
IGNhbiBkZWZlciBhcyBmYXN0IGFzIHBvc2liYmxlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBhd2XF
giBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jIHwgMzMgKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYyBi
L2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYwo+IGluZGV4IGY1MTY5N2YxZTBiMy4u
MmQwZTRkYzdlZGU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZy
ZXEuYwo+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYwo+IEBAIC01OTQs
NiArNTk0LDI2IEBAIHN0YXRpYyBpbnQgczVwdjIxMF9jcHVmcmVxX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAkgKiB0aGlzIHdob2xlIGRyaXZlciBhcyBzb29uIGFzIFM1
UFYyMTAgZ2V0cyBtaWdyYXRlZCB0byB1c2UKPiAgCSAqIGNwdWZyZXEtZHQgZHJpdmVyLgo+ICAJ
ICovCj4gKwlhcm1fcmVndWxhdG9yID0gcmVndWxhdG9yX2dldChOVUxMLCAidmRkYXJtIik7Cj4g
KwlpZiAoUFRSX0VSUihhcm1fcmVndWxhdG9yKSA9PSAtRVBST0JFX0RFRkVSKSB7Cj4gKwkJcHJf
ZGJnKCJ2ZGRhcm0gcmVndWxhdG9yIG5vdCByZWFkeSwgZGVmZXJcbiIpOwo+ICsJCXJldHVybiAt
RVBST0JFX0RFRkVSOwo+ICsJfSBlbHNlIGlmIChJU19FUlIoYXJtX3JlZ3VsYXRvcikpIHsKPiAr
CQlwcl9lcnIoImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZkZGFybVxuIik7Cj4gKwkJcmV0dXJu
IFBUUl9FUlIoYXJtX3JlZ3VsYXRvcik7Cj4gKwl9CgpUaGUgb25seSBkaWZmZXJlbmNlIGJldHdl
ZW4gdGhlIHR3byBjYXNlcyBpcyBwcl9kYmcgdnMgcHJfZXJyLCBpdHMKdWdseSB0aGF0IHdlIGhh
dmUgdG8gYWRkIHNwZWNpYWwgY29kZSBmb3IgdGhhdCA6KAoKTWF5YmUgd3JpdGUgaXQgYXM6Cgog
ICAgICAgIGlmIChJU19FUlIoYXJtX3JlZ3VsYXRvcikpIHsKICAgICAgICAgICAgICAgIGlmIChQ
VFJfRVJSKGFybV9yZWd1bGF0b3IpID09IC1FUFJPQkVfREVGRVIpCiAgICAgICAgICAgICAgICAg
ICAgICAgIHByX2RiZy4uLgogICAgICAgICAgICAgICAgZWxzZQogICAgICAgICAgICAgICAgICAg
ICAgICBwcl9lcnIKICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGFybV9yZWd1bGF0b3Ip
OwogICAgICAgIH0KCj4gKwo+ICsJaW50X3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwg
InZkZGludCIpOwo+ICsJaWYgKFBUUl9FUlIoaW50X3JlZ3VsYXRvciA9PSAtRVBST0JFX0RFRkVS
KSB7CgpEb2VzIHRoaXMgZXZlbiBjb21waWxlID8KCj4gKwkJcmVndWxhdG9yX3B1dChhcm1fcmVn
dWxhdG9yKTsKPiArCQlwcl9kYmcoInZkZGludCByZWd1bGF0b3Igbm90IHJlYWR5LCBkZWZlclxu
Iik7Cj4gKwkJcmV0dXJuIC1FUFJPQkVfREVGRVI7Cj4gKwl9IGVsc2UgaWYgKElTX0VSUihpbnRf
cmVndWxhdG9yKSkgewo+ICsJCXJlZ3VsYXRvcl9wdXQoYXJtX3JlZ3VsYXRvcik7Cj4gKwkJcHJf
ZXJyKCJmYWlsZWQgdG8gZ2V0IHJlZ3VsYXRvciB2ZGRpbnRcbiIpOwo+ICsJCXJldHVybiBQVFJf
RVJSKGludF9yZWd1bGF0b3IpOwo+ICsJfQo+ICsKPiAgCW5wID0gb2ZfZmluZF9jb21wYXRpYmxl
X25vZGUoTlVMTCwgTlVMTCwgInNhbXN1bmcsczVwdjIxMC1jbG9jayIpOwo+ICAJaWYgKCFucCkg
ewo+ICAJCXByX2VycigiJXM6IGZhaWxlZCB0byBmaW5kIGNsb2NrIGNvbnRyb2xsZXIgRFQgbm9k
ZVxuIiwKPiBAQCAtNjMzLDE5ICs2NTMsNiBAQCBzdGF0aWMgaW50IHM1cHYyMTBfY3B1ZnJlcV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAJCX0KPiAgCX0KPiAgCj4gLQlh
cm1fcmVndWxhdG9yID0gcmVndWxhdG9yX2dldChOVUxMLCAidmRkYXJtIik7Cj4gLQlpZiAoSVNf
RVJSKGFybV9yZWd1bGF0b3IpKSB7Cj4gLQkJcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IHJlZ3VsYXRv
ciB2ZGRhcm1cbiIpOwo+IC0JCXJldHVybiBQVFJfRVJSKGFybV9yZWd1bGF0b3IpOwo+IC0JfQo+
IC0KPiAtCWludF9yZWd1bGF0b3IgPSByZWd1bGF0b3JfZ2V0KE5VTEwsICJ2ZGRpbnQiKTsKPiAt
CWlmIChJU19FUlIoaW50X3JlZ3VsYXRvcikpIHsKPiAtCQlwcl9lcnIoImZhaWxlZCB0byBnZXQg
cmVndWxhdG9yIHZkZGludFxuIik7Cj4gLQkJcmVndWxhdG9yX3B1dChhcm1fcmVndWxhdG9yKTsK
PiAtCQlyZXR1cm4gUFRSX0VSUihpbnRfcmVndWxhdG9yKTsKPiAtCX0KPiAtCj4gIAlyZWdpc3Rl
cl9yZWJvb3Rfbm90aWZpZXIoJnM1cHYyMTBfY3B1ZnJlcV9yZWJvb3Rfbm90aWZpZXIpOwo+ICAK
PiAgCXJldHVybiBjcHVmcmVxX3JlZ2lzdGVyX2RyaXZlcigmczVwdjIxMF9kcml2ZXIpOwo+IC0t
IAo+IDIuMTcuMQoKLS0gCnZpcmVzaAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
