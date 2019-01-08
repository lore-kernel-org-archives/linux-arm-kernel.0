Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F98C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:02:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC32206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nZHvCCpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC32206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rT6BIr2kwknihZOEYMif7gOBdwUA5eGa2I5uvYhktTk=; b=nZHvCCpt2gMvWl
	LjU/Gpa/MBOx0HLsNV3/L6k84mEEqryyNv6badUCmp0x5LXr8KCvpSFZIBFjttB1IpSGCnujkWKMZ
	XkOhRvlsN/d0EwcijiXUQIDevviY4efd97t5a+prtBJsbTNaNjLw0ODexHW/1CthhSQ3G8z1yOo1S
	6YyU7n2N1+TUu6MCgakfcsvVyCZkgteoVdjQPKOfD6at0bAMpYtw+Wbyrb4mKP/RGYFlZmIR1GTAW
	KIrsI98m9lheuT7czhDoloMDhJls3OfsfVsTwf/SpcZvhy4i3rZs7rLGjoltj16DuyLAGMEr8CN48
	GMs4Wd8z5VJIcix1XmMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggp9F-0006lj-4e; Tue, 08 Jan 2019 11:02:17 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggp9A-0006l7-Vo
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 11:02:14 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x08Au4Jn016914; Tue, 8 Jan 2019 12:02:01 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2ptt11xepy-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 08 Jan 2019 12:02:01 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16C1238;
 Tue,  8 Jan 2019 11:01:59 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C8E5C2A7F;
 Tue,  8 Jan 2019 11:01:58 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.50) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 8 Jan
 2019 12:01:57 +0100
Subject: Re: New IIO/counter driver
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>, William Breathitt Gray
 <vilhelm.gray@gmail.com>
References: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
 <20190108004632.GA3247@icarus>
 <CA+M3ks7wX6MxvapDi_5SQ0rkJWoV+BcmzmbvtiqHVBzrrwAp4g@mail.gmail.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <8b2bb569-a6e0-25ec-740d-48083b30fe60@st.com>
Date: Tue, 8 Jan 2019 12:01:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CA+M3ks7wX6MxvapDi_5SQ0rkJWoV+BcmzmbvtiqHVBzrrwAp4g@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-08_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_030213_305592_0F33851B 
X-CRM114-Status: GOOD (  17.03  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Benjamin GAIGNARD <benjamin.gaignard@st.com>, linux-iio@vger.kernel.org,
 Patrick Havelange <patrick.havelange@essensium.com>,
 Hartmut Knaack <knaack.h@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMS84LzE5IDExOjU3IEFNLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToKPiBMZSBtYXIuIDgg
amFudi4gMjAxOSDDoCAwMTo0NiwgV2lsbGlhbSBCcmVhdGhpdHQgR3JheQo+IDx2aWxoZWxtLmdy
YXlAZ21haWwuY29tPiBhIMOpY3JpdCA6Cj4+Cj4+IE9uIE1vbiwgSmFuIDA3LCAyMDE5IGF0IDAy
OjQ1OjM3UE0gKzAxMDAsIFBhdHJpY2sgSGF2ZWxhbmdlIHdyb3RlOgo+Pj4gSGVsbG8sCj4+Pgo+
Pj4gSSdtIGluIHRoZSBwcm9jZXNzIG9mIGFkZGluZyBhIG5ldyBJSU8vY291bnRlciBkcml2ZXIs
IGhvd2V2ZXIgSSBhbHNvIHNhdwo+Pj4gdGhhdCB0aGVyZSB3YXMgYSB3b3JrIGluIHByb2dyZXNz
IHRvIGhhdmUgYSBzZXBhcmF0ZSBjb3VudGVyIHN1YnN5c3RlbSAoCj4+PiBodHRwczovL21hcmMu
aW5mby8/bD1saW51eC1paW8mbT0xNTM5NzQxNjc3MjcyMDYgKS4gQnV0IGl0IHNlZW1zIHRoZXJl
IGlzCj4+PiBubyByZWNlbnQgcHJvZ3Jlc3Mgb24gaXQuCj4+PiBXaGF0IGlzIHRoZSBzdGF0ZSBv
ZiB0aG9zZSBwYXRjaGVzID8gSXMgaXQgc3RpbGwgaW50ZXJlc3RpbmcgdG8gZGV2ZWxvcCB0aGUK
Pj4+IGRyaXZlciBhcyBhbiBJSU8vY291bnRlciAsIG9yIHNob3VsZCBJIHVzZSBhbHJlYWR5IHRo
YXQgbmV3IHN1YnN5c3RlbSA/Cj4+Pgo+Pj4gQmVzdCBSZWdhcmRzLAo+Pj4KPj4+IFBhdHJpY2sg
SGF2ZWxhbmdlLgo+Pgo+PiBIZWxsbywKPj4KPj4gSSBhbSBzdGlsbCBvcGVuIHRvIG1lcmdpbmcg
dGhpcyBwYXRjaHNldCBhbmQgbWFpbnRhaW5pbmcgdGhlIENvdW50ZXIKPj4gc3Vic3lzdGVtLiBI
b3dldmVyLCBJIHRvb2sgdGhlIGxhY2sgb2YgcmVzcG9uc2UgZm9yIG15IGxhdGVzdAo+PiBzdWJt
aXNzaW9uIHRvIGluZGljYXRlIGEgbG9zcyBvZiBpbnRlcmVzdCBpbiB0aGlzIHBhdGNoc2V0J3Mg
YXBwcm9hY2guCj4+IElmIHRoZXJlIGFyZSBzdGlsbCBwZW9wbGUgd2hvIHdhbnQgdGhpcywgSSBj
YW4gcmViYXNlIGFuZCByZXNlbmQgdGhpcwo+PiBwYXRjaHNldCBmb3Igc3VibWlzc2lvbjsgdGhl
IHBhc3QgZmV3IHZlcnNpb25zIGhhdmUgcHJpbWFyaWx5IGJlZW4gY29kZQo+PiBjbGFyaXR5IGFu
ZCBkb2N1bWVudGF0aW9uIGNoYW5nZXMgc28gSSBiZWxpZXZlIHRoZSBjb3JlIGRlc2lnbiBpdHNl
bGYgaXMKPj4gc29tZXdoYXQgc3RhYmxlIG5vdy4KPj4KPj4gSnVzdCBsZXQgbWUga25vdyBob3cg
YmVzdCB0byBwcm9jZWVkIGFuZCBJIHNoYWxsIGJlIGhhcHB5IHRvIG9ibGlnZSAtLQo+PiB3aGV0
aGVyIHRvIGNvbnRpbnVlIG1haW50YWluaW5nIHRoaXMgcGF0Y2hzZXQgb3IgdG8gZHJvcCB0aGlz
IGRlc2lnbiBpbgo+PiBmYXZvciBvZiBpbXByb3ZpbmcgdGhlIGV4aXN0aW5nIElJTyBDb3VudGVy
IGNvZGUgaW4gdGhlIGtlcm5lbC4KPj4KPj4gSSdsbCBDQyB0aG9zZSBmcm9tIHRoZSBwYXRjaHNl
dCBzdWJtaXNzaW9uIHRvIGtlZXAgdGhlbSBpbiB0aGUgbG9vcC4KPiAKPiBJIGNvbmZpcm0gdGhh
dCBJIHN0aWxsIGludGVyZXN0ZWQgdG8gZ2V0IHRob3NlIHBhdGNoZXMgbWVyZ2VkLgo+IAo+IFJl
Z2FyZHMsCj4gQmVuamFtaW4KSGksCgpTYW1lIGZvciBtZSwKClJlZ2FyZHMsCkZhYnJpY2UKPj4K
Pj4gU2luY2VyZWx5LAo+Pgo+PiBXaWxsaWFtIEJyZWF0aGl0dCBHcmF5Cj4+Cj4+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0Cj4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+
PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwKPiAKPiAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
