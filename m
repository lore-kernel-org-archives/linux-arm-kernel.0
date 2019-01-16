Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:16:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F07D205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r+VYw/SM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xr0GSlo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F07D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IrIsMau2hnCtivSkUpKe1ht8XEa86AgvpeyMrJUZbwk=; b=r+VYw/SM7ywIRs
	vurNUx/95/pgF+xOKbOPoFxPckD9s/Ot/kos0Av8um7tQ0dnC4bRy85HlyBW9boT5b/8JdZvJKWeg
	LEZox/cO7x0hLyiHo0F0/qTDc4g9LElc+M4HzEnd8oIp83Cl3jfnAAkw5AtyK19unYT75ZdkDZjDA
	mdRr4sct+xL/8daFO2iBjCjmkiqUY8t+Fy6PxfKB94CTqdg/h7mTL222IkizvKBeCvVehHuPHfPW5
	FbMeiMAp1EvBW91VS4TSf+BGJBADDAk6Xz7K77VmVK/zcdNyIM9X3x2w9px/5w46EDM0MHJn/5bZY
	lAfAREi/m3FIP7XeG1Qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjmvE-0003hP-Em; Wed, 16 Jan 2019 15:16:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjmv9-0003XT-9v; Wed, 16 Jan 2019 15:16:02 +0000
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD47D20896;
 Wed, 16 Jan 2019 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547651758;
 bh=FhtIDYW+wCB2HQTzHX9fQ0IjelhfkG3XvKPLXhG6y4I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xr0GSlo2nvlWuGsr7jweGcrtepRj+D96RyQ+3OmX9XbTMPamFrPpu4f/m5bPTi/sO
 8y6JlwR4JF+63DTRsEMl2RfD/+WwchlswVHiuuUDZL0SOCpLnxciljbXNI/wtVW0ZK
 Ys3oVFXPfCIv+U1cCkVRudGZEi0gdBT/KYCAGQY8=
Received: by mail-qk1-f180.google.com with SMTP id 68so3916824qke.9;
 Wed, 16 Jan 2019 07:15:58 -0800 (PST)
X-Gm-Message-State: AJcUukd7hMkbQnH3c7gCciB4BhcRKM0DysOD2bkGbxPR95C3Rn6s3wSc
 y8EEYEt/JgqGtB5mVMBMY0Hsm4a3h8sTzoVRlA==
X-Google-Smtp-Source: ALg8bN58+iZLgU0Dz1CX9M4G8I+i1sidyUpbMzMVG8uz2Sj9t19sPbU6vMAmegv9MXHzo0bLJlQeKTxDeZMUP4oPvQg=
X-Received: by 2002:a37:7682:: with SMTP id r124mr6995371qkc.79.1547651756813; 
 Wed, 16 Jan 2019 07:15:56 -0800 (PST)
MIME-Version: 1.0
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-9-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1547646261-32535-9-git-send-email-rppt@linux.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 16 Jan 2019 09:15:45 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+7=yiOYS0Nq7euXK4qghjAu9-mzruW0Jt1N146gK+DCQ@mail.gmail.com>
Message-ID: <CAL_Jsq+7=yiOYS0Nq7euXK4qghjAu9-mzruW0Jt1N146gK+DCQ@mail.gmail.com>
Subject: Re: [PATCH 08/21] memblock: drop __memblock_alloc_base()
To: Mike Rapoport <rppt@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_071559_395736_7503113C 
X-CRM114-Status: GOOD (  12.61  )
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
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, SH-Linux <linux-sh@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Openrisc <openrisc@lists.librecores.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 7:45 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> The __memblock_alloc_base() function tries to allocate a memory up to the
> limit specified by its max_addr parameter. Depending on the value of this
> parameter, the __memblock_alloc_base() can is replaced with the appropriate
> memblock_phys_alloc*() variant.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/sh/kernel/machine_kexec.c |  3 ++-
>  arch/x86/kernel/e820.c         |  2 +-
>  arch/x86/mm/numa.c             | 12 ++++--------
>  drivers/of/of_reserved_mem.c   |  7 ++-----
>  include/linux/memblock.h       |  2 --
>  mm/memblock.c                  |  9 ++-------
>  6 files changed, 11 insertions(+), 24 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
