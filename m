Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E4C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:35:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F4E20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rHeAG26/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F4E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DLc7bM2s3cZBskx35NSXbl4I62PuFF2L25I6My8AxnA=; b=rHeAG26/5klwm+
	ugu3XmbhYJLQoEsS/jXvXFkqW81GzMwbGNK2HoD66hnQSdnTnvd1Nq9vHuLQxvrPHxH7MZbATsYeT
	lY+m9E9SkS7ydAT271ZE1kZbUNzJdE4y3H7rnZ2mmPjoS1fB3hgsZoMesbYgANBzhe4GgA9aWFm7D
	Ke//+ti3i8Mg68hPuR4U5i8QCA0XYLOqEQ1bld5y9khVhjZGfiHJ1yuKYDlVQQT2PoYuvQWJtm0TB
	UWr0Dsqo0+n9fejZ9+P0F9D5SGgwRKKulxurG8TmvPH955TLauwnA6uPMvhG+KKHl6HFjKjSrbHgn
	qfXsCjIBs6QWZ1Y7vOWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXZZw-0008OB-Cs; Thu, 13 Dec 2018 22:35:36 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXZZt-0008NT-AA
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 22:35:34 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Dec 2018 14:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,350,1539673200"; d="scan'208";a="100546025"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga006.jf.intel.com with ESMTP; 13 Dec 2018 14:35:18 -0800
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Dec 2018 14:34:56 -0800
Received: from HASMSX109.ger.corp.intel.com (10.184.198.21) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Dec 2018 14:34:56 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.61]) by
 hasmsx109.ger.corp.intel.com ([169.254.3.179]) with mapi id 14.03.0415.000;
 Fri, 14 Dec 2018 00:34:53 +0200
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, Vinayak Holikatti
 <vinholikatti@gmail.com>, Joao Pinto <jpinto@synopsys.com>, Avri Altman
 <avri.altman@wdc.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v1] scsi: ufs: Use explicit access size in ufshcd_dump_regs
Thread-Topic: [PATCH v1] scsi: ufs: Use explicit access size in
 ufshcd_dump_regs
Thread-Index: AQHUkVxxN9195/jQlkyXNcQH8xQywKV9RJ2A
Date: Thu, 13 Dec 2018 22:34:52 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA52659@hasmsx108.ger.corp.intel.com>
References: <3bf7ea8e-4cf2-1f9b-7f46-15609dfcad19@free.fr>
In-Reply-To: <3bf7ea8e-4cf2-1f9b-7f46-15609dfcad19@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTE4NmE0ZmYtOWRlZi00ZjhlLWFkOTgtZTQzZjA4OWVmOWY1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTlFSRHNsMTNqc2VhZEdId21kNmpWMU5kTEFnQjlMUlVETmNnVnRoNDdWT1VIT09oSEJpeUJHMExLMWd4ejBITiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.249.91.43]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_143533_401709_D687F3C4 
X-CRM114-Status: GOOD (  19.27  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>, SCSI <linux-scsi@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> memcpy_fromio() doesn't provide any control over access size.
> For example, on arm64, it is implemented using readb and readq.
> This may trigger a synchronous external abort:
> 
> [    3.729943] Internal error: synchronous external abort: 96000210 [#1]
> PREEMPT SMP
> [    3.737000] Modules linked in:
> [    3.744371] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S                4.20.0-rc4
> #16
> [    3.747413] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1
> MTP (DT)
> [    3.755295] pstate: 00000005 (nzcv daif -PAN -UAO)
> [    3.761978] pc : __memcpy_fromio+0x68/0x80
> [    3.766718] lr : ufshcd_dump_regs+0x50/0xb0
> [    3.770767] sp : ffff00000807ba00
> [    3.774830] x29: ffff00000807ba00 x28: 00000000fffffffb
> [    3.778344] x27: ffff0000089db068 x26: ffff8000f6e58000
> [    3.783728] x25: 000000000000000e x24: 0000000000000800
> [    3.789023] x23: ffff8000f6e587c8 x22: 0000000000000800
> [    3.794319] x21: ffff000008908368 x20: ffff8000f6e1ab80
> [    3.799615] x19: 000000000000006c x18: ffffffffffffffff
> [    3.804910] x17: 0000000000000000 x16: 0000000000000000
> [    3.810206] x15: ffff000009199648 x14: ffff000089244187
> [    3.815502] x13: ffff000009244195 x12: ffff0000091ab000
> [    3.820797] x11: 0000000005f5e0ff x10: ffff0000091998a0
> [    3.826093] x9 : 0000000000000000 x8 : ffff8000f6e1ac00
> [    3.831389] x7 : 0000000000000000 x6 : 0000000000000068
> [    3.836676] x5 : ffff8000f6e1abe8 x4 : 0000000000000000
> [    3.841971] x3 : ffff00000928c868 x2 : ffff8000f6e1abec
> [    3.847267] x1 : ffff00000928c868 x0 : ffff8000f6e1abe8
> [    3.852567] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> [    3.857900] Call trace:
> [    3.864473]  __memcpy_fromio+0x68/0x80
> [    3.866683]  ufs_qcom_dump_dbg_regs+0x1c0/0x370
> [    3.870522]  ufshcd_print_host_regs+0x168/0x190
> [    3.874946]  ufshcd_init+0xd4c/0xde0
> [    3.879459]  ufshcd_pltfrm_init+0x3c8/0x550
> [    3.883264]  ufs_qcom_probe+0x24/0x60
> [    3.887188]  platform_drv_probe+0x50/0xa0
> 
> Assuming aligned 32-bit registers, let's use readl, after making sure that 'offset'
> and 'len' are indeed multiples of 4.
> 
> Fixes: ba80917d9932d ("scsi: ufs: ufshcd_dump_regs to use memcpy_fromio")
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
LGTM
Thanks
Tomas

> ---
>  drivers/scsi/ufs/ufshcd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
> 535180c01ce8..320bbd9849bc 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -112,13 +112,19 @@
>  int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
>  		     const char *prefix)
>  {
> -	u8 *regs;
> +	u32 *regs;
> +	size_t pos;
> +
> +	if (offset % 4 != 0 || len % 4 != 0) /* keep readl happy */
> +		return -EINVAL;
> 
>  	regs = kzalloc(len, GFP_KERNEL);
>  	if (!regs)
>  		return -ENOMEM;
> 
> -	memcpy_fromio(regs, hba->mmio_base + offset, len);
> +	for (pos = 0; pos < len; pos += 4)
> +		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
> +
>  	ufshcd_hex_dump(prefix, regs, len);
>  	kfree(regs);
> 
> --
> 2.17.1
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
