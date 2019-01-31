Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13783C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:42:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FE420881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JPjpUexw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FE420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m/sxU012/oeINy3krAh0ptvgREz3u8A9IDCBb66w2vI=; b=JPjpUexwEQA7uM
	Q8sROFvPbDsRny0NAK4AitK1XIzdeN7GdUyfahgTL8z1ohj1Vb7KWqo3PmD7RLYqQurAzARy/i1R1
	VCH4ZVYXNtBGFOsZzPsuSexO7MPQIzXBGbiu0p9xVFmtiZIm4SSQyZDmSvVsLs0uQR2IuzNj5+3lT
	KFktF6VuV9aAE/J2yS8Gfw0iH56wvaqms39Hasy1spq4cnhPTutx13fZnahbx4jBQeTsJoYU56ZNq
	EoW5u5CWf1vNpzjB02DLGQgLQXoU/xTS0hAtXI/u8gAc5awFzISVfHFE9C7sWum9FfHtWiVeHey8S
	B/d2SmO6WYQjVv53nCeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp63A-0008Sf-D2; Thu, 31 Jan 2019 06:42:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp634-0008OF-Pb
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 06:42:09 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0V6cYcQ135919
 for <linux-arm-kernel@lists.infradead.org>; Thu, 31 Jan 2019 01:42:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qbtrfb6vk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Thu, 31 Jan 2019 01:42:00 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Thu, 31 Jan 2019 06:41:57 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 31 Jan 2019 06:41:45 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0V6filb25034870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Jan 2019 06:41:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DDB0A4054;
 Thu, 31 Jan 2019 06:41:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E948A405C;
 Thu, 31 Jan 2019 06:41:41 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 31 Jan 2019 06:41:41 +0000 (GMT)
Date: Thu, 31 Jan 2019 08:41:39 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
 <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013106-0028-0000-0000-00000341269A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013106-0029-0000-0000-000023FF2799
Message-Id: <20190131064139.GB28876@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_224206_943567_7805F671 
X-CRM114-Status: GOOD (  23.60  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Petr Mladek <pmladek@suse.com>, linux-sh@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 devicetree@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 07:07:46AM +0100, Christophe Leroy wrote:
> =

> =

> Le 21/01/2019 =E0 09:04, Mike Rapoport a =E9crit=A0:
> >Add check for the return value of memblock_alloc*() functions and call
> >panic() in case of error.
> >The panic message repeats the one used by panicing memblock allocators w=
ith
> >adjustment of parameters to include only relevant ones.
> >
> >The replacement was mostly automated with semantic patches like the one
> >below with manual massaging of format strings.
> >
> >@@
> >expression ptr, size, align;
> >@@
> >ptr =3D memblock_alloc(size, align);
> >+ if (!ptr)
> >+ 	panic("%s: Failed to allocate %lu bytes align=3D0x%lx\n", __func__,
> >size, align);
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
> >Acked-by: Paul Burton <paul.burton@mips.com>	     # MIPS
> >Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
> >Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
> >---
> =

> [...]
> =

> >diff --git a/mm/sparse.c b/mm/sparse.c
> >index 7ea5dc6..ad94242 100644
> >--- a/mm/sparse.c
> >+++ b/mm/sparse.c
> =

> [...]
> =

> >@@ -425,6 +436,10 @@ static void __init sparse_buffer_init(unsigned long=
 size, int nid)
> >  		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> >  						__pa(MAX_DMA_ADDRESS),
> >  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> >+	if (!sparsemap_buf)
> >+		panic("%s: Failed to allocate %lu bytes align=3D0x%lx nid=3D%d from=
=3D%lx\n",
> >+		      __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
> >+
> =

> memblock_alloc_try_nid_raw() does not panic (help explicitly says: Does n=
ot
> zero allocated memory, does not panic if request cannot be satisfied.).

"Does not panic" does not mean it always succeeds.
 =

> Stephen Rothwell reports a boot failure due to this change.

Please see my reply on that thread.

> Christophe
> =

> >  	sparsemap_buf_end =3D sparsemap_buf + size;
> >  }
> >
> =


-- =

Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
