Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFC1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:33:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5140821850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RIMs4Hpt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VoB8W+aN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5140821850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pcOwAKd4NuHaEJTeZRMPi/Asn1Bk59vn8y17XwC/61E=; b=RIMs4HptA69UAb
	Iev+PkpONLrmEhcqDoBiyrCMtQkQA21MGqzTViGTk+YgKZFfpvin8pJJJDHRo6ibPNqBmBAw55Vzs
	QlcvHsvhgmW8Eis/L86qaoch4VgL1U9N/9S4olwISU8a/FrZ9LpES4Wq7LxJ8hXLUrVQkeIm/Ibsz
	GIXAKt7N3uYgTdjr0ai4M58qyltrpv2HscbcDrRBOBYId71FQUOiHMT5n0XI79N2pSNod8dQ9gN3B
	10ASe8Sb9JARbXISk6sqgxkIi+1fdLcjIoV9xHVM7g3UghkTuar4X3BPuw2Em8o1Gn/N/LBNG80ar
	xP+bUdIX+h55w7kMr1DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYEG-0008AJ-20; Wed, 19 Dec 2018 09:33:24 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYEB-00085V-LT; Wed, 19 Dec 2018 09:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XEdwmYpb9V17qjkZSHR5XXHlUzVbPyMwKaT9zenZRtM=; b=VoB8W+aN2VBR/la4LUJaHP8xp
 trOSt566Jd5quXeoXhhLv1kDQ5seisInv09pFBgRLG66YmZbVjEeZsihCpTW8LaHR9Gp9/h2zb43+
 wMkbOWmn2vBWXk2HT8yRf/qQqY6K6ftTIZuMctLDOQwQdDJNW3APi9Rt3AcewA32ChKqk=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:53501)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gZYDR-0002ih-Th; Wed, 19 Dec 2018 09:32:34 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gZYDP-0002y2-Dd; Wed, 19 Dec 2018 09:32:31 +0000
Date: Wed, 19 Dec 2018 09:32:30 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181219093230.GS26090@n2100.armlinux.org.uk>
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk>
 <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
 <20181218123318.GN26090@n2100.armlinux.org.uk>
 <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
 <20181218130146.GO26090@n2100.armlinux.org.uk>
 <CAFqt6zYnn76OdprSvA2Bj0v=xQqtJ6xJse6+iB+-=u3WsEv3pA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFqt6zYnn76OdprSvA2Bj0v=xQqtJ6xJse6+iB+-=u3WsEv3pA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_013319_704057_227CC847 
X-CRM114-Status: GOOD (  31.53  )
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
 linux-rockchip@lists.infradead.org, airlied@linux.ie, hjc@rock-chips.com,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 09:01:09AM +0530, Souptick Joarder wrote:
> On Tue, Dec 18, 2018 at 6:31 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Dec 18, 2018 at 06:24:29PM +0530, Souptick Joarder wrote:
> > > On Tue, Dec 18, 2018 at 6:03 PM Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> > > > > On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > > This looks like a change in behaviour.
> > > > > >
> > > > > > If user_count is zero, and offset is zero, then we pass into
> > > > > > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > > > > > nothing and returns zero.
> > > > > >
> > > > > > However, as we can see from the above code, the original behaviour
> > > > > > was to return -ENXIO in that case.
> > > > >
> > > > > I think these checks are not necessary. I am not sure if we get into mmap
> > > > > handlers of driver with user_count = 0.
> > > >
> > > > I'm not sure either, I'm just pointing out the change of behaviour.
> > >
> > > Ok. I think feedback from Heiko might be helpful here :)
> > >
> > > >
> > > > > > The other thing that I'm wondering is that if (eg) count is 8 (the
> > > > > > object is 8 pages), offset is 2, and the user requests mapping 6
> > > > > > pages (user_count = 6), then we call vm_insert_range() with a
> > > > > > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > > > > > end up inserting four pages.
> > > > >
> > > > > Considering the scenario, user_count will remain 8 (user_count =
> > > > > vma_pages(vma) ). ? No ?
> > > > > Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> > > > > a pages_count
> > > > > of 8 - 2 = 6. So we end up inserting 6 pages.
> > > > >
> > > > > Please correct me if I am wrong.
> > > >
> > > > vma_pages(vma) is the number of pages that the user requested, it is
> > > > the difference between vma->vm_end and vma->vm_start in pages.  As I
> > > > said above, "the user requests mapping 6 pages", so vma_pages() will
> > > > be 6, and so user_count will also be 6.  You are passing
> > > > user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
> > > > in my example.  This is two pages short of what the user requested.
> > > >
> > >
> > > So, this should be the correct behavior.
> > >
> > >                  return vm_insert_range(vma, vma->vm_start,
> > > rk_obj->pages + offset,
> > >                                                           user_count);
> >
> > ... and by doing so, you're introducing another instance of the same
> > bug I pointed out in patch 2.
> 
> Sorry but didn't get it ? How it will be similar to the bug pointed
> out in patch 2 ?

Towards the top of this function, you have:

        unsigned long user_count = vma_pages(vma);

So what you are proposing does:

        return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
                               vma_pages(vma));

Now if we look inside vm_insert_range():

+int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
+                       struct page **pages, unsigned long page_count)
+{
+       unsigned long uaddr = addr;
+       int ret = 0, i;
+
+       if (page_count > vma_pages(vma))
+               return -ENXIO;
+
+       for (i = 0; i < page_count; i++) {
+               ret = vm_insert_page(vma, uaddr, pages[i]);
+               if (ret < 0)
+                       return ret;
+               uaddr += PAGE_SIZE;
+       }

So, page_count _is_ vma_pages(vma).  So this code does these operations:

	if (vma_pages(vma) > vma_pages(vma))
		return -ENXIO;

This will always be false.  I've already stated in my reply to patch 2
in paragraph 3 about the uselessness of this test.

	for (i = 0; i < vma_pages(vma); i++) {
		ret = vm_insert_page(vma, uaddr, pages[i]);

So the loop will iterate over the number of pages that the user requested.

Now, taking another example.  The object is again 8 pages long, so
indexes 0 through 7 in its page array are valid.  The user requests
8 pages at offset 2 into the object.  Also as already stated in
paragraph 3 of my reply to patch 2.

vma_pages(vma) is 8.  offset = 2.

So we end up _inside_ vm_insert_range() with:

	if (8 > 8)
		return -ENXIO;

As stated, always false.

	for (i = 0; i < 8; i++) {
		ret = vm_insert_page(vma, vaddr, rk_obj->pages[2 + i]);

Which means we iterate over rk_obj->pages indicies from 2 through 9
inclusive.

Since only 0 through 7 are valid, we have walked off the end of the
array, and attempted to map an invalid struct page pointer - we could
be lucky, and it could point at some struct page (potentially causing
us to map some sensitive page - maybe containing your bank details or
root password... Or it could oops the kernel.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
