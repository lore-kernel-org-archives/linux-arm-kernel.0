Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7232FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:59:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF2520821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AgXgY028";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1+0BX7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF2520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zPUMPQt15NRbuS9MZD/Lct1Lp8e/vld9kAnSW0nTVEo=; b=AgXgY028lLqT/M
	JnxVtVGU1S9dmnPcZD3b3gKAaSw9ef/eBL3Kaf8GIVOO61jE60Pi7zDjBdeP6DAN0OlgfM+nLwIi7
	iyTAqB96vqTjxtfXXyQ8s8z/elKmGL4gzUmvB+26CTBnr4e0bSX2cI8RaC+43l+jgOUkPTqMbNT4j
	IQ555LJcSGwYIsRT9dwNT7iu8OwINoIK97xW4HFO2jW04DdmTfF6Q1lRM6CmIiWM8DTbn037cyBZP
	gXVJZindoifRHpzudD/Fyt8P1VvngV3q3Jn9Cg+GsN5kOlV+ALURLYn8/3wPOdLCW8GapYRV1fW04
	dP7Vljk138FGQeLJ4qxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKDu-0003tz-I1; Mon, 10 Dec 2018 11:59:42 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKDq-0003tX-Mm
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:59:40 +0000
Received: by mail-wr1-x442.google.com with SMTP id l9so10135380wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qaCop6a20Q0nzan8ttHGf8/SjzJGQNLWRubPwRQfQMI=;
 b=D1+0BX7fKXu+i8t0vGqEkByaaAh+qQzDGYRjkSqTqLOrJ5vxujRjXOoRgO32PLNXa2
 PRUoCeh0xFr1ENXf9YtYH22gWhqK8oIgOm0JmAtyIYio8XbZKkwKmZJcLi4XQgz0hW3u
 rKgMtGjyXKlEcALUQUVnFwZie5hc9o/4fDsW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qaCop6a20Q0nzan8ttHGf8/SjzJGQNLWRubPwRQfQMI=;
 b=h+Gmq1oyCA7ZIGois58biAwaz0RPomNWjv2NYr6i+i3KRlgQiY7pdL6Vedy3xcpJWl
 mjPo7tx580JvjZLBnrQ5GTT8Jowbqe9p7CByTjuuW3jNfFJK4tSOHlJQT+xt4Gxs4id6
 4fleigB90gyyZaXx3FDjuGXqrcg7wUrjJJ7Dj046nFIqd3qRl7h0a1h2WL9xuvnZp8ka
 IHz9kjIUQulbFycNUT29MS3/2AH//umUnC3UImXL3ChbYOojlA2L18ZkswqrDxoxhUug
 iZS8i4OSV3xMUmtuRe4Ku0ptJ7UEisVSGndoQOIdd6WCPSFYdnYMAraKzyvNQcRHf4C6
 AK3A==
X-Gm-Message-State: AA+aEWZs85KFITnd+3jNxdicH9p6KOFOfVzqBPBvPvHmvNuDpmGJbInw
 6OaqBtqoHJIjI0AOkkDxJ81SLHkiSmc=
X-Google-Smtp-Source: AFSGD/WMZ6FH/0LB50BqAbb2y7mE9InaQbsWXqgAutW2V4jH7YsxP5CxEuE0aRuQOozhiXv6NE+X0A==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr10084831wrr.162.1544443166749; 
 Mon, 10 Dec 2018 03:59:26 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2]) by smtp.googlemail.com with ESMTPSA id
 e142sm30847835wmf.46.2018.12.10.03.59.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 03:59:26 -0800 (PST)
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
To: Yangtao Li <tiny.windzz@gmail.com>, rjw@rjwysocki.net,
 lorenzo.pieralisi@arm.com
References: <20181120161451.21149-1-tiny.windzz@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ed0c146f-0a47-ef56-f919-4887d6a69001@linaro.org>
Date: Mon, 10 Dec 2018 12:59:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120161451.21149-1-tiny.windzz@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_035938_800170_C6E79A49 
X-CRM114-Status: GOOD (  19.98  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CkhpIFlhbmd0YW8sCgoKT24gMjAvMTEvMjAxOCAxNzoxNCwgWWFuZ3RhbyBMaSB3cm90ZToKPiBv
Zl9maW5kX25vZGVfYnlfcGF0aCgpIGFjcXVpcmVzIGEgcmVmZXJlbmNlIHRvIHRoZSBub2RlCj4g
cmV0dXJuZWQgYnkgaXQgYW5kIHRoYXQgcmVmZXJlbmNlIG5lZWRzIHRvIGJlIGRyb3BwZWQgYnkg
aXRzIGNhbGxlci4KPiBibF9pZGxlX2luaXQoKSBkb2Vzbid0IGRvIHRoYXQsIHNvIGZpeCBpdC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBZYW5ndGFvIExpIDx0aW55LndpbmR6ekBnbWFpbC5jb20+Cj4g
LS0tCj4gQ2hhbmdlcyBpbiB2MzoKPiAtdXBkYXRlIGNoYW5nZWxvZwo+IC0tLQo+ICBkcml2ZXJz
L2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxlLmMgfCA2ICsrKysrLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY3B1aWRsZS9jcHVpZGxlLWJpZ19saXR0bGUuYyBiL2RyaXZlcnMvY3B1aWRsZS9jcHVpZGxl
LWJpZ19saXR0bGUuYwo+IGluZGV4IGRiMmVkZTU2NWYxYS4uNjUwZjA2M2VmODA5IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvY3B1aWRsZS9jcHVpZGxlLWJpZ19saXR0bGUuYwo+ICsrKyBiL2RyaXZl
cnMvY3B1aWRsZS9jcHVpZGxlLWJpZ19saXR0bGUuYwo+IEBAIC0xNzQsOCArMTc0LDEyIEBAIHN0
YXRpYyBpbnQgX19pbml0IGJsX2lkbGVfaW5pdCh2b2lkKQo+ICAJLyoKPiAgCSAqIEluaXRpYWxp
emUgdGhlIGRyaXZlciBqdXN0IGZvciBhIGNvbXBsaWFudCBzZXQgb2YgbWFjaGluZXMKPiAgCSAq
Lwo+IC0JaWYgKCFvZl9tYXRjaF9ub2RlKGNvbXBhdGlibGVfbWFjaGluZV9tYXRjaCwgcm9vdCkp
Cj4gKwlpZiAoIW9mX21hdGNoX25vZGUoY29tcGF0aWJsZV9tYWNoaW5lX21hdGNoLCByb290KSl7
Cj4gKwkJb2Zfbm9kZV9wdXQocm9vdCk7Cj4gIAkJcmV0dXJuIC1FTk9ERVY7Cj4gKwl9Cj4gKwo+
ICsJb2Zfbm9kZV9wdXQocm9vdCk7CgpEb24ndCBkdXBsaWNhdGUgdGhlIG9mX25vZGVfcHV0LgoK
SSBzdWdnZXN0OgoKY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2hfaWQ7CgpbIC4uLiBd
CgoKbWF0Y2hfaWQgPSBvZl9tYXRjaF9ub2RlKGNvbXBhdGlibGVfbWFjaGluZV9tYXRjaCwgcm9v
dCk7CgpvZl9ub2RlX3B1dChyb290KTsKCmlmICghbWF0Y2hfaWQpCglyZXR1cm4gLUVOT0RFVjsK
Cgo+ICAJaWYgKCFtY3BtX2lzX2F2YWlsYWJsZSgpKQo+ICAJCXJldHVybiAtRVVOQVRDSDsKPiAK
CgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJj
ZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0cDovL3d3dy5mYWNl
Ym9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdpdHRlci5jb20vIyEv
bGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+
IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
