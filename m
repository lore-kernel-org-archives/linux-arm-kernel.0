Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5736C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:25:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C2221850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bTkURrLi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tLxWo5EI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C2221850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nbe7iHjPpe88DY9kTFwrv0vB2nY8Nk8LY8U5A6bpn4I=; b=bTkURrLiil5ZFk
	pkvTqhW6ZW9dZHrhClHizRjfLi07w9G24Ju6MNs0oeseyFaDPAzXzSu/1E/LbAZWU+TYcsvCHCPTp
	ccJwDEKrmdpARiLmJP5fLyl1Kjv4zIhYu7TyJBPtv7ZQ4Q5FAbQ6rs0WKXmW68Pbd1/I7xJMk3ZlU
	tV8ygBv5pZ2UwKTQ3VEhl8Vb/mIBLUJ0d5W/MgqX/t5tCYns/mMziM3RmaTgm/cJqdVU7ctUTAKFA
	3lK7cGTRw60vC8nvbHKlKWlMhPKuWXENiUFNl1u+WipZa41bSP8oDv3VlFsIQeOn2f3hGr5Bacu17
	ZrqJ753+q/gnbDZHR55Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDUt-0007j8-Fa; Tue, 18 Dec 2018 11:25:11 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDUq-0006OX-Oy
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:25:10 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181218112457euoutp027f38a152e116b79035887373347f43cb~xaaNe-ml01365113651euoutp02k
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 11:24:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181218112457euoutp027f38a152e116b79035887373347f43cb~xaaNe-ml01365113651euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1545132297;
 bh=Fn2lPujTaFWPaBPTiAGvyln8G1YyYThIpI0wJbDCuyw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=tLxWo5EIDRBqnRDh7xjmvJ7kULVpTJoj2KCdVB7JQspn6cSrNb20oKVsxC1DKLjkp
 5U2fULvdtv/vzGXPGGfScaO6TLSDQjceremlxB/BviKb+fkLRhDtEsC8lMbFqtS4oO
 VbDt+vpvC3YKl7tQZ+7pxgxBzl/bsNFYYvvfK8q4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181218112457eucas1p1591ca5aa0a3e3cdea6268224ca7adbca~xaaNJJ-Ms1106911069eucas1p1N;
 Tue, 18 Dec 2018 11:24:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 2E.E2.04441.809D81C5; Tue, 18
 Dec 2018 11:24:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181218112456eucas1p20bf31d210625499084754ad815be677c~xaaMaXtIb2617226172eucas1p2M;
 Tue, 18 Dec 2018 11:24:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181218112456eusmtrp2dc76df3486418d3280e6832867527508~xaaMLvBx90147001470eusmtrp2I;
 Tue, 18 Dec 2018 11:24:56 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-9b-5c18d9087ef2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.C0.04128.809D81C5; Tue, 18
 Dec 2018 11:24:56 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181218112455eusmtip265670bd80d3afdcde1d5c36ecfb2a929~xaaLshy1A3126131261eusmtip21;
 Tue, 18 Dec 2018 11:24:55 +0000 (GMT)
Subject: Re: [RFC/RFT 09/10] i2c: s3c2410: use core helper to mark adapter
 suspended
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2b73c71b-2b73-7132-3629-cf700b251fdb@samsung.com>
Date: Tue, 18 Dec 2018 12:24:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210210310.12677-10-wsa+renesas@sang-engineering.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7ocNyViDF4ds7R4c3w6k0X/49fM
 FufPb2C32PT4GqtFx98vjBaXd81hs/jce4TRYuvLd0wWM87vY7LoO+fuwOWxaVUnm8fmJfUe
 7/ddZfN4tnA9i8fnTXIBrFFcNimpOZllqUX6dglcGWuOxhfs5au4tOUtUwPjLe4uRk4OCQET
 ieddmxlBbCGBFYwSK5eoQ9hfGCVa1nh2MXIB2Z8ZJSa1NDHBNNxYOIUZIrGcUWLumy/sEB3v
 GSWmT5QFsYUFwiSWHP4JFhcRCJCY8H8hK0gDs8B0Jonmt6vAJrEJGEp0ve1iA7F5BewkDi45
 wApiswioSkxbMBksLioQI/G0YR8LRI2gxMmZT4BsDg5OAXeJCzvtQcLMAvIS29/OYYawxSVu
 PZnPBLJLQuAQu8TshmPsEFe7SGxY94kNwhaWeHV8C1RcRuL/TpiGZkaJ9hmz2CGcHkaJrXN2
 QHVYSxw+fpEVZDOzgKbE+l36EGFHiUezFzCDhCUE+CRuvBWEOIJPYtK26VBhXomONiGIajWJ
 WcfXwa09eOES8wRGpVlIPpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k
 /NxNjMDEdPrf8U87GL9eSjrEKMDBqMTDy3BCPEaINbGsuDL3EKMEB7OSCO+tUokYId6UxMqq
 1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYyBP81FZ6YeLqhZukv5
 Ie/DHd81p3jI28W1z9m4fV56n7tjyLraxcrP8mJFd/w6p3NAcW21cxXPCfcGzg1O0mc3pa5f
 JOj0+JHn48Zlk3e4GL8+4uq49d37W+FpblukAve0mm/f+lOQTeLpvurox1WbMie6h2ronRAP
 uzFpSaLdj4PeipNXW2YqsRRnJBpqMRcVJwIA+moES0gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7ocNyViDF4/Z7Z4c3w6k0X/49fM
 FufPb2C32PT4GqtFx98vjBaXd81hs/jce4TRYuvLd0wWM87vY7LoO+fuwOWxaVUnm8fmJfUe
 7/ddZfN4tnA9i8fnTXIBrFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
 NimpOZllqUX6dgl6GWuOxhfs5au4tOUtUwPjLe4uRk4OCQETiRsLpzB3MXJxCAksZZRo2nmJ
 ESIhI3FyWgMrhC0s8edaFxtE0VtGiTMXIYqEBcIklhz+yQ5iiwj4SRxa9o4ZxGYWmM4kcekH
 H4gtJHCNUWL1XXkQm03AUKLrLcggTg5eATuJg0sOgC1gEVCVmLZgMlCcg0NUIEbi2YJqiBJB
 iZMzn7CAhDkF3CUu7LSHmK4u8WfeJahN8hLb386BssUlbj2ZzzSBUWgWku5ZSFpmIWmZhaRl
 ASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBI3Hbs55YdjF3vgg8xCnAwKvHwMpwQjxFi
 TSwrrsw9xCjBwawkwnurVCJGiDclsbIqtSg/vqg0J7X4EKMp0GsTmaVEk/OBSSKvJN7Q1NDc
 wtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAMj0/27906duHZnxhyLbUfzW4R/
 yGuuWHTq65aIlAkzq+a1b1h3xGDx6zrfrYeljKb1XLjVt33LIdbKxnebdKIfvtyTZbV5pnT3
 dlkvH/PDnjxd1ezsK1RYvmgIzjqwpIbppW3rSctrt0x9oxTuHDiVvOecYu+f/rvbPPZPt/DW
 k3jzmdU7807+bSWW4oxEQy3mouJEAKQ1mpjaAgAA
X-CMS-MailID: 20181218112456eucas1p20bf31d210625499084754ad815be677c
X-Msg-Generator: CA
X-RootMTR: 20181210210451epcas5p2f186c09d2e89f30cdb7106272e5e4709
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181210210451epcas5p2f186c09d2e89f30cdb7106272e5e4709
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <CGME20181210210451epcas5p2f186c09d2e89f30cdb7106272e5e4709@epcas5p2.samsung.com>
 <20181210210310.12677-10-wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_032508_953627_ABA6301F 
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
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2018-12-10 22:03, Wolfram Sang wrote:
> Rejecting transfers should be handled by the core. Also, this will
> ensure proper locking which was forgotten in this open coded version.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Works fine on Odroid U3.

> ---
>  drivers/i2c/busses/i2c-s3c2410.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 2f2e28d60ef5..7c76edb25514 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -104,7 +104,6 @@ enum s3c24xx_i2c_state {
>  struct s3c24xx_i2c {
>  	wait_queue_head_t	wait;
>  	kernel_ulong_t		quirks;
> -	unsigned int		suspended:1;
>  
>  	struct i2c_msg		*msg;
>  	unsigned int		msg_num;
> @@ -703,9 +702,6 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
>  	unsigned long timeout;
>  	int ret;
>  
> -	if (i2c->suspended)
> -		return -EIO;
> -
>  	ret = s3c24xx_i2c_set_master(i2c);
>  	if (ret != 0) {
>  		dev_err(i2c->dev, "cannot get bus (error %d)\n", ret);
> @@ -1246,7 +1242,7 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
>  {
>  	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
>  
> -	i2c->suspended = 1;
> +	i2c_mark_adapter_suspended(&i2c->adap, true);
>  
>  	if (!IS_ERR(i2c->sysreg))
>  		regmap_read(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, &i2c->sys_i2c_cfg);
> @@ -1267,7 +1263,7 @@ static int s3c24xx_i2c_resume_noirq(struct device *dev)
>  		return ret;
>  	s3c24xx_i2c_init(i2c);
>  	clk_disable(i2c->clk);
> -	i2c->suspended = 0;
> +	i2c_mark_adapter_suspended(&i2c->adap, false);
>  
>  	return 0;
>  }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
