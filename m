Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:34:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE04020874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ipoieofq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FZt34N9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE04020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bk9kXHbCMPpB7Uf5P3kcGon89kbtOlAHUsAaKQ6EI+0=; b=Ipoieofqmkco/1
	Syt9MiwWuHYzdOwZ/AEZGLBN1gVykX/ZE6uNLF8vmKap1IxRRUDkTkthZo7KnB99m21u2jeDco2uT
	4dfcFS9EWK2Ck/HZSYFsAByFpNnESHJHlYh/n/aL69vgkwW8l6pITyvlRRKlnF7DP/SczyNTKFZi+
	0V5Gm7C3WHS3Qvk1B14QaHoJjQF4BPhF8+yGBsnvrnO0kpQu4OhKATFjrVgy+2nX4nyeA+bb1eACx
	d/x/6jL85QUCf0IA02paIrUAr+pvtSVQkyNUngsUyZyBzsuP6iS0VR7mNlafuk+8vagkuRgpCUwUo
	9IjwUfxxeqmkmmkyUP6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZEZh-0002ok-Hb; Tue, 18 Dec 2018 12:34:13 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEZG-0002Vb-6C; Tue, 18 Dec 2018 12:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g2wZq5y5ENq8UiNCs5gTLmGTpkFs7b8zTmrQA3nLddI=; b=FZt34N9gz4KJHOfktbCTFkJtG
 ymyudHAlx7rpGiuKIqR4CE+fMN4mR+7EO6TbDipXIxtphrOZj3gOpNQvk1UXpkC+ShOovF1tI4pct
 vLdyQWzmQg0/qHisevw/R6lyHdLM+iCLHG+ks3IJGsFwYz7eXkHS0ajNnmU2HY3yLibuw=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:44710)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gZEYt-00066i-5v; Tue, 18 Dec 2018 12:33:23 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gZEYq-0007Kf-Ll; Tue, 18 Dec 2018 12:33:20 +0000
Date: Tue, 18 Dec 2018 12:33:19 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181218123318.GN26090@n2100.armlinux.org.uk>
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk>
 <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_043346_290440_722193DB 
X-CRM114-Status: GOOD (  18.09  )
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
Cc: Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
 Linux-MM <linux-mm@kvack.org>, airlied@linux.ie, hjc@rock-chips.com,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > This looks like a change in behaviour.
> >
> > If user_count is zero, and offset is zero, then we pass into
> > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > nothing and returns zero.
> >
> > However, as we can see from the above code, the original behaviour
> > was to return -ENXIO in that case.
> 
> I think these checks are not necessary. I am not sure if we get into mmap
> handlers of driver with user_count = 0.

I'm not sure either, I'm just pointing out the change of behaviour.

> > The other thing that I'm wondering is that if (eg) count is 8 (the
> > object is 8 pages), offset is 2, and the user requests mapping 6
> > pages (user_count = 6), then we call vm_insert_range() with a
> > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > end up inserting four pages.
> 
> Considering the scenario, user_count will remain 8 (user_count =
> vma_pages(vma) ). ? No ?
> Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> a pages_count
> of 8 - 2 = 6. So we end up inserting 6 pages.
> 
> Please correct me if I am wrong.

vma_pages(vma) is the number of pages that the user requested, it is
the difference between vma->vm_end and vma->vm_start in pages.  As I
said above, "the user requests mapping 6 pages", so vma_pages() will
be 6, and so user_count will also be 6.  You are passing
user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
in my example.  This is two pages short of what the user requested.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
