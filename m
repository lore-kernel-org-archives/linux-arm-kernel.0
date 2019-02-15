Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79020C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:45:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F04222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bM++uss5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F04222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1v415s2Ocm6Z5Wf3/mvoG4M4ZxmuVxGsv0LELXMRLpw=; b=bM++uss5XcY8io
	yQuyT1eFl6d6P4xk57QwIZEqvecwapwugsjntUn8MjCkh+ZDnTVt8zNXYOPka0qG0VlPaD4BeVVfE
	r//l6ILj1R7MSZe9UNT/UWNT0skxJ/5XrZyuWY6WfNAq3S5e2Y9dcwv8MvxKzac4e89s4LsXMC9Xt
	aOncALLbP3c3+cE5WCzt81jXUuo8E8NIiD/rIm2XQbPm+e4GF+raTk4bEq2wOT5DOQ7Rvfkxq4t+t
	iun+Dgxob/MzJwMW13r6EPs45mIZriZ+jurw1sQvoGNp35cLRPEABn6nvRzkJEvto+tTxu8fOqOch
	m/53YqUrCW4GrK4q2FFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugbu-0003lE-On; Fri, 15 Feb 2019 16:45:10 +0000
Received: from mail-qk1-f172.google.com ([209.85.222.172])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugbr-0003Or-IT
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:45:08 +0000
Received: by mail-qk1-f172.google.com with SMTP id x9so6082402qkf.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mMszWvS4VQ6/npgfA6tgLTIrt0ch1yFf9gmDrnc6ep8=;
 b=gT4Ai9J5NV11n8in4sNKVhduD6i+c4+jsJ281IGBNOyRr3YqygyR5ct7sBpcVh5fHI
 wHesPX/VtfpRvNuVh9oEG6tShS3yZzs3J6rOY76AaYaxCGs/UAGec3y/wEXLPiZ+pQlh
 xcZW/rrvbExVGKyu5RNj8VyAF6Sloyh3Xe4cddjWEZNQOsth0MWIjs/1UjSK9wdXiEtF
 SjDqwE/3Oc4yOC2stOC1FcvTZIlBRfJadUfqooIYCkhONUHZ1cBvxF7ruCh9VV5tWU5U
 1Wa8JZG4x2FywJDcEQxqxqoh/iSy7AEZpPli27avajgtoFaNj/H+ND0+wAxicc/CD+5F
 aRlA==
X-Gm-Message-State: AHQUAuYTP/yM7lsxT+ZAG/UoNaowL/e552y59EkFtXEWRPw7vSJamQ3n
 O5cXFG1jRIJd5VFtV2zGQgNU3livbzs/AJvW2qU=
X-Google-Smtp-Source: AHgI3IYSqDxpb2Hw6A/YSBqxTcgdFy04MRGywCZn203CLenkVLF+BjK6vFJX6QHTi6V5tpeulwNvTj0cfrDs528V0bg=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7712521qkh.173.1550249106488; 
 Fri, 15 Feb 2019 08:45:06 -0800 (PST)
MIME-Version: 1.0
References: <87lg2q5635.fsf@FE-laptop>
In-Reply-To: <87lg2q5635.fsf@FE-laptop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:44:50 +0100
Message-ID: <CAK8P3a2QLKf-DidBHq-Wm739pROhpmxidac-kN5OcYZo8NY1Xw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mvebu: arm64 for v5.1 (#1)
To: Gregory CLEMENT <gregory.clement@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084507_611182_C69CEEAA 
X-CRM114-Status: UNSURE (   7.91  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 10:21 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
> ----------------------------------------------------------------
> mvebu arm64 for 5.1 (part 1)
>
>  - Add maintainer entry for for the new uDPU board (Armada 3720 based)
>

Pulled into arm/soc, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
