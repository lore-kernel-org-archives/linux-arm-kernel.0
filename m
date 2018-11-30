Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515DEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:36:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21AA420867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i1vMji8h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/hXU6VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AA420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kkthFuwWGmYGdk/kVEP68XGcyaREEkpkEr0agJONlV4=; b=i1vMji8hOwX9v3
	bgwFAYuQ04hxkoUCKANa3XIV+/NwbbThyxQzYZxMsvMgrip7KOCT7ma7PuOX33OL1JV3uBLqNX/AH
	+ujZWqpbE5G6un80yNF1pRAQOHeMNZlZFC40pAe6WBNG5XrF4nJZrz1eX6RDNMjd8pIexmtm0wmZb
	tKr3oLXOpGZPGwsxd9P04arlF/eOeeX0ZYf5YOBCdt0A1npGvLncsGqvTvNXyWtx3mdLT+Nrah6mS
	d/q0FqEwYmePQ6XZ0+CBuNUUseQQjKIr0MWF8lQRawRnWlSmsWVGAb0HhxnF+GT6TOVNgr3Vki4fz
	8o68Nt/gp0mPOsg8KuHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnef-0005Uc-8p; Fri, 30 Nov 2018 18:36:45 +0000
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSneb-0005TQ-VY
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:36:43 +0000
Received: by mail-yw1-xc43.google.com with SMTP id i20so2672904ywc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hT1QYZNc5YI+3fa+2DfsDewJX8UjoXT4yxiBn8gXHMc=;
 b=F/hXU6VB3m0gSRVuz6qlUIY0cgj8wBYdqnZ8qSprol6pPpgmGso2XKPIUtSSSiCGCM
 u/KlMfvSBj4Wynw9BhZrNwxGdvrSqdKidAk8h00tREcXunEHQ/CkEca7KqiMOIc1EM9p
 QtYJAZ5yvcvfCUFBFhEOwW3an9jiJKzYe6Qbg2ivrlXHbXDK2Em+ptnMIkiQ1cGnP8Uu
 hBslNLaxBwScXM/NtesgnO2nktuFVNOR0Vh8uoBY1JYZjCIDCye8pkADsrU/OrUJnDHy
 9xBMjFii5iz2WYLlAyv1ZRYN0Q3S0adMHIuPxuuvLvobDv6PH1NtGRJWmMxqmWu/Rfnu
 CSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hT1QYZNc5YI+3fa+2DfsDewJX8UjoXT4yxiBn8gXHMc=;
 b=s6dFgYE/AbltjULcvNIPaZn8nIl0L0O2Hr8MTdrN2dDmsUw/CWIU++LVgrVJhxquOl
 xRTK6QX3V8UpOL0yo1GqEKo8D3ZmLh/47QiVP1T2/FEHskLnavIhnR29venpD71W3M56
 eASWsRKWghEOIpWFfXC9Ot/qOAUIvLd5dpQf0Ye+Mi5D0duXFbiHuG1VZur8uvVVg3S+
 dCOcdJlQlGhSCMxxewc+zk1UvAmC7Cm95Mo9pEj+z6EvQ/kUjtqAuXlpANOarM755bfM
 iLfNaGKa1GzVSE2irPxqjilTYe9sOgyhzA3ydbygc6N1jh02ZsNqVPDhdxZHhrJIzekE
 m6qA==
X-Gm-Message-State: AA+aEWZ0nxYOVaQ1esJBcNIOcSTRVHI6AJChvCsO/XgkGQlJj6bb0B/Q
 Dij64AB08uRuoYVXFGpEW/fbd+9T
X-Google-Smtp-Source: AFSGD/V97uKhkYDR0SzZ6Z4CvAF5wpoN8rs88k6L3B2Stbs0xRiShwfbzqayREJmHE+xaTGfI7AiJw==
X-Received: by 2002:a81:29d5:: with SMTP id p204mr6836078ywp.285.1543602989157; 
 Fri, 30 Nov 2018 10:36:29 -0800 (PST)
Received: from [10.67.49.9] (igp-prod-emp-gw.vpn.broadcom.com.
 [192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id j186sm1688746ywg.36.2018.11.30.10.36.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 10:36:28 -0800 (PST)
Subject: Re: Adding a Basic DT for the Linksys ea6500 v2 wireless home router
To: =?UTF-8?Q?Ren=c3=a9_Kjellerup?= <rk.katana.steel@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <CACE8ZKbUhFyWg5oK1B8+aWAa0tdqKf5Kokj80+8x1X2EUaA_DQ@mail.gmail.com>
 <CACE8ZKZEpQjOW6CSvUuM9xhjtkSCF0bYxcfQ3htSabC=rVJcTA@mail.gmail.com>
 <86f391e5-9e38-c8b0-4753-4646c322c9bc@hauke-m.de>
 <CACE8ZKb5CxEBAdCdGAhwaQHC9_nHBjTTVwxdDOXRayqgz0FK5g@mail.gmail.com>
 <CACE8ZKYCyDx_E+3sLpjQSV6xrFxGyrYwEfhEO=QZPGpm3jsBrQ@mail.gmail.com>
 <5a6a30cf-1d93-7232-e607-3919b86bbdff@gmail.com>
 <CACE8ZKaMBfa5vWJMp_xVjstkuxkjO=DDwp1srA+Am1RP46gZcQ@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
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
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <0d26bc69-6439-05c9-a219-beae33f847c2@gmail.com>
Date: Fri, 30 Nov 2018 10:36:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACE8ZKaMBfa5vWJMp_xVjstkuxkjO=DDwp1srA+Am1RP46gZcQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_103642_017640_7D742B5B 
X-CRM114-Status: GOOD (  19.62  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Hauke Mehrtens <hauke@hauke-m.de>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTEvMjcvMTggNjowOSBQTSwgUmVuw6kgS2plbGxlcnVwIHdyb3RlOgo+IAo+IE9uIFR1ZSwg
Tm92IDI3LCAyMDE4IGF0IDQ6MjMgUE0gRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFp
bC5jb20KPiA8bWFpbHRvOmYuZmFpbmVsbGlAZ21haWwuY29tPj4gd3JvdGU6Cj4+Cj4+Cj4+Cj4+
IE9uIDExLzI2LzE4IDQ6NDkgUE0sIFJlbsOpIEtqZWxsZXJ1cCB3cm90ZToKPj4gPiBUbyB0aGUg
YnJvYWRjb20ga2VybmVsIG1haW50YWluZXJzLCAoZm9yIEJDTTQ3MDggQ1BVcykKPj4gPgo+PiA+
IEkganVzdCB3YW50IHRvIGFkZCBhIGxpdHRsZSBhdHRlbnRpb24gdG8gdGhpcyBwYXRjaCBhZ2Fp
bi4uLgo+PiA+IGxldCBtZSBrbm93IGlmIHRoZXJlJ3MgYW55IGNvbmNlcm5zIGFuZCBJIHdpbGwg
dHJ5IHRvIGFkZHJlc3MKPiBoaWdobGlnaHRlZCBpc3N1ZXMKPj4gPiBhcyBzb29uIGFzIHBvc3Np
YmxlLgo+PiA+Cj4+ID4gSSd2ZSBiZWVuIHJ1bm5pbmcgdGhlIGRldmVsb3BtZW50IGJ1aWxkcyBv
ZiBPcGVuV3J0IGtlcm5lbHMsIHdoZXJlCj4+ID4gdGhpcyBwYXRjaCBoYXMKPj4gPiBiZWVuIGlu
Y2x1ZGVkLCBvbiBteSBMaW5rc3lzIEVBNjUwMHYyIHJvdXRlciBmb3IgdGhlIHBhc3QgbW9udGhz
LAo+PiA+IHVwZGF0aW5nIGFzIG5ldwo+PiA+IGJ1aWxkcyBhcmUgYXZhaWxhYmxlLiBXaXRoIG9u
bHkgdGhlIG9uIGJvYXJkIEJDTTQzNjAgY2hpcCAoNUdIego+IFdpRmkpIGlzIGJlaW5nCj4+ID4g
ZGlzYWJsZWQsIGhhcyBzbyBmYXIgYmVlbiBzdGFibGUgZm9yIG15IHVzZSBjYXNlLgo+Pgo+PiAo
UGxlYXNlIG5vIHRvcCBwb3N0aW5nKS4gWW91ciBzdWJtaXNzaW9uIGRpZCBtYWtlIGl0IHRocm91
Z2ggcGF0Y2h3b3JrCj4+IGFuZCBsb29rcyBva2F5LCBJIHdpbGwgcnVuIGJ1aWxkIHRlc3RzIGFu
ZCBxdWV1ZSBpdCB1cCBmb3IgNC4yMSBpZgo+PiBldmVyeXRoaW5nIGxvb2tzIGdvb2QuIFRoYW5r
cy4KPj4KPiAuLi4KPj4KPj4gLS0KPj4gRmxvcmlhbgo+IAo+IHRoYW5rIHlvdSBGbG9yaWFuIGZv
ciB0aGUgdXBkYXRlCj4gSSBhcHByZWNpYXRlIHRoZSBmZWVkYmFjawoKTm93IGFwcGxpZWQgdG8g
ZGV2aWNldHJlZS9uZXh0LCB0aGFua3MuIFBsZWFzZSB1c2UgZ2l0CmZvcm1hdC1wYXRjaC9zZW5k
LWVtYWlsIGluIHRoZSBmdXR1cmUsIGFzIHRoZSBwYXRjaCB3YXMgbWFuZ2xlZCBhIGxpdHRsZQpi
aXQgYnkgYmVpbmcgc2VudCB3aXRoaW4gdGhlIG1lc3NhZ2UgYm9keS4KClRoYW5rIHlvdQotLSAK
RmxvcmlhbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
