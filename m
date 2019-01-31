Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9CFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D509F218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cDx6idd4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF60c/XR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D509F218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:To:References:
	Message-ID:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A0uUf6/pFi8bbqW+T0MIwZROAIqXub8uvj99Y0dXDx4=; b=cDx6idd4W5o2e2
	QZKy8sbpdo4uBd+DP6iHZZj/U+aHNk2SC+VdiFSQI91coctJGE6HQ1rjtEeqAAG4+Olk7Lp8Y6Px3
	YNUn+Wtx0pLXigdQLa1RPmgd7qaJ72ZveQG35FOHeQxxD+6fzGsNZtHLXY5F3hrR8GFqKd+iYTVC8
	FLdBOxFeICejzHfKbI3WJDBMqVX4Aw4Hy8Yqk9oAJ83+tYr4pPxjgHqm5u1VGfeXOAtqkKk98mM26
	GEMUOYClYqUTQqqIkrdneNq/8zqmPrxV0tcaqT1Lq5KAUQrrN2fMEGNCWd2iQKQaEcGQVzyRE93k4
	q+sZb+ZrwxmX9DuXmDhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFFi-0007TB-8y; Thu, 31 Jan 2019 16:31:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFFe-0007Qw-8u
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:31:43 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AC40D20869;
 Thu, 31 Jan 2019 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548952301;
 bh=gpWIdco5o2YJdlELwZUmv5WNqeLBP31go2K7jLLkvUY=;
 h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
 b=RF60c/XRDRGOuo1KgEl0pS6UIk+jRo14nu48G6qpcKAHevWsQDokAnHaSquJ9HGHo
 jAeHA1l2UxAuqzYEPQrMH0kUpFzNTjY96I8Yd17g2P0aP7EFtSeEDTbyWk04oYeSIn
 kJ6iJ5HgmYc56ZPciFnRMcQwpeMNNktZZhj+mImA=
MIME-Version: 1.0
Subject: Re: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier
 (UCI) table
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154895230081.169292.7994428901781990604@swboyd.mtv.corp.google.com>
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
User-Agent: alot/0.8
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Gross <andy.gross@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Doug Anderson <dianders@chromium.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, devicetree@vger.kernel.org
In-Reply-To: <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
Date: Thu, 31 Jan 2019 08:31:40 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_083142_385079_47173F83 
X-CRM114-Status: UNSURE (   9.56  )
X-CRM114-Notice: Please train this message.
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
 Tingwei Zhang <tingwei@codeaurora.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Sai Prakash Ranjan (2019-01-31 06:22:24)
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index e8819d750938..915d86a39cee 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
>         return 0;
>  }
>  
> +static struct amba_cs_uci_id uci_id_debug[] = {

Can this be const?

> +       {
> +               /*  CPU Debug UCI data */
> +               .devarch        = 0x47706a15,
> +               .devarch_mask   = 0xfff0ffff,
> +               .devtype        = 0x00000015,
> +       }
> +};

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
