Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E07C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:51:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA272070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oVlmqzYR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mJSmQKnn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dxjwamaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA272070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:Subject:To:From:Date:MIME-Version:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W5FHeMTjCm3usRL3emYDgXhym+L/kbMbp4EiUFQTWnw=; b=oVlmqzYRZ7MOdzyIhI0meDrJEs
	guOpfWpXcIYIuGJim576yBp4qEmsLQ80bn+ERn4NnnM+EGzNSOJ8HE4ravDDGw9Ijfa0Ozl65ocPr
	oVGzkNoomVzVlcU4nypyFTj/kk4qyTNngftT8Ng/TkICqWU2UajZNOg9xIf2qBEkAr7QHAWyaonXB
	aJ6/UKThg0uBE87cHGt9+BL0DD0R0buBFuzXYZtGGd5LqfmiNPQkfLYDwXtZJ5OPT9hPj7miuoozj
	YKn4r9MN9f0t9t4EPy2z7DYJq/VRsAVhuVszxzeK9bP5POhhBOqSY5jxZXNKjrIEHcTG+gP8rOvOW
	s6dvIJfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZhsU-0002RT-PB; Wed, 19 Dec 2018 19:51:34 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZhsR-0002Qa-HF
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 19:51:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 70B336055D; Wed, 19 Dec 2018 19:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545249080;
 bh=VHZONW94vpYDHpBgGNvLYtF8q29VTjx+UYGnR6dinHw=;
 h=Date:From:To:Cc:Subject:From;
 b=mJSmQKnnX4ldHW1V7PMYV7YfRDtY6e/RtFGRQoIb8QXtE0iRkTGiKUArqswWeu1uM
 ntt58bmxbI4JfvM+s3W/kqkRmm/b5IaPDvo/7BAvyXSVQGmc49BnDsq0M+trFBVAXn
 cOOIt31y7xIB1cac0MetLbLZz6Y0mokDTJVYDlz8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 by smtp.codeaurora.org (Postfix) with ESMTP id C1D9760591;
 Wed, 19 Dec 2018 19:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545249079;
 bh=VHZONW94vpYDHpBgGNvLYtF8q29VTjx+UYGnR6dinHw=;
 h=Date:From:To:Cc:Subject:From;
 b=dxjwamaQR1qgYBdpr5AoiMFh6GjwacpmZ0yd8H8+O9qqc8MIreTGoL9utxpSLXrK4
 vuCM5mdfPnbUAsW9e5YDq1H7f5A0Mkdm6iOMlOZdqqMmXzI8pRK51+3QWzFktTMqb3
 OeUa3yl+lkmvU8t63d/B7l2FOccM00ICnUMaNFjo=
MIME-Version: 1.0
Date: Wed, 19 Dec 2018 11:51:19 -0800
From: rishabhb@codeaurora.org
To: keescook@chromium.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Linux-arm Kernel
 <linux-arm-kernel@lists.infradead.org>
Subject: usercopy_warn in __copy_to_user
Message-ID: <ecb306ea6f4a83302e78884713ad7823@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_115131_603384_9178C18B 
X-CRM114-Status: UNSURE (   7.93  )
X-CRM114-Notice: Please train this message.
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
Cc: tsoni@codeaurora.org, ckadabi@codeaurora.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CkluIHRoZSA0LjE5IGtlcm5lbCwgd2UgYXJlIHNlZWluZyBhIFVTRVJDT1BZX1dBUk4gaW4gX19j
b3B5X3RvX3VzZXIgCmR1cmluZyBib290dXAuClRoZSBjb2RlLWZsb3cgaXMgc29tZXRoaW5nIGxp
a2UgdGhpczoKCihhcmNoL2FybTY0L2tlcm5lbC9zaWduYWwuYykKc3RydWN0IHNpZ3NldF90ICpz
ZXQ7Cl9fY29weV90b191c2VyKCZzZi0+dWMudWNfc2lnbWFzaywgc2V0LCBzaXplb2YoKnNldCkp
CgooaW5jbHVkZS9saW51eC91YWNjZXNzLmgpCl9fY29weV90b191c2VyKHZvaWQgX191c2VyICp0
bywgY29uc3Qgdm9pZCAqZnJvbSwgdW5zaWduZWQgbG9uZyBuKQp7CiAgICAgICAgICAgICAgICAg
bWlnaHRfZmF1bHQoKTsKICAgICAgICAgICAgICAgICBrYXNhbl9jaGVja19yZWFkKGZyb20sIG4p
OwogICAgICAgICAgICAgICAgIGNoZWNrX29iamVjdF9zaXplKGZyb20sIG4sIHRydWUpOwogICAg
ICAgICAgICAgICAgIHJldHVybiByYXdfY29weV90b191c2VyKHRvLCBmcm9tLCBuKTsKfQoKKGlu
Y2x1ZGUvbGludXgvdGhyZWFkX2luZm8uaCkKc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGNo
ZWNrX29iamVjdF9zaXplKGNvbnN0IHZvaWQgKnB0ciwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgbiwgYm9vbCB0b191c2VyKQp7CiAgICAgICAgICAgICAg
ICAgaWYgKCFfX2J1aWx0aW5fY29uc3RhbnRfcChuKSkKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgX19jaGVja19vYmplY3Rfc2l6ZShwdHIsIG4sIHRvX3VzZXIpOwp9CgpTaW5jZSBz
aXplb2YoKnNldCkgaXMgY29uc3RhbnQsIF9fYnVpbHRpbl9jb25zdGFudF9wKG4pIHNob3VsZCBy
ZXR1cm4gCnRydWUuCkJ1dCB3ZSBhcmUgc2VlaW5nIHRoYXQgaXRzIHJldHVybmluZyB0aGUgdmFs
dWUgYXMgZmFsc2UuIEJlY2F1c2Ugb2YgCndoaWNoCnRoZSBjb2RlIGdvZXMgb24gdG8gX19jaGVj
a19vYmplY3Rfc2l6ZSBhbmQgZ2VuZXJhdGVzIGEgVVNFUkNPUFlfV0FSTgooInVzZXJjb3B5OiBX
QVJOKCkgb24gc2xhYiBjYWNoZSB1c2VyY29weQpyZWdpb24gdmlvbGF0aW9ucyIpLgoKV2UgYXJl
IHVzaW5nIExMVk0gY2xhbmcgdmVyc2lvbiA2LjAgdG8gY29tcGlsZSB0aGUga2VybmVsIGFuZCBu
b3QgZ2NjLgpJbiBjbGFuZywgX19idWlsdGluX2NvbnN0YW50X3AgaXMgZXZhbHVhdGVkIGltbWVk
aWF0ZWx5LCBiZWZvcmUgaW5saW5pbmcKb3Igb3RoZXIgb3B0aW1pemF0aW9ucyBydW4sIGdjYyBl
dmFsdWF0ZXMgaXQgbGF0ZXIuCldlIGJlbGlldmUgdGhhdCBtYXliZSBjYXVzaW5nIF9fYnVpbHRp
bl9jb25zdGFudF9wKG4pIHRvIHJldHVybiBmYWxzZS4KVGhlcmXigJlzIHVwc3RyZWFtIHdvcmsg
dG8gY2hhbmdlIExMVk0sIHNvIF9fYnVpbHRpbl9jb25zdGFudF9wIHdvcmtzIG1vcmUKbGlrZSBn
Y2Mgd2hlbiBvcHRpbWl6YXRpb24gaXMgZW5hYmxlZCwgYnV0IGl0cyBzdGlsbCBpbiBwcm9ncmVz
cy4KCgpGb3IgdGhpcyBzY2VuYXJpbyBpcyB0aGVyZSBhIHdheSB0byBhdm9pZCB0aGUgd2Fybmlu
Zz8gU2hvdWxkIHRoZSBjb2RlIApiZQp3cml0dGVuIGluIGEgZGlmZmVyZW50IHRvIGF2b2lkIGRl
cGVuZGVuY3kgb24gY29tcGlsZXI/CgpUaGFua3MsClJpc2hhYmgKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
