Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296B4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:07:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE2E2195D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ws61GQ0u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZc+YWiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE2E2195D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xrTZBlhBBtUWKVOYT29fZOJ+6mDfeW8/W0DQ+GNTV08=; b=Ws61GQ0u4dRvpA
	9cbMJALdDszjP2bUWW2Fl3clJ/oB643qO7/Xif2aHe/7Zt62+6AyoAAwBfyZP35tgTEAT4OY9dzva
	VGkVdtYIG2Lt6Wy4X/Ysx8YYFknqaZcjVe4Uqe3rzSDuxp6sxV1cD9AcRWaJiLUgyq7sSgHApygFK
	NTLL+Es5Cb7ZTH14Eefl9n+v5X2ekSPUl27J94+P1DlooykInTMBTk1LZc9ZikURz95/02hc9+XxR
	l81wftcfp00BkoVzTFYX7jbzFuKr6OPvqt6xMrD74+uI9SVyxLRiI1CN49aFI8iN3x2Aeuols7cKD
	L2QMLiryzQlr4KTodWTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvGXh-0007c7-WD; Sun, 17 Feb 2019 07:07:14 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvGXe-0007aq-QF; Sun, 17 Feb 2019 07:07:12 +0000
Received: by mail-pl1-x641.google.com with SMTP id bj4so7147364plb.7;
 Sat, 16 Feb 2019 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=It5OEgJ4iYIMPI81go7NiHuDVjtSj5HVzsbxnYSlOe0=;
 b=aZc+YWiZzUUe0tTPkDcAUfqJ63RPBIhmPpH78AnM7ubdbgLf4TxT0FIapEealbMdIA
 8/F0Teqbas+ATEy3A1lS8KE8ui3UMKo3bnLgUPMAwNXJ9jEPn+OBZBOmFFfyrqW3pDTa
 p54YaZ6rAT/yLr7q/CX5lPmnxLTozqOK1vYJNSaCLB5AdFE3nqFOfw59/35KwGvvciAj
 1fWcR/XEUm6kz9ZGKqaIRprkM4vuDdZvVG9w7qxz5qkpa89e9uaYqGF9j8k666/uNg35
 SRzqoP7xQJcfSjC08epHN88GnNiCjGO0RE+0PGSfBSIUpUgJH3O2v2TZQnEH6epXSbnz
 76PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=It5OEgJ4iYIMPI81go7NiHuDVjtSj5HVzsbxnYSlOe0=;
 b=C7PAnIHAxEXv3a4MO6Vp2/14H7jYOIW77PsF8DzO/8HZ2jyR2sVKXWSuvINm2Mb7ht
 h6Go5ItMVus1KoPQiyaOFQ9UX9ldKDbaRyQypXc5Rozzy6Abh3dj5gb/CQJ179MsF21N
 WgPnfpIrBznR3TLUhOH9DiqZXQ2fButXHiMfF/jaqffDJypEmSxaLK9ienAUY5E1BlPQ
 +Gecb/TomfiOrOTvHy9Uk5Iv/3Ni35Xa4SCpTCFLoMMEqrkkxkE3MPOVGy8+6LdzwIdR
 iNXyutvinPHsrbbGxUAP5xsXdfAWyB711qK5h42by0aVoz5gq7jW7mq3JzXDnAkTSdf6
 oe0A==
X-Gm-Message-State: AHQUAuaio7IYKNL7sBDKZfmIBS9jN+C4Olpb0cWsvNEdN5r+nOGFZmfb
 jKz4YL4ba4RV1RThLJomnWU=
X-Google-Smtp-Source: AHgI3IYr6DW5xEyBkZoA2bWxKRmAM6CS+vmr/dyrrPkIUVkEW2uJNmmrx58yLGTrEraZZTLgdLxJTw==
X-Received: by 2002:a17:902:8e8a:: with SMTP id
 bg10mr18866625plb.192.1550387228616; 
 Sat, 16 Feb 2019 23:07:08 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id u13sm2947298pfa.169.2019.02.16.23.07.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 23:07:07 -0800 (PST)
Date: Sat, 16 Feb 2019 23:07:06 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH v3 0/3] input: goodix - support Goodix gt5688
Message-ID: <20190217070527.GC148958@dtor-ws>
References: <cover.1550239328.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_230710_875310_1187BD26 
X-CRM114-Status: GOOD (  12.96  )
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
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Bastien Nocera <hadess@hadess.net>,
 linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 03:11:50PM +0100, Guido G=FCnther wrote:
> Besides the support for gt5688 two more minimal changes piled up so I'm
> folding these in here. One is a doc update for the goodix bindings, the
> other one makes it a bit simpler to figure out configuration problems
> (like lack of touchscreen-size-{x,y} in the device tree.
> =

> I've kept the original subject to (hopefully) not break the series for
> patchwork. All patches can be applied independently. Series is based on
> next-20190208.
> =

> Changes from v2
> * Add 'dt-bindings: input: Refer to touchscreen.txt for goodix ts'
> * Add 'input: goodix: Print values in case of inconsistencies'
>   (sent out separtely before, no comments so far)
> * Collect 'Reviewed-By' on 'input: goodix - support Goodix gt5688'

Applied the lot, thank you.

-- =

Dmitry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
