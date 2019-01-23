Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814F5C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:41:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5028C217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WhwyERUi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PCHnjBrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5028C217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sUfowsy/dS1vQDhvdQWKI5xZP0/1fnhjjk3ON/M4/lM=; b=WhwyERUiWt37AA1r9gDIQSv52
	UqVFHmWJJz55VkXWb4ZAMrDUy2NJ/W1ZKLnMv9ffqjUUqj0qXLD/x0SD22/OMX9QXTu+7ko51KAqg
	RQAurcWcQjiLKEVd36PuJ9FtoF9AvE0YkfrqdgUtmH5sIbTtLCIEu+EQ6JoRf+Z5Ea9y2dPyFJrZU
	MjOeMCMTeq5iLELg0N5ea8UgviIHBONq+d5b+Dhbh/1qBkTLYLF+ZHtqN7D4hGqJ2m4XfF6nv0STH
	gTlv+u9BT6EWWGMU+r89rLmyvl7u9U2wHwJopXRXUe+MKUPpMlpkbpEnug3DaWA2BtFYfr08e4VH2
	OFiTeUNew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLaj-0001h4-Nw; Wed, 23 Jan 2019 16:41:29 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLae-0001bi-4j
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:41:27 +0000
Received: by mail-pl1-x642.google.com with SMTP id y1so1432312plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 08:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GI/hD49IoXBVt9EoZ9Vh6qj1RVUXxRKhEhoy6macpd4=;
 b=PCHnjBrNtRTBrcjeqU5VuXZ2TjZoCU2L+/bASsOt74+tbu1Co/Sy88a4jvHmS6wfsI
 RtpuaYoCNG8dK5d+6pJmCiBZ5trXnd+T+R4KSXvat8x8CvffNQkOLq+dStiCFSC8e/Yb
 bLBx1b/HD1LHWjl4cC3P3HcfAdAf029FORkm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GI/hD49IoXBVt9EoZ9Vh6qj1RVUXxRKhEhoy6macpd4=;
 b=HisKuKmh55FdxRA1gaFVYY3yH3OguLAjo2QsQMZqZAdKW3UuIWrWQLCisyHbMnPNh7
 f73HLyZRb7B90urqg1BpGMygajA+OoOwKotYJSkDzyAtz+fwxOc2AzQhjL7FJqrZTOBa
 5Z/PkFnkfluKZU/Tf7qgu1iANfs7s9ZDesyWny4dnj9YC+Rfxt+NDelKEAvn9Z27KyEh
 9pghU/5clnXt8I8lJmCwaQUfiaw7mLpgnGjM9M8HyQP5f0QVKOmdctswI8KmlI9BA52S
 +lr97K5EEe7+nNZDHyjLxEerCVnKbBGMP/qiBdO7bb6CPsAoOyLxwg4GBCNINvLJA8Im
 pElA==
X-Gm-Message-State: AJcUukdF/NbHEXxiqyml09Quduz46U02ZFeQFcFneqqQvw2+vj7mMk7f
 BDWS3V1KAn3BenZwohr519f8f1dV8+gvHNDaq3MphcgEDbALGO4Q2PANJRgvUjhdLBor7l9u9sH
 EmFFHF+/fZOD9QbLEmgn/oPGKRDMtn61lFqdyKaN1KmaOulY1Tait0dwEthoDFJwygwxsszb3ym
 ng7jZfHE+mE9BYjev4z4ucUw==
X-Google-Smtp-Source: ALg8bN7JKVWnizbJRcDCFpZ54B6fEuYDbeaD9T+RKttf02y5N99L1u2vZkB6m17u8udlp4BgwM3tCg==
X-Received: by 2002:a17:902:a58c:: with SMTP id
 az12mr2777132plb.299.1548261683198; 
 Wed, 23 Jan 2019 08:41:23 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id t87sm27720015pfk.122.2019.01.23.08.41.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 08:41:22 -0800 (PST)
Subject: Re: [PATCH 1/2] ARM: defconfig: Enable BCM2835_POWER for bcm2835 and
 multi_v7
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
References: <1548252470-17920-1-git-send-email-stefan.wahren@i2se.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <616d33b6-a8c8-3ead-c0f5-f87ca71b84b6@broadcom.com>
Date: Wed, 23 Jan 2019 08:41:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548252470-17920-1-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_084124_611215_F3DD4172 
X-CRM114-Status: GOOD (  21.04  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3RlZmFuLAoKT24gMjAxOS0wMS0yMyA2OjA3IGEubS4sIFN0ZWZhbiBXYWhyZW4gd3JvdGU6
Cj4gU2luY2UgY29tbWl0IDUyYTRhZGJhZWJjYyAoIkFSTTogYmNtMjgzeDogU3dpdGNoIFYzRCBv
dmVyIHRvIHVzaW5nIHRoZQo+IFBNIGRyaXZlciBpbnN0ZWFkIG9mIGZpcm13YXJlLiIpIFZDNCBv
biBCQ00yODM1IHJlcXVpcmVzIHRoZSBwb3dlciBkcml2ZXIuCj4KPiBPdGhlcndpc2UgdGhlIGRy
aXZlciB3b24ndCBwcm9iZSBhbmQgSERNSSBvdXRwdXQgc3RheXMgYmxhY2s6Cj4gdmM0X3YzZCAy
MGMwMDAwMC52M2Q6IGlnbm9yaW5nIGRlcGVuZGVuY3kgZm9yIGRldmljZSwgYXNzdW1pbmcgbm8g
ZHJpdmVyCj4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gV2FocmVuIDxzdGVmYW4ud2FocmVuQGky
c2UuY29tPgo+IC0tLQo+ICAgYXJjaC9hcm0vY29uZmlncy9iY20yODM1X2RlZmNvbmZpZyAgfCAx
ICsKPiAgIGFyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29uZmlnIHwgMSArCj4gICAyIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKU2VlbXMgbW9yZSBmb29sIHByb29mIHRvIGFk
ZCBhIGRlZmF1bHQgQVJDSF9CQ00zODI1IGluIHRoZSBLY29uZmlnCgppbnN0ZWFkIG9mIG1vZGlm
eWluZyBtdWx0aXBsZSBkZWZjb25maWcgZmlsZXMuCgpBbmQgdGhhdCB3YXkgdXNlcnMgd2l0aCBj
dXN0b20gZGVmY29uZmlnIGZpbGVzIGZvciAyODM1IHdpbGwgZ2V0IHRoZSAKY29uZmlnIGNoYW5n
ZSBhdXRvbWF0aWNhbGx5LgoKPgo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL2JjbTI4
MzVfZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmlncy9iY20yODM1X2RlZmNvbmZpZwo+IGluZGV4
IGJiNmEzNWYuLjI4YWFjZGQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vY29uZmlncy9iY20yODM1
X2RlZmNvbmZpZwo+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3MvYmNtMjgzNV9kZWZjb25maWcKPiBA
QCAtMTMyLDYgKzEzMiw3IEBAIENPTkZJR19TTkRfQkNNMjgzNT1tCj4gICBDT05GSUdfTUFJTEJP
WD15Cj4gICBDT05GSUdfQkNNMjgzNV9NQk9YPXkKPiAgICMgQ09ORklHX0lPTU1VX1NVUFBPUlQg
aXMgbm90IHNldAo+ICtDT05GSUdfQkNNMjgzNV9QT1dFUj15Cj4gICBDT05GSUdfUkFTUEJFUlJZ
UElfUE9XRVI9eQo+ICAgQ09ORklHX1BXTT15Cj4gICBDT05GSUdfUFdNX0JDTTI4MzU9eQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL211bHRpX3Y3X2RlZmNvbmZpZyBiL2FyY2gvYXJt
L2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29uZmlnCj4gaW5kZXggZmZhZjVjMC4uN2RlYjQwNCAxMDA2
NDQKPiAtLS0gYS9hcmNoL2FybS9jb25maWdzL211bHRpX3Y3X2RlZmNvbmZpZwo+ICsrKyBiL2Fy
Y2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29uZmlnCj4gQEAgLTkwMCw2ICs5MDAsNyBAQCBD
T05GSUdfVEVHUkFfSU9NTVVfU01NVT15Cj4gICBDT05GSUdfUkVNT1RFUFJPQz1tCj4gICBDT05G
SUdfU1RfUkVNT1RFUFJPQz1tCj4gICBDT05GSUdfUlBNU0dfVklSVElPPW0KPiArQ09ORklHX0JD
TTI4MzVfUE9XRVI9eQo+ICAgQ09ORklHX1JBU1BCRVJSWVBJX1BPV0VSPXkKPiAgIENPTkZJR19R
Q09NX0dTQkk9eQo+ICAgQ09ORklHX1FDT01fUE09eQoKUmVnYXJkcywKCiDCoFNjb3R0CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
