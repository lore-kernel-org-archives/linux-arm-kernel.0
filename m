Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5011C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:38:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D9E2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PTe27XBQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+5gcIz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D9E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7xvA2pFGSclewgVzQzHl0XHwlX5N/36MUaIXuOX2vRQ=; b=PTe27XBQmos4kX
	CnftDvvk5djWCaElsq6m8jVPQXOZmoNuq1oFwB7CXxV8BG3B405Pxd4SMJG+3ZHUixWBa8U05FnqD
	al9pXHChL6ZQtXC01cUt1ZMrD7mYpVFt3bUb/bVjw2AdSwarPzVV+P8P3xELApDovmNC8EP/azhUn
	43HwgnjluD/7oCRH0JsC+0DtCX0aYNXcy87bdi7Zts4m70OcutCUE59LOKnbhffqGzk8i7S9qnqzz
	gKUV36LK9zaa4e06DxyZeeK7x/ZyVYz6KUTwpi01yVGrfn6TkWXqNrq/+KSCCGNsl/7uBtV/fThJN
	yaUFv2y7AoJHYyEVxVBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1genHP-0006JZ-CF; Wed, 02 Jan 2019 20:38:19 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1genHL-0006Ij-HZ
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 20:38:17 +0000
Received: by mail-ed1-x544.google.com with SMTP id d39so27226209edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 12:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ksNlgM86gDq6F6FlGm+NBT+PmvygF6GxCr3UTu+6ME4=;
 b=i+5gcIz9hL1WVvnjbO5n31cVWC3wltF53sKOm1rK6C4eXqpibvcrS84oO867+6dE16
 Wd479yRjsA2Z2x1KdiYq9TI/ZpcF7YJ7tjjHxCS/tcwYdQzBYHXlKPtIxiFmNd+PJr3N
 XlISZVEkcOhWn7sfkM3lOoZz8B1vloIr5NhZT0i96sfKoj8B35pqi/YhALpDMc0o0ioc
 udA3X2h/jVeGX3bDl/d1sG/9Q8OFaQvHet28SC/vTybb1DrvSxeA7b6Vj79HA5d/jAPZ
 BcCAJnJJnI3i3RmdZDNqXaBNb06ceMRAjkqBsXCREFVQgK1OmiyCnhIJ3HsqGZqQpeXt
 3cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ksNlgM86gDq6F6FlGm+NBT+PmvygF6GxCr3UTu+6ME4=;
 b=nah6LDRj7t4H/2AuIcJWlRZDiazYePFnYM7E9Z5PYLiluFfinB5skXTBw2isfHxlo7
 4iWKiKL/3ryWeW6M974xVDsCHi0c2j2yBDaoQ26z4mZ1XqfaoHN6hKldGHRLqAbp3ZHJ
 pHbkOBhODUwhJJLM176UEZxPRf4R1r8foP03hwtLnXvYvZHxL0iHKPVvqGnpZssY0ymA
 EDgAfqlRp8J6VgTHUcOwgm33CGkyKUJAApJZ1AxWr09Jp4lYfVQf+tss0zR5J9G2CuTY
 2JcpXIhmM18602qecKASg7Zt0vWsNEHzMmhrIf3K85PvuhTNmFg6MzyoFClRGX1TCYHo
 1qow==
X-Gm-Message-State: AA+aEWa6t2Dpdja9xt6/ncuAf+2AhtcnCo6oeq6uHOY4Oz+I0mNVg2Ow
 mu3iDsj7xldMtBC8ubj43EdgSvdZ
X-Google-Smtp-Source: AFSGD/W3f7/yPerEgBq1LOpUuTtCE7vlBInIxiDjkQpRR2vcSiexfF0TF3nNnh9AxdGus/R6BaOHwA==
X-Received: by 2002:a17:906:41cc:: with SMTP id
 g12-v6mr33956265ejl.219.1546461491744; 
 Wed, 02 Jan 2019 12:38:11 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id
 w10-v6sm9022083ejn.67.2019.01.02.12.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Jan 2019 12:38:10 -0800 (PST)
Subject: Re: [PATCH 2/2] reset: Add Broadcom STB SW_INIT reset controller
 driver
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-3-f.fainelli@gmail.com>
 <1546425895.3457.1.camel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz7QnRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+iGYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSC5BA0ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU4hPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJ7kCDQRXG8fwARAA6q/pqBi5PjHcOAUgk2/2LR5LjjesK50bCaD4JuNc
 YDhFR7Vs108diBtsho3w8WRd9viOqDrhLJTroVckkk74OY8r+3t1E0Dd4wHWHQZsAeUvOwDM
 PQMqTUBFuMi6ydzTZpFA2wBR9x6ofl8Ax+zaGBcFrRlQnhsuXLnM1uuvS39+pmzIjasZBP2H
 UPk5ifigXcpelKmj6iskP3c8QN6x6GjUSmYx+xUfs/GNVSU1XOZn61wgPDbgINJd/THGdqiO
 iJxCLuTMqlSsmh1+E1dSdfYkCb93R/0ZHvMKWlAx7MnaFgBfsG8FqNtZu3PCLfizyVYYjXbV
 WO1A23riZKqwrSJAATo5iTS65BuYxrFsFNPrf7TitM8E76BEBZk0OZBvZxMuOs6Z1qI8YKVK
 UrHVGFq3NbuPWCdRul9SX3VfOunr9Gv0GABnJ0ET+K7nspax0xqq7zgnM71QEaiaH17IFYGS
 sG34V7Wo3vyQzsk7qLf9Ajno0DhJ+VX43g8+AjxOMNVrGCt9RNXSBVpyv2AMTlWCdJ5KI6V4
 KEzWM4HJm7QlNKE6RPoBxJVbSQLPd9St3h7mxLcne4l7NK9eNgNnneT7QZL8fL//s9K8Ns1W
 t60uQNYvbhKDG7+/yLcmJgjF74XkGvxCmTA1rW2bsUriM533nG9gAOUFQjURkwI8jvMAEQEA
 AYkCaAQYEQIACQUCVxvH8AIbAgIpCRBhV5kVtWN2DsFdIAQZAQIABgUCVxvH8AAKCRCH0Jac
 RAcHBIkHD/9nmfog7X2ZXMzL9ktT++7x+W/QBrSTCTmq8PK+69+INN1ZDOrY8uz6htfTLV9+
 e2W6G8/7zIvODuHk7r+yQ585XbplgP0V5Xc8iBHdBgXbqnY5zBrcH+Q/oQ2STalEvaGHqNoD
 UGyLQ/fiKoLZTPMur57Fy1c9rTuKiSdMgnT0FPfWVDfpR2Ds0gpqWePlRuRGOoCln5GnREA/
 2MW2rWf+CO9kbIR+66j8b4RUJqIK3dWn9xbENh/aqxfonGTCZQ2zC4sLd25DQA4w1itPo+f5
 V/SQxuhnlQkTOCdJ7b/mby/pNRz1lsLkjnXueLILj7gNjwTabZXYtL16z24qkDTI1x3g98R/
 xunb3/fQwR8FY5/zRvXJq5us/nLvIvOmVwZFkwXc+AF+LSIajqQz9XbXeIP/BDjlBNXRZNdo
 dVuSU51ENcMcilPr2EUnqEAqeczsCGpnvRCLfVQeSZr2L9N4svNhhfPOEscYhhpHTh0VPyxI
 pPBNKq+byuYPMyk3nj814NKhImK0O4gTyCK9b+gZAVvQcYAXvSouCnTZeJRrNHJFTgTgu6E0
 caxTGgc5zzQHeX67eMzrGomG3ZnIxmd1sAbgvJUDaD2GrYlulfwGWwWyTNbWRvMighVdPkSF
 6XFgQaosWxkV0OELLy2N485YrTr2Uq64VKyxpncLh50e2RnyAJ9Za0Dx0yyp44iD1OvHtkEI
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <7387643e-b22e-fe25-08e9-1f641f8b306a@gmail.com>
Date: Wed, 2 Jan 2019 12:38:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1546425895.3457.1.camel@pengutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_123815_613314_12EC6162 
X-CRM114-Status: GOOD (  25.78  )
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
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUGhpbGlwcCwKCk9uIDEvMi8xOSAyOjQ0IEFNLCBQaGlsaXBwIFphYmVsIHdyb3RlOgo+IEhp
IEZsb3JpYW4sCj4gCj4gT24gVGh1LCAyMDE4LTEyLTIwIGF0IDE3OjM0IC0wODAwLCBGbG9yaWFu
IEZhaW5lbGxpIHdyb3RlOgo+PiBBZGQgc3VwcG9ydCBmb3IgcmVzZXR0aW5nIGJsb2NrcyB0aHJv
dWdoIHRoZSBMaW51eCByZXNldCBjb250cm9sbGVyCj4+IHN1YnN5c3RlbSB3aGVuIHJlc2V0IGxp
bmVzIGFyZSBwcm92aWRlZCB0aHJvdWdoIGEgU1dfSU5JVC1zdHlsZSByZXNldAo+PiBjb250cm9s
bGVyIG9uIEJyb2FkY29tIFNUQiBTb0NzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIEZh
aW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4KPiAKPiBUaGFuayB5b3UsIHRoaXMgbG9va3Mg
bW9zdGx5IGdvb2QgdG8gbWUuIEkganVzdCBoYXZlIGEgZmV3IHNtYWxsCj4gbml0cGlja3MgYW5k
IEknbSBjdXJpb3VzIGFib3V0IHRoZSBtZGVsYXlzLCBzZWUgYmVsb3cuCgpUaGFua3MsIGFuc3dl
cnMgaW5saW5lLgoKW3NuaXBdCgo+PiArc3RydWN0IGJyY21zdGJfcmVzZXQgewo+PiArCXZvaWQg
X19pb21lbSAqYmFzZTsKPiAKPj4gKwl1bnNpZ25lZCBpbnQgbl93b3JkczsKPj4gKwlzdHJ1Y3Qg
ZGV2aWNlICpkZXY7Cj4gCj4gVGhlc2UgdHdvIHZhcmlhYmxlcyBhcmUgbm90IHVzZWQgYW55d2hl
cmUuCgpJbmRlZWQsIHRoZSBmaXJzdCBvbmUgc2hvdWxkIGFjdHVhbGx5IGJlIGFkZGVkIGFzIGEg
Y2hlY2sgdG8gbWFrZSBzdXJlCndlIGhhdmUgYSBjb3JyZWN0IHJlc291cmNlIHNpemUgYmVpbmcg
cGFzc2VkLCBJIHdpbGwgYWRkIHRoYXQgYmFjayBpbi4KCj4gCj4+ICsJc3RydWN0IHJlc2V0X2Nv
bnRyb2xsZXJfZGV2IHJjZGV2Owo+PiArfTsKPj4gKwo+PiArI2RlZmluZSBTV19JTklUX1NFVAkJ
MHgwMAo+PiArI2RlZmluZSBTV19JTklUX0NMRUFSCQkweDA0Cj4+ICsjZGVmaW5lIFNXX0lOSVRf
U1RBVFVTCQkweDA4Cj4+ICsKPj4gKyNkZWZpbmUgU1dfSU5JVF9CSVQoaWQpCQlCSVQoKGlkKSAm
IDB4MWYpCj4+ICsjZGVmaW5lIFNXX0lOSVRfQkFOSyhpZCkJKGlkID4+IDUpCj4gCj4gQ2hlY2tw
YXRjaCBzdWdnZXN0cyB0byB1c2UgKChpZCkgPj4gNSkgaGVyZS4KPiAKPj4gKwo+PiArI2RlZmlu
ZSBTV19JTklUX0JBTktfU0laRQkweDE4Cj4+ICsKPj4gK3N0YXRpYyBpbmxpbmUKPj4gK3N0cnVj
dCBicmNtc3RiX3Jlc2V0ICp0b19icmNtc3RiKHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAq
cmNkZXYpCj4+ICt7Cj4+ICsJcmV0dXJuIGNvbnRhaW5lcl9vZihyY2Rldiwgc3RydWN0IGJyY21z
dGJfcmVzZXQsIHJjZGV2KTsKPj4gK30KPj4gKwo+PiArc3RhdGljIGludCBicmNtc3RiX3Jlc2V0
X2Fzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LAo+PiArCQkJCXVuc2ln
bmVkIGxvbmcgaWQpCj4+ICt7Cj4+ICsJdW5zaWduZWQgaW50IG9mZiA9IFNXX0lOSVRfQkFOSyhp
ZCkgKiBTV19JTklUX0JBTktfU0laRTsKPj4gKwlzdHJ1Y3QgYnJjbXN0Yl9yZXNldCAqcHJpdiA9
IHRvX2JyY21zdGIocmNkZXYpOwo+PiArCj4+ICsJd3JpdGVsX3JlbGF4ZWQoU1dfSU5JVF9CSVQo
aWQpLCBwcml2LT5iYXNlICsgb2ZmICsgU1dfSU5JVF9TRVQpOwo+PiArCW1zbGVlcCgxMCk7Cj4g
Cj4gV2hhdCBpcyB0aGUgcHVycG9zZSBvZiB0aGUgbXNsZWVwKDEwKT8gSXMgaXQgZ3VhcmFudGVl
ZCB0aGF0IHRoZSB3cml0ZWwKPiB0YWtlcyBlZmZlY3QgYmVmb3JlIHRoZSBtc2xlZXAsIG9yIGNv
dWxkIGl0IGJlIGxpbmdlcmluZyBpbiBzb21lIHN0b3JlCj4gYnVmZmVyIGZvciAoYSBwYXJ0IG9m
KSB0aGUgZHVyYXRpb24/IEFsc28sIGNoZWNrcGF0Y2ggd2FybnPCoGFib3V0IHRoaXMKPiBiZWlu
ZyA8IDIwIG1zLiBZb3UgY291bGQgaW5jcmVhc2UgdGhlIGRlbGF5IG9yIHVzZSB1c2xlZXBfcmFu
Z2UuCgpHb29kIHBvaW50LCBsZXQgbWUgY2hlY2sgd2hhdCB0aGUgcmVhbCBkZWxheSByZXF1aXJl
bWVudHMgYXJlIHdpdGggdGhlCmRlc2lnbiB0ZWFtLCBzaW5jZSBJIHN1c3BlY3QgdGhleSB3ZXJl
IGp1c3Qgb3Zlcmx5IGNvbnNlcnZhdGl2ZSBpbiB0aGVpcgpyZWNvbW1lbmRhdGlvbnMgcHJldmlv
dXNseQoKPiAKPj4gKwlyZXR1cm4gMDsKPj4gK30KPj4gKwo+PiArc3RhdGljIGludCBicmNtc3Ri
X3Jlc2V0X2RlYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsCj4+ICsJ
CQkJICB1bnNpZ25lZCBsb25nIGlkKQo+PiArewo+PiArCXVuc2lnbmVkIGludCBvZmYgPSBTV19J
TklUX0JBTksoaWQpICogU1dfSU5JVF9CQU5LX1NJWkU7Cj4+ICsJc3RydWN0IGJyY21zdGJfcmVz
ZXQgKnByaXYgPSB0b19icmNtc3RiKHJjZGV2KTsKPj4gKwo+PiArCXdyaXRlbF9yZWxheGVkKFNX
X0lOSVRfQklUKGlkKSwgcHJpdi0+YmFzZSArIG9mZiArIFNXX0lOSVRfQ0xFQVIpOwo+PiArCW1z
bGVlcCgxMCk7Cj4gCj4gU2FtZSBhcyBhYm92ZSwgd2hhdCBoYXMgdG8gYmUgZGVsYXllZCBmb3Ig
MTAgbXMgYWZ0ZXIgZGVhc3NlcnRpbmcgdGhlCj4gcmVzZXQ/IElzIHRoaXMgdGhlIHNhbWUgZm9y
IGFsbCByZXNldCBsaW5lcyBoYW5kbGVkIGJ5IHRoaXMgY29udHJvbGxlcj8KCkFGQUlDVCwgYWxs
IGxpbmVzIGJlaGF2ZSB0aGUgc2FtZSB3YXksIGFzIHBlciBvdXIgU29DcyByZXNldCBhcmNoaXRl
Y3R1cmUuCgo+IAo+PiArCj4+ICsJcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyBpbnQg
YnJjbXN0Yl9yZXNldF9zdGF0dXMoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwK
Pj4gKwkJCQl1bnNpZ25lZCBsb25nIGlkKQo+PiArewo+PiArCXVuc2lnbmVkIGludCBvZmYgPSBT
V19JTklUX0JBTksoaWQpICogU1dfSU5JVF9CQU5LX1NJWkU7Cj4+ICsJc3RydWN0IGJyY21zdGJf
cmVzZXQgKnByaXYgPSB0b19icmNtc3RiKHJjZGV2KTsKPj4gKwo+PiArCXJldHVybiByZWFkbF9y
ZWxheGVkKHByaXYtPmJhc2UgKyBvZmYgKyBTV19JTklUX1NUQVRVUyk7Cj4gCj4gU2hvdWxkIHRo
aXMgYmUKPiAKPiArCXJldHVybiByZWFkbF9yZWxheGVkKHByaXYtPmJhc2UgKyBvZmYgKyBTV19J
TklUX1NUQVRVUykgJgo+ICsJICAgICAgIFNXX0lOSVRfQkFOSyhpZCk7Cj4gCj4gaS5lLiBkbyB0
aGUgU1dfSU5JVF9TVEFUVVMgcmVnaXN0ZXJzIGNvbnRhaW4gMzIgc3RhdHVzIGJpdHMsIG9uZSBm
b3IKPiBlYWNoIHJlc2V0IGxpbmU/CgpZZXMgdGhleSBkby4gVGhlIHNhbWUgYml0cyBhcmUgdXNl
ZCBmb3IgU0VUL0NMRUFSL1NUQVRVUyBzbyB0aGlzIHNob3VsZApiZSBzb21ldGhpbmcgYWxvbmcg
dGhlIGxpbmVzIG9mOgoKcmV0dXJuIHJlYWRsX3JlbGF4ZWQocHJpdi0+YmFzZSArIG9mZiArIFNX
X0lOSVRfU1RBVFVTKSAmIEJJVChpZCkpOwoKdGhhbmtzIGZvciBzcG90dGluZyB0aGF0IQoKPiAK
Pj4gK30KPj4gKwo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyBicmNt
c3RiX3Jlc2V0X29wcyA9IHsKPj4gKwkuYXNzZXJ0CT0gYnJjbXN0Yl9yZXNldF9hc3NlcnQsCj4+
ICsJLmRlYXNzZXJ0ID0gYnJjbXN0Yl9yZXNldF9kZWFzc2VydCwKPj4gKwkuc3RhdHVzID0gYnJj
bXN0Yl9yZXNldF9zdGF0dXMsCj4+ICt9Owo+PiArCj4+ICtzdGF0aWMgaW50IGJyY21zdGJfcmVz
ZXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4gK3sKPj4gKwlzdHJ1Y3Qg
ZGV2aWNlICprZGV2ID0gJnBkZXYtPmRldjsKPj4gKwlzdHJ1Y3QgYnJjbXN0Yl9yZXNldCAqcHJp
djsKPj4gKwlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsKPj4gKwo+PiArCXByaXYgPSBkZXZtX2t6YWxs
b2Moa2Rldiwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7Cj4+ICsJaWYgKCFwcml2KQo+PiAr
CQlyZXR1cm4gLUVOT01FTTsKPj4gKwo+PiArCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7Cj4+ICsJcHJpdi0+YmFzZSA9IGRldm1faW9yZW1hcF9y
ZXNvdXJjZShrZGV2LCByZXMpOwo+PiArCWlmIChJU19FUlIocHJpdi0+YmFzZSkpCj4+ICsJCXJl
dHVybiBQVFJfRVJSKHByaXYtPmJhc2UpOwo+PiArCj4+ICsJZGV2X3NldF9kcnZkYXRhKGtkZXYs
IHByaXYpOwo+PiArCj4+ICsJcHJpdi0+cmNkZXYub3duZXIgPSBUSElTX01PRFVMRTsKPj4gKwlw
cml2LT5yY2Rldi5ucl9yZXNldHMgPSAocmVzb3VyY2Vfc2l6ZShyZXMpIC8gU1dfSU5JVF9CQU5L
X1NJWkUpICogMzI7Cj4+ICsJcHJpdi0+cmNkZXYub3BzID0gJmJyY21zdGJfcmVzZXRfb3BzOwo+
PiArCXByaXYtPnJjZGV2Lm9mX25vZGUgPSBrZGV2LT5vZl9ub2RlOwo+PiArCS8qIFVzZSBkZWZh
dWx0czogMSBjZWxsIGFuZCBzaW1wbGUgeGxhdGUgZnVuY3Rpb24gKi8KPj4gKwlwcml2LT5kZXYg
PSBrZGV2Owo+IAo+IHByaXYtPmRldiBjb3VsZCBiZSByZW1vdmVkLgoKSW5kZWVkLCBJIGhhZCBz
cHJpbmtsZWQgZGV2XyooKSBtZXNzYWdlcyBkdXJpbmcgZGVidWcsIHdoaWNoIHJlcXVpcmVkCml0
LCBidXQgdGhpcyBpcyBubyBsb25nZXIgcmVxdWlyZWQgaW5kZWVkLgotLSAKRmxvcmlhbgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
