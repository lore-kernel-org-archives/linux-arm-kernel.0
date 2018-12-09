Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7B9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:27:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788EF20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HAnFgEKx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="Zn7Ms/Ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788EF20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZoZjuZ2VHushc0wbaIzPkoGnxHf1ZTRuDgILkytbGj4=; b=HAnFgEKxNs9jJJ
	u1B6eiZx4l2yrJBN1/QaQNsXv347J0cTmEWvNE23atlXWKtUWuk9w75yUVGEm3JzH1Vg1m3I1q01L
	o3JvX2tRIRHV8MgsAc7pWqOgcpwN8FRZ67cYBHOA0SVbgX+HvcVOLynhnxQqGnmfjlfyTiHz+GA0N
	JFFCyjnPISRA+Lp9NGe9S3EwGlPzR6T0NwhJ5M5Qz4CMSFIgbV/X/Q/OiBP7Mh5S27qY9YOUVzrAH
	QIusChL7YHZgKCIHwjRT1MiGooGRB4DStVGi4ZHFToMRWfyHVMUVHsNlMcGOV5X2aEzMsEd8SD14G
	pGAck300g8qjLwKiDj7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVuQy-00089D-47; Sun, 09 Dec 2018 08:27:28 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVuQu-00088L-TR
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 08:27:26 +0000
Received: by mail-ot1-x342.google.com with SMTP id 81so7702321otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 00:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4LKuPhYhw/uNr9uh6WrEzHch/ERmy/ZnGKpU1w1jWcw=;
 b=Zn7Ms/IgR4A7LmCpIUzt085XB9OcD7tF4E+Xwv2QbN9GRrKUDfTaAwclulKdw+8G/1
 vtCTb/rRR1PuA+OqkbfJjOBXcmZnuqoTSxjvGNRDyZGX+L5cah1qwtX830h1Zl879b7+
 bn5oOvdLppQ8K4hp3xOutPpJc1vh5W6TMWtTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4LKuPhYhw/uNr9uh6WrEzHch/ERmy/ZnGKpU1w1jWcw=;
 b=rnukCpctpdk+wCUg8BgpDS3jX0xm7vtcVvDPEQWIuCsNxGu+25rWngiOvMnYuh/2MK
 U207T5dbXD1IMbU/nw2qXlPOh32094AcJmWghN/K3PnoOHVrK5Lr+Qq8nB4PPLpaXFIQ
 pDzIQg41K6YEw9AnEqH0h4k5e2gBTmYgFvwEPcUTNwPTaqpK6U/J67NFAVJqXSB76duI
 tRFCoEormX3Z90lQP4zd2kBsFx+csGCBfylSHKWk+bz8RXA5W1b94hjCRq/+vRDGvVub
 XSa2scQx9raap/Vbss/Ls27CIs9+oVRwyY/y39fRzKGsM5lqegcPxbZVa83xFydAhiVR
 9vEg==
X-Gm-Message-State: AA+aEWZ4Af4tqvOAsiLNaepzxpenDZuxLekntF9U/RKi8kq6XzDpwY8g
 17WM7cmoDeF75M1fzlq5jJLtuLovA4Em9Q==
X-Google-Smtp-Source: AFSGD/VC0flC/B9kBMLUXIRMvbEGwgKub3xOiVvPFGUtklRiJLkk/JH+mQetmFn9NrhADy2Ny11TGQ==
X-Received: by 2002:a05:6830:cd:: with SMTP id
 x13mr5432702oto.13.1544344032583; 
 Sun, 09 Dec 2018 00:27:12 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com.
 [209.85.210.43])
 by smtp.gmail.com with ESMTPSA id c23sm3627846otn.21.2018.12.09.00.27.11
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 00:27:11 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id v23so7665903otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 00:27:11 -0800 (PST)
X-Received: by 2002:a9d:e8c:: with SMTP id 12mr5903831otj.297.1544344030991;
 Sun, 09 Dec 2018 00:27:10 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
 <20181204141341.4353-6-starnight@g.ncu.edu.tw>
 <20181204204508.3ebead06@alans-desktop>
In-Reply-To: <20181204204508.3ebead06@alans-desktop>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Sun, 9 Dec 2018 16:27:15 +0800
X-Gmail-Original-Message-ID: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
Message-ID: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
Subject: Re: [PATCH V4 5/6] net: maclorawan: Implement maclorawan class module
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_002724_969247_735BB5E0 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 "linux-kernel@vger.kernel.org>, " <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan - ML <linux-wpan@vger.kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 "<linux-arm-kernel@lists.infradead.org\\"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I made a fake skb and passed it to lrw_parse_frame() function for
testing.  I use print_hex_dump() function to show the skb's content.
Here is the original content in the skb->data and the length is 20 bytes.

[   33.732033] 00000000: 40 04 03 02 01 00 00 00 00 27 76 d3 2d 1b 79
a0  @........'v.-.y.
[   33.732065] 00000010: 18 38 fb a6                                      .8..

Byte 0: MHDR field, value is 0x40.
Byte 1 ~ 4: DevAddr field, value is 0x04 0x03 0x02 0x01.
Byte 5: FCtrl field, value is 0x00.
Byte 6 ~ 7: FCnt field, value is 0x00 0x00.
Byte 8: FPort field, value is 0x00.
Byte 9 ~ 15: Encrypted payload
Byte 16 ~ 19: MIC field value is 0x18 0x38 0xfb 0xa6.

> > +void
> > +lrw_parse_frame(struct lrw_session *ss, struct sk_buff *skb)
> > +{
> > +     struct lrw_fhdr *fhdr = &ss->rx_fhdr;
> > +     __le16 *p_fcnt;
> > +
> > +     pr_debug("%s: %s\n", LORAWAN_MODULE_NAME, __func__);
> > +
> > +     /* Get message type */
> > +     fhdr->mtype = skb->data[0];
> > +     skb_pull(skb, LRW_MHDR_LEN);

print_hex_dump skb here:
[   33.732202] 00000000: 04 03 02 01 00 00 00 00 27 76 d3 2d 1b 79 a0
18  ........'v.-.y..
[   33.732204] 00000010: 38 fb a6

> This does not seem robust. There is no point at which you actually check
> the message size is valid etc

Thanks!  It is a potential bug.
It should check skb->len >= length of MHDR + DevAddr + FCtrl + FCnt + MIC.
These are required fields for (Un)confirmed Data Up/Down messages.


print_hex_dump skb here:
[   33.732211] 00000000: 00 27 76 d3 2d 1b 79 a0 18 38 fb a6
   .'v.-.y..8..

> > +     fhdr->fopts_len = fhdr->fctrl & 0xF;
> > +     if (fhdr->fopts_len > 0) {
> > +             memcpy(fhdr->fopts, skb->data, fhdr->fopts_len);
> > +             skb_pull(skb, fhdr->fopts_len);
> > +     }

print_hex_dump skb here:
[   33.732213] 00000000: 00 27 76 d3 2d 1b 79 a0 18 38 fb a6
   .'v.-.y..8..

> In fact you appear to copy random kernel memory into a buffer

It copied fhdr->fopts_len bytes from skb->data to fhdr->fopts if
fhdr->fopts_len > 0.
https://www.kernel.org/doc/html/latest/core-api/kernel-api.html?highlight=memcpy#c.memcpy

> > +
> > +     /* TODO: Parse frame options */
> > +
> > +     /* Remove message integrity code */
> > +     skb_trim(skb, skb->len - LRW_MIC_LEN);

print_hex_dump skb here:
[   33.732216] 00000000: 00 27 76 d3 2d 1b 79 a0
   .'v.-.y.

> and then try and trim the buffer to a negative size ?

It removed 4 tail bytes (MIC).  (skb->len - LRW_MIC_LEN) is the final
new length as skb_trim()'s 2nd argument len.
https://www.kernel.org/doc/html/latest/networking/kapi.html?highlight=skb_trim#c.skb_trim

I found another bug which did not initialize rx_skb_list.  So,
lrw_parse_frame() may be passed a mystery skb.

Please keep reviewing.  That is appreciated.

Thank you,
Jian-Hong Pan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
