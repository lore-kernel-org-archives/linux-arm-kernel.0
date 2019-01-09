Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B961C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:01:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E3020685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PyyAcocT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN3l1YHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E3020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Kc7/IyKXYK/kYmIg3D/OPbGX4KAEKmq12Ut+GwwTnu0=; b=PyyAcocTHlvAr1
	lmdc9hVa8WmP0QGG0snevjQeJ1D3mDjEAHLlsCvV0Fv7UXVqaP9CxAdhy4SvHLcUw69pE3KGXEerM
	vcngYRCRrswNIDHlYkiCmA8o9kt1jPBb4LPXoNMlguFTMluagn7Km6UHH1rhEYHy0dT2iz0inYRHU
	ac8ApRGMV2j3Ncm+83sFxMWT1CNm9IdvaQwFnZVf7nkXdVJZcg1ltkcOZw3SGMg2O1AbIqffz8wWA
	lgQiqhw0m+5dhczLyARSoZRA5Rltdoe5LB+GpYRpooeyu9gwTJF6yrWX92EoBOqfGXK6WIZzEnk8+
	4jCQ2UfDXhCx6wb1uaDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghI9v-0006kN-Gw; Wed, 09 Jan 2019 18:00:55 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghI9s-0006jq-OA
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:00:54 +0000
Received: by mail-lf1-x141.google.com with SMTP id y11so6328849lfj.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 10:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f/Exw1NcVYYqGrDV4q3XAZMtf+t2lHH10SHKVIs+s0M=;
 b=nN3l1YHTwyNvgXU5aHouPLyz5RKleujjsUrUQZNpon475ZWiOOpJhVfzvr8J8jmsyo
 4J80CT+b2kpk0JndsiBspEE2vT08vfhyAM8SZVxkeRTpqrE+fZI3qhAHWCyeCLZZXdw7
 HJuNtqnIKTOJiT+q1ZvS0vh87pBnDs8B2HWKr462Hk/xGzwy7gVb+C6tqI2j0rBi1BwK
 2WQu75lAirxUOH+Vwvou68ojYlRqFHKaRzPSJ4gRa5+5rj7DyoRX7yhttS/3hO/qz6dP
 LTPlb/LnyO6SwXkP2Xp3VgG7tsmX97plEXlJHE56QAbKQ+w2O0qvTtVSWndptRT4KCuF
 K4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f/Exw1NcVYYqGrDV4q3XAZMtf+t2lHH10SHKVIs+s0M=;
 b=Y0T3xX/5mUPQd9ilD1rVhovRK3PpbdKN89skJTMdSs+KnY42sAJc6x3G4nzbyWEvqk
 9Ce4+gppq3KdjS3fs6ANK20o7m9lhiNlrYCXsXOppNUPHYg9uZi+HPpzKYIYDkYbk8u8
 JcKwAfLTPa28Jnk+s9T5FAUvjtIl6tQldEvwE4Vo9ASkuPZ//YHTRQDkLjPIasoyPhEK
 AG2JlTfnv9ymzTwyf+r9vUBNkAgo+enTpI9meOjoofFcc+Ja9GpO+VrviomcweCctDzz
 JGzcdw/2JbeJwyvAVv52jgx0EhjFqqAwP+D6MXh7BTCoUJ83QElPJFPv34LTeE6LsZ9+
 HwTg==
X-Gm-Message-State: AJcUukeQ989ev1997exiHH7kvlgrk0RuOOgAr3sAWyLt5o/HMjzoJkJ6
 nMcl6HBageR7QFNC+CWoZZY=
X-Google-Smtp-Source: ALg8bN5fQjwNwyGqcTdgDv8HuAV34HEznubOvmzRp6xS1BVxGJxxbr7M5qR87k+TaO5am3Uy05NqNQ==
X-Received: by 2002:a19:660a:: with SMTP id a10mr4350637lfc.146.1547056847286; 
 Wed, 09 Jan 2019 10:00:47 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:c1c3:bc43:64cd:2432])
 by smtp.googlemail.com with ESMTPSA id p67sm13817510lfe.14.2019.01.09.10.00.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 10:00:46 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: andrzej.p@samsung.com
Subject: [PATCH] media: s5p-jpeg: Correct step and max values for
 V4L2_CID_JPEG_RESTART_INTERVAL
Date: Wed,  9 Jan 2019 19:00:41 +0100
Message-Id: <20190109180041.31052-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_100052_813793_C7E40548 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: linux-samsung-soc@vger.kernel.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
 linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com,
 s.nawrocki@samsung.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBjb21taXQgY29ycmVjdHMgbWF4IGFuZCBzdGVwIHZhbHVlcyBmb3IgdjRsMiBjb250cm9s
IGZvcgpWNEwyX0NJRF9KUEVHX1JFU1RBUlRfSU5URVJWQUwuIE1heCBzaG91bGQgYmUgMHhmZmZm
IGFuZCBzdGVwIHNob3VsZCBiZSAxLgpJdCB3YXMgZm91bmQgYnkgdXNpbmcgdjRsMi1jb21wbGlh
bmNlIHRvb2wgYW5kIGNoZWNraW5nIHJlc3VsdCBvZgpWSURJT0NfUVVFUllfRVhUX0NUUkwvUVVF
UllNRU5VIHRlc3QuClByZXZpb3VzbHkgaXQgd2FzIGNvbXBsYWluaW5nIHRoYXQgc3RlcCB3YXMg
YmlnZ2VyIHRoYW4gZGlmZmVyZW5jZQpiZXR3ZWVuIG1heCBhbmQgbWluLgoKRml4ZXM6IDE1ZjRi
YzNiMWY0MiAoIlttZWRpYV0gczVwLWpwZWc6IEFkZCBKUEVHIGNvbnRyb2xzIHN1cHBvcnQiKQpT
aWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5j
b20+Ci0tLQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zNXAtanBlZy9qcGVnLWNvcmUuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vczVwLWpwZWcvanBlZy1jb3JlLmMgYi9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL3M1cC1qcGVnL2pwZWctY29yZS5jCmluZGV4IDNmOTAwMGI3MDM4
NS4uMzNlOTkyN2RiOWEwIDEwMDY0NAotLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3M1cC1q
cGVnL2pwZWctY29yZS5jCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vczVwLWpwZWcvanBl
Zy1jb3JlLmMKQEAgLTIwMDIsNyArMjAwMiw3IEBAIHN0YXRpYyBpbnQgczVwX2pwZWdfY29udHJv
bHNfY3JlYXRlKHN0cnVjdCBzNXBfanBlZ19jdHggKmN0eCkKIAogCQl2NGwyX2N0cmxfbmV3X3N0
ZCgmY3R4LT5jdHJsX2hhbmRsZXIsICZzNXBfanBlZ19jdHJsX29wcywKIAkJCQkgIFY0TDJfQ0lE
X0pQRUdfUkVTVEFSVF9JTlRFUlZBTCwKLQkJCQkgIDAsIDMsIDB4ZmZmZiwgMCk7CisJCQkJICAw
LCAweGZmZmYsIDEsIDApOwogCQlpZiAoY3R4LT5qcGVnLT52YXJpYW50LT52ZXJzaW9uID09IFNK
UEVHX1M1UCkKIAkJCW1hc2sgPSB+MHgwNjsgLyogNDIyLCA0MjAgKi8KIAl9Ci0tIAoyLjE3LjEK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
