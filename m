Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B66C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:41:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DEA206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rcWz4Iwx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1rd0Ooq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DEA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ywhaIFboHCaqezqj6flKVwyXMw3oExzbPVAEYnaoBsQ=; b=rcWz4Iwxaca6VC8b+Oyx713yr
	PNa2bQEt4HnreFGcS3KZpWHg4tlMYKn70HiZvR5foaGZyGXwVi+r41Qv40QgDeNwoGoVWB2is1pvN
	Hz3fSeCk4GzziJojDmdisTnSzN8WX5CiJsXU7wud7HdkmTLuLKi6noIsTvfGj/p5rZE1wxyfaHG7s
	8Eb+fz2zPIK789dzWWLzO2IRySaG7iJygDhQIWHJelquOjyVI460A+/0CWp1Q1rqyu8/nyQUVwd+z
	Gj80WllSLyxqVsjc+f00/Imo8VxH6oVC1Qca3N/ArqOsN6fxQm9vI68uW/d8U77ZsxgogbziY+M1I
	J8L2wlcyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYMs-0006w9-IR; Wed, 05 Dec 2018 14:41:38 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYMo-0006hw-VK
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:41:36 +0000
Received: by mail-ot1-x343.google.com with SMTP id s5so18789443oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 06:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7PJkTt1Q09aP9Mt4aoTE32lQqSFGN1wZG6dZAj981EY=;
 b=c1rd0OoqCf4oEJI7JQJlfJItrWmmF5L1xxVrbmxKvj24A43OQ4D4GolgnDdS+rjNCv
 mpjZDenzI7c4ZJV3e0U6fl5gcc6vIbdvN8bltDLG5NJuG6wP+keDFa6UtcLgQ31wxGZU
 hRvnRG5q7vKeEFET8Xmtgby16ncmDY7ImOt2QmMpANdiIHZFyDk9crTyFWJXmgHjwf3z
 FjUXyi/Rw17xbfyVxGJUAvDBSuf+cDpXscq3uewdunbyc9XVJSeFGy4heiQoniUamtbz
 xOCTFh/L5mUncnjmRCfW6Y24fB9Q06zRI0i2+T5/QXoHy/+wNuyhWDrhkMRlhnpPgm/Z
 ajSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7PJkTt1Q09aP9Mt4aoTE32lQqSFGN1wZG6dZAj981EY=;
 b=MG7/AJb0+Y2LtNk3mSKJoiHopUn9LkS2CIyTjaSEb8Va7A5EbqNUIonFGlJ0WM3fmv
 qaNIomD19MuXzuym4ncMX7HZS+N8QzqZz5szIc9hlKfLMVoBzHMGpuNul6qtkakSQ3wY
 U3gJoGNhDjMSmPOEgYAvwDDoNb6h6evc/0heIn7SM8/xB1rONSyjaRzb2vUhUq2fhx6B
 hqquZbVTH7I8U3UYx1Okal9qO+H61DQ7nLne526VAOsxcjD22AQP7aCE9T+bQEQITH4A
 rpsmm1Lzr3WQPQkyIDm5QLFjcrLRMNh9QpVSpcpro9M9N5IXTSTwjd4LYPc01Xfwb5St
 ds1A==
X-Gm-Message-State: AA+aEWb/QPAj3BRyDTiiImHh++gGtjyfUvmKgZco/mYQtn0Ic7N8Rhki
 MnKEd5Leqf66lN9EfWe6Gs/6HiwzFS3mSf58A/0=
X-Google-Smtp-Source: AFSGD/WfkhQOP+TMCoA3kOGXwFWVxTHd5SSaOnJrJAngHhHSIIIf2cJ4xbiy5aOiHexrzo1wCH0Se0FKmT1u/Ln0ryU=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr16204755otj.228.1544020883693; 
 Wed, 05 Dec 2018 06:41:23 -0800 (PST)
MIME-Version: 1.0
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5ACrqY9FusUG7E-vMWJ4pKpVgw-yLOYqJncOJ+H9A5k5w@mail.gmail.com>
In-Reply-To: <CAOMZO5ACrqY9FusUG7E-vMWJ4pKpVgw-yLOYqJncOJ+H9A5k5w@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Dec 2018 12:41:27 -0200
Message-ID: <CAOMZO5DXDB+6an4N5SRmviW_oJ_6AtogkVQ_Mpj6o3bVKDsuKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: add light sensor support
To: Yongcai Huang <anson.huang@nxp.com>
Content-Type: multipart/mixed; boundary="0000000000004c8df8057c4760c7"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_064135_061256_9E6E8FE6 
X-CRM114-Status: GOOD (  17.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--0000000000004c8df8057c4760c7
Content-Type: text/plain; charset="UTF-8"

Hi Anson,

On Wed, Dec 5, 2018 at 10:15 AM Fabio Estevam <festevam@gmail.com> wrote:

> I know that you followed the existing pattern for regulators in this
> file, but it is not recommended to put regulators under "simple-bus".
>
> I would suggest you to make a first patch of the series that removes
> all of the existing regulators from "simple-bus", then you add this
> series on top.

To make things easier, please find attached a patch that implements
this suggestion.

Please make it the first patch of your series.

Thanks

--0000000000004c8df8057c4760c7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ARM-dts-imx6qdl-sabresd-Move-regulators-outside-of-s.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-dts-imx6qdl-sabresd-Move-regulators-outside-of-s.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jpba50ba0>
X-Attachment-Id: f_jpba50ba0

RnJvbSBhMDU1MjljNzdhYjEwN2RhYjZjY2Y5N2U5NzY3Y2VkOGZkMGIwNWQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+CkRh
dGU6IFdlZCwgNSBEZWMgMjAxOCAxMjozNjozNSAtMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFSTTog
ZHRzOiBpbXg2cWRsLXNhYnJlc2Q6IE1vdmUgcmVndWxhdG9ycyBvdXRzaWRlIG9mCiAic2ltcGxl
LWJ1cyIKCkl0IGlzIG5vdCByZWNvbW1lbmRlZCB0byBwbGFjZSByZWd1bGF0b3JzIGluc2lkZSAi
c2ltcGxlLWJ1cyIsIHNvIG1vdmUKdGhlbSBvdXQgdG8gbWFrZSBpdCBjbGVhbmVyIHRoZSBhZGRp
dGlvbiBvZiBuZXcgcmVndWxhdG9ycy4KClNpZ25lZC1vZmYtYnk6IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXNhYnJlc2Qu
ZHRzaSB8IDgyICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAzNiBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9pbXg2cWRsLXNhYnJlc2QuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxZGwtc2FicmVzZC5kdHNpCmluZGV4IDZlNDZhMTkuLmQ3NTg1ODUgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtc2FicmVzZC5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZxZGwtc2FicmVzZC5kdHNpCkBAIC0xNiw1MiArMTYsNDIgQEAKIAkJcmVnID0gPDB4
MTAwMDAwMDAgMHg0MDAwMDAwMD47CiAJfTsKIAotCXJlZ3VsYXRvcnMgewotCQljb21wYXRpYmxl
ID0gInNpbXBsZS1idXMiOwotCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKLQkJI3NpemUtY2VsbHMg
PSA8MD47Ci0KLQkJcmVnX3VzYl9vdGdfdmJ1czogcmVndWxhdG9yQDAgewotCQkJY29tcGF0aWJs
ZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwotCQkJcmVnID0gPDA+OwotCQkJcmVndWxhdG9yLW5hbWUg
PSAidXNiX290Z192YnVzIjsKLQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDUwMDAwMDA+
OwotCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8NTAwMDAwMD47Ci0JCQlncGlvID0gPCZn
cGlvMyAyMiAwPjsKLQkJCWVuYWJsZS1hY3RpdmUtaGlnaDsKLQkJCXZpbi1zdXBwbHkgPSA8JnN3
YnN0X3JlZz47Ci0JCX07Ci0KLQkJcmVnX3VzYl9oMV92YnVzOiByZWd1bGF0b3JAMSB7Ci0JCQlj
b21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7Ci0JCQlyZWcgPSA8MT47Ci0JCQlyZWd1bGF0
b3ItbmFtZSA9ICJ1c2JfaDFfdmJ1cyI7Ci0JCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1
MDAwMDAwPjsKLQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDUwMDAwMDA+OwotCQkJZ3Bp
byA9IDwmZ3BpbzEgMjkgMD47Ci0JCQllbmFibGUtYWN0aXZlLWhpZ2g7Ci0JCQl2aW4tc3VwcGx5
ID0gPCZzd2JzdF9yZWc+OwotCQl9OwotCi0JCXJlZ19hdWRpbzogcmVndWxhdG9yQDIgewotCQkJ
Y29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwotCQkJcmVnID0gPDI+OwotCQkJcmVndWxh
dG9yLW5hbWUgPSAid204OTYyLXN1cHBseSI7Ci0JCQlncGlvID0gPCZncGlvNCAxMCAwPjsKLQkJ
CWVuYWJsZS1hY3RpdmUtaGlnaDsKLQkJfTsKLQotCQlyZWdfcGNpZTogcmVndWxhdG9yQDMgewot
CQkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwotCQkJcmVnID0gPDM+OwotCQkJcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKLQkJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llX3Jl
Zz47Ci0JCQlyZWd1bGF0b3ItbmFtZSA9ICJNUENJRV8zVjMiOwotCQkJcmVndWxhdG9yLW1pbi1t
aWNyb3ZvbHQgPSA8MzMwMDAwMD47Ci0JCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAw
MDAwPjsKLQkJCWdwaW8gPSA8JmdwaW8zIDE5IDA+OwotCQkJZW5hYmxlLWFjdGl2ZS1oaWdoOwot
CQl9OworCXJlZ191c2Jfb3RnX3ZidXM6IHJlZ3VsYXRvci11c2Itb3RnLXZidXMgeworCQljb21w
YXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7CisJCXJlZ3VsYXRvci1uYW1lID0gInVzYl9vdGdf
dmJ1cyI7CisJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDUwMDAwMDA+OworCQlyZWd1bGF0
b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsKKwkJZ3BpbyA9IDwmZ3BpbzMgMjIgMD47CisJ
CWVuYWJsZS1hY3RpdmUtaGlnaDsKKwkJdmluLXN1cHBseSA9IDwmc3dic3RfcmVnPjsKKwl9Owor
CisJcmVnX3VzYl9oMV92YnVzOiByZWd1bGF0b3ItdXNiLWgxLXZidXMgeworCQljb21wYXRpYmxl
ID0gInJlZ3VsYXRvci1maXhlZCI7CisJCXJlZ3VsYXRvci1uYW1lID0gInVzYl9oMV92YnVzIjsK
KwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NTAwMDAwMD47CisJCXJlZ3VsYXRvci1tYXgt
bWljcm92b2x0ID0gPDUwMDAwMDA+OworCQlncGlvID0gPCZncGlvMSAyOSAwPjsKKwkJZW5hYmxl
LWFjdGl2ZS1oaWdoOworCQl2aW4tc3VwcGx5ID0gPCZzd2JzdF9yZWc+OworCX07CisKKwlyZWdf
YXVkaW86IHJlZ3VsYXRvci1hdWRpbyB7CisJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVk
IjsKKwkJcmVndWxhdG9yLW5hbWUgPSAid204OTYyLXN1cHBseSI7CisJCWdwaW8gPSA8JmdwaW80
IDEwIDA+OworCQllbmFibGUtYWN0aXZlLWhpZ2g7CisJfTsKKworCXJlZ19wY2llOiByZWd1bGF0
b3ItcGNpZSB7CisJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsKKwkJcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsKKwkJcGluY3RybC0wID0gPCZwaW5jdHJsX3BjaWVfcmVnPjsKKwkJ
cmVndWxhdG9yLW5hbWUgPSAiTVBDSUVfM1YzIjsKKwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQg
PSA8MzMwMDAwMD47CisJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+OworCQln
cGlvID0gPCZncGlvMyAxOSAwPjsKKwkJZW5hYmxlLWFjdGl2ZS1oaWdoOwogCX07CiAKIAlncGlv
LWtleXMgewotLSAKMi43LjQKCg==
--0000000000004c8df8057c4760c7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--0000000000004c8df8057c4760c7--

