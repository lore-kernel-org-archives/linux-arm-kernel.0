Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3223C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:40:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97682147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aQCC4BBW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fenKO9JF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97682147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VABYfUR1XdOGUngbDBL4GiIVocFpAliScCOP8QbpTR4=; b=aQCC4BBWvJNEwZ
	PQpuRZm1iEFURml/Q2Cy4D13rYXNmGUvEJdJocndoU5YjHqR0jlI1NVfbv0RE4QgMLXn5jNm8eu4e
	yASUzgyI5/pUTs9j78AUbGECPa11R/uGShmR5mqnoUPHpuU1LJE7hpVy4AfIN/45hLwL8PPTcfokk
	YM68ruf4BlyxpjJDh3Y4YRbkE4E0Dx/Iuw36yLU+wEfFjN0YHP3Ea3CvHWJ4NfZkG/Z/Y5fbiOl+c
	6LPIj5YeLsRIrWvu46IXrpaGWXpCIS3QcIVJKL0xr6eiMy2nRCspLk4mJ6piquLt9Ea7pcXBvQUKI
	L1qp5IFLMwvYqKcitdhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTC3l-0002dr-Ri; Sat, 01 Dec 2018 20:40:17 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTC3X-0001G9-Kh
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 20:40:05 +0000
Received: by mail-oi1-x242.google.com with SMTP id x202so7694453oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 12:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9vhd9W7UPJ4xEv9pUq8XhtBCJG/+f1BG0vJBijfVeoM=;
 b=fenKO9JFfluMHI1kreCcwOLSfaFqDnEQhvLfKgyFoQprYRtaJtO/47MFNGSvbNDLXB
 01ez4Vkr4+lSqDWv0plVv1yCpTrb7706g0zo1fX6KD2X1BKFzYTMhPkSimJhTNwb2JUa
 wsSFG3640Svx5+CwC5uNCmCO06D7v7wIHg6IkT1MFONljwUwOSC+Nls4G/Ze/c1lfFgX
 hvSFDE42Ne6rqy6hhMgzG5Dfz2dsNq5Lq9OZDcideJXnkKM8m5DUm7fRyGGkW9HmQngz
 +E7LS0xo/S6C894BLgirxae21CTAR/IpEVW1CX7ra33dYRb8M846R45aSA3upHZpFsZO
 fBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9vhd9W7UPJ4xEv9pUq8XhtBCJG/+f1BG0vJBijfVeoM=;
 b=VKlp/sSYAvUZtZBK1TcNjLcb+XXi0V7F8N4xPxEa3WXiCPToCVW7m/Ea1DieQo9LJi
 iFbtb8OB5TVeGrvVJhf7ZbxtPOBu2ffvxURPIP1V19pK23cPC5I/J1IHwH/eGd2bAfgI
 XUsljnbIsKZ8f1DcoIko17H6kbJ73xp6GaaMEueRmhi3U42iP/dd87i6yCiVDGAkPMOj
 ZUimGE5VLws9bNpM7WbTWHGPcvZQReWvdylBunQs20eYTPRikgUmhlj2Ut4/onvNAlwg
 b4OgQ3p0wm8wIdICL459eBSbnZIEQwNUdiHa0090WeCtFZPeEeMwkebljnhbYuvNQwu6
 66EA==
X-Gm-Message-State: AA+aEWbRJo6CAT6KfhRL2cmtmlm5L6kMfQLvsvPQ8tEL3IISLLhFdBed
 bGWmtTsUVeA+4c8TQUNmAN8=
X-Google-Smtp-Source: AFSGD/VxZuyAflYfiK2ViB5k/F+/+oEWoSYSmQ3ZY1T+eKiYZa1nHRupuUYmmHGVPY5QBuOK9EBx1Q==
X-Received: by 2002:aca:b404:: with SMTP id d4mr6695135oif.167.1543696790354; 
 Sat, 01 Dec 2018 12:39:50 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id b12sm3140320otp.75.2018.12.01.12.39.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Dec 2018 12:39:48 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 1/4] Broadcom devicetree changes for 4.21
Date: Sat,  1 Dec 2018 12:39:39 -0800
Message-Id: <20181201203942.13376-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_124003_688854_4E867106 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>, arnd@arndb.de, khilman@kernel.org,
 olof@lixom.net, Phil Elwell <phil@raspberrypi.org>,
 =?UTF-8?q?Ren=C3=A9=20Kjellerup?= <rk.katana.steel@gmail.com>,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Vivek Unune <npcomplete13@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2NTEwMjIzODJjN2Y4ZGE0NmNiNDg3
MmE1NDVlZTFkYTZkMDk3ZDJhOgoKICBMaW51eCA0LjIwLXJjMSAoMjAxOC0xMS0wNCAxNTozNzo1
MiAtMDgwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoKICBodHRw
czovL2dpdGh1Yi5jb20vQnJvYWRjb20vc3RibGludXguZ2l0IHRhZ3MvYXJtLXNvYy9mb3ItNC4y
MS9kZXZpY2V0cmVlCgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gOTk5NDI0MWFjOTdj
Yjg0ZDFkZjk4ZmRjMTcyZDNjYzZiMDRiMTFiZjoKCiAgQVJNOiBkdHM6IEJDTTUzMDFYOiBEZXNj
cmliZSBOb3J0aHN0YXIgcGlucyBtdXggY29udHJvbGxlciAoMjAxOC0xMS0zMCAxMDozNTowMiAt
MDgwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KVGhpcyBwdWxsIHJlcXVlc3QgY29udGFpbnMgQnJvYWRjb20gQVJNLWJh
c2VkIFNvQ3MgRGV2aWNlIFRyZWUgY2hhbmdlcwpmb3IgNC4yMSwgcGxlYXNlIHB1bGwgdGhlIGZv
bGxvd2luZzoKCi0gUmFmYWwgcmVsaWNlbnNlcyBhIGJ1bmNoIG9mIERUUyBmaWxlcyBoZSB3cm90
ZSB1bmRlciB0aGUgR1BMIDIuMCsvTUlUCiAgbGljZW5zZSBhbmQgYWRkcyBwcm9wZXIgU1BEWCBs
aWNlbnNlIHRhZ3MgaW4gdGhlIHByb2Nlc3MKCi0gUmVuZSBhZGRzIHN1cHBvcnQgZm9yIHRoZSBM
aW5rc3lzIEVBNjUwMCB2MiBXaS1GaSByb3V0ZXIgYmFzZWQgb24KICBCQ000NzA4IHBsdXMgdHdv
IEJDTTQzNjAgYW5kIEJDTTQzMzEgcmFkaW9zCgotIFBoaWwgZG9jdW1lbnRzIGFuZCB1cGRhdGVz
IHRoZSB2Y2hpcSBtYWlsYm94IGNvbXBhdGlibGUgc3RyaW5nIGluCiAgb3JkZXIgdG8gZXN0YWJs
aXNoIGEgY29ycmVjdCBhZ3JlZW1lbnQgYmV0d2VlbiB0aGUgUmFzcGJlcnJ5IFBpCiAgZmlybXdh
cmUgYW5kIHRoZSBBUk0gQ1BVJ3MgdmlldyBvZiB3aGF0IGFuIEFSTSBDUFUgY2FjaGUgbGluZSBz
aXplIGlzLAogIGhlIGFsc28gZml4ZXMgdGhlIG1haWxib3ggInJlZyIgcHJvcGVydHkgdG8gYmUg
Y29ycmVjdGx5IGV4cHJlc3NlZCBpbgogIGJ5dGVzCgotIFN0ZWZhbiB1cGRhdGVzIHRoZSBSYXNw
YmVycnkgUGkgWmVybyBEVFMgZmlsZXMgdG8gdXNlIFNQRFggdGFncwoKLSBGbG9yaWFuIGVuYWJs
ZXMgdGhlIFNBVEEgUEhZIGFuZCBBSENJIGNvbnRyb2xsZXIgb24gdGhlIEJDTTYzMTM4IFNvQ3Ms
CiAgaGUgYWxzbyBkb2VzIGEgYml0IG9mIHJlZmFjdG9yaW5nIG9mIGFsaWFzZXMgZm9yIHRoZSBO
b3J0aHN0YXIgUGx1cwogIERUUyBmaWxlcwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpGbG9yaWFuIEZhaW5lbGxpICg0KToK
ICAgICAgQVJNOiBkdHM6IEJDTTYzeHg6IGVuYWJsZSBTQVRBIFBIWSBhbmQgQUhDSSBjb250cm9s
bGVyCiAgICAgIEFSTTogZHRzOiBCQ002M3h4OiBFbmFibGUgU0FUQSBBSENJIGFuZCBQSFkgZm9y
IEJDTTk2MzEzOERWVAogICAgICBBUk06IGR0czogTlNQOiBNb3ZlIGFsaWFzZXMgdG8gYmNtLW5z
cC5kdHNpCiAgICAgIE1lcmdlIHRhZyAndGFncy9iY20yODM1LWR0LW5leHQtMjAxOC0xMS0yNycg
aW50byBkZXZpY2V0cmVlL25leHQKClBoaWwgRWx3ZWxsICgzKToKICAgICAgZHQtYmluZGluZ3M6
IHNvYzogRG9jdW1lbnQgImJyY20sYmNtMjgzNi12Y2hpcSIKICAgICAgQVJNOiBkdHM6IGJjbTI4
M3g6IENvcnJlY3QgdmNoaXEgY29tcGF0aWJsZSBzdHJpbmcKICAgICAgQVJNOiBkdHM6IGJjbTI4
M3g6IENvcnJlY3QgbWFpbGJveCByZWdpc3RlciBzaXplcwoKUmFmYcWCIE1pxYJlY2tpICg1KToK
ICAgICAgQVJNOiBkdHM6IEJDTTUzMDFYOiBSZWxpY2Vuc2UgQkNNNDcwODEvQkNNNDcwOSBmaWxl
cyB0byB0aGUgR1BMIDIuMCsgLyBNSVQKICAgICAgQVJNOiBkdHM6IEJDTTUzMDFYOiBSZWxpY2Vu
c2UgQkNNNDcwOTQgZmlsZSB0byB0aGUgR1BMIDIuMCsgLyBNSVQKICAgICAgQVJNOiBkdHM6IEJD
TTUzNTczOiBSZWxpY2Vuc2UgVGVuZGEgQUM5IGZpbGUgdG8gdGhlIEdQTCAyLjArIC8gTUlUCiAg
ICAgIEFSTTogZHRzOiBCQ001MzU3MzogUmVsaWNlbnNlIFNvQyBmaWxlIHRvIHRoZSBHUEwgMi4w
KyAvIE1JVAogICAgICBBUk06IGR0czogQkNNNTMwMVg6IERlc2NyaWJlIE5vcnRoc3RhciBwaW5z
IG11eCBjb250cm9sbGVyCgpSZW7DqSBLamVsbGVydXAgKDEpOgogICAgICBBUk06IGR0czogQkNN
NTMwMVg6IEFkZCBiYXNpYyBEVCBmb3IgTGlua3N5cyBFQTY1MDAgVjIKClN0ZWZhbiBXYWhyZW4g
KDEpOgogICAgICBBUk06IGR0czogYmNtMjgzNS1ycGktemVybzogU3dpdGNoIHRvIFNQRFggaWRl
bnRpZmllcgoKIC4uLi9iaW5kaW5ncy9zb2MvYmNtL2JyY20sYmNtMjgzNS12Y2hpcS50eHQgICAg
ICAgIHwgIDMgKy0KIGFyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDEgKwogYXJjaC9hcm0vYm9vdC9kdHMvYmNtLW5zcC5kdHNpICAgICAgICAgICAg
ICAgICAgICAgfCAgOCArKysrCiBhcmNoL2FybS9ib290L2R0cy9iY20yODM1LXJwaS16ZXJvLXcu
ZHRzICAgICAgICAgICB8ICA4ICstLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTI4MzUtcnBpLXpl
cm8uZHRzICAgICAgICAgICAgIHwgIDggKy0tLQogYXJjaC9hcm0vYm9vdC9kdHMvYmNtMjgzNS1y
cGkuZHRzaSAgICAgICAgICAgICAgICAgfCAgNCArLQogYXJjaC9hcm0vYm9vdC9kdHMvYmNtMjgz
Ni1ycGktMi1iLmR0cyAgICAgICAgICAgICAgfCAgMiArLQogYXJjaC9hcm0vYm9vdC9kdHMvYmNt
MjgzNi1ycGkuZHRzaSAgICAgICAgICAgICAgICAgfCAgNiArKysKIGFyY2gvYXJtL2Jvb3QvZHRz
L2JjbTI4MzctcnBpLTMtYi1wbHVzLmR0cyAgICAgICAgIHwgIDIgKy0KIGFyY2gvYXJtL2Jvb3Qv
ZHRzL2JjbTI4MzctcnBpLTMtYi5kdHMgICAgICAgICAgICAgIHwgIDIgKy0KIGFyY2gvYXJtL2Jv
b3QvZHRzL2JjbTI4MzctcnBpLWNtMy5kdHNpICAgICAgICAgICAgIHwgIDIgKy0KIGFyY2gvYXJt
L2Jvb3QvZHRzL2JjbTQ3MDgtbGlua3N5cy1lYTY1MDAtdjIuZHRzICAgIHwgNDUgKysrKysrKysr
KysrKysrKysrKysrKwogYXJjaC9hcm0vYm9vdC9kdHMvYmNtNDcwODEuZHRzaSAgICAgICAgICAg
ICAgICAgICAgfCAxMyArLS0tLS0tCiBhcmNoL2FybS9ib290L2R0cy9iY200NzA5LmR0c2kgICAg
ICAgICAgICAgICAgICAgICB8ICAzICstCiBhcmNoL2FybS9ib290L2R0cy9iY200NzA5NC5kdHNp
ICAgICAgICAgICAgICAgICAgICB8ICAzICstCiBhcmNoL2FybS9ib290L2R0cy9iY200NzE4OS10
ZW5kYS1hYzkuZHRzICAgICAgICAgICB8ICAzICstCiBhcmNoL2FybS9ib290L2R0cy9iY201MzAx
eC5kdHNpICAgICAgICAgICAgICAgICAgICB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKwogYXJj
aC9hcm0vYm9vdC9kdHMvYmNtNTM1NzMuZHRzaSAgICAgICAgICAgICAgICAgICAgfCAgMyArLQog
YXJjaC9hcm0vYm9vdC9kdHMvYmNtNjMxMzguZHRzaSAgICAgICAgICAgICAgICAgICAgfCAzMSAr
KysrKysrKysrKysrKysKIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTk1ODUyMmVyLmR0cyAgICAgICAg
ICAgICAgICAgIHwgIDQgLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTk1ODUyNWVyLmR0cyAgICAg
ICAgICAgICAgICAgIHwgIDQgLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTk1ODUyNXhtYy5kdHMg
ICAgICAgICAgICAgICAgIHwgIDQgLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTk1ODYyMmhyLmR0
cyAgICAgICAgICAgICAgICAgIHwgIDQgLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTk1ODYyM2hy
LmR0cyAgICAgICAgICAgICAgICAgIHwgIDQgLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTk1ODYy
NWhyLmR0cyAgICAgICAgICAgICAgICAgIHwgIDQgLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTk1
ODYyNWsuZHRzICAgICAgICAgICAgICAgICAgIHwgIDUgLS0tCiBhcmNoL2FybS9ib290L2R0cy9i
Y205NjMxMzhkdnQuZHRzICAgICAgICAgICAgICAgICB8ICA4ICsrKysKIGFyY2gvYXJtL2Jvb3Qv
ZHRzL2JjbTk4ODMxMmhyLmR0cyAgICAgICAgICAgICAgICAgIHwgIDQgLS0KIDI4IGZpbGVzIGNo
YW5nZWQsIDE1OCBpbnNlcnRpb25zKCspLCA3NCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybS9ib290L2R0cy9iY20yODM2LXJwaS5kdHNpCiBjcmVhdGUgbW9kZSAxMDA2
NDQgYXJjaC9hcm0vYm9vdC9kdHMvYmNtNDcwOC1saW5rc3lzLWVhNjUwMC12Mi5kdHMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
