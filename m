Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E2CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:14:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C1D20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVW1zmUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C1D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DzPs9vD1r4uroBijcdyCmOSYf1lY9FlWZqDARs3H0GQ=; b=kVW1zmUdKavZ3Y
	wDSwQ+Vbg12gIu+gqhzlhf/D/BRLnRYrWQh1xKCYXZ1XJfOndE8YjJtpskQGK5cFL7nHJ6zg3h8To
	P8IG088k6CJSIX4ki6fJR+h5MvCpzxXpgFWnQi7bx8Tjvn0s4y19BzuDUnevRHmmAhYecAjXzX3aj
	qRXPhZ0SUIfM7pyOiCbwz9YtXuBXF9cda+BlZdNjQrT7+9GFLp0N5fBIPr/lDSDMB7l6q+ZVzF4Mo
	bhVEW8LBafnOsLqP/PHRFShmH4l2Y/cYXvYNqtOEy1bcNFwRPV+bMBIAkMTvx5iC1cI5D4lcPgMTU
	ti2RBzwYPfOLhZ5yWURA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjmtT-0001Sb-ED; Wed, 16 Jan 2019 15:14:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjmtQ-0001R0-5B
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 15:14:14 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0GF9Fgj103295
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 10:14:10 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q24cmr1hp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 10:14:09 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Wed, 16 Jan 2019 15:14:07 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 15:13:55 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0GFDsYN29294608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 15:13:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3306A4066;
 Wed, 16 Jan 2019 15:13:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C613EA405F;
 Wed, 16 Jan 2019 15:13:50 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Jan 2019 15:13:50 +0000 (GMT)
Date: Wed, 16 Jan 2019 17:13:49 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 19/21] treewide: add checks for the return value of
 memblock_alloc*()
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
 <CAMuHMdWKPj-2Let44rmaVwh-b6kkGg+0cFPQ-+3k9LP86pB7NA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWKPj-2Let44rmaVwh-b6kkGg+0cFPQ-+3k9LP86pB7NA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19011615-0008-0000-0000-000002B1DF75
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011615-0009-0000-0000-0000221DF943
Message-Id: <20190116151348.GD6643@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_071412_301405_C0D30809 
X-CRM114-Status: GOOD (  34.66  )
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Linux-sh list <linux-sh@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 alpha <linux-alpha@vger.kernel.org>, linux-um@lists.infradead.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Openrisc <openrisc@lists.librecores.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 03:27:35PM +0100, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Wed, Jan 16, 2019 at 2:46 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > Add check for the return value of memblock_alloc*() functions and call
> > panic() in case of error.
> > The panic message repeats the one used by panicing memblock allocators with
> > adjustment of parameters to include only relevant ones.
> >
> > The replacement was mostly automated with semantic patches like the one
> > below with manual massaging of format strings.
> >
> > @@
> > expression ptr, size, align;
> > @@
> > ptr = memblock_alloc(size, align);
> > + if (!ptr)
> > +       panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> 
> In general, you want to use %zu for size_t
> 
> > size, align);
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Thanks for your patch!
> 
> >  74 files changed, 415 insertions(+), 29 deletions(-)
> 
> I'm wondering if this is really an improvement?

From memblock perspective it's definitely an improvement :)

git diff --stat mmotm/master include/linux/memblock.h mm/memblock.c
 include/linux/memblock.h |  59 ++---------
 mm/memblock.c            | 249 ++++++++++++++++-------------------------------
 2 files changed, 90 insertions(+), 218 deletions(-)

> For the normal memory allocator, the trend is to remove printing of errors
> from all callers, as the core takes care of that.

It's more about allocation errors handling than printing of the errors.
Indeed, there is not much that can be done if an early allocation fails,
but I believe having an explicit pattern

	ptr = alloc();
	if (!ptr)
		do_something_about_it();

is clearer than relying on the allocator to panic().

Besides, the diversity of panic and nopanic variants creates a confusion
and I've caught several places that call nopanic variant and do not check
its return value.
 
> > --- a/arch/alpha/kernel/core_marvel.c
> > +++ b/arch/alpha/kernel/core_marvel.c
> > @@ -83,6 +83,9 @@ mk_resource_name(int pe, int port, char *str)
> >
> >         sprintf(tmp, "PCI %s PE %d PORT %d", str, pe, port);
> >         name = memblock_alloc(strlen(tmp) + 1, SMP_CACHE_BYTES);
> > +       if (!name)
> > +               panic("%s: Failed to allocate %lu bytes\n", __func__,
> 
> %zu, as strlen() returns size_t.

Thanks for spotting it, will fix.

> > +                     strlen(tmp) + 1);
> >         strcpy(name, tmp);
> >
> >         return name;
> > @@ -118,6 +121,9 @@ alloc_io7(unsigned int pe)
> >         }
> >
> >         io7 = memblock_alloc(sizeof(*io7), SMP_CACHE_BYTES);
> > +       if (!io7)
> > +               panic("%s: Failed to allocate %lu bytes\n", __func__,
> 
> %zu, as sizeof() returns size_t.
> Probably there are more. Yes, it's hard to get them right in all callers.

Yeah :)
 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
