Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F34C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:24:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3AF2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SqbWLhnQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V7pozMlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3AF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G0CPPS/SiqFavg4J4qmXGrjYUySWjBatB+laNJeZMds=; b=SqbWLhnQWfdPhR
	O03YZ4SoRoL2MDGw/Z0TL6076JHi2zIJ7M66MqU4YoC+bSIx1K9l9WSLyFnI6MkauKNyMl+ggmRJM
	BSLMa6g2/rvvuQSf95AZzWaQRPybgbwH50hvxtZdg4V/coR3uyPnU5JGWJoR3MiAZS3tCVhFeRye3
	V4vhvWB3j/sWVN1wL3lBTb6tww/+3pVW3ENu0LRpz1SehUf/C8Cei9klZiRI+Po9k2OrvqQi5m0xF
	SvK3nTJ+zHT4HCmUHvxWcuxtMbBLAeyL+opoxjwqqyHdFA/WTbR4GOCRQ1I2M1hz03+qgxq62b9pt
	X3/yhut2AqqW4RIUtr0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy43o-0005Q1-Ff; Mon, 25 Feb 2019 00:23:56 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy43k-0005Pd-Am
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 00:23:53 +0000
Received: by mail-qk1-x741.google.com with SMTP id m9so4343385qkl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 24 Feb 2019 16:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QUPTL3PLqLo52so3LAReL1b7OoKBQnl+BlN/LgFRYCg=;
 b=V7pozMlwApDKiEuQ9KL99F2KVnCWK4yyb52Eec+39LdbtmZGHL4qD9tBIbF/OwIW+y
 cM1aCYv/z1jPXZ7bMZ6GvPia/8hff80OYppp2fw6cFExuhUxML2MU9prpa0SluDPE0dw
 5R6hzapbb+GT0B0Q6uA7M4QHKCJm20igRHoL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QUPTL3PLqLo52so3LAReL1b7OoKBQnl+BlN/LgFRYCg=;
 b=bhBUoGHMle5gPj0an2C3jn0TBZm6fSJhuBBZNCXtS1h8lz51bGWFzRsnPMVN6CrpzO
 bSBUwrJQmAYrLePvvuQgtuS4cWFgE+f1iu2t7ngHt6kB4cHSv+sCyeF3xuFnIzEXD3RX
 rC+r/L16JinO41WRfrmZBh+eop/tRo6Z2D8xqxSU+yAP/wr4/QBVf6KBUwv+vJG20BUJ
 qktat1oX8NVM9WCKTqIQjouH1NsYKanKA8fmbVxyXR3HqARpT1qe7chZHHp8Evwy72r+
 ashbu0pIAaWQgOnjLdMUqkgRvVmpbAC/ld9cP7ad8xRWxN/GJoFan7zK/2fAVZAu8mM1
 NTJg==
X-Gm-Message-State: AHQUAubbIHaIubDp8njXrHcu9nA91htlJ/tXkTEs/pH+p/+XcRJ2blOI
 DfdkMWkoYEFCDSf88AtrZ7I7Dsw6zwVNVmIcKQ3Dgg==
X-Google-Smtp-Source: AHgI3IYirf19cEx+D7YVBM5KBkdm2qM0SS7imatY1p89YM8NkGpwT67vhO3HIEUXH8EZmfreZX4pl0NiDFDcK8eBgF0=
X-Received: by 2002:ae9:e901:: with SMTP id x1mr11369376qkf.124.1551054230094; 
 Sun, 24 Feb 2019 16:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
 <20190111102155.in5rctq5krs4ewfi@8bytes.org>
 <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
 <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz>
In-Reply-To: <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Mon, 25 Feb 2019 08:23:39 +0800
Message-ID: <CANMq1KCfhWdWtXP_PRd_LEEcWV8SQg=hOy4V7_grqtL873uUCg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
To: Vlastimil Babka <vbabka@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_162352_372434_15A6F418 
X-CRM114-Status: GOOD (  15.10  )
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
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 hch@infradead.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 David Rientjes <rientjes@google.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yong Wu <yong.wu@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 iommu@lists.linux-foundation.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 1:12 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/22/19 11:51 PM, Nicolas Boichat wrote:
> > Hi Andrew,
> >
> > On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
> >>
> >> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> >> > Does anyone have any further comment on this series? If not, which
> >> > maintainer is going to pick this up? I assume Andrew Morton?
> >>
> >> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
> >> this should go through mm.
> >
> > Gentle ping on this series, it seems like it's better if it goes
> > through your tree.
> >
> > Series still applies cleanly on linux-next, but I'm happy to resend if
> > that helps.
>
> Ping, Andrew?

Another gentle ping, I still don't see these patches in mmot[ms]. Thanks.

> > Thanks!
> >
> >> Regards,
> >>
> >>         Joerg
> >
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
