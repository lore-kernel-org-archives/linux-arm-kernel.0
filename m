Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD1CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:47:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54D920B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="auBGmVNt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="O/gK0avf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54D920B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lIEMPS5Wm4vX6fMAGnv6S1UJGRPWIXE/zhUjGpihe1I=; b=auBGmVNt2/irvI
	fSDg+25gy2G1RmRLsM4Gjz/mwoI19DUsIYx9F3puGHUFZKwcIJwXMzVoXDvMZYzzxPuMSnNeKVnaY
	a6rAbdcUXyNnHoGkyI8hUfQDWstSd3I78shuJr2fwMZDoqhZMjQBms5pKdx6WD6i4Xrpr8XE5hG/2
	JvcNYi2+TZjvniY7udEUeQeq0OYZRdKIqFNSnqh4S0mt84h7Ct9eQ5O4B/iph/YzpfEh3J1ze60dM
	DWVk4Lv7TuS5GKyvVC00RxfFhrWQYY4Vi3ZGbnN3OKNIj0vQmvSyls1bb/EGjcUXz773O3ZoqRH2t
	Q7emS3m+0rhl/PDg1bQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5PR-0004J4-2u; Mon, 31 Dec 2018 21:47:41 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5Om-0003hK-D5
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:47:06 +0000
Received: by mail-pf1-x441.google.com with SMTP id b85so13580360pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mzbID4cPz5p3YB+iynLwm/8n+8ZRTYuq7NL3iNt4c44=;
 b=O/gK0avfs3tvqXfiDlB5cB013b8KHkbDZj8o9oKz8EtMzIiu7ctdt27Cef2kbqVxUF
 D5HrvX0lPI+ccqpDpkG3+JhpaM4NS4z++JWCWyPzdldZ6xKUYM9QUmkqvtdkbVtMxMz3
 4SaIDQ449KV181+C1mU8YGR5k6jSWBftEy9D95eK212gzScp/yRg6ToVsRquySzbGH07
 eanrfMo8aOuGLwm0o+yy5QLtK5pRy0p6VRMiXNt81tk5UAck6c5YQpPNdcTIrjfXCh8G
 bG8WKlsAPuHiVGksCfIyfLGi3aCbNhtPu/IkQ2qEtxK7IrcKpj8l4xXv2uKAm/uHH/J2
 /0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mzbID4cPz5p3YB+iynLwm/8n+8ZRTYuq7NL3iNt4c44=;
 b=INYVRdtnGAjsFhUuX2AyoHNB7ZvL+aRHXDg2G+m12QF13gpDhXZuQpwdR8zMUz6dAh
 qFu+WJtufLmHb6cMfZaP+5Wx8HvD5APkrMlg4kqfVFf1HgJWg8T7zKa/vY3jKUPxbcOV
 of8fzy+cnaQU8nPvU7/nSs7/WdtsZ5WkPo+jotxTM4LzaBXl+Al1tP3sArOQKQEx7+JZ
 hVYByidW9iARRhTNAvRAVoffjOtLxFdQFceHb4Z6HiOjNmTWYi0eFUiIryQx54oLhKr2
 TPcoaEjlKh875OLiK6YO4idqMVi/KtRvH4rRfvXxvUnT/ymq8b5NXuQ5I0i2v+6JDghc
 VSYA==
X-Gm-Message-State: AJcUukdnP/dGT/R2E4s+vT3X/zggv9xQ8nEkrrlYiDco6YOKjyDFHFY4
 kXA/wqJf9luS37efCMBPA7L1DQ==
X-Google-Smtp-Source: ALg8bN5KDybRvtW/y1g68pWrftpCN6yO0VOVkbbXW70XGsin7YP+Gsf0pj2fDYDKXYmQA664TQ3asA==
X-Received: by 2002:a63:7a09:: with SMTP id v9mr8812820pgc.112.1546292819781; 
 Mon, 31 Dec 2018 13:46:59 -0800 (PST)
Received: from localhost.localdomain
 (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
 by smtp.gmail.com with ESMTPSA id u126sm96477085pgb.2.2018.12.31.13.46.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 13:46:58 -0800 (PST)
From: Olof Johansson <olof@lixom.net>
To: torvalds@linux-foundation.org
Subject: [GIT PULL 4/4] ARM: SoC defconfig updates
Date: Mon, 31 Dec 2018 13:46:40 -0800
Message-Id: <20181231214640.17015-5-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181231214640.17015-1-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_134700_947157_781A7AA5 
X-CRM114-Status: GOOD (  16.80  )
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
Cc: Olof Johansson <olof@lixom.net>, arm@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TW9zdCBjaGFuZ2VzIGhlcmUgYXJlIHRvIGVuYWJsZSBuZXcgZHJpdmVycyBhbmQgcGxhdGZvcm1z
IGluIHRoZSB2YXJpb3VzCmNvbmZpZ3MgdGhhdCBhZmZlY3QgdGhlbS4gTW9zdCBvZiB0aGVzZSBo
YXZlIGJlZW4gY292ZXJlZCBhbmQgZGVzY3JpYmVkCmluIHRoZSBvdGhlciBicmFuY2hlcywgd2Ug
bW9zdGx5IGtlZXAgZGVmY29uZmlnIHNlcGFyYXRlIHRvIGF2b2lkCmNvbmZsaWN0cyBiZXR3ZWVu
IFNvQy9kdC9kcml2ZXIgdXBkYXRlcyB0aGF0IHRoZXkgb3RoZXJ3aXNlIHdvdWxkIGJlCmdyb3Vw
ZWQgd2l0aC4KCk9uZSB0aGluZyB3b3J0aCBtZW50aW9uaW5nIGhlcmUgaXMgdGhhdCBPTUFQIGNo
YW5nZXMgZnJvbSB1c2luZyB0aGVpcgpvd24gVUFSVCBkcml2ZXIsIHRvIDgyNTAsIGZvciB0aGUg
bXVsdGlfdjdfZGVmY29uZmlnIHNoYXJlZCBjb25maWcgb24KMzItYml0LiBUaGlzIG1lYW5zIHRo
YXQgdGhlIGNvbnNvbGUgaXMgbm93IG5hbWVkIHR0eVMqIGluc3RlYWQgb2YgdHR5TyouClRoaXMg
Y2hhbmdlIHdhcyBhbHJlYWR5IGRvbmUgZm9yIG9tYXAyX2RlZmNvbmZpZyBhIHdoaWxlIGJhY2ss
IHNvIG1vc3QKdXNlcnMgb2YgdGhlc2UgY29uZmlncyBoYXZlIGVpdGhlciBhbHJlYWR5IHVwZGF0
ZWQsIG9yIGNhbiBlYXNpbHkgZm9sbG93CnRoZSBzYW1lIHBhdHRlcm5zIGFzIHRoZXkgZGlkIGF0
IHRoYXQgdGltZS4gVGhpcyBtYWtlcyBwbGF0Zm9ybSBzdXBwb3J0CnNsaWdodGx5IGVhc2llciBm
b3IgZGlzdHJvcywgc2luY2UgdGhleSBubyBsb25nZXIgbmVlZCB0byBrZWVwIHRyYWNrIG9mCmEg
c2VwYXJhdGUgY29uc29sZSBwcmVmaXggZm9yIHRoZXNlIHBsYXRmb3Jtcy4KCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KClRo
ZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZjdmNjI2MGYwNDg5NjE3YjQ5MTc2ZjFi
MzBlMmNkZDVjNDNlMDkxODoKCiAgTWVyZ2UgdGFnICdhcm1zb2MtZHQnIGludG8gSEVBRAoKYXJl
IGF2YWlsYWJsZSBpbiB0aGUgZ2l0IHJlcG9zaXRvcnkgYXQ6CgogIGdpdDovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hcm0vYXJtLXNvYy5naXQgdGFncy9hcm1zb2Mt
ZGVmY29uZmlnCgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gODJjN2IzNTFiZTNmYWQw
MDViYTM4YTI2ZjdmMWFiN2YwODQxZTUwNToKCiAgUmV2ZXJ0ICJhcm02NDogZGVmY29uZmlnOiBF
bmFibGUgRlNMX01DX0JVUyBhbmQgRlNMX01DX0RQSU8iCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpBLnMuIERvbmcgKDEp
OgogICAgICBBUk06IGlteF92Nl92N19kZWZjb25maWc6IGFkZCBpbXg3dWxwIHN1cHBvcnQKCkFk
YW0gRm9yZCAoMSk6CiAgICAgIEFSTTogb21hcDJwbHVzX2RlZmNvbmZpZzogQWRkIHRsdjMyMGFp
YzIzIGFzIG1vZHVsZQoKQWxleCBHb256YWxleiAoMSk6CiAgICAgIEFSTTogaW14X3Y2X3Y3X2Rl
ZmNvbmZpZzogU2VsZWN0IFRPVUNIU0NSRUVOX0dPT0RJWAoKQW5kcmVhcyBNw7xsbGVyICgyKToK
ICAgICAgQVJNOiBpbXhfdjZfdjdfZGVmY29uZmlnOiBFbmFibGUgQlRfQk5FUAogICAgICBBUk06
IGlteF92Nl92N19kZWZjb25maWc6IEVuYWJsZSBVU0JfQU5OT1VOQ0VfTkVXX0RFVklDRVMKCkJq
b3JuIEFuZGVyc3NvbiAoNCk6CiAgICAgIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBRQ1M0MDQg
Y29uZmlncwogICAgICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgc29tZSBxY29tIHJlbW90ZXBy
b2MgY29uZmlncwogICAgICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgY29yZSBRdWFsY29tbSBT
RE04NDUgb3B0aW9ucwogICAgICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgR0NDIGFuZCBQSU5D
VFJMIGZvciBNU004OTk4CgpGYWJpbyBFc3RldmFtICgxKToKICAgICAgQVJNOiBpbXhfdjZfdjdf
ZGVmY29uZmlnOiBTZWxlY3QgdGhlIFBYUCBkcml2ZXIKCkZhYnJpY2UgR2FzbmllciAoMSk6CiAg
ICAgIEFSTTogbXVsdGlfdjdfZGVmY29uZmlnOiBlbmFibGUgU1RNMzIgYW5hbG9nICYgdGltZXIg
ZHJpdmVycwoKRmFicml6aW8gQ2FzdHJvICgxKToKICAgICAgQVJNOiBzaG1vYmlsZTogZGVmY29u
ZmlnOiBFbmFibGUgU0lJOTAyWAoKSG9yaWEgR2VhbnTEgyAoMSk6CiAgICAgIFJldmVydCAiYXJt
NjQ6IGRlZmNvbmZpZzogRW5hYmxlIEZTTF9NQ19CVVMgYW5kIEZTTF9NQ19EUElPIgoKSmFnYW4g
VGVraSAoNCk6CiAgICAgIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBNRkRfQVhQMjBYX0kyQwog
ICAgICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgRFJNX1NVTjhJX01JWEVSCiAgICAgIGFybTY0
OiBkZWZjb25maWc6IEVuYWJsZSBEUk1fU1VOOElfRFdfSERNSQogICAgICBhcm02NDogZGVmY29u
ZmlnOiBFbmFibGUgUFdNX1NVTjRJCgpKYW4gVHVlcmsgKDEpOgogICAgICBBUk06IGlteF92Nl92
N19kZWZjb25maWc6IEVuYWJsZSBEQTkwNjMgUE1JQyBzdXBwb3J0CgpMZW9uYXJkIENyZXN0ZXog
KDEpOgogICAgICBBUk06IGlteF92Nl92N19kZWZjb25maWc6IEVuYWJsZSBDUllQVE9fREVWX01Y
U19EQ1AKCkxpbnVzIFdhbGxlaWogKDIpOgogICAgICBBUk06IGRlZmNvbmZpZzogVXBkYXRlIHRo
ZSB2ZXhwcmVzcyBkZWZjb25maWcKICAgICAgQVJNOiBkZWZjb25maWc6IEVuYWJsZSB0aGUgUEwx
MTEgRFJNIGRyaXZlciBvbiB2ZXhwcmVzcwoKTWFyYyBHb256YWxleiAoMyk6CiAgICAgIGFybTY0
OiBkZWZjb25maWc6IFJlZ2VuZXJhdGUgZm9yIHY0LjIwCiAgICAgIGFybTY0OiBkZWZjb25maWc6
IFJlcGxhY2UgUElOQ1RSTF9NVDc2MjIgd2l0aCBQSU5DVFJMX01US19NT09SRQogICAgICBhcm02
NDogZGVmY29uZmlnOiBFbmFibGUgRlNMX01DX0JVUyBhbmQgRlNMX01DX0RQSU8KCk1hcmVrIFN6
eXByb3dza2kgKDUpOgogICAgICBBUk06IGV4eW5vc19kZWZjb25maWc6IEFkZCBNQVg4OTk4IFJU
QyBhbmQgY2hhcmdlciBkcml2ZXJzCiAgICAgIEFSTTogZXh5bm9zX2RlZmNvbmZpZzogQWRkIE1B
WDg5NTIgcmVndWxhdG9yIGRyaXZlcgogICAgICBBUk06IGV4eW5vc19kZWZjb25maWc6IEFkZCBU
T1NISUJBIFRDMzU4NzY0IGJyaWRnZSBkcml2ZXIKICAgICAgQVJNOiBtdWx0aV92N19kZWZjb25m
aWc6IEFkZCBNQVg4OTUyIHJlZ3VsYXRvciBkcml2ZXIKICAgICAgQVJNOiBtdWx0aV92N19kZWZj
b25maWc6IEFkZCBUT1NISUJBIFRDMzU4NzY0IGJyaWRnZSBkcml2ZXIKCk9sb2YgSm9oYW5zc29u
ICg3KToKICAgICAgTWVyZ2UgdGFnICd2ZXhwcmVzcy1kZWZjb25maWctYXJtLXNvYycgb2YgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvLi4uL2xpbnVzdy9saW51eC1pbnRlZ3JhdG9yIGludG8gbmV4dC9k
ZWZjb25maWcKICAgICAgTWVyZ2UgdGFnICdvbWFwLWZvci12NC4yMS9kZWZjb25maWctc2lnbmVk
JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy8uLi4vdG1saW5kL2xpbnV4LW9tYXAgaW50byBuZXh0
L2RlZmNvbmZpZwogICAgICBNZXJnZSB0YWcgJ3Fjb20tYXJtNjQtZGVmY29uZmlnLWZvci00LjIx
JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy8uLi4vYWdyb3NzL2xpbnV4IGludG8gbmV4dC9kZWZj
b25maWcKICAgICAgTWVyZ2UgdGFnICdyZW5lc2FzLWFybS1kZWZjb25maWctZm9yLXY0LjIxJyBv
ZiBodHRwczovL2dpdC5rZXJuZWwub3JnLy4uLi9ob3Jtcy9yZW5lc2FzIGludG8gbmV4dC9kZWZj
b25maWcKICAgICAgTWVyZ2UgdGFnICdzdW54aS1jb25maWc2NC1mb3ItNC4yMScgb2YgaHR0cHM6
Ly9naXQua2VybmVsLm9yZy8uLi4vc3VueGkvbGludXggaW50byBuZXh0L2RlZmNvbmZpZwogICAg
ICBNZXJnZSB0YWcgJ3NhbXN1bmctZGVmY29uZmlnLTQuMjEnIG9mIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvLi4uL2tyemsvbGludXggaW50byBuZXh0L2RlZmNvbmZpZwogICAgICBNZXJnZSB0YWcg
J2lteC1kZWZjb25maWctNC4yMScgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvLi4uL3NoYXduZ3Vv
L2xpbnV4IGludG8gbmV4dC9kZWZjb25maWcKCk90YXZpbyBTYWx2YWRvciAoMSk6CiAgICAgIEFS
TTogaW14X3Y2X3Y3X2RlZmNvbmZpZzogUmVtb3ZlIGV4cGxpY2l0IEFSTV9VTldJTkQgZGlzYWJs
ZQoKVG9ueSBMaW5kZ3JlbiAoMik6CiAgICAgIE1lcmdlIGJyYW5jaCAnb21hcC1mb3ItdjQuMjAv
ZGVmY29uZmlnJyBpbnRvIG9tYXAtZm9yLXY0LjIxL2RlZmNvbmZpZwogICAgICBBUk06IG11bHRp
X3Y3X2RlZmNvbmZpZzogRW5hYmxlIDgyNTAtb21hcCBzZXJpYWwgZHJpdmVyIGFuZCB1c2UgaXQg
YnkgZGVmYXVsdAoKCiBhcmNoL2FybS9jb25maWdzL2V4eW5vc19kZWZjb25maWcgICAgfCAgIDQg
KwogYXJjaC9hcm0vY29uZmlncy9pbXhfdjZfdjdfZGVmY29uZmlnIHwgIDEwICsrLQogYXJjaC9h
cm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcgIHwgIDEzICsrKwogYXJjaC9hcm0vY29uZmln
cy9vbWFwMnBsdXNfZGVmY29uZmlnIHwgICAxICsKIGFyY2gvYXJtL2NvbmZpZ3Mvc2htb2JpbGVf
ZGVmY29uZmlnICB8ICAgMSArCiBhcmNoL2FybS9jb25maWdzL3ZleHByZXNzX2RlZmNvbmZpZyAg
fCAgMjQgKystLS0tCiBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgfCAxMjgg
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiA3IGZpbGVzIGNoYW5nZWQsIDEwNSBpbnNl
cnRpb25zKCspLCA3NiBkZWxldGlvbnMoLSkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
