Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEBAC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:16:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7B42184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PFQVPzJn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="N55NHHGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7B42184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xtdBKGRWUUBfVDgFTHLfZ5ycBBjsLfPuYpcSuR2PCJg=; b=PFQVPzJne4wjILjykPena5Jbw
	BScaaAOel1evlAWlIgfgDLMKdZO2W+Dxki5Amn88tp0YvuECuu8hJQy0i+kq8Ir8OYOf6uPH7+tKs
	rY72yLiiBsqgsEL9jsqd5KLKjzHb2voG3MFueYbrWZwiOAe4k2kHcA/pEkOOEjeQ1hwAlSeDdUtr8
	DUYS6y0ecOlybJAwJYC9LzKHPtQng0t2pjGJJQMa5nVB5nq5OYX3cpGLsfx2NbpbzJuhybCk3hPiM
	LjnGeh9EjMqAlkpO9Mzlt3Lij11ft0j4WpyOOgzphDzQ+Ff6onHT2nls57o+xxt+TWTTVIyKPwD7r
	kQZXHgnzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnRZD-0007FK-4V; Sat, 26 Jan 2019 17:16:27 +0000
Received: from se14t.web-hosting.com ([162.255.118.155])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnRZ9-0007Eh-N0
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 17:16:25 +0000
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
 by se14.registrar-servers.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jagan@openedev.com>)
 id 1gnQW8-0002w8-Kf; Sat, 26 Jan 2019 08:09:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eerXW8deLRFNJ082VjgdoXPR1hogTB4K5IRcED5Ob3Q=; b=N55NHHGErksks3wkgIKLSVpTMV
 AyPOu3jAy4oEqzGeV0wB4quAc5qG9HzFd5bpWk499eoLSv7RCagZ9ldqTXQqWIMJ4heu/5V7J0/+/
 /COiDLD2blMLPcGULqDX+6qbJlgD5mn5V4X8j5MHEP/pJjnwLaSLuV2jlCs+0QldbKB8t84u8HXOa
 PyVcztswWSc1ZboBU+eHC2prPtoy859LyK+d3+BpQwnNnbYWt2kBFcbspX/TDtH6jAjzPOOIcbXqI
 6gGn8IsSmnToFlgwolHOa3Va/ZTkuWeOOasYYs8+RYu3NgCwlig/wM8mkg3j3zobOVCzG7vU9n6LZ
 qM0hHLKQ==;
Received: from [115.97.179.75] (port=51782 helo=[192.168.0.10])
 by server153.web-hosting.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <jagan@openedev.com>)
 id 1gnQW2-002TlN-Vi; Sat, 26 Jan 2019 11:09:07 -0500
Subject: Re: [linux-sunxi] Re: [PATCH v6 14/22] dt-bindings: sun6i-dsi: Add
 A64 DSI compatible (w/ A31 fallback)
To: maxime.ripard@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-15-jagan@amarulasolutions.com>
 <20190125155236.agxwkxvyefmrbvym@flea>
From: Jagan Teki <jagan@openedev.com>
Message-ID: <bed39fd2-1f4f-4c6b-afc6-da127326775c@openedev.com>
Date: Sat, 26 Jan 2019 21:39:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125155236.agxwkxvyefmrbvym@flea>
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com;
 auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5p3su2DtuSZ1p0nI9y4N8fZ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO0Ma0zdKrj2HeYAO9pcN4rBgaa/6KAnDjbDW9Kfk8S67g3pl1PjvMwh7dhUCqsSW27/t
 rDpkMvqAKkcaWePFrnWbCOEGmYDYXX5N55z9d8KgsbramU7NHkOygsZkJKqgTbdp4t6W3IMAO2SH
 1E8zaxox8L7GcfNO+2MU0i0gmK7/z4AuKVkkaYzGFQ2Ibzaym5b2BO/9WjebTieNrwxflLMZXQ36
 dEAVm3i4vm5cXrAOZG9Sp2J20AHLJSx77kQkVnnVSft1LT6y1e0U9STPKa/GQdeBNIkLb6r47afa
 w/CH6KBkbKsuM8AASIR5FkcIFuzQu5IqYl3M6BKhcK235VfjkgLL7IxFttHKDG1B2EwbdbpdlBjV
 CLeXVxe8pBwJ2z2ZxJi1Q8sHZ7bnbbjx8d44Mc2SXSmbnCWBzdnGy8uFWJJSMDV+rzwLvyOpGnZR
 EskE8uGttwnPZM1P+VPKwUVnVpSuzRRB0yO0FgxZ5NStM50u1cVPItYg5ol3QOm7L4Sid3vYU1bR
 705IPIadxBD/3mgYy2wgK4dNReNhf3bmnjFv2zPPUxDS+mKKTObFcFx0QrY5Wr4Tr9eOpg5s32g8
 9AFms9wgEy0AcHbma/+26M+pbz8SjqkO4ZmYmgW7lHTFgIfDMShmlQFqCr5hA8wXS7Jg7MEKutMz
 dp+wUO6KCTr6J/h3GgxZZjPp6umVzGyBOCDwRLhgcnpcOwrGK2ayxQgNyqqf/IN48z1lpo6ODRmi
 SLYXQoEVxAAhr5KC2z00v+4P+5at/HsH1isNq8k+VTLs7+3/QriFdXoSiJZ/kuI+OJDNovVqKLll
 g3MLAhJh4EBfV0EQXhOSRzoZcOef8MeTUF+3u4q6NzJgW1ruJDheH5hLAJSBqnHN5aPUgBtRC2aF
 hr6pfb8wbPuJxsjlgTl6fJxyntEfhZCKje4ZXau28ZLUwqHGS5T/H0nFZKe5av/CxXIXJIBC+ema
 c+G2uJyh1FYJh7VnqItchrC72OUMeHyTpNN0eXybX/w7/4VO4PqH7tRQbUwn/Z22G56P9zwlrdZi
 NQj4PT1Zbis+EXUG7TNSxNow7/t2xrEP1ATsqGMGrkOirMZUMXyr+Ba9g0MOnCndEeVcIKB2jIn4
 vrRYEXTMu1QMr3TBnoscZ8OYieT8qf6TsMCg/vmaSHUKgyH3fip4DAxWRW/wxLWB7HrZLYgDmgz6
 KUwxi29Bp9FIkeIiDP/ECUoOSkeHK8v64f+QgoKau2bG0Hp+HzAjsWCLuhF1p5ywGhk+JygEFSG7
 X+t1TW39Ja77LGPpOwA1DvwEC4Lrfaqa2sMQ8hhbKGrji4Pk/Gyrw43N0WGaeDB4FfZzPE/Pcs/5
 uRYMV187qlt4wO85XNTxg1DyrHa1ZbTcx8N0iCdZNCLd191YqcjWBA4Ws7Ey1JEqCGHE58V2XN6q
 AseowdwxD2E3+DaJDvXMbLOjVpPm3YT8Yh1GaqvcHCQ0IJV0lzcUVPfZKuExL7hrJSk60SF3F6RY
 OYr2
X-Report-Abuse-To: spam@se16.registrar-servers.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_091623_753604_2AA46220 
X-CRM114-Status: GOOD (  16.35  )
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
 David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/01/19 9:22 PM, Maxime Ripard wrote:
> On Fri, Jan 25, 2019 at 01:28:52AM +0530, Jagan Teki wrote:
>> The MIPI DSI controller in Allwinner A64 is similar to A33.
>>
>> But unlike A33, A64 doesn't have DSI_SCLK gating which eventually
>> set the mod clock rate for the controller.
>>
>> So, use the DSI_DPHY gating for the similar purpose of mod clock
>> so-that the controller can operate properly.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
>> index 69e233e8fad1..dbda2e567760 100644
>> --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
>> +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
>> @@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
>>   Required properties:
>>     - compatible: value must be one of:
>>       * allwinner,sun6i-a31-mipi-dsi
>> +    * "allwinner,sun50i-a64-mipi-dsi", "allwinner,sun6i-a31-mipi-dsi"
> 
> The other line doesn't have quotes, we should be consistent

You mean to say, remove quotes like this


allwinner,sun50i-a64-mipi-dsi, allwinner,sun6i-a31-mipi-dsi

This make confusion with comma with allwinner vs next compatible string 
isn't it? (In fact I did follow the similar like TCON in sun4i-drm.txt)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
