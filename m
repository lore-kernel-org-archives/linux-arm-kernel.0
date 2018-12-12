Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720E1C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:25:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FE020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MznAWeMM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHV0kssu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FE020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bQgmtaj6cbQ5q2GPbhExTDbddhPQ9mVpzHqvN2MwD4c=; b=MznAWeMMFqMiuh
	7uSaHQUMQDd7RQ2r5JqRCXrT3RNNxAey4cQYtzTC9Ke+qjtYgBnYo2UOjzWYOZAMS2Ribz7kATuZc
	Vj2QX0lM5GekKFmcpAis8vO6mylqa5UMkFO0Jvt/76VGBsoKDpKNWWwnq4cTmil0QDYy499zpnJx6
	gpajp7bq7oPKKprHT0jgwN3LEmvnQGDYpTb15/V5upfMbEp8l9PpLedmpS66KcRfjbLJzJVstxo5U
	abTjjy2KCwFXu4NelvfNI6vF4aBbxsXn+gWJ75ESx+zD+XFh3LQD9pIFlgXkUVs3qGoZii/1XeuND
	tuOadob+Kw7TkIx0rv2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWtHK-0007iK-4q; Wed, 12 Dec 2018 01:25:34 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWtHF-0007h4-EY
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 01:25:31 +0000
Received: by mail-pf1-x443.google.com with SMTP id u6so8001798pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 17:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=L39WCp8AxvhR/l4yS6pELUyTr3cXP/cgOqOF4fuUhUk=;
 b=ZHV0kssuZYF1MTJVNYU97cHo10V1xY1m6lumN05r/KEJbxczO4otmex59kO7yTCYSE
 XiI0HLp7dn2t1ikJgwdnsckkT7K1J8tkqpD4XP7ujPhIKVy75NMSNIASynhSTm9hZajI
 MWPv3HjdGYflHA8IyaUzquXCefo9W3SoOoPw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=L39WCp8AxvhR/l4yS6pELUyTr3cXP/cgOqOF4fuUhUk=;
 b=pI0w1pUjhtCdrr8Clkju4UFbFChD5xVlgxZbUKz+aIuD9PywZ/uZLdxCUhRkmf062z
 UiaXp5YhYzNFw+w4ewG2n36IVI3rsRHbBlsyT6pQo4Xp4GrKf8g7c+1b3ing/yEA+TrV
 RWEYbzM3HmuIX/AZ8QGFX1Z5073Kx5mlDBbCFlqkBeapgMlrpKOTxirunA4NaRIcilwS
 2oS08ZRC9cs43/AU6HSn5KT6gPBMw4tVktK75dO5FdltARkb1TkSf6UbiGxwvdje7Gzx
 Hj+na3VXtJnVsxT7CZnHEn4Q3B1mB5YvTc3tDxKvMzEB8ZpPxyxcOyndsI1TlQd1FzRT
 6w4g==
X-Gm-Message-State: AA+aEWbBL+Z0l5FiiTYCzlqva0ggiT0Fs7L0pF4bybmzaBxKSa999/m2
 wdDWKysxYlpgYbUXKmDiF5KdvA==
X-Google-Smtp-Source: AFSGD/Xr5aT6Ks/5LCdeflLsdpc3K1lWxxLJxyvX8a819NiOz1jxnv4d557+SO2Z5AvhJ6ax28meUA==
X-Received: by 2002:a65:560e:: with SMTP id l14mr16670645pgs.168.1544577918462; 
 Tue, 11 Dec 2018 17:25:18 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
 by smtp.googlemail.com with ESMTPSA id
 r130sm30409734pfr.48.2018.12.11.17.25.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 17:25:17 -0800 (PST)
Date: Wed, 12 Dec 2018 10:28:31 +0900
From: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v16 06/16] lib: fdt: add a helper function for handling
 memory range property
Message-ID: <20181212012830.GJ21466@linaro.org>
Mail-Followup-To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 David Howells <dhowells@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, dyoung@redhat.com,
 Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, prudo@linux.ibm.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, bhsharma@redhat.com,
 kexec@lists.infradead.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-7-takahiro.akashi@linaro.org>
 <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
 <20181206155424.GA4422@arm.com>
 <681e1265-2f0c-2a62-3778-09911b2be7fc@arm.com>
 <20181211061715.GF21466@linaro.org>
 <654bffae-7edb-bda4-d01d-99a8b455b186@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <654bffae-7edb-bda4-d01d-99a8b455b186@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_172529_494042_FF4D57BE 
X-CRM114-Status: GOOD (  24.59  )
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
Cc: prudo@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
 Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com,
 Frank Rowand <frowand.list@gmail.com>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 David Howells <dhowells@redhat.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, dyoung@redhat.com,
 David Miller <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:09:07AM +0000, James Morse wrote:
> Hi Akashi,
> 
> On 11/12/2018 06:17, AKASHI, Takahiro wrote:
> > On Fri, Dec 07, 2018 at 10:12:47AM +0000, James Morse wrote:
> >> On 06/12/2018 15:54, Will Deacon wrote:
> >>> On Thu, Dec 06, 2018 at 08:47:04AM -0600, Rob Herring wrote:
> >>>> On Wed, Nov 14, 2018 at 11:52 PM AKASHI Takahiro
> >>>> <takahiro.akashi@linaro.org> wrote:
> >>>>>
> >>>>> Added function, fdt_setprop_reg(), will be used later to handle
> >>>>> kexec-specific property in arm64's kexec_file implementation.
> >>>>> It will possibly be merged into libfdt in the future.
> >>>>
> >>>> You generally can't modify libfdt files. Any changes will be blown
> >>>> away with the next dtc sync (there's one in -next now). Though here
> >>>> you are creating a new location with fdt code. lib/ is just a shim to
> >>>> the actual libfdt code. Don't put any implementation there. You can
> >>>> add this to drivers/of/fdt_address.c for the short term, but it still
> >>>> needs to go upstream.
> >>>>
> >>>> Otherwise, the implementation looks fine to me.
> >>>
> >>> I agree, but I don't think there's a real need for us to hack
> >>> drivers/of/fdt_address.c in the meantime -- let's just target upstream
> >>> and not carry this in the kernel.
> >>>
> >>> Akashi -- for now, I'll drop the kdump parts of this series which rely
> >>> on this helper. The majority of the series is actually independent and
> >>> can go in as-is.
> >>>
> >>> I've pushed out a kexec branch to the arm64 tree for you to take a look
> >>> at:
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kexec
> >>
> >> I gave this a quick spin. Without the elfcorehdr/usable-memory-range arm64 needs
> >> to explicitly forbid kdump via kexec_file_load. (like powerpc does already).
> > 
> > Thank you for pointing this out.
> > 
> >> Without this kdump works, but the second kernel overwrites the first as those DT
> >> properties are missing.
> >>
> >> I'll post a patch momentarily,
> > 
> > Fine, but anyhow I'm going to submit a new version (*without* kdump),
> > I will fix the issue along with others.
> 
> I had a quick look at the arm64 for-next/core branch. Will has queued the
> non-kdump parts of this series.
> 
> If you have changes, they need to be against the arm64 tree.

Okay!

-Takahiro Akashi

> 
> Thanks,
> 
> James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
