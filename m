Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF669C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:15:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4DE2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZJNh+pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4DE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W5A+dG4iXtStx15HqhmBwGVrbralo0POKelO5P76g+0=; b=ZZJNh+palbfiBM
	mydd9iGzzRtwJHcsDBfKoqTwGVFqgcF1PCAKt24YH3H6ELFQNZU71sMAlBFEbZ1M7Nyu15K0FgFUZ
	8uhYIM4RpHwtI91hKIokuSsXb86tpMNi7D6a33nFRGmqVFDLdPTDYg28lAYBA3jj4n8N8oQCRnNjD
	Bkl3WyXY2aFwAoMkD2vtD6E4fOok+uHPG80+QADFdDbP2/zQP4uMQspPIyE1KeLp8B/M5F1IbwXRC
	tHzIdV/5mgTElkb1ptVMPojZq7B5Ltco5AcgElAFaF+yOpsiPetUQbh5CbK8+VjHPZ6UasffYFgIM
	TgSN8R6rxFBdB9Z86bJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp6ZJ-0003NB-Qr; Thu, 31 Jan 2019 07:15:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp6ZG-0003MH-DV
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 07:15:24 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0V7E98L129170
 for <linux-arm-kernel@lists.infradead.org>; Thu, 31 Jan 2019 02:15:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qbsrcxetd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Thu, 31 Jan 2019 02:15:20 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Thu, 31 Jan 2019 07:15:17 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 31 Jan 2019 07:15:07 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0V7F6tN55378120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Jan 2019 07:15:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D50C74C046;
 Thu, 31 Jan 2019 07:15:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E7D14C040;
 Thu, 31 Jan 2019 07:15:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 31 Jan 2019 07:15:01 +0000 (GMT)
Date: Thu, 31 Jan 2019 09:14:59 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
 <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
 <20190131064139.GB28876@rapoport-lnx>
 <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
 <d5e4ff5b-d33a-e641-8159-d4f83bc28d0b@c-s.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d5e4ff5b-d33a-e641-8159-d4f83bc28d0b@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013107-0020-0000-0000-0000030F29F7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013107-0021-0000-0000-000021602B4F
Message-Id: <20190131071459.GC28876@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_231522_655109_D8B5675D 
X-CRM114-Status: GOOD (  29.52  )
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

On Thu, Jan 31, 2019 at 08:07:29AM +0100, Christophe Leroy wrote:
> =

> =

> Le 31/01/2019 =E0 07:44, Christophe Leroy a =E9crit=A0:
> >
> >
> >Le 31/01/2019 =E0 07:41, Mike Rapoport a =E9crit=A0:
> >>On Thu, Jan 31, 2019 at 07:07:46AM +0100, Christophe Leroy wrote:
> >>>
> >>>
> >>>Le 21/01/2019 =E0 09:04, Mike Rapoport a =E9crit=A0:
> >>>>Add check for the return value of memblock_alloc*() functions and call
> >>>>panic() in case of error.
> >>>>The panic message repeats the one used by panicing memblock
> >>>>allocators with
> >>>>adjustment of parameters to include only relevant ones.
> >>>>
> >>>>The replacement was mostly automated with semantic patches like the o=
ne
> >>>>below with manual massaging of format strings.
> >>>>
> >>>>@@
> >>>>expression ptr, size, align;
> >>>>@@
> >>>>ptr =3D memblock_alloc(size, align);
> >>>>+ if (!ptr)
> >>>>+=A0=A0=A0=A0 panic("%s: Failed to allocate %lu bytes align=3D0x%lx\n=
", __func__,
> >>>>size, align);
> >>>>
> >>>>Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >>>>Reviewed-by: Guo Ren <ren_guo@c-sky.com>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 # c-sky
> >>>>Acked-by: Paul Burton <paul.burton@mips.com>=A0=A0=A0=A0=A0=A0=A0=A0 =
# MIPS
> >>>>Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
> >>>>Reviewed-by: Juergen Gross <jgross@suse.com>=A0=A0=A0=A0=A0=A0=A0=A0 =
# Xen
> >>>>---
> >>>
> >>>[...]
> >>>
> >>>>diff --git a/mm/sparse.c b/mm/sparse.c
> >>>>index 7ea5dc6..ad94242 100644
> >>>>--- a/mm/sparse.c
> >>>>+++ b/mm/sparse.c
> >>>
> >>>[...]
> >>>
> >>>>@@ -425,6 +436,10 @@ static void __init sparse_buffer_init(unsigned
> >>>>long size, int nid)
> >>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 memblock_alloc_try_nid_raw(size, PAGE_SIZ=
E,
> >>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 __pa(MAX_DMA_ADDRESS),
> >>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> >>>>+=A0=A0=A0 if (!sparsemap_buf)
> >>>>+=A0=A0=A0=A0=A0=A0=A0 panic("%s: Failed to allocate %lu bytes align=
=3D0x%lx nid=3D%d
> >>>>from=3D%lx\n",
> >>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __func__, size, PAGE_SIZE, n=
id, __pa(MAX_DMA_ADDRESS));
> >>>>+
> >>>
> >>>memblock_alloc_try_nid_raw() does not panic (help explicitly says:
> >>>Does not
> >>>zero allocated memory, does not panic if request cannot be satisfied.).
> >>
> >>"Does not panic" does not mean it always succeeds.
> >
> >I agree, but at least here you are changing the behaviour by making it
> >panic explicitly. Are we sure there are not cases where the system could
> >just continue functionning ? Maybe a WARN_ON() would be enough there ?
> =

> Looking more in details, it looks like everything is done to live with
> sparsemap_buf NULL, all functions using it check it so having it NULL
> shouldn't imply a panic I believe, see code below.

You are right, I'm preparing the fix right now.
 =

> static void *sparsemap_buf __meminitdata;
> static void *sparsemap_buf_end __meminitdata;
> =

> static void __init sparse_buffer_init(unsigned long size, int nid)
> {
> 	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
> 	sparsemap_buf =3D
> 		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> 						__pa(MAX_DMA_ADDRESS),
> 						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> 	sparsemap_buf_end =3D sparsemap_buf + size;
> }
> =

> static void __init sparse_buffer_fini(void)
> {
> 	unsigned long size =3D sparsemap_buf_end - sparsemap_buf;
> =

> 	if (sparsemap_buf && size > 0)
> 		memblock_free_early(__pa(sparsemap_buf), size);
> 	sparsemap_buf =3D NULL;
> }
> =

> void * __meminit sparse_buffer_alloc(unsigned long size)
> {
> 	void *ptr =3D NULL;
> =

> 	if (sparsemap_buf) {
> 		ptr =3D PTR_ALIGN(sparsemap_buf, size);
> 		if (ptr + size > sparsemap_buf_end)
> 			ptr =3D NULL;
> 		else
> 			sparsemap_buf =3D ptr + size;
> 	}
> 	return ptr;
> }
> =

> =

> Christophe
> =


-- =

Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
