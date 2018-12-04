Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5730C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:27:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 883BB206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K6TqBfsN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLzKMTPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883BB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6+UkaUWGHK5BLXdo9YAvvlxzaB5nnnqMM0f2k1caxIo=; b=K6TqBfsNULWjdO
	LUmO0VjrWN9oGgYm7aqFcjOt6N0c9Z4SYBcWttub3eUuP6JTnhMnqOo7fr2hTatL36tp7cIztngBi
	FpZRfV0K3u6LYW8tekEpCdxKdLu3h79FxyJwiRsduYW2pFroUtSOwdSRIo6DN7c1pz9r80AgNVh9W
	iO/i8crc4+FL3sxoYkwJlO4TQCR2JLm+zFIqdzshDR8ka/kvRY3p1MrR62oqBtk/6dh5MMi18E+1e
	x36pBWt8z3Tn+JwUn+7wojRGo/RdaPKZMvqI47ccSo5YYqVsoDfCOJZVwe+9tojqxe6V2hvOJ9FCN
	3oVdS+v2oXf1wsKG0K8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGLk-0008Mn-NH; Tue, 04 Dec 2018 19:27:16 +0000
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGKQ-0006xf-5h
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:25:56 +0000
Received: by mail-yw1-xc43.google.com with SMTP id d190so7449407ywd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QOg6aNcJr1LQ7jAnnZQn6cnT30WyrQH2omgagch31qU=;
 b=JLzKMTPAxNKMl9OJ0JnfJxdS+jvQrSVktsCKY05zGofV9GRG158An8xO7Y0UoabwTB
 r7/WLg4ZzfmE9nvyGV8S75W7Qd8bwMwLNaSZjkbijleiy3rbXRZ9o7YC+his5iPEIVSh
 bV3QJyeWjCty/0yezB/FW5AYzASB9QL7GKCG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QOg6aNcJr1LQ7jAnnZQn6cnT30WyrQH2omgagch31qU=;
 b=I38/2T9PtHx6GvnBB4uVdtG8qYhyzBtQZZEVphwdhtNCMzeQV4EHW25ypExYq9Cunb
 1xwoc+7OWQtlQIBpqxRGQhxY/+HflK8Sc+EOoKl6W6+9c7XYMlLpS/u+MqkUoiUZgV/S
 0kzlJK++LPClytLsg9L+bXSeBdPNNvL6gEbViMK0Mh4I1giavGm2PVASBW7QFGk+pLPy
 4Mo0hNLD3ifjYsQuRdxONq0zpMgetRxnytOevXCwKvGgZt08l6g5xp39G1h4VlxxmgQG
 Nk/8YlpD1tZlp6HTjop4SKqjgaeQrygfBx2mYVmGuB1nZmQUsZR2tkmEvP6y2fIetvGI
 WqZA==
X-Gm-Message-State: AA+aEWYUeR0T5payqeexAsFnnwXQ+XypzAckFlEmKZNnmDN1QMImsFKq
 KCRvMemAk8mKfaf/Gugw5ZopLsFKLkfPNuLc1j8IJJZc7+4=
X-Google-Smtp-Source: AFSGD/UjJ6NCQDWd3O3Xf2OCzZtaZuSW+MEc2k2UdWTzt2JOjOUqklIBIx0TGuKyKLOCS1dUqf64PARvW45TkV301fA=
X-Received: by 2002:a81:e40b:: with SMTP id r11mr21086209ywl.56.1543951542441; 
 Tue, 04 Dec 2018 11:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20181204191229.6851-1-anders.roxell@linaro.org>
 <20181204141908.76e7afa5@vmware.local.home>
 <20181204142142.4e2e2169@vmware.local.home>
In-Reply-To: <20181204142142.4e2e2169@vmware.local.home>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 4 Dec 2018 20:25:31 +0100
Message-ID: <CADYN=9LNunVkSTzg1fri7Mu7mbu8gFPpgnFfCRQk4T61JXt1_A@mail.gmail.com>
Subject: Re: [PATCH] tracing: add cond_resched to ftrace_replace_code()
To: rostedt@goodmis.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_112554_496577_0E538C73 
X-CRM114-Status: GOOD (  14.40  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 4 Dec 2018 at 20:21, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 4 Dec 2018 14:19:08 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > @@ -2435,6 +2438,13 @@ void __weak ftrace_replace_code(int enable)
> > >                     /* Stop processing */
> > >                     return;
> > >             }
> > > +           /*
> > > +            * Some archs calls this function with interrupts or preemption
> > > +            * disabled. Howeve, other archs don't and this can cause a
>
> typo "However". But could you write it this way:
>
>         "However, for other archs that can preempt, this can cause an
>         tremendous unneeded latency."
>

I'll fix this and move it up (where I added it in the first place but
moved it) =)

Cheers,
Anders

> Thanks!
>
> -- Steve
>
> > > +            * tremendous unneeded latency.
> > > +            */
> >
> > Actually, could you move the comment up where schedulable gets set?
> >
> > Thanks!
> >
> > -- Steve
> >
> > > +           if (schedulable)
> > > +                   cond_resched();
> > >     } while_for_each_ftrace_rec();
> > >  }
> > >
> >
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
