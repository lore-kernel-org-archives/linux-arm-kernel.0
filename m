Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF283C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:41:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988FA2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SesyyCEn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="LWa0+4+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988FA2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A9Vy5Mh2qBt+3TXJ7RfNBnHnfAtylSAPInBupDOM+zY=; b=SesyyCEnv2lkBcBVJmD2Ct8FS
	Huz+vKSqhb/lk/gsaNTZmVI8X3/xtMTonzyvA6eiym6k9Yq6nJBYfCSbZUs7h9rIskCyjc0vE5YVq
	uzNP7RvWxIvrli06cQn5cDeT69KP/71tvjz1XjQg3vNewx/bAcSRJW8/yarplPnvqtx681yMdn8nJ
	GI+do686zq0WV8wDnM4ZB5DN/a0d9334FYIaxFG10g0TXVVs/mPeZAkh96DyBDgpj+13+8PRjZQHB
	FmuTctrYgKm6HW9XFek6w9FjvEIkJtf4UkPl6Yt9EWwEUCywEltB6rvdmrYrDUZ7oDJJwcycgbQQn
	FeR/hwBeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvIxA-0004VC-QW; Sun, 17 Feb 2019 09:41:40 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvIx6-0004UX-PY
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 09:41:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NWDenohgjVPpXw0dAhnvd0a3PuMIuvHxk5FQ1rJpcCg=; b=LWa0+4+jw/k1F1re+/Arwyjpkt
 8Br/H2givwywznq1qrBQ7X21AVGq7h1BY2+peLJUZT6kTCASqWU6wb5DVbl8/aveB47DHB7VjBSwF
 Ow9M9df8yULN4yzoik1W+jG40C0jIeGDhmZnRDlez4zuKMQeBvqw5mezeP9HRb3LFltnm3sAmqZHV
 SElg3ea5pzSetjPkXCj4Z/dIEdZwo7fxCxunG09JEaZZgV7vXM4luvj5SKhDdfFjTE1NbIHt55soK
 3AhYRGzG6rotPyaDnqA/ks2DSobuOE3PtEz3bitW6/rzdlFUxOJm6mAJyI3mCbDfJVlh/sNA9pU4g
 QL8VREnQ==;
Received: from [185.122.190.68] (port=57384 helo=gerda-5.local)
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gvIwu-0006Gr-O3; Sun, 17 Feb 2019 04:41:24 -0500
Subject: Re: [PATCH v4 15/37] irqchip: davinci-aintc: add a new config
 structure
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-16-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <a2b34a20-dd2d-43ff-dd22-4f07f54046be@lechnology.com>
Date: Sun, 17 Feb 2019 10:41:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-16-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_014136_907962_BF429759 
X-CRM114-Status: UNSURE (   8.44  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a config structure that will be used by aintc-based platforms.
> It contains the register range resource, number of interrupts and
> a list of priorities.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
