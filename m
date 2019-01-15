Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1429DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:42:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76F020659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A+svrGUI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlkYiNkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76F020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=doGaVAi7RnT/TLXm+sQVFgoqaWXAxmqU15ekv4d4+JI=; b=A+svrGUI1l0pST
	LOynCz6sdYq1WMckEvnSeqddGYr8esa7xLLskVUl0VEWXx18HaZSAmia4qReor6yf/XUkN8PCtCFd
	fTkDgnMwZruOULXFUB3UrR4LZ+rRHR5RP1UtF2ZAffx/zIdFKRaRaVlyUuD18V1T2RD/1YcK1m8t/
	PcWt/HdsYxTGVhg6fhnGvklyTlTzrRjzfw7gIq9XmIHpzXZUhAu3CWY/DeFWcgsWy+kemEQ/S5PmT
	sVS1i0EvVBKSFP6eaJGuRRNpnsV1s/vB77Iw4fK7iBSxJNl6BCqt+TC6CyUq/rW+KIQGJbsTANsHU
	J4oc0mXk5mDC2VmVGpSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjCoR-0002FX-Eq; Tue, 15 Jan 2019 00:42:39 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjCoO-0002FB-Kz
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 00:42:38 +0000
Received: by mail-pl1-x643.google.com with SMTP id t13so409240ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 16:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Siayggi2yHTLNKyVgxd6Cw++xWFsxfY4GIGBFVsloGE=;
 b=dlkYiNkv20xZaaEMVVqgHfrCrX2g8jhnqMnsfSgVbraKT+QtXbpyf+eUcCwDYCsnSb
 xFVmHwAlRyGog1M2EHyjvZc+rd/c9NpofxzLGjWB94VFNKVvHCodnC4vrr1NgPBeqT+j
 XxAJ6kP+XxDijx+QYJgTX/cA6uXba1NNNL+YvT2uyhLXSMPmy7kubmyA0jWgiMDZBlvK
 rmiTMFvIChW61SPJ5W7Cb6Bk7VJGz2OYCvYdHJWUM+oAg4kx6P57o+OAa76CjpyOh5Ps
 +cEYCmZWfiXKnMsmD1xjb38y+xbJNzPS1fP1BE7WtgXNU8nrmlOgaMSAkJyWok/0j0KJ
 2eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Siayggi2yHTLNKyVgxd6Cw++xWFsxfY4GIGBFVsloGE=;
 b=hBZWDFpkpyTNwCmjUjMHKYvNNqyQz0XhmEh4ija3/JoxjPEJBgg6lykI/ZXJVvZwD9
 0B50quW2529cjUd6jAj+Z1SXxrhxmp/k6gH29e+FUd8+KS9AeLnVGqf5UsXkRoRQt9o3
 dJmsdr2M1RnnNuOUOe+OrkknJyKkA7BJPzeEulO1PNJuPrfec24q50OgrxkQvKRmCOK2
 fyEUXqbzQ7JEojmX2nKM8ek0b+K6Nu9TX1MAU/Ss75GEzf8e4YBtFJ5PTTylvINcAT10
 EacMg7MMN0bZyY372s0tRuM82T8GFaY57eSRoX8RKbT1BQjxyvKtHDYF+PIqgyp1sczo
 kuww==
X-Gm-Message-State: AJcUukdWObz6FOPn5SbeA/OWtZeG4LR7Igc611vqiuop8u/v/O4NGAP3
 4x4HfJ4EqH/jjFL8pqINwpA=
X-Google-Smtp-Source: ALg8bN5/g2GfLnTnjMmMjuSN+OeH1DUb/Y9GTo/I6wULSkhpcg8JwxHbvuvS5Ib6VJC95LB+7sO0zw==
X-Received: by 2002:a17:902:20e9:: with SMTP id
 v38mr1228588plg.250.1547512955605; 
 Mon, 14 Jan 2019 16:42:35 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id m3sm2001949pfi.102.2019.01.14.16.42.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 16:42:34 -0800 (PST)
Date: Mon, 14 Jan 2019 16:42:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v5 2/3] Input: atmel_mxt_ts: Wait for device be ready for
 communication
Message-ID: <20190115004232.GK117329@dtor-ws>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
 <20181214151214.5391-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214151214.5391-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_164236_683731_F02B4F57 
X-CRM114-Status: GOOD (  19.44  )
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
 alexandre.belloni@bootlin.com, nick@shmanahar.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBEZWMgMTQsIDIwMTggYXQgMDQ6MTI6MTNQTSArMDEwMCwgUGF3ZcWCIENobWllbCB3
cm90ZToKPiBBY2NvcmRpbmcgdG8gZG9jdW1lbnRhdGlvbiwgZGV2aWNlIGlzbid0IHJlYWR5IGZv
ciBjb21tdW5pY2F0aW9uLAo+IHVudGlsIGZpcm13YXJlIGFzc2VydHMgdGhlIENIRyBsaW5lLiBB
ZGQgbWlzc2luZyB3YWl0IGZvciB0aGlzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1p
ZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KPiAtLS0KPiBDaGFuZ2VzIGZyb20g
djE6Cj4gICAtIEZpeCBjaGVja3BhdGNoIGlzc3Vlcwo+IC0tLQo+ICBkcml2ZXJzL2lucHV0L3Rv
dWNoc2NyZWVuL2F0bWVsX214dF90cy5jIHwgMTEgKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC90b3Vj
aHNjcmVlbi9hdG1lbF9teHRfdHMuYyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxf
bXh0X3RzLmMKPiBpbmRleCA1NWExMDdmYzFiNzMuLmU4OTQ5YzZjZWFmYSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2F0bWVsX214dF90cy5jCj4gKysrIGIvZHJpdmVy
cy9pbnB1dC90b3VjaHNjcmVlbi9hdG1lbF9teHRfdHMuYwo+IEBAIC0yMDIsNiArMjAyLDcgQEAg
ZW51bSB0MTAwX3R5cGUgewo+ICAjZGVmaW5lIE1YVF9DUkNfVElNRU9VVAkJMTAwMAkvKiBtc2Vj
ICovCj4gICNkZWZpbmUgTVhUX0ZXX1JFU0VUX1RJTUUJMzAwMAkvKiBtc2VjICovCj4gICNkZWZp
bmUgTVhUX0ZXX0NIR19USU1FT1VUCTMwMAkvKiBtc2VjICovCj4gKyNkZWZpbmUgTVhUX1BPV0VS
T05fREVMQVkJMTUwCS8qIG1zZWMgKi8KPiAgCj4gIC8qIENvbW1hbmQgdG8gdW5sb2NrIGJvb3Rs
b2FkZXIgKi8KPiAgI2RlZmluZSBNWFRfVU5MT0NLX0NNRF9NU0IJMHhhYQo+IEBAIC0zMDcwLDYg
KzMwNzEsMTYgQEAgc3RhdGljIGludCBteHRfcmVndWxhdG9yX2VuYWJsZShzdHJ1Y3QgbXh0X2Rh
dGEgKmRhdGEpCj4gIAkJbXNsZWVwKE1YVF9SRUdVTEFUT1JfREVMQVkpOwo+ICAJCWdwaW9kX3Nl
dF92YWx1ZShkYXRhLT5yZXNldF9ncGlvLCAxKTsKPiAgCQltc2xlZXAoTVhUX1JFU0VUX0lOVkFM
SURfQ0hHKTsKPiArCj4gK3JldHJ5X3dhaXQ6Cj4gKwkJcmVpbml0X2NvbXBsZXRpb24oJmRhdGEt
PmJsX2NvbXBsZXRpb24pOwo+ICsJCWRhdGEtPmluX2Jvb3Rsb2FkZXIgPSB0cnVlOwoKSSB0aGlu
ayB5b3Ugd291bGQgd2FudCB0byByZWluaXQgdGhlIG9jbXBsZXRpb24gYW5kIHNldCB0aGUgZmxh
ZyBiZWZvcmUKcmVsZWFzaW5nIHJlc2V0IGxpbmUgYW5kIHNsZWVwaW5nLCBvdGhlcndpc2UgaWYg
aW50ZXJydXB0IGZpcmVzIHRvbwplYXJseSB5b3UnbGwgYmUgc3Bpbm5pbmcgZm9yIGV4dHJhIHRp
bWUuCgpJJ2QgYWxzbyByZWFsbHkgd2FudCB0byBoZWFyIGZyb20gTmljayBvbiB0aGlzIGNoYW5n
ZS4KCj4gKwkJZXJyb3IgPSBteHRfd2FpdF9mb3JfY29tcGxldGlvbihkYXRhLCAmZGF0YS0+Ymxf
Y29tcGxldGlvbiwKPiArCQkJCQkJTVhUX1BPV0VST05fREVMQVkpOwo+ICsJCWlmIChlcnJvciA9
PSAtRUlOVFIpCj4gKwkJCWdvdG8gcmV0cnlfd2FpdDsKPiArCj4gKwkJZGF0YS0+aW5fYm9vdGxv
YWRlciA9IGZhbHNlOwo+ICAJfQo+ICAKPiAgCXJldHVybiAwOwo+IC0tIAo+IDIuMTcuMQo+IAoK
VGhhbmtzLgoKLS0gCkRtaXRyeQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
