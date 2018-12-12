Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF3CC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:32:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D9C20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iIBl+QSv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ViogDmAr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="BPoACujm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D9C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AJA1YXMRLshauEtGNQClZY99TgFkFKsQraVAIIbJ9/0=; b=iIBl+QSv7/Ga5q
	m9iyoqKw+yH1MPmvd5v3QR+Vj9e1rgkXoWvMnW0CFbppEgUnUparoghBt2q26GGYxx0FOwvBS6acl
	c7w0EsXbws4lGtBNZR0M8+qHEZu7H0Op1Re0j7FefbXcWXyDgaGto6cwHWC4uDrQ23XkJa0BeL778
	dWpDPhXL+F6Hh3LuyKePPvxi7VCBdqHkN1G5vg9gMER/QbthRaO4goGd2lSdfpuXWaopey3zyGJl4
	rRIw0lsYLX+0Abnu66zB4nbypBXvQzfW4+dHRJs+2aImV/wIBFVwsDrB27MwowwbQ1ynK4lyU5OIf
	6FptceZ85p/leQi9qkaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXD3T-0003PZ-CN; Wed, 12 Dec 2018 22:32:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXD3R-00036U-LQ
 for linux-arm-kernel@bombadil.infradead.org; Wed, 12 Dec 2018 22:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3TPOPLVphELr8ik3XzklvdOBho1jQ0ueiqJCuWDuxF8=; b=ViogDmAr3bnFkztumXYH2MQBS
 IUFnpI1YMccxRGrzyUqAVQgF6fFgz+4NkwXqX20kbl4QgjoSK9TUVQpB9aoyjYipqIcOFC48/t/ye
 vw3i6sbwWVi4REUUx4FptrShVpYhyJj24WfgX35PdKHq8OcQWLvs6rZlctBR374hqN/DUI/u668wL
 HRjKO7fypk919EoJgsylAptkac+XCicHG+9BxvhmLTO6JHohSLbZEoUCGgZpT8BIBa6LdNLhhMLpY
 PLmnMcGaZk+GY47ocNpnoYFD8BQB1t2LWNrlDcwsekhygf7YPV6GKEhiQFit3oIh+1Lr96F50xg+u
 1Ll5KAVyw==;
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCny-0003xD-Su
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:36 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so15476ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3TPOPLVphELr8ik3XzklvdOBho1jQ0ueiqJCuWDuxF8=;
 b=BPoACujmsfQqzNR4DHj8iYobjde9LGXdnRHszYY0uLJ8QKDhezYsth7K6wHBKTFdne
 avyEfO/e/fsU1rIMn6Uq8S6m1hvlpQi+97dEGzwhHUiskqYbcBOOBAHxUZuOgNUfUlpl
 wfDR1xFXg/kRXLMlAcvpjb3TpvoEu4bTXS2b+TPy9EaK526vQpqeXjgZAiHfEpftnZw6
 8GH0ZC07kN4POlAbTMB2e4XjkWKUfb9yZwV7tZ3DRDc0RwczWa1nqBRyUuY2m6Cu+x1h
 Jn95mKiq42YBoo6ni0KnJDovfHPSMkurhDya0SebYP57kpryySQ25Z8qE/3H5g8uh8Rt
 o7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3TPOPLVphELr8ik3XzklvdOBho1jQ0ueiqJCuWDuxF8=;
 b=Ahh0CUwB9+OVZsurpaSoGt4mmu/0hjoYyzs28PisWMCDX59Gw1ym1VcEhG9xCXSUtl
 U2g2ku6x1VK16bXDeDrqqZyITOvBEosrnbxIO7JI5RmD7U+RPNKgwt0zHGpuzdoVdpp0
 WtN+QNafO/PiVXXUei7xXKLbx2v41rFj5+7ZGPCKRdgxytlasan4yRU9Lvyl2kvRctWd
 nGeJCl0pV8g/wxKp1353/iQV0gMUC9/+iVx9MMjt8ZPNv1s05bBJY7ESXFm9gZUUMcaJ
 HUXKXnW4sIgxWWhDo0E0vHpmqeubU0lWBxhxbyAy2/zPtrlQNxHAtuvfJ9SVTjdEEegf
 7Bag==
X-Gm-Message-State: AA+aEWZtnZLYCdQoIntNXPmI3WlHYwlTHxkMwJXMm0T2hiGvKZS5QzzG
 mzOJt9/JgbCRrqZsC+H51XNCCg==
X-Google-Smtp-Source: AFSGD/V+jfOjELXOUGH+rwaqtjni6So7p9LTwGKH4mhK/Te1sCDmraYtjA4TiPVVtHziBbEHksDGNA==
X-Received: by 2002:a2e:880a:: with SMTP id
 x10-v6mr14679506ljh.174.1544652983046; 
 Wed, 12 Dec 2018 14:16:23 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id u79-v6sm2667lje.36.2018.12.12.14.16.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:20 -0800 (PST)
Date: Wed, 12 Dec 2018 13:45:39 -0800
From: Olof Johansson <olof@lixom.net>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [GIT PULL 4/6] memory: tegra: Changes for v4.21-rc1
Message-ID: <20181212214539.yhfphs2k3ysq77fu@localhost>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
 <20181207141739.9085-4-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207141739.9085-4-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_221634_946047_04F08781 
X-CRM114-Status: GOOD (  15.15  )
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
Cc: linux-tegra@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:17:37PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-memory
> 
> for you to fetch changes up to 96e5da7c842424bcf64afe1082b960b42b96190b:
> 
>   memory: tegra: Introduce Tegra20 EMC driver (2018-11-08 12:50:34 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> memory: tegra: Changes for v4.21-rc1
> 
> This contains a single commit that adds support for the EMC driver on
> Tegra20.

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
