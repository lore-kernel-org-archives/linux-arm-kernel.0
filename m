Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7CFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:44:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE40320859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pkxH6XMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE40320859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y54C3/lc8hmMGSPDgHwm9ur1ODqL7nK8dnSV7/E2Aj8=; b=pkxH6XMaYJcNoc
	6qcywpX5JuhJeGIU0Fyx2/2cJNacEKr9cKlsvyYNM7pavDFIUA4hZefQ5kxrd1VowcopvkbKqehvd
	8WQD6EIwzD2s36+EfnmrJevaqtQG9gX1jJY4s0P7oWOigakjI/36Rm94j1QX1gPw5kkJdkmX3pHzS
	UYnq5NgZtBaAxjm1vcnB47Ji4MhH/P3V67yaRK9Br5hNephD45XFxRaEzfhTFt2Xz0pC1DMTQwW0N
	yxVNgiL/eaVon4ANcdsVzGEOxOvVs68k2uH5jT6/FSNpRgbcTuy0MziKnOrdGqnoRerb0WoST5cPG
	qwRKt7BE2cU84DMNWRlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjhju-0007zo-Cl; Wed, 16 Jan 2019 09:44:02 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjhjr-0007z2-3x
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 09:44:00 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jan 2019 01:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; d="scan'208";a="128180954"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga001.jf.intel.com with ESMTP; 16 Jan 2019 01:43:57 -0800
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 16 Jan 2019 01:43:57 -0800
Received: from lcsmsx152.ger.corp.intel.com (10.186.165.231) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 16 Jan 2019 01:43:57 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.155]) by
 LCSMSX152.ger.corp.intel.com ([10.186.165.231]) with mapi id 14.03.0415.000;
 Wed, 16 Jan 2019 11:43:56 +0200
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, Vinayak Holikatti
 <vinholikatti@gmail.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 James Bottomley <jejb@linux.ibm.com>
Subject: RE: [PATCH v1] scsi: ufs: Use explicit access size in ufshcd_dump_regs
Thread-Topic: [PATCH v1] scsi: ufs: Use explicit access size in
 ufshcd_dump_regs
Thread-Index: AQHUkVxxN9195/jQlkyXNcQH8xQywKWm7VCAgAAxToCACpsfgIAAI0vA
Date: Wed, 16 Jan 2019 09:43:55 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA7B9D5@hasmsx108.ger.corp.intel.com>
References: <3bf7ea8e-4cf2-1f9b-7f46-15609dfcad19@free.fr>
 <214700f8-a381-5740-47c0-54923dae60b1@free.fr>
 <4c367e20-3ae8-ba28-75dc-b07805e27ea8@codeaurora.org>
 <c3c4e886-39ef-6384-5772-96b865d0b059@free.fr>
In-Reply-To: <c3c4e886-39ef-6384-5772-96b865d0b059@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjhlOGIxYTQtYThjMy00ZjliLWJiNDYtNWRjODkxYzljODY4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWWJQN2pON3FXUjloMWpNVWt1cTVcL2t3R3F4OXZBajY1RmpsZCt4VFlNK3NBQXlRV3ZpWFRKemVtKzZPbXFZMnAifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.126.169]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_014359_173766_0134287D 
X-CRM114-Status: GOOD (  22.24  )
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
Cc: SCSI <linux-scsi@vger.kernel.org>, Avri Altman <avri.altman@wdc.com>,
 Jeffrey Hugo <jhugo@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Joao Pinto <jpinto@synopsys.com>,
 Andy Gross <andy.gross@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> 
> On 09/01/2019 16:38, Jeffrey Hugo wrote:
> 
> >> On 11/12/2018 15:18, Marc Gonzalez wrote:
> >>
> >>> memcpy_fromio() doesn't provide any control over access size.
> >>> For example, on arm64, it is implemented using readb and readq.
> >>> This may trigger a synchronous external abort:
> >>>
> >>> [    3.729943] Internal error: synchronous external abort: 96000210 [#1]
> PREEMPT SMP
> >>> [    3.737000] Modules linked in:
> >>> [    3.744371] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S                4.20.0-
> rc4 #16
> >>> [    3.747413] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1
> MTP (DT)
> >>> [    3.755295] pstate: 00000005 (nzcv daif -PAN -UAO)
> >>> [    3.761978] pc : __memcpy_fromio+0x68/0x80
> >>> [    3.766718] lr : ufshcd_dump_regs+0x50/0xb0
> >>> [    3.770767] sp : ffff00000807ba00
> >>> [    3.774830] x29: ffff00000807ba00 x28: 00000000fffffffb
> >>> [    3.778344] x27: ffff0000089db068 x26: ffff8000f6e58000
> >>> [    3.783728] x25: 000000000000000e x24: 0000000000000800
> >>> [    3.789023] x23: ffff8000f6e587c8 x22: 0000000000000800
> >>> [    3.794319] x21: ffff000008908368 x20: ffff8000f6e1ab80
> >>> [    3.799615] x19: 000000000000006c x18: ffffffffffffffff
> >>> [    3.804910] x17: 0000000000000000 x16: 0000000000000000
> >>> [    3.810206] x15: ffff000009199648 x14: ffff000089244187
> >>> [    3.815502] x13: ffff000009244195 x12: ffff0000091ab000
> >>> [    3.820797] x11: 0000000005f5e0ff x10: ffff0000091998a0
> >>> [    3.826093] x9 : 0000000000000000 x8 : ffff8000f6e1ac00
> >>> [    3.831389] x7 : 0000000000000000 x6 : 0000000000000068
> >>> [    3.836676] x5 : ffff8000f6e1abe8 x4 : 0000000000000000
> >>> [    3.841971] x3 : ffff00000928c868 x2 : ffff8000f6e1abec
> >>> [    3.847267] x1 : ffff00000928c868 x0 : ffff8000f6e1abe8
> >>> [    3.852567] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> >>> [    3.857900] Call trace:
> >>> [    3.864473]  __memcpy_fromio+0x68/0x80
> >>> [    3.866683]  ufs_qcom_dump_dbg_regs+0x1c0/0x370
> >>> [    3.870522]  ufshcd_print_host_regs+0x168/0x190
> >>> [    3.874946]  ufshcd_init+0xd4c/0xde0
> >>> [    3.879459]  ufshcd_pltfrm_init+0x3c8/0x550
> >>> [    3.883264]  ufs_qcom_probe+0x24/0x60
> >>> [    3.887188]  platform_drv_probe+0x50/0xa0
> >>>
> >>> Assuming aligned 32-bit registers, let's use readl, after making
> >>> sure that 'offset' and 'len' are indeed multiples of 4.
> >>>
> >>> Fixes: ba80917d9932d ("scsi: ufs: ufshcd_dump_regs to use
> >>> memcpy_fromio")
> >>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> >>> ---
> >>>   drivers/scsi/ufs/ufshcd.c | 10 ++++++++--
> >>>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> >>> index 535180c01ce8..320bbd9849bc 100644
> >>> --- a/drivers/scsi/ufs/ufshcd.c
> >>> +++ b/drivers/scsi/ufs/ufshcd.c
> >>> @@ -112,13 +112,19 @@
> >>>   int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
> >>>   		     const char *prefix)
> >>>   {
> >>> -	u8 *regs;
> >>> +	u32 *regs;
> >>> +	size_t pos;
> >>> +
> >>> +	if (offset % 4 != 0 || len % 4 != 0) /* keep readl happy */
> >>> +		return -EINVAL;
> >
> > Hmm.  It seems like these cases could be handled, but I guess we
> > cannot necessarily assume that reading past the bounds specified by
> > the client is safe, so this seems reasonable.
> >
> >>>
> >>>   	regs = kzalloc(len, GFP_KERNEL);
> >>>   	if (!regs)
> >>>   		return -ENOMEM;
> >>>
> >>> -	memcpy_fromio(regs, hba->mmio_base + offset, len);
> >>> +	for (pos = 0; pos < len; pos += 4)
> >>> +		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
> >>> +
> >>>   	ufshcd_hex_dump(prefix, regs, len);
> >>>   	kfree(regs);
> >>>
> >
> > Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
> 
> James, Martin,
> 
> I haven't heard back from Vinayak. (In fact, his last review dates back to 2016.
> Should MAINTAINERS be updated? I can send a patch.)
> 
> Would you mind taking this patch through the SCSI tree?
> 
> Tomas, does "LGTM" translate to Acked-by? :-D
Yes, you can add my Ack.

Thanks
Tomas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
