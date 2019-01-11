Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69291C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:39:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7C32146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kGX5s651";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc8kxKjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7C32146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hIDWoyKxZ7KG5UebN6o7OeOQVnslvuouHrDQGAGM2/A=; b=kGX5s651Vzpp1J
	gk6lEJ1DXWYezRTd1WK9RqkTNzeHuu/bNKv3DLP9F3WXY9aadg6hPtphZS4boISiVP7rCUyFCCeSH
	iflDYOk5Rr24LfFbt0buWtpdVI19eOgU+jYDmruD+UbDKiq6+ai2ZSomIPHm/NuAzkCNl0waQ7/qb
	nrvxlJBSKAIyLBZxW3VjFGBcbCHFw2ZKYXwLyFpGpbl62IlQYsss79KQVJ2IOfNai8hLFL5eiiqdY
	i7ry4oru/wpsHaNK6tJcWpJ5Y0XOCKeNRqOgRQJorwV+AED3Ywc7FtskoUtrVUcsGxRQ+9i2Hsmeo
	I6zP8+4FDhDcqarTDiNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtHi-0001pr-BK; Fri, 11 Jan 2019 09:39:26 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtHP-0001Y1-MR
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:39:11 +0000
Received: by mail-wm1-x341.google.com with SMTP id b11so1704563wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0zsaqiFcpYXcCFsq+FAdMLlkTpsvPBWVOZxTGMUhgoM=;
 b=Pc8kxKjrXqxpNBROsHpISPINeN6qheusQQhAIklADat1GC2LXVcdnRTq5t9obDZ00V
 y/UZEhWPDF0j1+8vRi54ONhwN6AyabgK8iifakz/qrL7lFaxJwx6f3H5Ja9fVshsvxCh
 nwMlUnzI2NT3R0IR/0aGFnhDr3Hg+kvnVfCTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0zsaqiFcpYXcCFsq+FAdMLlkTpsvPBWVOZxTGMUhgoM=;
 b=Ibum5FzfrP2RqL3x9SezWs09NRe9H7sUhPjAi0kRnFrHGj3To60A9G7X+a8if1zwxt
 dYCqpSE7n8jw3w+mAM6GJjAlo0DcqDhLDy8io7sDTIo3KUTHy09PZx06v46Q28N617KE
 V7mBEejtyXyl5UccuiAQy+ILiPNTF/av6NRXs6njmRa5bqfGTCy4mJLOLBfkzD42ehCH
 tZMCtvh4Od7aDxuMKl+/aUYRgmspkhnfCMSKck6kB+WkE8Wy3yoWAeBmKd5ikldRi36i
 AcPyXStlZXkHJyPgXFHf+v97Cst6HL7HlKbyueGg2Rf3iBSm2UCr52b8qTWbpDJIfyUE
 l3Hw==
X-Gm-Message-State: AJcUukf6fBFjWub8KZfYj+4RW2JQkEXXxKEWMS5fiw2gwDflp8kviWNg
 mzQ2+v5LURU8aDDv+lc7d2EmwIC+n6F5wg==
X-Google-Smtp-Source: ALg8bN67P7vgoMl0PMJxpWcYivyBDHXNTowY5OD5ejJ409LH5XkyZ5FjRtxfFYUblCZ64cvSnHMsgw==
X-Received: by 2002:a1c:1a8a:: with SMTP id a132mr1595849wma.109.1547199545827; 
 Fri, 11 Jan 2019 01:39:05 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id t5sm12963321wmg.43.2019.01.11.01.39.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 01:39:04 -0800 (PST)
Date: Fri, 11 Jan 2019 09:39:02 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 2/4] tee: optee: add TEE bus device enumeration support
Message-ID: <20190111093902.hfxb67txjhhlegzu@holly.lan>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-3-git-send-email-sumit.garg@linaro.org>
 <20190110141856.p3evqyf34py74gkg@holly.lan>
 <CAFA6WYPHmtY4N9ruGLZ70FNeiDCbQE-fs+EP2px-S+GEj2nPTw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFA6WYPHmtY4N9ruGLZ70FNeiDCbQE-fs+EP2px-S+GEj2nPTw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_013908_043669_7D7AE5BD 
X-CRM114-Status: GOOD (  15.87  )
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
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 12:52:19PM +0530, Sumit Garg wrote:
> On Thu, 10 Jan 2019 at 19:49, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > > +static int get_devices(struct tee_context *ctx, u32 session,
> > > +                    struct tee_shm *device_uuid, u32 *shm_size)
> >
> > Missing const on device_uuid?
> >
> 
> I don't think we should have a const for device_uuid here as this is
> shared memory struct pointer which is dynamically allocated and used
> to fetch device UUIDs.

Agree. Perhaps device_uuid is misnamed though (part of the reason I
misread this is that it is singular so I though it was a single UUID
travelling into the TZ).

> > > +     rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
> > > +     if (rc < 0)
> > > +             goto out_shm;
> > > +
> > > +     device_uuid = tee_shm_get_va(device_shm, 0);
> > > +     if (IS_ERR(device_uuid)) {
> > > +             pr_err("tee_shm_get_va failed\n");
> > > +             rc = PTR_ERR(device_uuid);
> > > +             goto out_shm;
> > > +     }
> > > +
> > > +     while (idx < shm_size / sizeof(uuid_t)) {
> >
> > This is a very uncommon way to write a for loop ;-).
> >
> 
> Ok, will add "num_devices" variable.

num_devices might add readability but that is not what I meant.

The most idiomatic way to write somthing that loops for every valid index
value is:

	for (i=0; i < limit; i++)

You wrote it like this:

	int idx=0;

	/* lots of code between initializer and first use */

	while (idx < limit) {
		/* more code */
		idx++;
	}

Sure, they are equivalent but the idiomatic form is easier to read.


Daniel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
