Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CF1C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:41:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7649520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZvnrAjr8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO3gTIgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7649520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zG+ND8YQFOjkH4Qeu6+kp6uHOYljIaVxXnEvx4u6DIA=; b=ZvnrAjr8ee0H4O
	brdoj4bitXBPZUSOImi323HIxMA3XzNYTp8CDBQ8KX7/opqb3KL+FBi9YUzS0LYUYUfBa2LesaSzH
	/JAHQYCySIZT6G3olUBfW0IrFJ9dQGPq4x0229D+ZCihHCQQLYxneUPdj9kztUknV9skUnG/HNCns
	Z10gG6gGSla6SrSarLO9R349a0l0mxy7fuVZk9XEnOLjUdtxnNUguit00SxLeUtjbdGuj33lwWN/U
	oDIS40HHAWdddinlAMCFM9SWsgpMIEDzkdY84U7KOsTGVaE5t70+DcQlqSrdJ599A6KpZnp3N7aTb
	cwyclrdyw53dqYnxinzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpY8Y-0004mF-BC; Fri, 01 Feb 2019 12:41:38 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpY8V-0004bf-OR
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:41:37 +0000
Received: by mail-lj1-x244.google.com with SMTP id v15-v6so5621476ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 04:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iODfpulofSvICmUrVD6LE9v57Ag6LMIWvsLhakZo+v4=;
 b=KO3gTIgy1VLS/nKUjaD6txQVMHuZjdAM92FM8tGlN4Og83T2J0f8vLaBpfI3uzM2KV
 iwKsxWBYz07V0PC+zODfTxA0pxxmrOLk30w6DkvSkmD1f2IKzZuk/SbG+N5QMsg41EaN
 2uejdYzKPA6gn9pSBGdCMKg4CSsN+qVcV6SoPWsjOPlLnMYEoEA4hhkX/V/sPIkaa346
 SQ2F2dPIaNhIKPt5l1oMyc/g8h+JqVW0KbpRAF6/ooM922qYrIKL2TQOIDJCy9gduytN
 9gKXq10HW8jpWJcy3Yg1vwn1kKF/aTrRj7DiYnjbzNs2qcfumrT2H0wsm7PNuoYFkVJt
 hLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iODfpulofSvICmUrVD6LE9v57Ag6LMIWvsLhakZo+v4=;
 b=Hh/7a/mzWuUsnYgBip9Z0du/BVmDedo0xNpZKxlUYKGfZMhmzWU72FZ8TUPRFBGRne
 dFMLcAKaTUYO4HOgcIorAUdw8pShWzLaIeIiMHg40ohH1xtSbkVv4id8zM2P3Zojpw3m
 PzHvIxK5LpSulZCjgTlbEmPNmLtiOM1rqrtIh2zui38yUN8OvDu8U8h26cOIhaBCiDvw
 AhyhBOl4gaaPJbjRTSxnqyaXedI1mGYVJJnS76HrHjKSDHdpAh7cJtltKEl0XOoUBD+M
 szsAoFeI87hU4cXUlWGFocfg0Fu6cMVVNZDBjNnXPrqdzku4Py6Vzy64viZ/20Q+cjhG
 LKtg==
X-Gm-Message-State: AJcUukfkRdlYB2qLAo87S/mCunvSV8hrlTyC8miFBcLHDUnTami1N2XP
 5rIo3DNOCgLCl8L1RO2COa37ENIhAEEWFmMkdxw=
X-Google-Smtp-Source: ALg8bN5knmz7SeCBsrXwu1a1gQWzHOdKxmYWL/9m3A67SexQtbd9pPoSNgF8BKtCyS1xodcsPSYJhCngOahTYTQEyDc=
X-Received: by 2002:a2e:9059:: with SMTP id
 n25-v6mr30283823ljg.155.1549024894063; 
 Fri, 01 Feb 2019 04:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
 <20190117112803.GC3710@rapoport-lnx>
 <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
 <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
 <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
 <001c1195-fe06-fc78-b8a9-ec96f44aef32@arm.com>
In-Reply-To: <001c1195-fe06-fc78-b8a9-ec96f44aef32@arm.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 1 Feb 2019 18:11:21 +0530
Message-ID: <CAFqt6zae+8-TLaWEmgyLEVCbsy2cbeFg35SxH5r1kHYu6rrybw@mail.gmail.com>
Subject: Re:
To: Vladimir Murzin <vladimir.murzin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_044135_796138_7EBD1B28 
X-CRM114-Status: GOOD (  15.49  )
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

On Fri, Feb 1, 2019 at 6:06 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> On 2/1/19 12:32 PM, Souptick Joarder wrote:
> > On Thu, Jan 31, 2019 at 6:28 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> >>
> >> Hi Souptick,
> >>
> >> On 1/31/19 5:54 AM, Souptick Joarder wrote:
> >>> On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>>>
> >>>> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
> >>>>> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>>>>>
> >>>>>> Remove duplicate headers which are included twice.
> >>>>>>
> >>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>>>
> >>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> >>>>
> >>>>> Any comment on this patch ?
> >>>
> >>> If no further comment, can we get this patch in queue for 5.1 ?
> >>
> >> I'd be nice to use proper tags in subject
> >> line. I'd suggest
> >>
> >> [PATCH] ARM: mm: Remove duplicate header
> >>
> >> but you can get some inspiration form
> >>
> >> git log --oneline --no-merges arch/arm/mm/
> >>
> >> In case you want to route it via ARM tree you need to drop it into
> >> Russell's patch system [1].
> >
> > How to drop it to Russell's patch system other than posting it to
> > mailing list ? I don't know.
>
> https://www.armlinux.org.uk/developer/patches/info.php

This link is not reachable.

>
> Vladimir
>
> >>
> >> [1] https://www.armlinux.org.uk/developer/patches/
> >>
> >> Cheers
> >> Vladimir
> >
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
