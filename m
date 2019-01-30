Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42BEC282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:02:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEEB20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QbZkFOiS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbVdWpwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEEB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bS02H2QWdOwqupep5I/OUYFBuob7gArw78hWgg9wQwo=; b=QbZkFOiScEHdTkzA36IbRYsUn
	/++X7j4ZIq3Uxq7VxLe9PmYCX23Bbt1uByHOyfn/NPCGgbJFihZVxJ/k1Ul2K37YCP0qYrzablCss
	crDkyfzXMA/n7fZAxe+nHIGt+Hrm9B/up6KE8zrtg0wMhWaWfpBqGE3erSVe9R+4P5GcD3zGERQ0L
	E1dCjutQusOZUFYpO9N9PkvixLycqO6smT1pUckQrD+0kK727WjHbyq9+klG2M338bODvdLw4hcJD
	gOZ8yuj9pX6S7PGj91AsXP6XrfgY44MGBHsdwve5roATPm2GsCP78CVTRFZA7y7DynR6nojhZaoUF
	f5CsLj40Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goiwe-0004df-TU; Wed, 30 Jan 2019 06:01:56 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goiwa-0004cX-RK
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 06:01:54 +0000
Received: by mail-pf1-x443.google.com with SMTP id c123so10945620pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 22:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=samU8fo3ywPoP/rVSLYa27WCE33+YfoN0anBeV5TrXk=;
 b=PbVdWpwHE3dY1giHuc1367CPou6B4V9bcHnMGB5PC6+FUnim8Zsum4A2ugPeQE6NOI
 niApwQDnyQ/eblojQI+8r7eYxUwgUs3yxobW1RZPHqT3xNGHxeM9cQnf2p1EsosV48AT
 hq8IdIdA6kqKbfXfzR/PGjw2qnLg6osx8CExw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=samU8fo3ywPoP/rVSLYa27WCE33+YfoN0anBeV5TrXk=;
 b=D3lXrq8+usiKM7YEnbUX64KuFq918p3MiXRa6AyqlJa4Qye8xrkCS0c0D5jrlDxUrd
 NQmwpNrL2hd2hB83MItabrcLyKZTBJEXBx7AwWLXZS0cm3N4k+v6wYd6hKUT+MVa+ep8
 msBs7Np48Bx48u3eV7N+4w7H1v8T2eCoKhPJ7DYyJJ+tYsCErJbT89L9rAairlHQgWhU
 6WEbiYONcvk9E0wc65tWV+0tnsa4JBSSO/M89NzFAReyVgM5wnmnlD7I4apVV0i3WEbm
 IGnHS69bBhP7hvMwu/zkbJ08I5SbkV0dM7KTNkY51/eECGIcHApCYVGxWrzMPd5z08UQ
 uT0A==
X-Gm-Message-State: AJcUukcyl7i49P7UUssMG8SvcjoU36ECuRrEJnXsB+FFTXtVq1tKDRuE
 ATP4p561EhB+HOt8uJ0IHjIyGw==
X-Google-Smtp-Source: ALg8bN64u60hq7uAhVMUaSksQqc+0PWXigb1KiFbWJyB4TXoKnC8/S/ucn5WDpCFFg6GBbRre4Ozvw==
X-Received: by 2002:a63:1560:: with SMTP id 32mr25849129pgv.383.1548828111978; 
 Tue, 29 Jan 2019 22:01:51 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.gmail.com with ESMTPSA id t21sm560643pgg.24.2019.01.29.22.01.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 22:01:51 -0800 (PST)
Subject: Re: [PATCH 08/10] soc: mediatek: add packet encoder function
To: Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 CK HU <ck.hu@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-9-git-send-email-bibby.hsieh@mediatek.com>
From: Pi-Hsun Shih <pihsun@chromium.org>
Message-ID: <c1aba25b-5d8c-b79a-36b3-3d6217a5aa6b@chromium.org>
Date: Wed, 30 Jan 2019 14:01:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548747128-60136-9-git-send-email-bibby.hsieh@mediatek.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_220152_887310_B1E13DD4 
X-CRM114-Status: GOOD (  25.79  )
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
Cc: devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
 Sascha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com,
 Daoyuan Huang <daoyuan.huang@mediatek.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Houlong Wei <houlong.wei@mediatek.com>,
 Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>, kendrick.hsu@mediatek.com,
 linux-mediatek@lists.infradead.org, ginny.chen@mediatek.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
 Frederic Chen <Frederic.Chen@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/29/2019 03:32 PM, Bibby Hsieh wrote:
> Implement a function can encode the GCE instructions
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c   | 102 ++++++++++++++++++++-----------
>   include/linux/mailbox/mtk-cmdq-mailbox.h |   2 +
>   include/linux/soc/mediatek/mtk-cmdq.h    |  14 ++---
>   3 files changed, 76 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 16c0393..923a815 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -9,11 +9,43 @@
>   #include <linux/mailbox_controller.h>
>   #include <linux/soc/mediatek/mtk-cmdq.h>
>   
> -#define CMDQ_ARG_A_WRITE_MASK	0xffff
> +#define CMDQ_GET_ARG_B(arg)	(((arg) & GENMASK(31, 16)) >> 16)
> +#define CMDQ_GET_ARG_C(arg)	((arg) & GENMASK(15, 0))
>   #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
>   #define CMDQ_EOC_IRQ_EN		BIT(0)
>   #define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
>   				<< 32 | CMDQ_EOC_IRQ_EN)
> +#define CMDQ_IMMEDIATE_VALUE	0
> +#define CMDQ_REG_TYPE		1
> +
> +struct cmdq_instruction {
> +	s16 arg_c:16;
> +	s16 arg_b:16;
> +	s16 arg_a:16;
> +	u8 s_op:5;
> +	u8 arg_c_type:1;
> +	u8 arg_b_type:1;
> +	u8 arg_a_type:1;
> +	u8 op:8;
> +};
> +
> +static void cmdq_pkt_instr_encoder(struct cmdq_pkt *pkt, s16 arg_c, s16 arg_b,
> +				   s16 arg_a, u8 s_op, u8 arg_c_type,
> +				   u8 arg_b_type, u8 arg_a_type, u8 op)
> +{
> +	struct cmdq_instruction *cmdq_inst;
> +
> +	cmdq_inst = pkt->va_base + pkt->cmd_buf_size;
> +	cmdq_inst->op = op;
> +	cmdq_inst->arg_a_type = arg_a_type;
> +	cmdq_inst->arg_b_type = arg_b_type;
> +	cmdq_inst->arg_c_type = arg_c_type;
> +	cmdq_inst->s_op = s_op;
> +	cmdq_inst->arg_a = arg_a;
> +	cmdq_inst->arg_b = arg_b;
> +	cmdq_inst->arg_c = arg_c;
> +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> +}
>   
>   u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base)
>   {
> @@ -180,10 +212,11 @@ void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
>   }
>   EXPORT_SYMBOL(cmdq_pkt_destroy);
>   
> -static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> -				   u32 arg_a, u32 arg_b)
> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, s16 arg_c, s16 arg_b,
> +				   s16 arg_a, u8 s_op, u8 arg_c_type,
> +				   u8 arg_b_type, u8 arg_a_type,
> +				   enum cmdq_code code)
>   {
> -	u64 *cmd_ptr;
>   
>   	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
>   		/*
> @@ -199,65 +232,59 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
>   			__func__, (u32)pkt->buf_size);
>   		return -ENOMEM;
>   	}
> -	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> -	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> -	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> +	cmdq_pkt_instr_encoder(pkt, arg_c, arg_b, arg_a, s_op, arg_c_type,
> +			       arg_b_type, arg_a_type, code);
>   
>   	return 0;
>   }
>   
> -int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
>   {
> -	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
> -		    (subsys << CMDQ_SUBSYS_SHIFT);
> -
> -	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
> +	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(value),
> +				       CMDQ_GET_ARG_B(value), offset, subsys,
> +				       CMDQ_IMMEDIATE_VALUE,
> +				       CMDQ_IMMEDIATE_VALUE,
> +				       CMDQ_IMMEDIATE_VALUE, CMDQ_CODE_WRITE);

All other codes use 0 instead of CMDQ_IMMEDIATE_VALUE. Also use 0 here
or use CMDQ_IMMEDIATE_VALUE at other places too?

>   }
>   EXPORT_SYMBOL(cmdq_pkt_write);
>   
> -int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> -			u32 subsys, u32 offset, u32 mask)
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
> +			u32 value, u32 mask)
>   {
>   	u32 offset_mask = offset;
>   	int err = 0;
>   
>   	if (mask != 0xffffffff) {
> -		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
> +		err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(~mask),
> +					      CMDQ_GET_ARG_B(~mask), 0, 0, 0, 0,
> +					      0, CMDQ_CODE_MASK);
>   		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
>   	}
> -	err |= cmdq_pkt_write(pkt, value, subsys, offset_mask);
> +	err |= cmdq_pkt_write(pkt, subsys, offset_mask, value);

I know that the code was already that way before, but why do you or
the 2 return values, instead of just returning early if
cmdq_pkt_append_command fails?

>   
>   	return err;
>   }
>   EXPORT_SYMBOL(cmdq_pkt_write_mask);
>   
> -int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
>   {
> -	u32 arg_b;
> -
>   	if (event >= CMDQ_MAX_EVENT)
>   		return -EINVAL;
>   
> -	/*
> -	 * WFE arg_b
> -	 * bit 0-11: wait value
> -	 * bit 15: 1 - wait, 0 - no wait
> -	 * bit 16-27: update value
> -	 * bit 31: 1 - update, 0 - no update
> -	 */
> -	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> -
> -	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
> +	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_WFE_OPTION),
> +				       CMDQ_GET_ARG_B(CMDQ_WFE_OPTION), event,
> +				       0, 0, 0, 0, CMDQ_CODE_WFE);
>   }
>   EXPORT_SYMBOL(cmdq_pkt_wfe);
>   
> -int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
>   {
>   	if (event >= CMDQ_MAX_EVENT)
>   		return -EINVAL;
>   
> -	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
> -				       CMDQ_WFE_UPDATE);
> +	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_WFE_UPDATE),
> +				       CMDQ_GET_ARG_B(CMDQ_WFE_UPDATE), event,
> +				       0, 0, 0, 0, CMDQ_CODE_WFE);
>   }
>   EXPORT_SYMBOL(cmdq_pkt_clear_event);
>   
> @@ -266,10 +293,15 @@ static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   	int err;
>   
>   	/* insert EOC and generate IRQ for each command iteration */
> -	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> -
> +	err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_EOC_IRQ_EN),
> +				      CMDQ_GET_ARG_B(CMDQ_EOC_IRQ_EN),
> +				      0, 0, 0, 0, 0, CMDQ_CODE_EOC);
> +	if (err < 0)
> +		return err;
>   	/* JUMP to end */
> -	err |= cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> +	err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_JUMP_PASS),
> +				      CMDQ_GET_ARG_B(CMDQ_JUMP_PASS),
> +				      0, 0, 0, 0, 0, CMDQ_CODE_JUMP);
>   
>   	return err;
>   }
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index 911475da..f21801d 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -19,6 +19,8 @@
>   #define CMDQ_WFE_UPDATE			BIT(31)
>   #define CMDQ_WFE_WAIT			BIT(15)
>   #define CMDQ_WFE_WAIT_VALUE		0x1
> +#define CMDQ_WFE_OPTION                 (CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | \
> +					CMDQ_WFE_WAIT_VALUE)
>   /** cmdq event maximum */
>   #define CMDQ_MAX_EVENT			0x3ff
>   
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index e5b0a98..e4d1876 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -70,26 +70,26 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
>   /**
>    * cmdq_pkt_write() - append write command to the CMDQ packet
>    * @pkt:	the CMDQ packet
> - * @value:	the specified target register value
>    * @subsys:	the CMDQ sub system code
>    * @offset:	register offset from CMDQ sub system
> + * @value:	the specified target register value
>    *
>    * Return: 0 for success; else the error code is returned
>    */
> -int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset);
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value);
>   
>   /**
>    * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
>    * @pkt:	the CMDQ packet
> - * @value:	the specified target register value
>    * @subsys:	the CMDQ sub system code
>    * @offset:	register offset from CMDQ sub system
> + * @value:	the specified target register value
>    * @mask:	the specified target register mask
>    *
>    * Return: 0 for success; else the error code is returned
>    */
> -int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> -			u32 subsys, u32 offset, u32 mask);
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
> +			u32 value, u32 mask);
>   
>   /**
>    * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
> @@ -98,7 +98,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
>    *
>    * Return: 0 for success; else the error code is returned
>    */
> -int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
>   
>   /**
>    * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
> @@ -107,7 +107,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
>    *
>    * Return: 0 for success; else the error code is returned
>    */
> -int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event);
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
>   
>   /**
>    * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
