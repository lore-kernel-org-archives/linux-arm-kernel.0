Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:28:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88FA222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BpInb0gz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrvH0y8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88FA222D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FkBcAdab4YMLMEo57G4VgcjBrZ3BJaHjGx5goFxHe2I=; b=BpInb0gzDBLY9R
	GYDoSEYVkfTIYzqgkf9QH9uAqjMHN1JVOBVhsNgZvBU8hwm29ucf4u1L4SWbyhor47quoXQ5x6W1V
	bXlmP0y+/3q1p9mjv+BTziWhRwm9Z58KSRZZvtYuCyhXbPWn1v7XM9ZAlaniT6k/ExGvQRgCfET9h
	2+jSjx+X0cGSBeeURlmFDIRJFsN+kWuQXVBHsDgxfmbFpR8D2fmy4DQTuHYArsGztjzDWvxKjFi6S
	fEmkEsMoT+LH2l89F+6T07cJKHT4retZ7JzTdTigX7PYNP4QM2I5C3TbiRacCt4MePcHP06W4DziI
	Vp1jcX2x2wwT/ZB4fyZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujA5-0003qG-K9; Fri, 15 Feb 2019 19:28:37 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujA2-0003pt-KK
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:28:35 +0000
Received: by mail-it1-x142.google.com with SMTP id l131so25965789ita.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=16BwAubb/CEwkuqEMJJnIJO3EunA1ix3duMQL+2f3lU=;
 b=vrvH0y8CnGZA+tV0X6L3rT1mEM3hnJbKb74e73VtQceln+xtO+nEuVWFNz+6M8w94M
 43OKbKsezU7WxUM2TG7EK8vokj00UG6XsLIH21SwZHvyucRvnG9viI7P8Zlje97csZrn
 Qju78pIFbEWpVlGEMcQ9/naIo+qUBQr0ove2phUWYLLBm3o+4igUVEa9gLGfjPsNacJj
 VMCFlAhgwv/GM5jBDXON8ZL2dLjSbCd1DjlUkPXlxwSb9hBogIb9Ok6v/BwPNrnSlOaH
 1xXOj7DWrn8YXM8x3wKyl4PHWTbspDqHjj0uIanx0OxuTG+1DTLRW0lcv+sbwjlqY8D7
 9b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=16BwAubb/CEwkuqEMJJnIJO3EunA1ix3duMQL+2f3lU=;
 b=i6m+dnwbMY+CbcRBvVU/+0/KzyvkDLw29TWhhJi0rY1xILItJkBYJIS/JY4MKc0CDn
 GBqDh9vTcxoN5ld9pOULMJhAovI41xAyLlEPATwCXDWhoIsds88KBc/uk4nTSivhPtI3
 EOml43hXZIEe0ZQjuEeTQ2lLQv4oTFpgBjTj0bWD9N3/0nq6yTLibtLEhDE7RYpfb9/2
 +rb2zq8uA/4A2x37S05YbyNBNdEH7JCdAhStIS9bKfJ3enQvg41Vs/E0z/vICtgGdL9U
 YzW8Jhd/6aBRfFe3E7m+9Rbpkx/2aXWupnTxhi1Je4P1HxwOZ1zI/mKrm8g7JFOnveFx
 YC+g==
X-Gm-Message-State: AHQUAuZMW9L/8++iR+JfzFnJV/ZBcogypcKY044prbqbbK/hOanehp6D
 a5RxV8sUyfCP9+2vICpkIjsuINTSpcsZgRlc9hjrQA==
X-Google-Smtp-Source: AHgI3IYBKcAfW/QJVhSHH0YYCs8IpDhzCYCUusmu9NDi/3WEs647Eo9ViDhl+Z6uSw1Z6fyDCC5P4LsybC616Hrg4xs=
X-Received: by 2002:a24:c3c4:: with SMTP id s187mr6590904itg.158.1550258913880; 
 Fri, 15 Feb 2019 11:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com>
 <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
In-Reply-To: <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 15 Feb 2019 20:28:23 +0100
Message-ID: <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To: Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_112834_668043_2FCEC483 
X-CRM114-Status: GOOD (  10.24  )
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
Cc: Sandeep Patil <sspatil@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > Provided that we stop sending Clang enablement patches to -stable:
>
> What does that mean?  We're trying to provide clang support back to
> 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).

I understand that is what you are attempting, but that does not mean
it /belongs/ in -stable.

There are rules for stable, and people that track stable kernels (such
as the distros) should be able to rely on us to only backport bug
fixes, not linker script changes and other updates that fix issues
that did not exist when those kernels were released.

It is unclear to me how these clang changes benefit those users.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
