Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36363C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:12:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0906620866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ArwWB5bZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YM9GLDOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0906620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IO7R08HWYE3ok83bS+Ig77IuKO0ypC4vI8r0DTnMXTk=; b=ArwWB5bZLkrRxV82nYpCtys4e
	Wko9hUuMcAg+HMSylbjXKUswGkYxInGholdvo36g/6IzXmKfOmFx8k6EmQ7dlMWQ0T4EbCER3DWj8
	oS7IFSAXjy7ulz1eL8PsGtpL2bsxKYaKjecU6+gZZ2nGFs91cURzopQt4ll/Ct5EgNw9YzvdfQjRp
	SXMKvFGsks8K5DCUM4arr62VBgTRhvY97OSX9YdabW6X3MG4T693E0uXPcpKX/8Tg78r0fxP7cOyD
	H1APH1JRRaQXOATI5f4qJKZAplJNEHjgRaDuThn9x64DyzAsjoE1AmKPqhpE42hWa0cTphafHNWcy
	COCXkZKAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm2Po-0006y0-B8; Tue, 22 Jan 2019 20:12:56 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm2Pk-0006hf-3a
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 20:12:53 +0000
Received: by mail-pl1-x643.google.com with SMTP id e5so12007423plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 12:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lzB1F40T0BECSjVk/G6PCWKauVkIgx1ZLhCXr/OL7Go=;
 b=YM9GLDOk+3AYhoaSB9s0WFl3KB6pVvIpBmK0SgWDzOq74gZvD4vwl+v3Vge+G6tkrZ
 5PVx9l7VeUChsX3+PHA6/HsBORkrDvQzlYuAORN7plXWU/NGLCECm2UcriIl6EOZN1xE
 bZi1XQ7llQNoqEwGEOMoZgrcGRJSEekD4ZRLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lzB1F40T0BECSjVk/G6PCWKauVkIgx1ZLhCXr/OL7Go=;
 b=Ni1nLT/ViKeO3kshTIhJM1iaf5E80y83G3pGodAnfY2VCIwqeChVTZ1TppfQhraYIc
 HXqhBEfmqOPmear8gvK1DMeE+ibYMsGJEunCLo3xP/VRaI6WZxQsp4pLkfybTLh8tIZ0
 NQCtTgdF6m4j2LS4V9eWH/ps7jBpneT9T+7SAyjslzBjuT0s/nf+z1rVuVJPSc97MPPZ
 tqarZ1cWnUADdkXIKI6e4xvySXFn6YojvnKAlbnZvAww2kExDPkjlQN9vJNNdUFrikwY
 4QGJZEfvSxwjdTaJImrpJwM4lFZi5wUy1Co5BB3M2Xly2FyC5Zby3IbDd4GupHrKBuqJ
 D2dA==
X-Gm-Message-State: AJcUukd+X2okwFVKNvnlhULuYYG+Q1AVzrmDxtYnrgG1eUl/BeBtqbei
 ko20XHnmIYrNh6WJ1Bkp3CfUKwIW1ZUlU5Gy
X-Google-Smtp-Source: ALg8bN6QE0zUBhaoAiv7g5A3LcMyvBk8c5qEm/CIe09HjPpiLCzzM8dFu9PnpMkvv/heAgLgVRvkMQ==
X-Received: by 2002:a17:902:b01:: with SMTP id
 1mr36296019plq.331.1548187971203; 
 Tue, 22 Jan 2019 12:12:51 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id l85sm26297518pfg.161.2019.01.22.12.12.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 12:12:50 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
To: Rob Herring <robh@kernel.org>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
 <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
 <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
 <20190121231105.GA928@bogus>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <9b2dd73d-3a38-3a68-d37c-490811ed80ee@broadcom.com>
Date: Tue, 22 Jan 2019 12:12:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121231105.GA928@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_121252_151456_736F299A 
X-CRM114-Status: GOOD (  28.42  )
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
Cc: linux-pwm@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iLAoKT24gMjAxOS0wMS0yMSAzOjExIHAubS4sIFJvYiBIZXJyaW5nIHdyb3RlOgo+IE9u
IFR1ZSwgSmFuIDE1LCAyMDE5IGF0IDA0OjE0OjIxUE0gLTA4MDAsIFNjb3R0IEJyYW5kZW4gd3Jv
dGU6Cj4+IEhpIFV3ZSwKPj4KPj4gT24gMjAxOS0wMS0xMiA3OjA1IGEubS4sIFV3ZSBLbGVpbmUt
S8O2bmlnIHdyb3RlOgo+Pj4gSGVsbG8gU2NvdHQsCj4+Pgo+Pj4gT24gRnJpLCBKYW4gMTEsIDIw
MTkgYXQgMDE6Mjg6NDVQTSAtMDgwMCwgU2NvdHQgQnJhbmRlbiB3cm90ZToKPj4+PiBPbiAyMDE5
LTAxLTExIDEyOjQ4IHAubS4sIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOgo+Pj4+PiBPbiBGcmks
IEphbiAxMSwgMjAxOSBhdCAxMDo1MToxNEFNICswNTMwLCBTaGVldGFsIFRpZ2Fkb2xpIHdyb3Rl
Ogo+Pj4+Pj4gRnJvbTogUHJhdmVlbiBLdW1hciBCIDxwcmF2ZWVuLmJAYnJvYWRjb20uY29tPgo+
Pj4+Pj4KPj4+Pj4+IEFkZCBuZXcgY29tcGF0aWJsZSBzdHJpbmcgZm9yIG5ldyB2ZXJzaW9uIG9m
IHB3bS1rb25hCj4+Pj4+Pgo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUHJhdmVlbiBLdW1hciBCIDxw
cmF2ZWVuLmJAYnJvYWRjb20uY29tPgo+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFJheSBKdWkgPHJheS5q
dWlAYnJvYWRjb20uY29tPgo+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFNjb3R0IEJyYW5kZW4gPHNjb3R0
LmJyYW5kZW5AYnJvYWRjb20uY29tPgo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogU2hlZXRhbCBUaWdh
ZG9saSA8c2hlZXRhbC50aWdhZG9saUBicm9hZGNvbS5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICAg
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2JyY20sa29uYS1wd20udHh0
IHwgMiArLQo+Pj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcHdtL2JyY20sa29uYS1wd20udHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3B3bS9icmNtLGtvbmEtcHdtLnR4dAo+Pj4+Pj4gaW5kZXggOGVhZTlmZS4u
ZDM3ZjY5NyAxMDA2NDQKPj4+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wd20vYnJjbSxrb25hLXB3bS50eHQKPj4+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wd20vYnJjbSxrb25hLXB3bS50eHQKPj4+Pj4+IEBAIC0zLDcgKzMs
NyBAQCBCcm9hZGNvbSBLb25hIFBXTSBjb250cm9sbGVyIGRldmljZSB0cmVlIGJpbmRpbmdzCj4+
Pj4+PiAgICAgVGhpcyBjb250cm9sbGVyIGhhcyA2IGNoYW5uZWxzLgo+Pj4+Pj4gICAgIFJlcXVp
cmVkIFByb3BlcnRpZXMgOgo+Pj4+Pj4gLS0gY29tcGF0aWJsZTogc2hvdWxkIGNvbnRhaW4gImJy
Y20sa29uYS1wd20iCj4+Pj4+PiArLSBjb21wYXRpYmxlOiBzaG91bGQgY29udGFpbiAiYnJjbSxr
b25hLXB3bSIgb3IgImJyY20sa29uYS1wd20tdjIiCj4+Pj4+IElzIHYyIHVzZWQgb24gYSBuZXdl
ciBnZW5lcmF0aW9uIG9mIGtvbmEgU29Dcz8gT24gaS5NWCB0aGVzZSB2YXJpYW50cwo+Pj4+PiBh
cmUgdXN1YWxseSBuYW1lZCBhZnRlciB0aGUgZmlyc3QgU29DIHRoYXQgY2FtZSB3aXRoIHRoZSBu
ZXcgdmFyaWFudC4gSXMKPj4+Pj4gdGhpcyBzZW5zaWJsZSBoZXJlLCB0b28/Cj4+Pj4gSXQgZG9l
c24ndCBtYWtlIGFzIG11Y2ggc2Vuc2UgaGVyZSBhcyBkaWZmZXJlbnQgcmV2cyBvZiB0aGUgSVAg
YmxvY2sgYXJlCj4+Pj4gcGlja2VkIHVwIGJhc2VkIG9uIHZhcmlvdXMgZGVjaXNpb25zLgo+Pj4+
Cj4+Pj4gQSBuZXcgU29DIGNvdWxkIGRlY2lkZSB0byB1c2UgYW4gb2xkIHZlcnNpb24uCj4+PiBJ
TUhPIHRoaXMgaXMgbm8gcmVhc29uIHRvIG5vdCB1c2UgdGhlIG5hbWUgb2YgdGhlIG9sZGVzdCBT
b0Mgd2l0aCB0aGlzCj4+PiB2YXJpYW50LiBJIGRvbid0IGtub3cgaG93IHRoZSBTb0MgbmFtZXMg
YXJlIGluIHRoZSBicm9hZGNvbSBmYW1pbHksIGJ1dAo+Pj4gaWYgdGhleSB3ZXJlIChpbiBvcmRl
ciBvZiBhZ2UsIG9sZGVzdCBmaXJzdCk6Cj4+Pgo+Pj4gCWFudAo+Pj4gCWJlYXIKPj4+IAljcm9j
b2RpbGUKPj4+Cj4+PiBhbmQgYW50IGFuZCBjcm9jb2RpbGUgdXNlIHRoZSBzYW1lIElQIGJsb2Nr
IHdlIHdvdWxkIGhhdmUKPj4+Cj4+PiBhKSB3aXRoIHYxLCB2MjoKPj4+Cj4+PiAJYW50Ogo+Pj4g
CQljb21wYXRpYmxlID0gImJyY20sa29uYS1wd20tdjEiOwo+Pj4gCWJlYXI6Cj4+PiAJCWNvbXBh
dGlibGUgPSAiYnJjbSxrb25hLXB3bS12MiI7Cj4+PiAJY3JvY29kaWxlOgo+Pj4gCQljb21wYXRp
YmxlID0gImJyY20sa29uYS1wd20tdjEiOwo+IFZlcnNpb24gbnVtYmVycyBjYW4gYmUgZmluZSwg
YnV0IGdlbmVyYWxseSBvbmx5IGFzIGZhbGxiYWNrcyBhcyBldmVuIHRoZQo+IHNhbWUgSVAgdmVy
c2lvbiBjYW4gYmUgaW50ZWdyYXRlZCBpbnRvIGFuIFNvQyBkaWZmZXJlbnRseS4KPgo+IFRoZSBv
dGhlciBpc3N1ZSB3aXRoIHZlcnNpb25zIGlzIHRoZXkgc2hvdWxkIGJlIG1lYW5mdWwgc3VjaCBh
cwo+IGNvcnJlc3BvbmRpbmcgdG8gdmVyc2lvbiB0YWdzIGluIElQIHJlcG9zLiBPZnRlbiwgSSdk
IGd1ZXNzIGFueXRoaW5nCj4gd2l0aCBhICd2MScgaXMganVzdCB3aGF0IHNvbWUgcy93IHBlcnNv
biBtYWRlIHVwLiBPZiBjb3Vyc2UsIHdlIG9ubHkKPiBjYW4gcmVhbGx5IGtub3cgdGhhdCBmb3Ig
b3BlbnNvdXJjZSBJUCBvciBwcm9ncmFtbWFibGUgbG9naWMgSVAuCj4KPiBJZiB5b3UgZG8gdXNl
IHZlcnNpb25zLCBkb2N1bWVudCB3aGF0IHRoZSB2ZXJzaW9uaW5nIHNjaGVtZSBpcy4KPgo+Pj4g
OyBhbmQKPj4+Cj4+PiBiKSB3aXRoIHRoZSBTb0MgbmFtaW5nOgo+Pj4KPj4+IAlhbnQ6Cj4+PiAJ
CWNvbXBhdGlibGUgPSAiYnJjbSxrb25hLWFudC1wd20iOwo+Pj4gCWJlYXI6Cj4+PiAJCWNvbXBh
dGlibGUgPSAiYnJjbSxrb25hLWJlYXItcHdtIjsKPj4+IAljcm9jb2RpbGU6Cj4+PiAJCWNvbXBh
dGlibGUgPSAiYnJjbSxrb25hLWNyb2NvZGlsZS1wd20iLCAiYnJjbSxrb25hLWFudC1wd20iOwo+
IFRoaXMgaXMgdGhlIHJlY29tbWVuZGVkIHByYWN0aWNlLgo+Cj4+PiAoSWYgeW91IHdhbnQsIGRy
b3AgImJyY20sa29uYS1jcm9jb2RpbGUtcHdtIiwgYnV0IGtlZXBpbmcgaXQgaXMgbW9yZQo+Pj4g
ZGVmZW5zaXZlLikKPiBHZW5lcmFsbHksIHlvdSBzaG91bGQgaGF2ZSAiYnJjbSxrb25hLWNyb2Nv
ZGlsZS1wd20iIGluIGNhc2UgdGhlcmUncwo+IHNvbWUgZGlmZmVyZW5jZSBmb3VuZCBsYXRlci4g
VGhlbiB5b3UgY2FuIHN1cHBvcnQgdGhlIGJ1ZyBvciBmZWF0dXJlCj4gd2l0aG91dCBhIERUIGNo
YW5nZS4KCk5vIERUIGNoYW5nZSB3b3VsZCBiZSBuZWNlc3NhcnkgaW4gYW55IGNhc2UuCgpBIGNo
ZWNrIGFnYWluc3QgdGhlIFNPQyB0eXBlIGluIHRoZSBkcml2ZXIgd2l0aG91dCBhZGRpdGlvbmFs
IERUIApjb21wYXRpYmlsaXR5IHN0cmluZ3MgY291bGQgYmUgZG9uZS4KCj4KPj4+IEkgbGlrZSBi
KSAod2l0aCAiLi4uLWNyb2NvZGlsZS0uLi4iKSBiZXR0ZXIgdGhhbiBhKS4gY3JvY29kaWxlIHVz
aW5nCj4+PiAiLi4uLWFudC0uLi4iIGlzIG5vdCBtb3JlIHVnbHkgdGhhbiBjcm9jb2RpbGUgdXNp
bmcgIi4uLi12MSIuIFRoaXMgaXMKPj4+IGFsc28gYSB0YWQgbW9yZSByb2J1c3QgYmVjYXVzZSBp
ZiBicm9hZGNvbSByZWxlYXNlcyBrb25hLWRvbHBoaW4gYW5kCj4+PiBzb21lb25lIGZpbmRzIGEg
bWlub3IgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBJUHMgdXNlZCBvbiBhbnQgYW5kCj4+PiBjcm9j
b2RpbGUgaXQgZGVwZW5kcyBvbiB0aGUgb3JkZXIgb2YgdGhlc2UgZXZlbnRzIHdobyBnZXRzIHYz
LCB3aGlsZQo+Pj4gd2l0aCB0aGUgU29DIG5hbWluZyB0aGUgcmVzdWx0IGlzIGNsZWFyLgo+Pj4K
Pj4+IChPSywgYW5kIGdpdmVuIHRoYXQgImJyY20sa29uYS1wd20iIGlzIGFscmVhZHkgZml4ZWQs
IGJvdGggYXBwcm9hY2hlcwo+Pj4gbmVlZCBzbGlnaHQgYWRhcHRpb24sIGJ1dCBJIGd1ZXNzIHlv
dSBzdGlsbCBnZXQgd2hhdCBJIG1lYW50LikKPj4gVGhhbmtzIGZvciB5b3VyIHRob3VnaHRzIGFu
ZCBleHBsYW5hdGlvbi4KPj4KPj4gSXQgaXMgdW5mb3J0dW5hdGUgZGV2aWNldHJlZSBoYXMgbm8g
cHJvcGVyIGd1aWRlbGluZXMgb3IgZG9jdW1lbnRhdGlvbiBvbgo+Pgo+PiBiaW5kaW5nIG5hbWlu
Zy7CoCBJbiB0aGUgaW50ZXJlc3Qgb2YgZ2V0dGluZyB0aGlzIHVwc3RyZWFtIHdlIGNhbiBuYW1l
IGl0Cj4gU3VyZWx5IHdlJ3ZlIGNhcHR1cmVkIHRoYXQgc29tZXdoZXJlLi4uCgpQbGVhc2UgcG9p
bnQgbWUgYXQgc3VjaCBkb2N1bWVudGF0aW9uLgoKVGhlcmUgaXMgbm8gY29uc2lzdGVuY3kgaW4g
a2VybmVsIGRyaXZlcnMgZnJvbSB3aGF0IEkgaGF2ZSBzZWVuLgoKPgo+PiAiYnJjbSwgb21lZ2Et
cHdtIi7CoCBXZSBjYW4gZHJvcCBrb25hIGZyb20gdGhlIGJpbmRpbmcgbmFtZSBhcyB0aGF0Cj4+
IGFyY2hpdGVjdHVyZQo+Pgo+PiBpcyByZWFsbHkgbm8gbW9yZSAtIG9ubHkgSVAgZGVyaXZlZCBm
cm9tIGl0IGlzIC0gaGVuY2UgdGhlIG5hbWUga29uYS12Mgo+PiBwcmV2aW91c2x5Lgo+Pgo+Pj4g
QmVzdCByZWdhcmRzCj4+PiBVd2UKPj4+Cj4+Pgo+PiBDaGVlcnMsCj4+IFNjb3R0CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
