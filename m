Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6E1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:59:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1786E20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NsziZhRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1786E20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qL2zfG38eFfNFt011yeMA2tlV5cqmEU204Hn+jF/ix4=; b=NsziZhRjr81tCy
	4I3kWi0gotAwvua/i8qJfzHSyeH0WNkUri+C4536vJ+1r3NC7LODfetWhLM3dyPeh1TWpK0UWZ196
	VubNP5ay3HD0qSByUuNAHHoTa0wKMf3AzDh8nh3jgfTyQ1J5JQWMNbMURmfvNbBJnN3WnG/+FdmrW
	2Uahpv8H0h/bIebfwwEtk45Nroa/jNMpilbLjW5nQkO1ubYUuC4XDGkfCIkBco8bWS5ZXi1kHdDdp
	NjMDSyJsLZGo0/M8+kfvK1M7YdhIZGxXdFLRVPaNXM/YYS/GOMucW5iaVbEy6dpM8gaR5rFSSPUPX
	z14IoD1QqyODwcwmO7CA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3BC-0003LS-94; Wed, 12 Dec 2018 11:59:54 +0000
Received: from smtpbgeu1.qq.com ([52.59.177.22])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3B4-0003ES-Vb
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:59:52 +0000
X-QQ-mid: bizesmtp6t1544615939tggzc0x18
Received: from [192.168.117.185] (unknown [210.22.22.130])
 by esmtp6.qq.com (ESMTP) with 
 id ; Wed, 12 Dec 2018 19:58:58 +0800 (CST)
X-QQ-SSF: 00400000002000F0FL51B00B0000000
X-QQ-FEAT: OZV4j+Fl8oZUBCrrqrQxCMJnaPmBZDWf+SOdeHExRR3SLtNlL8536zcIWsgzM
 w9P+zzc//CJh9TEXiDm8cDpcyeAVTVqrSwpNrPXUADv/Qk2LKw8VahGBkpE/B26wrE6UhMC
 kRvB49XaB0TKRgArn5KvGGNBntckfifg+cIXxjFfl+SvcqgAhBfloO4dhyfSwfKbM3EgKcW
 Ckb7dSDB9luzTYm3kOk6YTlw+Cm8hMw0MH+fqUocOVp/9UpW3ghNwRebI9ki1K4Diffqycv
 TsutEIcQqSSYLY3+RQG1VMyemHkx//D4XR7WO9Pmxdfkwl
X-QQ-GoodBg: 2
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: Built a neon version copy_page/clear_page is correct?
From: JackieLiu <liuyun01@kylinos.cn>
In-Reply-To: <3ce08db0-a138-1f36-a038-62071b6ab537@arm.com>
Date: Wed, 12 Dec 2018 19:58:58 +0800
Message-Id: <F9994C30-2F3F-448E-96E0-CEAE24010FD2@kylinos.cn>
References: <BE9C50D9-738C-4EAD-9BBC-5D1CE6BC077E@kylinos.cn>
 <CAKv+Gu-OWVd_oq-Zb49Kgsswr99oZ5pUOoTN5pkYPFmRDDWoOA@mail.gmail.com>
 <370722B9-5CAE-4420-9126-3DF805BC115B@kylinos.cn>
 <3ce08db0-a138-1f36-a038-62071b6ab537@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3445.101.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_035947_306123_E6DABBD6 
X-CRM114-Status: GOOD (  11.45  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Andrew Pinski <apinski@cavium.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24sIG1heWJlIHRoZSBwcm9ibGVtIGlzIG5vdCBvbiB0
aGUgY29weV9wYWdlLCAKSSBuZWVkIHRvIHJlLXVuZGVyc3RhbmQgdGhlIGZvcmsgZnVuY3Rpb24g
Y29kZSwgbG9va2luZyBmb3IgdGhlIHJlYWwgYm90dGxlbmVjay4KCkJSLgpKYWNraWUKCj4g1Nog
MjAxOMTqMTLUwjEyyNWjrDE5OjQ1o6xSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29t
PiDQtLXAo7oKPiAKPiBPbiAxMi8xMi8yMDE4IDA3OjMyLCBKYWNraWVMaXUgd3JvdGU6Cj4+IFll
cy4gSSBoYXZlIGEgYm90dGxlbmVjaywgbWF5YmUgaXShr3Mgbm90IGNvcHlfcGFnZaGvcy4gYnV0
Cj4+IGR1cmluZyB0aGUgZGVidWdnaW5nIHByb2Nlc3MsIHRoaXMgZnVuY3Rpb24gaGFzIGEgdmVy
eSBoaWdoCj4+IENQVSB1dGlsaXphdGlvbi4KPj4gVGhlIHRlc3QgcHJvZ3JhbSBpcyBVbml4QmVu
Y2ihr3Mgc3JjL3NwYXduLmMsIHdpdGggYSB3aGlsZSB0bwo+PiBmb3JrIHByb2Nlc3MuIFRoZSBv
bmx5IHZhcmlhYmxlIGZvciB0ZXN0IGlzIFBBR0VfU0laRSwgb25lIGlzCj4+IDRrIFBBR0VfU0la
RSwgbmV4dCBpcyA2NGsgUEFHRV9TSVpFLgo+IAo+IEFGQUlDUyBhbGwgdGhhdCBkb2VzIGlzIGNh
bGwgZm9yaygpIGluIGEgbG9vcCBhcyBmYXN0IGFzIGl0IHBvc3NpYmx5IGNhbi4gRm9ya2luZyBp
bnZvbHZlcyBjb3B5aW5nIHBhZ2VzLCBlaXRoZXIgZHVyaW5nIHRoZSBjYWxsIG9yIHZpYSBjb3B5
LW9uLXdyaXRlIHRyaWdnZXJpbmcgaW4gb25lIG9yIGJvdGggcHJvY2Vzc2VzIGFmdGVyIHRoZSBz
eXNjYWxsIHJldHVybnMuIFNvIHlvdXIgJ3Byb2JsZW0nIGlzIHRoYXQgc29tZSBiZW5jaG1hcmsg
Y29kZSBzcGVuZHMgYSBmYWlyIGFtb3VudCBvZiB0aW1lIGRvaW5nIHRoZSBtYWpvciBwYXJ0IG9m
IHRoZSBvcGVyYXRpb24gaXQncyBiZW5jaG1hcmtpbmcuLi4gOi8KPiAKPj4gcmVzdWx0IGZvciAi
cGVyZiB0b3AiOgo+PiA0ayAgfCAgMTMlIENQVSAgY29weV9wYWdlCj4+IDY0ayB8ICA0OCUgQ1BV
ICBjb3B5X3BhZ2UKPj4gVGhpcyBpcyB3aHkgSSB3YW50IHRvIG9wdGltaXplIHRoaXMgZnVuY3Rp
b24uIE1heWJlIGJvdHRsZW5lY2sKPj4gaXMgbm90IGhlcmU/Cj4gCj4gQWxzbyBiZWFyIGluIG1p
bmQgdGhhdCBBRkFJSyBtb3N0IGN1cnJlbnQgY29yZXMgY2FuIGhhcHBpbHkgc2F0dXJhdGUgdGhl
aXIgbG9hZC9zdG9yZSB1bml0IHdpdGgganVzdCBMRFAvU1RQIC0gdGhpcyBpc24ndCBsaWtlIEFy
bXY3IHdoZXJlIFZMRCogd2FzIHRoZSBvbmx5IHdheSB0byBnZW5lcmF0ZSBhIHNpbmdsZSAxMjgt
Yml0IHdpZGUgYWNjZXNzLiBJZiB5b3UncmUgbm90IGRvaW5nIGFueSBhY3R1YWwgY2FsY3VsYXRp
b24gb3IgTERuL1NUbiBpbnRlcmxlYXZpbmcgdHJpY2tlcnksIHVzaW5nIE5FT04gcHVyZWx5IHRv
IG1vdmUgZGF0YSBpcyB1bmxpa2VseSB0byBiZSB3b3J0aHdoaWxlIGluIGdlbmVyYWwuIE9uIG1h
bnkgY29yZXMgaXQgbWF5IHdlbGwgZW5kIHVwIGJlaW5nIHNsb3dlci4KPiAKPiBSb2Jpbi4KPiAK
Pj4+INTaIDIwMTjE6jEy1MIxMsjVo6wxNToxOKOsQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1
dmVsQGxpbmFyby5vcmc+INC0tcCjugo+Pj4gCj4+PiBBcyBmb3IgY29weV9wYWdlKCksIHBsZWFz
ZSBkZXNjcmliZSBhIHVzZSBjYXNlIHdoZXJlIGl0IGlzIGEKPj4+IGJvdHRsZW5lY2ssIGFuZCBy
ZWFzb24gYWJvdXQgaG93IG11Y2ggeW91IGNvdWxkIGltcHJvdmUgcGVyZm9ybWFuY2UgaW4KPj4+
IHRoYXQgY2FzZSBieSBpbXByb3ZpbmcgdGhlIHNwZWVkIG9mIGNvcHlfcGFnZSgpIGl0c2VsZi4g
T3RoZXJ3aXNlLAo+Pj4gd2UncmUganVzdCBhZGRpbmcgTkVPTiByb3V0aW5lcyBmb3IgdGhlIHNh
a2UgaWYgaXQsIHdoaWNoIGlzIGEgYmFkCj4+PiBpZGVhIGltby4KPj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKPj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo+
IAoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
