Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285D9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:06:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC54A207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LviEAtyw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="cEGauRB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC54A207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mOzNA6RIzloTitln/h+HohD6f3M+8yQiMFhqB0J/GXQ=; b=LviEAtyw2dJ+No
	QXCSfDgj7oPZd1MX6ikPNjAYJiesHf98994uSSJzKmMFh2bl4hkSNrHScynZk+l9UhOGeFBjkbe2K
	lFhyFOriu/pgCkLiNMbZUDxgvp0aHr++IX0FiwGUuO6cAZmWhXdDgOR+dSz+ZX7JcRu2fbLRljaRM
	PwkZ7OQNYjRhtkSAPXX8BPO45zMKqkW5qIuikmJ5yDkvE7NjGwYMQ/wb0lCO7wdhiL4IgJzvoEKUg
	iExFCkwrsD5H1h/JuVywnbmfSlAHwdUNyTDZmXmaefI/NAtQthavdom+f2Q8nDJoLissHs4WmTFKq
	zhG4d6WRw5Z2hNrAzWHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwUD-0000DN-S3; Thu, 21 Feb 2019 22:06:33 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwUA-0000Cb-Ti
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:06:32 +0000
Received: by mail-pg1-x541.google.com with SMTP id r124so96512pgr.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 14:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=sNViGJvrXCaoJlnXuiNu2YjSa7SxUCjLL8DEwon24Q8=;
 b=cEGauRB+4YtZAU6hGgs5/nvyC+ld9C327auZPsEhqYsWb3OUPLwPoodFEZWbJ7kMES
 nYKnRpLL4zanjpuV09G5vUdUdCnX2kUxi/72XwRFBJQH8N0E/CypZyAAmWC3Ry7cvGVZ
 f14xvCDLwlHI5IzrU6SCmgL5z7Z/HBhFw4ip1jlAlHylG/h1hxP4htILVAqFZcouCwiF
 +MN/TiMmHhfcVvuPXAt9zRnprl4WhE07f2qS8LY4YxO9EVTlReiaO2jb9MGtJY1xBc+q
 REBP/64Zi354XtXSC3LCVTalcOzBWtW07TU3ZyFQrvWODXWqXzpKse+UY/FI+vbn2iPK
 2zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=sNViGJvrXCaoJlnXuiNu2YjSa7SxUCjLL8DEwon24Q8=;
 b=HXJVLmCIft7En2zBvDYhs460akRNkNn1fAEU4I0/Xz6lZvgLtW8j7JdXCkWTp0x+mo
 kDKt+mxKhAg+H9ypmOdz1lnXwoNu6loZBWBqG6W36zok/CAYHP8Cs9mM0X88DVEPeOld
 igOE6vfx+jXHiC2AuVRby+Z/lZQWhX4E8wyFpSSjgyCCT9pWclkKeJbd2Ui10qeuVz/t
 dm8hyMXI3dz1Cq0QSuX04Owps0kWtkZyUI7JNhCYru+b16u6OBbY/m9f8NL4IYNHcLpg
 2LZZTPohvia2gB6Vfkwd9N9HcwXZX178lKX4Yy81vC6SA7QGACDl9KjWdv0pcQtUc72q
 T6yA==
X-Gm-Message-State: AHQUAuZVPkFY2q68zqqiyp359noMVBaeW9HQ3+BFxlsWDZ6oDA65xCYI
 lm0P1URW9C+ldG/VQtk1yn898A==
X-Google-Smtp-Source: AHgI3IY9PTilcQLs2Ybwg4yTYtSN5TxL+HhrgS9MGVT6NQHrtNXoMUUy8KMBlVZ64S+F1TM5GaoemA==
X-Received: by 2002:a63:ef50:: with SMTP id c16mr711567pgk.3.1550786789525;
 Thu, 21 Feb 2019 14:06:29 -0800 (PST)
Received: from ?IPv6:2600:1010:b016:9155:d0fd:1b5f:8b43:47e6?
 ([2600:1010:b016:9155:d0fd:1b5f:8b43:47e6])
 by smtp.gmail.com with ESMTPSA id q28sm28508pgl.35.2019.02.21.14.06.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 14:06:28 -0800 (PST)
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190221124629.GA12696@fuggles.cambridge.arm.com>
Date: Thu, 21 Feb 2019 14:06:26 -0800
Message-Id: <43ED7513-6A7E-45BC-973A-4EB6DB8E5505@amacapital.net>
References: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <20190221124629.GA12696@fuggles.cambridge.arm.com>
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_140631_029708_54FEB74F 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: dvlasenk@redhat.com, brgerst@gmail.com,
 Julien Thierry <julien.thierry@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 catalin.marinas@arm.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
 valentin.schneider@arm.com, mingo@redhat.com, james.morse@arm.com,
 luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, bp@alien8.de,
 tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org




> On Feb 21, 2019, at 4:46 AM, Will Deacon <will.deacon@arm.com> wrote:
> 
>> On Wed, Feb 20, 2019 at 02:55:59PM -0800, H. Peter Anvin wrote:
>>> On 2/19/19 4:48 AM, Will Deacon wrote:
>>> 
>>> I think you'll still hate this, but could we not disable preemption during
>>> the uaccess-enabled region, re-enabling it on the fault path after we've
>>> toggled uaccess off and disable it again when we return back to the
>>> uaccess-enabled region? Doesn't help with tracing, but it should at least
>>> handle the common case.
>>> 
>> 
>> There is a worse problem with this, I still realize: this would mean blocking
>> preemption across what could possibly be a *very* large copy_from_user(), for
>> example.
> 
> I don't think it's legitimate to call copy_{to,from}_user() inside a
> user_access_{begin,end} region. You'd need to add some unsafe variants,
> which could periodically disable uaccess and call cond_resched() inside
> the loop to avoid the problem you're eluding to.
> 

Definitely not safe. On x86 they do CLAC and everything breaks.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
