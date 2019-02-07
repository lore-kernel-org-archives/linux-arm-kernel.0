Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD7CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:34:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700EE2077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TRelaCOT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LqyOFZTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700EE2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xHvQwl1y+8GOuSsq6wW0qoGOKnul2EHl2BIYSXmL2oY=; b=TRelaCOT+KyA+F0oEmxE8cN4R
	d84P6aBx31inNnTsHHixn/OEQtKs96ddAjY9V1y6nnIky+DlQlp4cxpE17EPn9gvav1mymon9VH85
	YFwGQzuVxueJgT0HIIE0ySx14mONwm/kW9RV3SSghUQs4DErPoLB5W9giM+Otq/MJIAQ1CjbIrceq
	DnKEuP0v0s/SPt4QVC2YakB2vHxFckQoXUSQx31IqIhlpF6B6B9s1t9jjzEsDx8ta6tNrT3hws6XV
	IrLnAmd4V5AAAFfeNgUDlnZb3AkVoRtHhQ3hlMLEngWYXy1QWhKNkknI//zjVkQ878X63HdbCbuqd
	2JmPNidAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlh2-0005l9-2K; Thu, 07 Feb 2019 15:34:24 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlgx-0005kh-T1
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:34:21 +0000
Received: by mail-pl1-x644.google.com with SMTP id o6so70457pls.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8zLBuc0sBo52O4bloIqQvrcyfDP4dPfYY5yzFr1WIjY=;
 b=LqyOFZTgpwimtcg6h/ifQ1jy7jMNg8xS54lUMHN7OO8i2ohbAmeK8nOG++3dGbHUih
 cEurY7rJCDqAhQWAPQ63GToV8NK+KhKPEY50YNZOeqRDVZILlwdorLPv+WrxIK406uwa
 cRgP2cpu4+NCeOxdYKeXESNmumtxrSxsy+Yo/ucpmHz2xEIXN1hHkuBfqKGCbozJmTca
 ujQW5p+PQNeWO+tKk07FLT9zc4fSLR7LfvKBtmjt7Hecd8OX3vzz9bMzcPQLziS1XB9E
 lgKaPET3teay1WoaYU9CMZP+PVsboqyv6H7cRVbhRrk8Y6MwP1zPAW89crO3RM0psxi+
 bh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8zLBuc0sBo52O4bloIqQvrcyfDP4dPfYY5yzFr1WIjY=;
 b=opPFrt+7IGlQhKvPzCJ9ObGOCzGuO1KarER9VrudkrNsJrC28q53vfX4BPm9inP4f0
 nzmdGH+VgA4ipyN4bF8blwY3oUp1RevebBsuhukhUmDw7c+vSJU3TGhFgHpdfWRb8fCN
 g4pFxUSYKaA8xra2KKYm6Hx7Ba0BCQwtLJkdgLrnPXNUAZkFmTQzEp2Bx+XKdkSyn5k5
 n6QEAXsyQjAubKrdbt5jjMY5qwb+9S9C4WeYtnZQ7b6BMOgr2gs9QRxV0veGAKjfTMQP
 6EUns1mOplaEWV211fl+XZkpVOdxq2qEFx/G95/3iKgmP1jQhcN9YXGhW+5eJtt87jo9
 1CtQ==
X-Gm-Message-State: AHQUAub3bP4YzNRuMScTWMgDXDGWEedyZoPNAfGI7aqtjPN1gNGBwSF8
 m0VRokQrRj07qWxhr2sumwdWNITQhqdLw8RPuXfjjA==
X-Google-Smtp-Source: AHgI3IZdDWszJGx7zQzLD8P5tmlbNuB2twIL3Lxhj+0O61Ipu9AXNAoqooq6906pDqScfxcNWeTRRnzsnSOCjIn2ank=
X-Received: by 2002:a17:902:8303:: with SMTP id
 bd3mr9087825plb.10.1549553659042; 
 Thu, 07 Feb 2019 07:34:19 -0800 (PST)
MIME-Version: 1.0
References: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
 <CAAeHK+yzHbLbFe7mtruEG-br9V-LZRC-n6dkq5+mmvLux0gSbg@mail.gmail.com>
 <89b343eb-16ff-1020-2efc-55ca58fafae7@lca.pw>
In-Reply-To: <89b343eb-16ff-1020-2efc-55ca58fafae7@lca.pw>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 7 Feb 2019 16:34:06 +0100
Message-ID: <CAAeHK+zxxk8K3WjGYutmPZr_mX=u7KUcCUYXHi+OgRYMfcvLTg@mail.gmail.com>
Subject: Re: CONFIG_KASAN_SW_TAGS=y NULL pointer dereference at
 freelist_dereference()
To: Qian Cai <cai@lca.pw>
Content-Type: multipart/mixed; boundary="00000000000068e02505814f9370"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_073419_961577_623B82F9 
X-CRM114-Status: GOOD (  13.37  )
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
Cc: kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--00000000000068e02505814f9370
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 7, 2019 at 2:27 PM Qian Cai <cai@lca.pw> wrote:
>
>
>
> On 2/7/19 7:58 AM, Andrey Konovalov wrote:
> > On Thu, Feb 7, 2019 at 5:04 AM Qian Cai <cai@lca.pw> wrote:
> >>
> >> The kernel was compiled by clang-7.0.1 on a ThunderX2 server, and it fails to
> >> boot. CONFIG_KASAN_GENERIC=y works fine.
> >
> > Hi Qian,
> >
> > Could you share the kernel commit id and .config that you use?
>
> v5.0-rc5
>
> https://git.sr.ht/~cai/linux-debug/tree/master/config
>
> # cat /proc/cmdline
> page_poison=on crashkernel=768M earlycon page_owner=on numa_balancing=enable
> slub_debug=-

Reproduced, looks like a conflict with CONFIG_SLAB_FREELIST_HARDENED.
Could you try the attached patch?

--00000000000068e02505814f9370
Content-Type: text/x-patch; charset="US-ASCII"; name="kasan-hardened-freelist-fix.patch"
Content-Disposition: attachment; 
	filename="kasan-hardened-freelist-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jrus7qij0>
X-Attachment-Id: f_jrus7qij0

ZGlmZiAtLWdpdCBhL21tL3NsdWIuYyBiL21tL3NsdWIuYwppbmRleCAxZTNkMGVjNGUyMDAuLjVm
Yjc1MDdlYjhkMSAxMDA2NDQKLS0tIGEvbW0vc2x1Yi5jCisrKyBiL21tL3NsdWIuYwpAQCAtMjQ5
LDcgKzI0OSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCAqZnJlZWxpc3RfcHRyKGNvbnN0IHN0cnVj
dCBrbWVtX2NhY2hlICpzLCB2b2lkICpwdHIsCiAJCQkJIHVuc2lnbmVkIGxvbmcgcHRyX2FkZHIp
CiB7CiAjaWZkZWYgQ09ORklHX1NMQUJfRlJFRUxJU1RfSEFSREVORUQKLQlyZXR1cm4gKHZvaWQg
KikoKHVuc2lnbmVkIGxvbmcpcHRyIF4gcy0+cmFuZG9tIF4gcHRyX2FkZHIpOworCXJldHVybiAo
dm9pZCAqKSgodW5zaWduZWQgbG9uZylwdHIgXiBzLT5yYW5kb20gXgorCQkJKHVuc2lnbmVkIGxv
bmcpa2FzYW5fcmVzZXRfdGFnKCh2b2lkICopcHRyX2FkZHIpKTsKICNlbHNlCiAJcmV0dXJuIHB0
cjsKICNlbmRpZgo=
--00000000000068e02505814f9370
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--00000000000068e02505814f9370--

