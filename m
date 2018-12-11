Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62682C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:45:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6BB2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UMpX0Xz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6BB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7PJ/+cdKDBgruJEjiBM+S14mZq2zR/4oS55WU+mzy3c=; b=UMpX0Xz7YJi1iu
	BUpj5lHyIII/yAHWv1XB++aGTkK3jLEpVReCBgDoIM3E8+o5Nuj8IYNGrASsLBMzcU8KXkdANUAuE
	fVeZayGZzBatZTT61I7Sz6yC5KYuGGpzu6Ki4HEF0ZI3gxVOF4hPOtUqE0T7gddD0PCHOCdOjISHu
	JgCmY5TsXt8UZVsIbMldKPS+mMdBkQOnhM7DOeLSu6plIJCaGVDnKOjl3ai9giGHbEYwIclYLHZqk
	pG04sRKT5nfbepGHTeOmaTDtMK6x0SrPRcPwPx5txM8/4NYm8Fc3p65dT5FhBmqfpsxLnJPhwjH3u
	iAwvnvGX6MYXSu3z6fOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWfXp-0004St-Jb; Tue, 11 Dec 2018 10:45:41 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWfXm-0004S9-CU
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:45:40 +0000
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 1665ef04eab9dd22; Tue, 11 Dec 2018 11:45:23 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] cpufreq: s3c24xx: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
Date: Tue, 11 Dec 2018 11:45:05 +0100
Message-ID: <1989663.EJsIJGg71O@aspire.rjw.lan>
In-Reply-To: <20181108044503.7zqgi3cjsxnsziuo@vireshk-i7>
References: <20181107161346.9887-1-tiny.windzz@gmail.com>
 <20181108044503.7zqgi3cjsxnsziuo@vireshk-i7>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_024538_586055_1E050D20 
X-CRM114-Status: GOOD (  11.35  )
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
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thursday, November 8, 2018 5:45:03 AM CET Viresh Kumar wrote:
> On 07-11-18, 11:13, Yangtao Li wrote:
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/cpufreq/s3c24xx-cpufreq-debugfs.c | 46 +++--------------------
> >  1 file changed, 6 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> > index 4d976e8dbb2f..0df87b6480fe 100644
> > --- a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> > +++ b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> > @@ -63,18 +63,7 @@ static int board_show(struct seq_file *seq, void *p)
> >  	return 0;
> >  }
> >  
> > -static int fops_board_open(struct inode *inode, struct file *file)
> > -{
> > -	return single_open(file, board_show, NULL);
> > -}
> > -
> > -static const struct file_operations fops_board = {
> > -	.open		= fops_board_open,
> > -	.read		= seq_read,
> > -	.llseek		= seq_lseek,
> > -	.release	= single_release,
> > -	.owner		= THIS_MODULE,
> > -};
> > +DEFINE_SHOW_ATTRIBUTE(board);
> >  
> >  static int info_show(struct seq_file *seq, void *p)
> >  {
> > @@ -105,18 +94,7 @@ static int info_show(struct seq_file *seq, void *p)
> >  	return 0;
> >  }
> >  
> > -static int fops_info_open(struct inode *inode, struct file *file)
> > -{
> > -	return single_open(file, info_show, NULL);
> > -}
> > -
> > -static const struct file_operations fops_info = {
> > -	.open		= fops_info_open,
> > -	.read		= seq_read,
> > -	.llseek		= seq_lseek,
> > -	.release	= single_release,
> > -	.owner		= THIS_MODULE,
> > -};
> > +DEFINE_SHOW_ATTRIBUTE(info);
> >  
> >  static int io_show(struct seq_file *seq, void *p)
> >  {
> > @@ -162,19 +140,7 @@ static int io_show(struct seq_file *seq, void *p)
> >  	return 0;
> >  }
> >  
> > -static int fops_io_open(struct inode *inode, struct file *file)
> > -{
> > -	return single_open(file, io_show, NULL);
> > -}
> > -
> > -static const struct file_operations fops_io = {
> > -	.open		= fops_io_open,
> > -	.read		= seq_read,
> > -	.llseek		= seq_lseek,
> > -	.release	= single_release,
> > -	.owner		= THIS_MODULE,
> > -};
> > -
> > +DEFINE_SHOW_ATTRIBUTE(io);
> >  
> >  static int __init s3c_freq_debugfs_init(void)
> >  {
> > @@ -185,13 +151,13 @@ static int __init s3c_freq_debugfs_init(void)
> >  	}
> >  
> >  	dbgfs_file_io = debugfs_create_file("io-timing", S_IRUGO, dbgfs_root,
> > -					    NULL, &fops_io);
> > +					    NULL, &io_fops);
> >  
> >  	dbgfs_file_info = debugfs_create_file("info", S_IRUGO, dbgfs_root,
> > -					      NULL, &fops_info);
> > +					      NULL, &info_fops);
> >  
> >  	dbgfs_file_board = debugfs_create_file("board", S_IRUGO, dbgfs_root,
> > -					       NULL, &fops_board);
> > +					       NULL, &board_fops);
> >  
> >  	return 0;
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
