Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8BEC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:16:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB382190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UtUWjWdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB382190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ACG6Y4HZz93UTnrGOh79sF64sYbQXK719h/8uEN7DoA=; b=UtUWjWdX+acQDU
	nGOJ/gXCLEmltDerB9EHF/vIdkktgnIpjB7iALHW1B0g5GqNsG5fY1iYvOOnyE3Q6Wg08JtOEYJ29
	/YMxzgWxcPQVJWvZ5BYdJYOpZsJ5WYQ2i96CBHXL9znmIaeeJQNEsriWRiwPJyFQTCHmz3roJzPD2
	qeUJu+wU1LEVc7O+e0TFtEkbXebu6z6RDBrwnwldjlwlJZbua3opE0zvvX9iyP0G3jXxcvfrUVUMg
	btss6Yxo0lBgkkbldhq7SF+4M/LvufpuRdhG8WrV+CnifZdWXafy107qpCihrhA7wc4GrgFPjYYqH
	vjO6MjCpwBCrqMNuSmeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsWa-0000Kq-KF; Wed, 13 Feb 2019 11:16:20 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsWS-0000JG-0N; Wed, 13 Feb 2019 11:16:13 +0000
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 113749FDF3;
 Wed, 13 Feb 2019 11:16:11 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-27.pek2.redhat.com
 [10.72.12.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1CF119C7B;
 Wed, 13 Feb 2019 11:15:58 +0000 (UTC)
Date: Wed, 13 Feb 2019 19:15:52 +0800
From: Dave Young <dyoung@redhat.com>
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, anderson@redhat.com
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Message-ID: <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 13 Feb 2019 11:16:11 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_031612_088887_6A910BD5 
X-CRM114-Status: GOOD (  17.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Bhupesh Sharma <bhsharma@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
 "anderson@redhat.com" <anderson@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 02/12/19 at 11:03pm, Kazuhito Hagio wrote:
> 
> On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
> > BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
> > (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
> > mentioned that the changes look necessary.
> > 
> > [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html
> 
> > > > The increased 'PTRS_PER_PGD' value for such cases needs to be then
> > > > calculated as is done by the underlying kernel (see
> > > > 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
> > > >
> > > > #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
> 
> Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
> It is used for pgd_index() also in makedumpfile to walk page tables.
> 
> /* to find an entry in a page-table-directory */
> #define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))

Since Dave mentioned crash tool does not need it, but crash should also
travel the pg tables.

If this is really necessary it would be good to describe what will
happen without the patch, eg. some user visible error from an actual test etc.

> 
> Thanks,
> Kazu
> 
> > > >
> > > > Also, note that 'arch/arm64/include/asm/memory.h' defines 'MAX_USER_VA_BITS'
> > > > as 'VA_BITS' in case 'CONFIG_ARM64_USER_VA_BITS_52' is set to 'n':
> > > >
> > > > #ifdef CONFIG_ARM64_USER_VA_BITS_52
> > > > #define MAX_USER_VA_BITS      52
> > > > #else
> > > > #define MAX_USER_VA_BITS      VA_BITS
> > > > #endif
> > > >
> > > > So, makedumpfile will need this symbol exported in vmcore to make the above
> > > > determination.
> > > >
> > > > [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022425.html
> > > >
> > > > Thanks,
> > > > Bhupesh
> > >
> > > Thanks
> > > Dave
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
