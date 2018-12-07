Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CFC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:58:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA29420882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ue6RbdPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA29420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y1RKmKIn/XHOMbEJ0xq98uAF3OnwZD/0x/8h5fAg6WQ=; b=Ue6RbdPzhfTpWk
	maBCNXlTPeDyo3U7LYoHmL5loCUERLiQoFUc2m82l16hJcOeuEMbKTxaUAkPAQrBb7qGQGdAF//15
	sHG7CyUZWNf+mu8afaxIZ/QVfNdCyD6oNIOp5sXv/q8Z7S0IFNj9xWmVg5GsHkztbmaaX9cQGljrF
	dI4BXvpZusOUK96Pj6gDbB7ugahaS1I4L6cYuPL8hqYVKrlLYivc9yYwfTHPjqKzg05KVCDqThdEw
	HFQRfyvwvJO2XTjwTeM0Uo/0vGk1udYY0Z9/IZJnPO6XKS7+rckFrBD8FtmaJ70u0ooXjFqqkritP
	aL3PONSfZab9iF+gqsEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVBxo-0003Xq-TW; Fri, 07 Dec 2018 08:58:24 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVBxl-0003TT-6i
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 08:58:22 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id BFBE613F88D;
 Fri,  7 Dec 2018 09:57:48 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
To: Evan Green <evgreen@chromium.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
 <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
 <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
 <a4c0c2e1-09d8-c48f-d434-6147c047c3a8@free.fr>
 <d99567c7-9c1c-6d7e-6dd1-2930b82db7d8@codeaurora.org>
 <0c189977-62dd-3539-3b5c-233773682e69@free.fr>
 <1dbb2f0b-0ad1-e622-a9c4-9ff7284dbee7@codeaurora.org>
 <7a7ccedd-c6b2-6789-c76e-ad2ddcd53e2a@codeaurora.org>
 <6b8898b9-a9cb-8a72-0c73-f8a956cf629e@free.fr>
 <CAE=gft7Pd5u4Axa1XNf+tSYC_awxT8VLNXfJg7820LA1z9RtZg@mail.gmail.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <b1349dd8-ef6f-7506-888a-9204870d040f@free.fr>
Date: Fri, 7 Dec 2018 09:57:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft7Pd5u4Axa1XNf+tSYC_awxT8VLNXfJg7820LA1z9RtZg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_005821_393777_0AD4FB93 
X-CRM114-Status: UNSURE (   9.63  )
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
Cc: Jeffrey Hugo <jhugo@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06/12/2018 17:45, Evan Green wrote:

> I'll throw my random thought into the hopper here. With one particular
> brand of UFS part on SDM845 we needed to make sure we banged on the
> ufs_reset pin before the device would re-initialize fully. My hunch
> says this is not your issue, but it can't hurt to make sure this is
> happening.

First of all, thanks for chiming in. I feel I'm close to making this work.

My UFSHC DT node defines:

			resets = <&gcc GCC_UFS_BCR>;
			reset-names = "rst";

If I'm not mistaken, the uhfhc driver should tickle the reset register?
Is the ufs_reset pin something different?

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
