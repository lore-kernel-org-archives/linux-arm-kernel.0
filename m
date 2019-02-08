Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84054C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:31:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53FC62080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mnWJ/+KB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kF+DA96O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FC62080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q9lxiIRzpDxXkcvkbT5fHvW+CULtcXOswx4m4hXFWVQ=; b=mnWJ/+KBKTq6cf
	vWiMLf5jp0L9VttFEtpG3W3a4//zpIrxfKZXs0N/2qoA4cIjC/xQwFIDuSZ7L8X7DNxjBTSYFsuz8
	Zsh+t6pHNesKbpFPfJDfFV0tvQWRvTHrkFYkcZXSSHfRODuRfK6aGwv5sH4Zp8xC7/04oRSJXKHbk
	P0YHBROuu63+AubknfoGFt/POnC1v4vcUAi8Bfq6OZGkWQ6z+TifB+UrrSiRuVdjSe2mE9EMAD3dR
	V1ekgMk7eZrGdmLvb8WCIySPBzVUDUZq9724jhct81Cf4CjoafhcROA/KHHlYlQw5oStLdM/Zsa8l
	dAkr/ywsDUl6hJ6V8dng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gru4z-00025B-60; Fri, 08 Feb 2019 00:31:41 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gru3a-0008NF-5k
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:30:18 +0000
Received: by mail-qt1-x82c.google.com with SMTP id a48so2142028qtb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RMe7AVsMjh+VkK1x7GiCCnejt907H2ljXbmC15yNzuI=;
 b=kF+DA96OlADNN+EubsYiqoqNkvnBYeSDHZSDiaQmqWpMfp9KPsvdGqSGMnUB7lMdCh
 XyaFyJyor0TFQbZkgK/5f1zdFNoM8UEt1S33/p/VQ3OiXhWgIqB73WbDxf0jXVm5f2BN
 RZ4op8XWlwKd88q+odancnWkE4zrt1Dc0XdkT3x+dY+W7B4n/QWBT8bhqkQXDOYDtrfl
 QhePtXjQ++Wpm4rOzswQCvnsssrQJgQjZdSQDXNIFQzYfKM7gO2gsYQMocWRKv39S/Aa
 WuJyHXfH+6RzFLfZpBJVfnuFEkmztOzWbNWadgbeZOgeYGhFHcgZ3NWtZkAYRIlsDTyg
 ZYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RMe7AVsMjh+VkK1x7GiCCnejt907H2ljXbmC15yNzuI=;
 b=gA8JmQdhvOeYE6JzGHlfUhCdMlfwlOYhxA0mzA4UbAtd3raqqnCpUNqq0fAqcOinmF
 QlntOt+Xmw9SP0OhdffGm23+Hupzh8g7tKqb8pW7LoLK2Y6CunTdsCoJk9907G35WtL3
 rlCb4dh5ZTNP1AVy1GDNittjJi6JFrKMDXrj5az+T0j/JRnBsA3JB9WqXRD1wiMxEV1V
 9R1dTpotAIstylZg/9wZYwEu3N0JGEXMTUJNgmhinl0yYmZvTDVJ52TObiFcpTKwhyg6
 TRM9O226duJaK4EJk0f2eTzzABeh9vyB1QU/ILZhNczHOIGw/O/IlLXqwfIYcVdykyTw
 xdBA==
X-Gm-Message-State: AHQUAuZEq3onpo1tsMxfGXFiVvmU87CxlDLumDwlHyKi5LWzVbHa0U6O
 XHsinnVU2CEIfAS79E7YIQj3Gg==
X-Google-Smtp-Source: AHgI3IYzwOR0xRYy4WWnLHqFOwTXXHOpIy9YHGqmQ6MRjp23/KzxqwEu0PZxYDtVkcajAuwqw8B/kQ==
X-Received: by 2002:ac8:2783:: with SMTP id w3mr14328224qtw.221.1549585811735; 
 Thu, 07 Feb 2019 16:30:11 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id g3sm457393qkc.54.2019.02.07.16.30.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Feb 2019 16:30:11 -0800 (PST)
Subject: Re: CONFIG_KASAN_SW_TAGS=y NULL pointer dereference at
 freelist_dereference()
To: Andrey Konovalov <andreyknvl@google.com>
References: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
 <CAAeHK+yzHbLbFe7mtruEG-br9V-LZRC-n6dkq5+mmvLux0gSbg@mail.gmail.com>
 <89b343eb-16ff-1020-2efc-55ca58fafae7@lca.pw>
 <CAAeHK+zxxk8K3WjGYutmPZr_mX=u7KUcCUYXHi+OgRYMfcvLTg@mail.gmail.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <d8cdc634-0f7d-446e-805a-c5d54e84323a@lca.pw>
Date: Thu, 7 Feb 2019 19:30:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zxxk8K3WjGYutmPZr_mX=u7KUcCUYXHi+OgRYMfcvLTg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_163014_783700_350910F8 
X-CRM114-Status: UNSURE (   9.89  )
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
Cc: kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/7/19 10:34 AM, Andrey Konovalov wrote:
> Reproduced, looks like a conflict with CONFIG_SLAB_FREELIST_HARDENED.
> Could you try the attached patch?
> 

You nailed it!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
