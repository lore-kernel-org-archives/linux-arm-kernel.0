Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:48:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BFE2064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jhqzEFob";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBiCVq/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BFE2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UqtzQKDU8aoiOGAt/ddO7ZIZq1HsLkKe+0b053RRhEc=; b=jhqzEFobLZZ/mK
	D2QYI2v1R+YRtiB0zQG8j7rWbx/RaYh0opZeDdwRDBAxT1a0dC/G6VdKe8ifDbVwVHuym5TGsps3D
	4HkMGmfcbC8GrYYINQpakt10nbZhikOh5/pO342FQlYdOKSHLUocXjjjfyx2lPMaERvfj6Evfl5+U
	qbiksRdimTmRvUhZPin+7SBewLuy4kL+WL7fy56woxaJAjXzyRg/zZAVOmKKQtUbH10Vm8oCtCBYO
	bPYbsxrlt2GWEPRkv+CRMFhVrZSmNSiGZIPw/SmcPaw8L2Br7hBcceMhenwaTvh6t3Kty/sRktCrL
	posBYY5qXxqSGYqnv3sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOjk-0007tc-DZ; Mon, 10 Dec 2018 16:48:52 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOjg-0007sR-Pu
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:48:50 +0000
Received: by mail-qk1-x741.google.com with SMTP id q1so6836577qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:subject:to:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jIu/NQdLrU30oMjYFo1Dv8/5GvUAOK5LaTrL/MaVmCg=;
 b=BBiCVq/uyLE8Mcbj3/85rQLeTaF8vub5hoz5Kc5iSMv1QCR16Ef7AVjcegACWoNq2f
 b9FdakseRmRV12Sg5KE2z2Tgr+3eYXlQss/vCtI7sbVB6qPTTYbOmgUDuEDF3HntoBcd
 UQljs+6XDQ2PKvNkHy2raDh7Bhs4JA8gCN9E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:cc:subject:to:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jIu/NQdLrU30oMjYFo1Dv8/5GvUAOK5LaTrL/MaVmCg=;
 b=kSgOFPCZhV1vTWG3q+IKtbR0fKIee1iBATURuaDi7+QwYiMiWP+k2mQGp/rxa06bi/
 JP/FsOITx8CBICTD8dE0X1/xToebcBwCrQR0zlTq4wdwdLxSGV6msJD4+saBda6XbTHi
 kvgTG6GxOWANg86A5OqArL/58C949MmMaGyPiHSzeqn8FhtvDAhD0u+dZzubd8elW7+E
 5+1y4rK+vAGr1jmi70JjFgqsKD0aMFqJEkzF6IM9+RJ4+sKHU6iaAxmYwop75BJ4FUeU
 FlraEnhu9NwFyBP1Y5DLtJ+r3gurGsmFEn036iXbKwidGpeeZl3Rtk1tZ+x8aQvuWIOV
 oAwg==
X-Gm-Message-State: AA+aEWajWzbFiYFrL4O7jccNNalW21TsfMO0pWHlqGxT3W/Tuduf6wyy
 wblBaHzS1jnIl1U3SB81/HZcvQ==
X-Google-Smtp-Source: AFSGD/VfFUo4Nn/T94zhYEFli0jTOMHkAuEvRfT+ju+BCOJQSu7CmgpI09H1hfGJ0mz5hl9C98/w6Q==
X-Received: by 2002:a37:1f44:: with SMTP id f65mr11166603qkf.33.1544460517260; 
 Mon, 10 Dec 2018 08:48:37 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.7])
 by smtp.gmail.com with ESMTPSA id l15sm6158986qtr.25.2018.12.10.08.48.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:48:36 -0800 (PST)
Subject: Re: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
To: "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20181210142105.6750-1-rafael.tinoco@linaro.org>
 <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <32747ea1-7437-8055-a4f5-9f22378e57ae@linaro.org>
Date: Mon, 10 Dec 2018 14:48:25 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_084848_846175_45E9595F 
X-CRM114-Status: GOOD (  18.17  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Khalid Aziz <khalid.aziz@oracle.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 James Hogan <jhogan@kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>,
 Nitin Gupta <ngupta@vflare.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Rafael David Tinoco <rafael.tinoco@linaro.org>,
 Juergen Gross <jgross@suse.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>, Tony Luck <tony.luck@intel.com>,
 Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Minchan Kim <minchan@kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMTAvMTggMToxNSBQTSwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOgo+IE9uIE1vbiwg
RGVjIDEwLCAyMDE4IGF0IDEyOjIxOjA1UE0gLTAyMDAsIFJhZmFlbCBEYXZpZCBUaW5vY28gd3Jv
dGU6Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0X3R5cGVz
LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0X3R5cGVzLmgKPj4gaW5kZXggODRi
ZDliZGMxOTg3Li5kODA4Y2ZkZTNkMTkgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3BndGFibGVfNjRfdHlwZXMuaAo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3Rh
YmxlXzY0X3R5cGVzLmgKPj4gQEAgLTY0LDggKzY0LDYgQEAgZXh0ZXJuIHVuc2lnbmVkIGludCBw
dHJzX3Blcl9wNGQ7Cj4+ICAjZGVmaW5lIFA0RF9TSVpFCQkoX0FDKDEsIFVMKSA8PCBQNERfU0hJ
RlQpCj4+ICAjZGVmaW5lIFA0RF9NQVNLCQkofihQNERfU0laRSAtIDEpKQo+PiAgCj4+IC0jZGVm
aW5lIE1BWF9QT1NTSUJMRV9QSFlTTUVNX0JJVFMJNTIKPj4gLQo+PiAgI2Vsc2UgLyogQ09ORklH
X1g4Nl81TEVWRUwgKi8KPj4gIAo+PiAgLyoKPj4gQEAgLTE1NCw0ICsxNTIsNiBAQCBleHRlcm4g
dW5zaWduZWQgaW50IHB0cnNfcGVyX3A0ZDsKPj4gIAo+PiAgI2RlZmluZSBQR0RfS0VSTkVMX1NU
QVJUCSgoUEFHRV9TSVpFIC8gMikgLyBzaXplb2YocGdkX3QpKQo+PiAgCj4+ICsjZGVmaW5lIE1B
WF9QT1NTSUJMRV9QSFlTTUVNX0JJVFMgKHBndGFibGVfbDVfZW5hYmxlZCgpID8gNTIgOiA0NikK
Pj4gKwo+IAo+IC4uLgo+IAo+PiAgI2VuZGlmIC8qIF9BU01fWDg2X1BHVEFCTEVfNjRfREVGU19I
ICovCj4+IGRpZmYgLS1naXQgYS9tbS96c21hbGxvYy5jIGIvbW0venNtYWxsb2MuYwo+PiBpbmRl
eCAwNzg3ZDMzYjgwZDguLjEzMmMyMGI2ZmQ0ZiAxMDA2NDQKPj4gLS0tIGEvbW0venNtYWxsb2Mu
Ywo+PiArKysgYi9tbS96c21hbGxvYy5jCj4gCj4gLi4uCj4gCj4+IEBAIC0xMTYsNiArMTAwLDI1
IEBACj4+ICAgKi8KPj4gICNkZWZpbmUgT0JKX0FMTE9DQVRFRF9UQUcgMQo+PiAgI2RlZmluZSBP
QkpfVEFHX0JJVFMgMQo+PiArCj4+ICsvKgo+PiArICogTUFYX1BPU1NJQkxFX1BIWVNNRU1fQklU
UyBzaG91bGQgYmUgZGVmaW5lZCBieSBhbGwgYXJjaHMgdXNpbmcgenNtYWxsb2M6Cj4+ICsgKiBU
cnlpbmcgdG8gZ3Vlc3MgaXQgZnJvbSBNQVhfUEhZU01FTV9CSVRTLCBvciBjb25zaWRlcmluZyBp
dCBCSVRTX1BFUl9MT05HLAo+PiArICogcHJvdmVkIHRvIGJlIHdyb25nIGJ5IG5vdCBjb25zaWRl
cmluZyBQQUUgY2FwYWJpbGl0aWVzLCBvciB1c2luZyBTUEFSU0VNRU0KPj4gKyAqIG9ubHkgaGVh
ZGVycywgbGVhZGluZyB0byBiYWQgb2JqZWN0IGVuY29kaW5nIGR1ZSB0byBvYmplY3QgaW5kZXgg
b3ZlcmZsb3cuCj4+ICsgKi8KPj4gKyNpZm5kZWYgTUFYX1BPU1NJQkxFX1BIWVNNRU1fQklUUwo+
PiArICNkZWZpbmUgTUFYX1BPU1NJQkxFX1BIWVNNRU1fQklUUyBCSVRTX1BFUl9MT05HCj4+ICsg
I2Vycm9yICJNQVhfUE9TU0lCTEVfUEhZU01FTV9CSVRTIEhBUyB0byBiZSBkZWZpbmVkIGJ5IGFy
Y2ggdXNpbmcgenNtYWxsb2MiOwo+PiArI2Vsc2UKPj4gKyAjaWZuZGVmIENPTkZJR182NEJJVAo+
PiArICAjaWYgKE1BWF9QT1NTSUJMRV9QSFlTTUVNX0JJVFMgPj0gKEJJVFNfUEVSX0xPTkcgKyBQ
QUdFX1NISUZUIC0gT0JKX1RBR19CSVRTKSkKPj4gKyAgICNlcnJvciAiTUFYX1BPU1NJQkxFX1BI
WVNNRU1fQklUUyBpcyB3cm9uZyBmb3IgdGhpcyBhcmNoIjsKPj4gKyAgI2VuZGlmCj4+ICsgI2Vu
ZGlmCj4+ICsjZW5kaWYKPj4gKwo+PiArI2RlZmluZSBfUEZOX0JJVFMgKE1BWF9QT1NTSUJMRV9Q
SFlTTUVNX0JJVFMgLSBQQUdFX1NISUZUKQo+PiAgI2RlZmluZSBPQkpfSU5ERVhfQklUUwkoQklU
U19QRVJfTE9ORyAtIF9QRk5fQklUUyAtIE9CSl9UQUdfQklUUykKPj4gICNkZWZpbmUgT0JKX0lO
REVYX01BU0sJKChfQUMoMSwgVUwpIDw8IE9CSl9JTkRFWF9CSVRTKSAtIDEpCj4gCj4gSGF2ZSB5
b3UgdGVzdGVkIGl0IHdpdGggQ09ORklHX1g4Nl81TEVWRUw9eT8KPiAKPiBBU0FJQ1MsIHRoZSBw
YXRjaCBtYWtlcyBPQkpfSU5ERVhfQklUUyBhbmQgd2hhdCBkZXBlbmRzIGZyb20gaXQgZHluYW1p
YyAtLQo+IGl0IGRlcGVuZHMgd2hhdCBwYWdpbmcgbW9kZSB3ZSBhcmUgYm9vdGluZyBpbi4gWlNf
U0laRV9DTEFTU0VTIGRlcGVuZHMKPiBpbmRpcmVjdGx5IG9uIE9CSl9JTkRFWF9CSVRTIGFuZCBJ
IGRvbid0IHNlZSBob3cgc3RydWN0IHpzX3Bvb2wgZGVmaW5pdGlvbgo+IGNhbiBjb21waWxlIHdp
dGggZHluYW1pYyBaU19TSVpFX0NMQVNTRVMuCj4gCj4gSG0/Cj4gCgpZb3UncmUgcmlnaHQsIHRl
cnJpYmx5IHNvcnJ5LiBUaGlzIHdhcyBhIGxhc3QgdGltZSBjaGFuZ2UuCgptbS96c21hbGxvYy5j
OjI1NjoyMTogZXJyb3I6IHZhcmlhYmx5IG1vZGlmaWVkIOKAmHNpemVfY2xhc3PigJkgYXQgZmls
ZSBzY29wZQoKSSdsbCByZXZpc2l0IHRoZSBwYXRjaC4gQW55IG90aGVyIGNvbW1lbnRzIGFyZSB3
ZWxjb21lLgoKVGhhbmsgeW91CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
