Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AED9C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:32:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE939218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="usCZ09Bq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og7ObeOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE939218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lVJu47pCidY4havXWtyoRxNLhHYfbhkiLtEijdYDvsE=; b=usCZ09Bq7mnR4a
	Ger21i8798GQR0cHZU/FIcZKz+dL1ASI1uzl1XCM+yl8YG2SxJ8fafzVe/z0gxU292PCBRbHrePct
	sP77AuhqAQ5ezyQJcNUbbf4yHdM29MPrUNVWc0LNvepGifbdYInUJGepCsxsMYtDzqBXVIUBkMf3G
	/vqLMDI+cVSPI+lH1UD5Mu57wVnvMzUSo3dhe68mJ1ihxi43xmlDz9+VN6YYC3fM1KdVqHYMNMsR7
	2tE5kFp3w7L0B2GMT3xVjghlHWkrM23ESzw5N0JrztKt9rjABop70VHADqiOBJAZHDegpHjoPSNvU
	Sm7w55/83eWfyiBFVcfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpXzi-0000cD-M1; Fri, 01 Feb 2019 12:32:30 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpXzf-0000ba-0M
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:32:28 +0000
Received: by mail-lj1-x244.google.com with SMTP id s5-v6so5599270ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 04:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8rNxm2fv00ManwVnsYnyLFJNBjAatMdZ/RRWb7HrcS0=;
 b=og7ObeOmE/rEjMmdDhJyK7r2CVRFrtebvUKXSvR9be/BPVzwmaWFqEcBrUZlH9tWb3
 tfzBNYLwgKuPHKRhHLBMb6Fs9YFY//W+56B4V5KMxkLxNiK9rFR0C4Waw8DlwcL9HubT
 ZO/fwRiSCr4Mlfz9FNrgnP3kxe3F68tiG1VO4XzvefWNU8IlLzIbV6g7rGenAciEL9U+
 Tf+FN1edZ+Hehg5jrmtgBswKC9QVbmMvVM+U6lV7nDDtAV+SLaCflUQg/IchoywCNfMj
 UaOBw02VyV3JobLYV5hnD3AiZWoVNRcOUJ1wNR+Uje609GWu2fKbQaow/nGicEZDqrD6
 +fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8rNxm2fv00ManwVnsYnyLFJNBjAatMdZ/RRWb7HrcS0=;
 b=GuAQsjI2seSMFqDefNzKbtauJgg/rVwCSG8iPbj16RomhsSrbU9DOeAXJOHPOBYYIJ
 fBxTTvoCQ93cchJe2rzyRibgP2MObpCL6U35L6NIi5RHcgwxKh1oHt/y3tpLa/05BIYK
 5SxJlbVbTtIhZdGEEhuEpg0SrhUPNmTIdQBpXLNPLPx7teDwFldm7rr29S6jyiqy/g09
 7c1+1RGXiaWsUaROwyt5+YRy2xqiFg9BVlehj/VcDkJGTiaQUz0qLFL1vl9yqCZFS9PP
 9zrHLosO3msY+OhS3nftV1t3gU1TzjlyKT6su1C/PT7GX9z+/KIJ1dyaR3WR7VT6HP+l
 Ygvg==
X-Gm-Message-State: AJcUukd/GhBre/zF0/CbZNYBBgxsVdeAbCxu3Q1ocEr1Xzxn7c3bo7ET
 N6LIfPAQ5P7PIeq07z5najuQ1ZUiJs6xeXz/ed5AYw==
X-Google-Smtp-Source: ALg8bN7uCET9Pxh7PdClRvWI1wL7udB1yOPIgy9+apCkHsgcW+pd7YxPrG5MgM7cuIz7h9xLe6unO8yJDmuH8LUL5Zg=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr31169671ljj.9.1549024344032; 
 Fri, 01 Feb 2019 04:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
 <20190117112803.GC3710@rapoport-lnx>
 <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
 <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
In-Reply-To: <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 1 Feb 2019 18:02:12 +0530
Message-ID: <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
Subject: Re:
To: Vladimir Murzin <vladimir.murzin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_043227_069720_FBA99531 
X-CRM114-Status: GOOD (  14.30  )
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
Cc: Michal Hocko <mhocko@suse.com>,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 rppt@linux.vnet.ibm.com, Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 6:28 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> Hi Souptick,
>
> On 1/31/19 5:54 AM, Souptick Joarder wrote:
> > On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>
> >> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
> >>> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>>>
> >>>> Remove duplicate headers which are included twice.
> >>>>
> >>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>
> >> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> >>
> >>> Any comment on this patch ?
> >
> > If no further comment, can we get this patch in queue for 5.1 ?
>
> I'd be nice to use proper tags in subject
> line. I'd suggest
>
> [PATCH] ARM: mm: Remove duplicate header
>
> but you can get some inspiration form
>
> git log --oneline --no-merges arch/arm/mm/
>
> In case you want to route it via ARM tree you need to drop it into
> Russell's patch system [1].

How to drop it to Russell's patch system other than posting it to
mailing list ? I don't know.
>
> [1] https://www.armlinux.org.uk/developer/patches/
>
> Cheers
> Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
