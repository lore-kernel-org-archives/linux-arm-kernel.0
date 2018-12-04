Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092FCC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:45:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5FA20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G6bUlU35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5FA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=luSA72CLunPVRlo8GZ+bSrsHaNXG1Oi4lx9zlHIPfLQ=; b=G6bUlU358zE6Jp
	dLN50rAlK9U8mT9WgAsR2SIysXDT9eN4B2YTFuYvBBPCJRdj1WEgAaWsBFwBnM7GiO5+S4f/ivw75
	+vB/qwz0CNzxSheMx60nYQDE4rdJqks4asTR9O/xR61s/3yL0B4DGRm5uLd9MtXjcvOG1vtQyBvu1
	rrZDUcbZt+K0w9DowBD7trWaKlKg1UcCiCA2VGkTEl5A5WnVifgr6DNXt6y7CdWLraXC4n9HW0CRs
	eOBolvooP5v8hvx/s0Ngb2nrG1Ckk219Nrwf7c21Q4R52VzqoO7elGzlGrpAEZZI/LvLdU0KKPdE6
	BwUicNXogW/6tMVR0NEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHZa-0002MW-Jj; Tue, 04 Dec 2018 20:45:38 +0000
Received: from www.llwyncelyn.cymru ([82.70.14.225] helo=fuzix.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHZW-0002M4-6P
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:45:36 +0000
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk
 [82.70.14.226])
 by fuzix.org (8.15.2/8.15.2) with ESMTP id wB4Kj9MP024700;
 Tue, 4 Dec 2018 20:45:10 GMT
Date: Tue, 4 Dec 2018 20:45:08 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: Re: [PATCH V4 5/6] net: maclorawan: Implement maclorawan class module
Message-ID: <20181204204508.3ebead06@alans-desktop>
In-Reply-To: <20181204141341.4353-6-starnight@g.ncu.edu.tw>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
 <20181204141341.4353-6-starnight@g.ncu.edu.tw>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_124534_523622_19BCDC15 
X-CRM114-Status: UNSURE (   9.79  )
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
Cc: netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan@vger.kernel.org,
 Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> +void
> +lrw_parse_frame(struct lrw_session *ss, struct sk_buff *skb)
> +{
> +	struct lrw_fhdr *fhdr = &ss->rx_fhdr;
> +	__le16 *p_fcnt;
> +
> +	pr_debug("%s: %s\n", LORAWAN_MODULE_NAME, __func__);
> +
> +	/* Get message type */
> +	fhdr->mtype = skb->data[0];
> +	skb_pull(skb, LRW_MHDR_LEN);

This does not seem robust. There is no point at which you actually check
the message size is valid etc

> +	fhdr->fopts_len = fhdr->fctrl & 0xF;
> +	if (fhdr->fopts_len > 0) {
> +		memcpy(fhdr->fopts, skb->data, fhdr->fopts_len);
> +		skb_pull(skb, fhdr->fopts_len);
> +	}

In fact you appear to copy random kernel memory into a buffer
> +
> +	/* TODO: Parse frame options */
> +
> +	/* Remove message integrity code */
> +	skb_trim(skb, skb->len - LRW_MIC_LEN);

and then try and trim the buffer to a negative size ?

Alan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
