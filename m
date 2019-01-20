Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4DC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 21:41:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8592214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 21:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EqPLax1W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z9aH3/9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8592214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=leJrlUD4lbihRSEuLdaLb7wQAbx724OPTOpo0BgZxOo=; b=EqPLax1WU1qJjN
	8Z7LG6psNtW0WxKsaENT4ouyshpwbn8gLE+JQfIFeZ/nS2sm2Rk0n97MqVYV0SeYv5bnCPCnfaQcE
	5Vg5LlGGNz7kP5bI51MppN/4AdGDGcqCY3wcSuyXlGJ8f/IzTZPUaGICq1bl0NCVlrUyQxZnRDt1U
	FJmcSyZl71olIyViAdqqCB/FTGGL4PrWp/Z1rpv26NC6XgBorIJ1oew40Yg/a/JwlWL8ZH+qpcZdA
	NchCNFsIyD65CQDvlC7PKsrai3SGHrJEpBoAvaZj3A11NDEjjTvzv33ElrKYE1v7IM0YUVx3zsLk2
	OHNXNiDeIiVyDB2Edztw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glKqR-00021b-FS; Sun, 20 Jan 2019 21:41:31 +0000
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glKqK-000211-QU
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 21:41:28 +0000
Received: by mail-yb1-xb42.google.com with SMTP id y7so6414636ybg.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 13:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WAsgi9z+q7Ez6FA/JsmnCOegKj2qaFLDUKqTP2l6SfY=;
 b=Z9aH3/9z2ZhogOUwrGBSYChpJubtstD07OPA0LLnaOxUg6sOj4Wn6iRbCJCpdTL0xI
 uWnraSn8T2+zSj3HgJAsWn6aVc4C5cy0vynF20IRgesIUR7q9KWBOX8IlT10bKB7BK4C
 MaNswRBJPro3BPOiVCDgEOQzQPO435zS912Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WAsgi9z+q7Ez6FA/JsmnCOegKj2qaFLDUKqTP2l6SfY=;
 b=H2vXn0UxoppRNvzcmfh+IP9I3l/ypA2ZkSos9zN5tJOXV/UFRJLbhgB6S/rqJmw65K
 Waa4Q7DKEMTlpbnND+Aqh3uxTzwVShFn31P5QPAGJ+mccLru1KQe4nHLunYUh6EE3C97
 Lho7amhvowjAJ3dcve3JuXbHz8fXaE/m/g9sGYNAoUeL3K1eGmQ2xtxCNQN4Z75UOADH
 xZMLJhXPlLRixTMc7RsdgoRiDnPWacjz8Vv0RD3/jUo/vRqdWjcYLiBQiNg3XkV+F5Xg
 GX5nDHKVq5n2R7kmY5ipoel43oTzPLscOWAq9ycspnW+iiUiQqJOCB4EBi9TbdGCgQwu
 VMIw==
X-Gm-Message-State: AJcUuke8bT5cWfXmqaZUVpX3zcA8YgA/Xew3k97TiNHCmteycNDe8fkp
 F5mcE4WCC7EOEQw8Je4bqJUC0A==
X-Google-Smtp-Source: ALg8bN4Gy4xGAqNdkVkBUJweR9Zd3Y5hKbZnBq08fN08lbOyMXVEDFa+OgdKbKOyWT4ly3O8FtQHpg==
X-Received: by 2002:a25:1446:: with SMTP id 67mr14578436ybu.372.1548020481691; 
 Sun, 20 Jan 2019 13:41:21 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id b144sm7013563ywa.33.2019.01.20.13.41.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Jan 2019 13:41:20 -0800 (PST)
Subject: Re: [PATCH v3 1/8] i2c: iproc: I2C read up to 255 bytes support
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, rjui@broadcom.com
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <1547791464-3540-2-git-send-email-rayagonda.kokatanur@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <e3f402dc-3fa9-4d3c-8fc5-956737c1a3f3@broadcom.com>
Date: Sun, 20 Jan 2019 13:41:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547791464-3540-2-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_134124_874974_5F2C1F4D 
X-CRM114-Status: GOOD (  26.33  )
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
Cc: mark.rutland@arm.com, Shreesha Rajashekar <shreesha@broadcom.com>,
 heikki.krogerus@linux.intel.com, vigneshr@ti.com, ajayg@nvidia.com,
 wsa@the-dreams.de, rayagonoda.kokatanur@braodcom.com, aaron.wu@analog.com,
 pierre-yves.mordret@st.com, kramasub@codeaurora.org, linux-i2c@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, jdelvare@suse.de, f.fainelli@gmail.com,
 eajames@linux.vnet.ibm.com, shreesha.rajashekar@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, geert@linux-m68k.org,
 devicetree@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org,
 ccheng@broadcom.com, andriy.shevchenko@linux.intel.com,
 mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 sbranden@broadcom.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 jarkko.nikula@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/17/2019 10:04 PM, Rayagonda Kokatanur wrote:
> From: Shreesha Rajashekar <shreesha@broadcom.com>
> 
> Add support to allow I2C RX transfer up to 255 bytes.
> 
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
> ---
>  drivers/i2c/busses/i2c-bcm-iproc.c | 98 +++++++++++++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 4c8c3bc4669c..eb7339a0280e 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -80,6 +80,10 @@
>  
>  #define I2C_TIMEOUT_MSEC             50000
>  #define M_TX_RX_FIFO_SIZE            64
> +#define M_RX_FIFO_MAX_THLD_VALUE     (M_TX_RX_FIFO_SIZE - 1)
> +
> +#define M_RX_MAX_READ_LEN            255
> +#define M_RX_FIFO_THLD_VALUE         50
>  
>  enum bus_speed_index {
>  	I2C_SPD_100K = 0,
> @@ -102,17 +106,41 @@ struct bcm_iproc_i2c_dev {
>  
>  	/* bytes that have been transferred */
>  	unsigned int tx_bytes;
> +	/* bytes that have been read */
> +	unsigned int rx_bytes;
> +	unsigned int thld_bytes;
>  };
>  
>  /*
>   * Can be expanded in the future if more interrupt status bits are utilized
>   */
> -#define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT))
> +#define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT)\
> +		| BIT(IS_M_RX_THLD_SHIFT))
> +
> +static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
> +{
> +	struct i2c_msg *msg = iproc_i2c->msg;
> +
> +	/* Read valid data from RX FIFO */
> +	while (iproc_i2c->rx_bytes < msg->len) {
> +		if (!((readl(iproc_i2c->base +
> +		M_FIFO_CTRL_OFFSET) >>
> +		M_FIFO_RX_CNT_SHIFT) &
> +		M_FIFO_RX_CNT_MASK))
> +			break;
> +
> +		msg->buf[iproc_i2c->rx_bytes] =
> +			(readl(iproc_i2c->base + M_RX_OFFSET) >>
> +			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
> +		iproc_i2c->rx_bytes++;
> +	}
> +}
>  
>  static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>  {
>  	struct bcm_iproc_i2c_dev *iproc_i2c = data;
>  	u32 status = readl(iproc_i2c->base + IS_OFFSET);
> +	u32 tmp;
>  
>  	status &= ISR_MASK;
>  
> @@ -136,8 +164,6 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>  
>  			/* mark the last byte */
>  			if (idx == msg->len - 1) {
> -				u32 tmp;
> -
>  				val |= BIT(M_TX_WR_STATUS_SHIFT);
>  
>  				/*
> @@ -156,6 +182,32 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>  		iproc_i2c->tx_bytes += tx_bytes;
>  	}
>  
> +	if (status & BIT(IS_M_RX_THLD_SHIFT)) {
> +		struct i2c_msg *msg = iproc_i2c->msg;
> +		u32 bytes_left;
> +
> +		bcm_iproc_i2c_read_valid_bytes(iproc_i2c);
> +		bytes_left = msg->len - iproc_i2c->rx_bytes;
> +		if (bytes_left == 0) {
> +			/* finished reading all data, disable rx thld event */
> +			tmp = readl(iproc_i2c->base + IE_OFFSET);
> +			tmp &= ~BIT(IS_M_RX_THLD_SHIFT);
> +			writel(tmp, iproc_i2c->base + IE_OFFSET);
> +		} else if (bytes_left < iproc_i2c->thld_bytes) {
> +			/* set bytes left as threshold */
> +			tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +			tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
> +			tmp |= (bytes_left << M_FIFO_RX_THLD_SHIFT);
> +			writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +			iproc_i2c->thld_bytes = bytes_left;
> +		}
> +		/*
> +		 * bytes_left >= iproc_i2c->thld_bytes,
> +		 * hence no need to change the THRESHOLD SET.
> +		 * It will remain as iproc_i2c->thld_bytes itself
> +		 */
> +	}
> +
>  	if (status & BIT(IS_M_START_BUSY_SHIFT)) {
>  		iproc_i2c->xfer_is_done = 1;
>  		complete(&iproc_i2c->done);
> @@ -253,7 +305,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  {
>  	int ret, i;
>  	u8 addr;
> -	u32 val;
> +	u32 val, tmp, val_intr_en;
>  	unsigned int tx_bytes;
>  	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
>  
> @@ -298,7 +350,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	 * transaction is done, i.e., the internal start_busy bit, transitions
>  	 * from 1 to 0.
>  	 */
> -	val = BIT(IE_M_START_BUSY_SHIFT);
> +	val_intr_en = BIT(IE_M_START_BUSY_SHIFT);
>  
>  	/*
>  	 * If TX data size is larger than the TX FIFO, need to enable TX
> @@ -307,9 +359,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	 */
>  	if (!(msg->flags & I2C_M_RD) &&
>  	    msg->len > iproc_i2c->tx_bytes)
> -		val |= BIT(IE_M_TX_UNDERRUN_SHIFT);
> -
> -	writel(val, iproc_i2c->base + IE_OFFSET);
> +		val_intr_en |= BIT(IE_M_TX_UNDERRUN_SHIFT);
>  
>  	/*
>  	 * Now we can activate the transfer. For a read operation, specify the
> @@ -317,11 +367,27 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	 */
>  	val = BIT(M_CMD_START_BUSY_SHIFT);
>  	if (msg->flags & I2C_M_RD) {
> +		iproc_i2c->rx_bytes = 0;
> +		if (msg->len > M_RX_FIFO_MAX_THLD_VALUE)
> +			iproc_i2c->thld_bytes = M_RX_FIFO_THLD_VALUE;
> +		else
> +			iproc_i2c->thld_bytes = msg->len;
> +
> +		/* set threshold value */
> +		tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +		tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
> +		tmp |= iproc_i2c->thld_bytes << M_FIFO_RX_THLD_SHIFT;
> +		writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +
> +		/* enable the RX threshold interrupt */
> +		val_intr_en |= BIT(IE_M_RX_THLD_SHIFT);
> +
>  		val |= (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
>  		       (msg->len << M_CMD_RD_CNT_SHIFT);
>  	} else {
>  		val |= (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
>  	}
> +	writel(val_intr_en, iproc_i2c->base + IE_OFFSET);
>  	writel(val, iproc_i2c->base + M_CMD_OFFSET);
>  
>  	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
> @@ -353,17 +419,6 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  		return ret;
>  	}
>  
> -	/*
> -	 * For a read operation, we now need to load the data from FIFO
> -	 * into the memory buffer
> -	 */
> -	if (msg->flags & I2C_M_RD) {
> -		for (i = 0; i < msg->len; i++) {
> -			msg->buf[i] = (readl(iproc_i2c->base + M_RX_OFFSET) >>
> -				      M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
> -		}
> -	}
> -
>  	return 0;
>  }
>  
> @@ -395,9 +450,8 @@ static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
>  	.functionality = bcm_iproc_i2c_functionality,
>  };
>  
> -static const struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> -	/* need to reserve one byte in the FIFO for the slave address */
> -	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
> +static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> +	.max_read_len = M_RX_MAX_READ_LEN,
>  };
>  
>  static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
> 

Reviewed-by: Ray Jui <ray.jui@broadcom.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
