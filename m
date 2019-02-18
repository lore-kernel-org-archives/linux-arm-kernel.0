Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB14C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DD52173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OCbpe3Rj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ahd4lZy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DD52173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C7hrYXPRuPKu8ZcGc0Bl9C0bTZpDXrjj5sh6G8I+BBQ=; b=OCbpe3RjT+bBJK
	p8lduyNXAsvezegdUnvg4fvHTt3ZRFtsbRJYhXSryGMm0naTZq9stkd65YXCj3e7WVYu2RrAsXJp9
	hvsae7aWb3vZ4PQKMUiDSBf9pJQidNYbOAERSV4Ehum45wWcEqtT7YnXOo48jJDTcdTAtQQmu9Ea0
	4f33DMg5y44fCEOItZJNueiiPpO0n90massqzET/ih0M1ZsXcEvT4mVgUUbLOq3uB8oRamGDS11cx
	oGGHGxdJ1V9zEDak4OmdE+pleVtaTzCTt3hvl2y6zD1lUy0d43WT4zeHLlCi67djU80gyKmIc0kRX
	8+nGRl6ZeGuoAumTG1jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvk7N-0001bZ-RO; Mon, 18 Feb 2019 14:42:01 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvk7K-0001b9-Q3
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:42:00 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1IEcqk2069955;
 Mon, 18 Feb 2019 14:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Sdh5gxVK+gZ9BiZKjcXGLF0oqJBlvYU82+RTEeFhQbI=;
 b=Ahd4lZy0q/FcjwDQtFqoSSVlNNGS/a1hDOXzgBFA5/NEDg83SrqpF9Cub+QkPv/7O6tC
 czVAiNRzBugQq3h+3ddHSwjtz5fpZRrLnovg7UOVVCMrZcSYxVLZWOJbUZcWfYh6feuB
 Y0ecjO/SuJ5mEjo5cCVBHbWb1IPfRaxSxz4g7ZVGDrF1gMGN7UxDa0/EKKgJl5Z+//fC
 70oTA51om3o6/DOO6zp753sfryqWfUaZeRgWceVHLIM5+4aEFcl+rNnpjEtyVVtlXDXz
 MOENaE635GF8GSjxkIUd00pfcgiiYdChGsahXtzn+AE4mSpBJ1AyZ5ggZkJ9rzjPR9fl rg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2120.oracle.com with ESMTP id 2qpb5r6fj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Feb 2019 14:41:45 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1IEfi6e030462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Feb 2019 14:41:44 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1IEfiY0022006;
 Mon, 18 Feb 2019 14:41:44 GMT
Received: from kadam (/197.157.0.22) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 18 Feb 2019 06:41:43 -0800
Date: Mon, 18 Feb 2019 17:41:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: stm32: sai: remove set but not used
 variables 'mask, cr1'
Message-ID: <20190218144133.GF17104@kadam>
References: <20190218134836.107220-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218134836.107220-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_064158_927627_75D82595 
X-CRM114-Status: GOOD (  20.23  )
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
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 01:48:36PM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_configure_clock':
> sound/soc/stm/stm32_sai_sub.c:902:11: warning:
>  variable 'mask' set but not used [-Wunused-but-set-variable]
> sound/soc/stm/stm32_sai_sub.c:902:6: warning:
>  variable 'cr1' set but not used [-Wunused-but-set-variable]
> 
> It's not used any more after 8307b2afd386 ("ASoC: stm32: sai: set sai as
> mclk clock provider")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/stm/stm32_sai_sub.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index d4825700b63f..a00640f1df06 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -898,7 +898,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
>  				     struct snd_pcm_hw_params *params)
>  {
>  	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
> -	int cr1, mask, div = 0;
> +	int div = 0;
>  	int sai_clk_rate, mclk_ratio, den;
>  	unsigned int rate = params_rate(params);
>  
> @@ -944,8 +944,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
>  			if (sai->mclk_rate) {
>  				mclk_ratio = sai->mclk_rate / rate;
>  				if (mclk_ratio == 512) {
> -					mask = SAI_XCR1_OSR;
> -					cr1 = SAI_XCR1_OSR;
> +					;
>  				} else if (mclk_ratio != 256) {


Please, no...

				if (mclk_ratio != 512 && mclk_ratio != 256) {
					dev_err(...

regards,
dan carpenter


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
