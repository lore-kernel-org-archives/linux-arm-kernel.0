Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8354FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:18:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537A120685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HgUMYmD0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSSKJYA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537A120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=0DQ3Zl9ehXOsWtaeePiODoZ4XOksvpK6aShDcB5snzE=; b=HgUMYmD0+hQidq
	Gna8mghu6HXiseCzEQkqYL9jGPBbkiCzzw6qs/w13tdGbcJ/fZ66F1N4SvDpPALio2+6erSbdfrql
	XWkJLHc0FbICL5yOrAcNOaIugE6djZTqvr1KDNqYYH3nOjw4wXsBC6cN6CgwM994FDXZtmBiTyAmu
	dmzvTGFSKyD7Q5q6J9dhPIJth+5JzjRcpE43EwWU9Rdjc8r+uFyk0u/ycj3H385JPQQB7Le2Bl/86
	QdzxKJPwJsGFid3l+tcjwJ3COEsO2cwjzIcHClO+xDKgy+ETpdrysFvp3k8v2fhiKJZJCCgMRukgT
	HjLKQlYFT2DiKHe1pAxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvxF-0004Eg-1L; Tue, 08 Jan 2019 18:18:21 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvxB-0004E7-8p
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 18:18:19 +0000
Received: by mail-ed1-x530.google.com with SMTP id b14so5151011edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 10:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=vemH3ZAGsDw4JcpIFc4ATVnJcIv0YXx3bdKcmjTp69E=;
 b=XSSKJYA6cBxXYwMUTuVfPuNIxLaU8vFfH+9LrNsTpfzHWoVVpWLAz4627sm3bykwQe
 KMDTBNvZKaXZ3oZa6m9iTTv4LHBKczKRWOBbkfpG5ZlHAsleWNpb3Jf+YRGz0rFzyBp5
 W3zSAq6QYeRLmklAW+6ByDsFyZ57z4pSclwM6IOeGklC6Bv4VIsY+FHAv1Dav2PxLFAm
 NOuIXjF1Ps+/TuNacPON1H24qQhENJoAbIjIkkQ4j8GZUCN7QNUXv/kcgeV4gY/5u+er
 MSfoEn3ALNhJidvzY0nBBknBA0+R7vR0Fx+cpOhXi0MDUhdnCqDYYfC18rZJTctyWoQj
 qbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vemH3ZAGsDw4JcpIFc4ATVnJcIv0YXx3bdKcmjTp69E=;
 b=l+x1H/T+blkAM6LYOoBanGZnnNTFSdt8uPPDKJpsfw1rXgjI0X+yX6vZcy0Y25ZsaY
 nPYP27wsLwA440kshtA7URlJ3IQY9U5r0hBdZIbjz+Cv1vVVhET8RZGdPLd/7j3V+nVH
 ilLhGZAb48J7yVWpbfjyAUTvUk+41UPrfjYod3Z31tzFjHtWj4B3da1GZS/bhu4OQvPD
 KVB6LoQ2oiIHY26S2nxDAlSJ5aTDWmjJ67KFylDJrYniVPjBoNSpeFCIO4AlOSLVqkZU
 NaHT1MaPEkTt59WT4gcvcBVUjEO7FbwCTzrogUH2oy5pS+BN/SeF0qWOC36Hsh+FttDU
 3r6w==
X-Gm-Message-State: AJcUukeQtVu/0DfZeUq7drKPAXQOiJSNsJcsPNNAMNkXreASDFcZdsOS
 8PSBU4yE3Jih00sCEx4vD3A=
X-Google-Smtp-Source: ALg8bN7ujd8pyUNTTYyt7ELx8SdU+mNzthvR8oHFkqNy3Y9/ZPG3jQS4shaa6hi00ddlioNBDNJIXA==
X-Received: by 2002:aa7:c703:: with SMTP id i3mr3164156edq.170.1546971493978; 
 Tue, 08 Jan 2019 10:18:13 -0800 (PST)
Received: from localhost (ip1f11350a.dynamic.kabel-deutschland.de.
 [31.17.53.10])
 by smtp.gmail.com with ESMTPSA id v43sm426821edc.18.2019.01.08.10.18.11
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Tue, 08 Jan 2019 10:18:12 -0800 (PST)
Date: Tue, 8 Jan 2019 19:18:10 +0100
From: Oliver Graute <oliver.graute@gmail.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: Re: [PATCHv2] ARM: dts: Add support for Variscite DART-6UL board
Message-ID: <20190108181810.GA24239@ripley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <413a63ce-618e-4edc-ab1a-cd3071543a84@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_101817_314004_DDD308A9 
X-CRM114-Status: UNSURE (   9.06  )
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
Cc: s.hauer@pengutronix.de, linux-imx@nxp.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

i've splitted the Board and the SoM part into two different dts/dtb files:

imx6ul-var-6ulcustomboard.dts 
imx6ul-var-dart-nand-wifi.dts

What is the right way to boot my Board and the SoM from u-boot?

currently my u-boot just load the SoM file and I see only:

Kernel image @ 0x82000000 [ 0x000000 - 0x839980 ]
## Flattened Device Tree blob at 83000000
   Booting using the fdt blob at 0x83000000
      Using Device Tree in place at 83000000, end 83009509

      Starting kernel ...

Best regards,

Oliver

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
