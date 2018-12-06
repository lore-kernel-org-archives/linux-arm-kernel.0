Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4469FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:49:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1411F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N3bM5Gtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1411F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3U61xM/9zrOek9fVoEfoxPl6aj6HS9cWo6GfMQ/gl/g=; b=N3bM5Gtu2bP/KR
	ecGxSnYkJJ29zwIT+RGZ5bPYEs9uZQUuHp2Vjb+pJhR4ssdyTVwmDaPKsRuM2EIXjLSkCUBsWkUyY
	bchKD57nRUm7ylEu7FxWuf7VX6mRiC8jV9kIAhvE6V4FY0EUntmZhwfzzaaBAAeQacVTwa6Pupqi0
	ObTX3j5OEsy2nggwAiYns9tC+E49ZaDbzw3wAxm6zBtxpLAmck+BEFqXM9GQO8/ZurKlx0besBSK3
	SdjZcmE16CUIvCUvevtsE4UhLwqlQklWi9QEU2EHkouQvn2Bczy9KlM/0xRwcwUqdMVKnaRefWeTU
	BR+vJCsSKTVPUgXEFYQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUs9u-0004qn-UY; Thu, 06 Dec 2018 11:49:34 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUs9q-0004qH-GR
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:49:32 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB6BjwJb016149; Thu, 6 Dec 2018 12:49:13 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p3wt6v1ky-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 06 Dec 2018 12:49:13 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ABD4131;
 Thu,  6 Dec 2018 11:49:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A6AB287B;
 Thu,  6 Dec 2018 11:49:12 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Dec
 2018 12:49:11 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Thu, 6 Dec 2018 12:49:12 +0100
From: Fabien DESSENNE <fabien.dessenne@st.com>
To: Yangtao Li <tiny.windzz@gmail.com>, "kyungmin.park@samsung.com"
 <kyungmin.park@samsung.com>, "s.nawrocki@samsung.com"
 <s.nawrocki@samsung.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
 "kgene@kernel.org" <kgene@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>,
 Jean Christophe TROTIN <jean-christophe.trotin@st.com>
Subject: Re: [PATCH v2] media: remove bdisp_dbg_declare() and hva_dbg_declare()
Thread-Topic: [PATCH v2] media: remove bdisp_dbg_declare() and
 hva_dbg_declare()
Thread-Index: AQHUieNcD7uIlY5JtUWqqeHlup+8a6Vxjt2A
Date: Thu, 6 Dec 2018 11:49:12 +0000
Message-ID: <aa26931d-c4f0-32d2-30d8-65fd4376d3d9@st.com>
References: <20181202020425.9189-1-tiny.windzz@gmail.com>
In-Reply-To: <20181202020425.9189-1-tiny.windzz@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-ID: <5564D1E2BE98B944B64A9343E59EACB0@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_03:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_034930_834053_257DB3E4 
X-CRM114-Status: GOOD (  19.12  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

The patch itself is OK, but the commit talks about bdisp & hva while the 
patch is also for fimc-is.
Could you please update the commit header & messages?

BR

Fabien

On 02/12/2018 3:04 AM, Yangtao Li wrote:
> We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
> bdisp_dbg_declare and hva_dbg_declare,so remove them.Also use
> DEFINE_SHOW_ATTRIBUTE to simplify some code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2:
> -delete fimc_is_debugfs_open
> ---
>   drivers/media/platform/exynos4-is/fimc-is.c   | 16 ++-------
>   .../media/platform/sti/bdisp/bdisp-debug.c    | 34 ++++++------------
>   drivers/media/platform/sti/hva/hva-debugfs.c  | 36 +++++++------------
>   3 files changed, 26 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
> index f5fc54de19da..02da0b06e56a 100644
> --- a/drivers/media/platform/exynos4-is/fimc-is.c
> +++ b/drivers/media/platform/exynos4-is/fimc-is.c
> @@ -738,7 +738,7 @@ int fimc_is_hw_initialize(struct fimc_is *is)
>   	return 0;
>   }
>   
> -static int fimc_is_log_show(struct seq_file *s, void *data)
> +static int fimc_is_show(struct seq_file *s, void *data)
>   {
>   	struct fimc_is *is = s->private;
>   	const u8 *buf = is->memory.vaddr + FIMC_IS_DEBUG_REGION_OFFSET;
> @@ -752,17 +752,7 @@ static int fimc_is_log_show(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -static int fimc_is_debugfs_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, fimc_is_log_show, inode->i_private);
> -}
> -
> -static const struct file_operations fimc_is_debugfs_fops = {
> -	.open		= fimc_is_debugfs_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(fimc_is);
>   
>   static void fimc_is_debugfs_remove(struct fimc_is *is)
>   {
> @@ -777,7 +767,7 @@ static int fimc_is_debugfs_create(struct fimc_is *is)
>   	is->debugfs_entry = debugfs_create_dir("fimc_is", NULL);
>   
>   	dentry = debugfs_create_file("fw_log", S_IRUGO, is->debugfs_entry,
> -				     is, &fimc_is_debugfs_fops);
> +				     is, &fimc_is_fops);
>   	if (!dentry)
>   		fimc_is_debugfs_remove(is);
>   
> diff --git a/drivers/media/platform/sti/bdisp/bdisp-debug.c b/drivers/media/platform/sti/bdisp/bdisp-debug.c
> index c6a4e2de5c0c..77ca7517fa3e 100644
> --- a/drivers/media/platform/sti/bdisp/bdisp-debug.c
> +++ b/drivers/media/platform/sti/bdisp/bdisp-debug.c
> @@ -315,7 +315,7 @@ static void bdisp_dbg_dump_ivmx(struct seq_file *s,
>   	seq_puts(s, "Unknown conversion\n");
>   }
>   
> -static int bdisp_dbg_last_nodes(struct seq_file *s, void *data)
> +static int last_nodes_show(struct seq_file *s, void *data)
>   {
>   	/* Not dumping all fields, focusing on significant ones */
>   	struct bdisp_dev *bdisp = s->private;
> @@ -388,7 +388,7 @@ static int bdisp_dbg_last_nodes(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -static int bdisp_dbg_last_nodes_raw(struct seq_file *s, void *data)
> +static int last_nodes_raw_show(struct seq_file *s, void *data)
>   {
>   	struct bdisp_dev *bdisp = s->private;
>   	struct bdisp_node *node;
> @@ -437,7 +437,7 @@ static const char *bdisp_fmt_to_str(struct bdisp_frame frame)
>   	}
>   }
>   
> -static int bdisp_dbg_last_request(struct seq_file *s, void *data)
> +static int last_request_show(struct seq_file *s, void *data)
>   {
>   	struct bdisp_dev *bdisp = s->private;
>   	struct bdisp_request *request = &bdisp->dbg.copy_request;
> @@ -474,7 +474,7 @@ static int bdisp_dbg_last_request(struct seq_file *s, void *data)
>   
>   #define DUMP(reg) seq_printf(s, #reg " \t0x%08X\n", readl(bdisp->regs + reg))
>   
> -static int bdisp_dbg_regs(struct seq_file *s, void *data)
> +static int regs_show(struct seq_file *s, void *data)
>   {
>   	struct bdisp_dev *bdisp = s->private;
>   	int ret;
> @@ -582,7 +582,7 @@ static int bdisp_dbg_regs(struct seq_file *s, void *data)
>   
>   #define SECOND 1000000
>   
> -static int bdisp_dbg_perf(struct seq_file *s, void *data)
> +static int perf_show(struct seq_file *s, void *data)
>   {
>   	struct bdisp_dev *bdisp = s->private;
>   	struct bdisp_request *request = &bdisp->dbg.copy_request;
> @@ -627,27 +627,15 @@ static int bdisp_dbg_perf(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -#define bdisp_dbg_declare(name) \
> -	static int bdisp_dbg_##name##_open(struct inode *i, struct file *f) \
> -	{ \
> -		return single_open(f, bdisp_dbg_##name, i->i_private); \
> -	} \
> -	static const struct file_operations bdisp_dbg_##name##_fops = { \
> -		.open           = bdisp_dbg_##name##_open, \
> -		.read           = seq_read, \
> -		.llseek         = seq_lseek, \
> -		.release        = single_release, \
> -	}
> -
>   #define bdisp_dbg_create_entry(name) \
>   	debugfs_create_file(#name, S_IRUGO, bdisp->dbg.debugfs_entry, bdisp, \
> -			    &bdisp_dbg_##name##_fops)
> +			    &name##_fops)
>   
> -bdisp_dbg_declare(regs);
> -bdisp_dbg_declare(last_nodes);
> -bdisp_dbg_declare(last_nodes_raw);
> -bdisp_dbg_declare(last_request);
> -bdisp_dbg_declare(perf);
> +DEFINE_SHOW_ATTRIBUTE(regs);
> +DEFINE_SHOW_ATTRIBUTE(last_nodes);
> +DEFINE_SHOW_ATTRIBUTE(last_nodes_raw);
> +DEFINE_SHOW_ATTRIBUTE(last_request);
> +DEFINE_SHOW_ATTRIBUTE(perf);
>   
>   int bdisp_debugfs_create(struct bdisp_dev *bdisp)
>   {
> diff --git a/drivers/media/platform/sti/hva/hva-debugfs.c b/drivers/media/platform/sti/hva/hva-debugfs.c
> index 9f7e8ac875d1..7d12a5b5d914 100644
> --- a/drivers/media/platform/sti/hva/hva-debugfs.c
> +++ b/drivers/media/platform/sti/hva/hva-debugfs.c
> @@ -271,7 +271,7 @@ static void hva_dbg_perf_compute(struct hva_ctx *ctx)
>    * device debug info
>    */
>   
> -static int hva_dbg_device(struct seq_file *s, void *data)
> +static int device_show(struct seq_file *s, void *data)
>   {
>   	struct hva_dev *hva = s->private;
>   
> @@ -281,7 +281,7 @@ static int hva_dbg_device(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -static int hva_dbg_encoders(struct seq_file *s, void *data)
> +static int encoders_show(struct seq_file *s, void *data)
>   {
>   	struct hva_dev *hva = s->private;
>   	unsigned int i = 0;
> @@ -299,7 +299,7 @@ static int hva_dbg_encoders(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -static int hva_dbg_last(struct seq_file *s, void *data)
> +static int last_show(struct seq_file *s, void *data)
>   {
>   	struct hva_dev *hva = s->private;
>   	struct hva_ctx *last_ctx = &hva->dbg.last_ctx;
> @@ -316,7 +316,7 @@ static int hva_dbg_last(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -static int hva_dbg_regs(struct seq_file *s, void *data)
> +static int regs_show(struct seq_file *s, void *data)
>   {
>   	struct hva_dev *hva = s->private;
>   
> @@ -325,26 +325,14 @@ static int hva_dbg_regs(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -#define hva_dbg_declare(name)						  \
> -	static int hva_dbg_##name##_open(struct inode *i, struct file *f) \
> -	{								  \
> -		return single_open(f, hva_dbg_##name, i->i_private);	  \
> -	}								  \
> -	static const struct file_operations hva_dbg_##name##_fops = {	  \
> -		.open		= hva_dbg_##name##_open,		  \
> -		.read		= seq_read,				  \
> -		.llseek		= seq_lseek,				  \
> -		.release	= single_release,			  \
> -	}
> -
>   #define hva_dbg_create_entry(name)					 \
>   	debugfs_create_file(#name, 0444, hva->dbg.debugfs_entry, hva, \
> -			    &hva_dbg_##name##_fops)
> +			    &name##_fops)
>   
> -hva_dbg_declare(device);
> -hva_dbg_declare(encoders);
> -hva_dbg_declare(last);
> -hva_dbg_declare(regs);
> +DEFINE_SHOW_ATTRIBUTE(device);
> +DEFINE_SHOW_ATTRIBUTE(encoders);
> +DEFINE_SHOW_ATTRIBUTE(last);
> +DEFINE_SHOW_ATTRIBUTE(regs);
>   
>   void hva_debugfs_create(struct hva_dev *hva)
>   {
> @@ -380,7 +368,7 @@ void hva_debugfs_remove(struct hva_dev *hva)
>    * context (instance) debug info
>    */
>   
> -static int hva_dbg_ctx(struct seq_file *s, void *data)
> +static int ctx_show(struct seq_file *s, void *data)
>   {
>   	struct hva_ctx *ctx = s->private;
>   
> @@ -392,7 +380,7 @@ static int hva_dbg_ctx(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -hva_dbg_declare(ctx);
> +DEFINE_SHOW_ATTRIBUTE(ctx);
>   
>   void hva_dbg_ctx_create(struct hva_ctx *ctx)
>   {
> @@ -407,7 +395,7 @@ void hva_dbg_ctx_create(struct hva_ctx *ctx)
>   
>   	ctx->dbg.debugfs_entry = debugfs_create_file(name, 0444,
>   						     hva->dbg.debugfs_entry,
> -						     ctx, &hva_dbg_ctx_fops);
> +						     ctx, &ctx_fops);
>   }
>   
>   void hva_dbg_ctx_remove(struct hva_ctx *ctx)
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
