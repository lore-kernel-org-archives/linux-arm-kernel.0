Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92416C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0922082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ulPC9YK4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMInVECG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0922082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sr/26/GkofPHeAQk1Q2VQTt6FAnf7cAS/G/ZC8zvugg=; b=ulPC9YK4v1KNEg
	4uADHnVG/TLdOfipJv9bIDsKbqxM9SDPIR7F2MQUvrRFD512b0fZF1UToGAHqfc3d65vQqbwshIKF
	ylWrD6ipJf5ypk2Fn040ah0pYgA7RUfBt2WIeQcrgu1k7WzmNM2LhGRCYQC7+FJyMWcYrnLtkC1wc
	4BFyAwvgPD6y9aFS06cwWmAacQL9fDEYqcK59GobjFJISrK6wcuq1PQbwRdGEPZxJZo52ZG/2WzHj
	2gYAGZVpm9uIGrS6mEa8LJvT50yaNWtkYoF+CXLoGx2Y3gFBf7HdC33mgrh9D5Q7COZ/gICM2fjg+
	5gfWQfCDGKulJlkEPF6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCE3-00028G-Ol; Tue, 04 Dec 2018 15:03:03 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCE0-00026N-Uf
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:03:02 +0000
Received: by mail-it1-x143.google.com with SMTP id p197so14873146itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 07:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qh/wV9x3S3cyWCk64DCI2ErdXYcx2GoynHE7n3HA9aQ=;
 b=aMInVECGXpVp9gtqYLDnvb5BcfP9np8PWQII82Y2aEuBlEa7Sw9CD9gasgHPM4o3Yj
 Vs91GGiObXMwIWB6Pl/mECu47VA1Y0yahyx89r8Qsjp4ZMTEw5dumA9A3M6BtPwbXh6X
 OqmWic6HiYsOu/tnsQFPXrSw7ifFGR5Hk0F98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qh/wV9x3S3cyWCk64DCI2ErdXYcx2GoynHE7n3HA9aQ=;
 b=En3FsO/c/PD/jk8uxQhFs+ALHaMjh+DgwSx9Y8ut3/4Z8GLC3KyS1UGty7bRM0S/NB
 Bs7VzBoE/0+kgPX8S8LsdWsiCKOhDEm6ZUzmd/HeiOz46gD78Cx0VZZXFIBtxzlAb5lc
 5YrNAaVQ92SvP3HjTuJl9wokxW8aNHLB+4gB3bwOfzl5bS0DdnVaG43bUF/8wGRYz9ZX
 LWzq9Xpqivp4fJK77fiXCuFBv3XPjN/dFr7YQNYga7XoVT3wWsLVHcV2QqaCoNY2tdS1
 K7FkGMW8BKfS1hJ6W57WAqwiKhH7ldKwFPCdOuLLEXoOQKyToLE5kMI3A9TzCCjOZ172
 esdA==
X-Gm-Message-State: AA+aEWaCT8Rkbg6o9nlU7o65a7deJlaAjfXnOhJdM1KWsau4sNT4hvs7
 CbEsmoMfxerJLZnq+oaWGYzqN5IiGYvdBF9ai+tfAg==
X-Google-Smtp-Source: AFSGD/UGjYsHviHw8FDYua1w6Q3GuqeTjcmI7HjCOkhpqiEsqtbU7xdmJF1cT5pvgNAEOBQQx6D5KkclXMGInHJUhdw=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr12202685itk.71.1543935769699; 
 Tue, 04 Dec 2018 07:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20181204014323.1438-1-liuyun01@kylinos.cn>
 <20181204150124.GA23762@infradead.org>
In-Reply-To: <20181204150124.GA23762@infradead.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 4 Dec 2018 16:02:36 +0100
Message-ID: <CAKv+Gu-9uWo3xnBdNjJ_FOyuy6ifqdABppRRdxiVm=-p9Bt=EQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] arm64: provide a NEON-accelerated XOR algorithm
 extension
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_070300_989832_159DC5CD 
X-CRM114-Status: UNSURE (   8.23  )
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
Cc: linux-block@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 liuyun01 <liuyun01@kylinos.cn>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 4 Dec 2018 at 16:01, Christoph Hellwig <hch@infradead.org> wrote:
>
> Why does this go to linux-block?

Because xor_blocks() is part of the RAID driver?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
