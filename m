Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B1BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:42:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A58218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TWueoKxQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3As3Hav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A58218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J23h35nlPIuBNuZMSVaEST4AIiUdb0I6zcu0lVwXrYA=; b=TWueoKxQ5xQHXl
	jD7ElQfYmKfhAzc4lHV0WU/cNz9hFSmI4aKaiv99aRrRJmOmatAv8we1fCOSrYAL2U4ao9p3t6oAe
	SA2RLKzecF3zW/MpxFbfaC72+FbReOGa8R28eOWExro2lLU2FkD9L5h3f6nzVqlBR4yQfNyzAO/Ia
	Ev13JiwkkDsLfN3jvH9UFcRp3G7uz+NTYbRtfNikJ7ZrcfG/uLZrRr2q39dGTWI3fP1TYMjQNiflD
	iWSYjISZ/Y+KkxqyborUaBA432rKTqHj+l7N8iH/Q5Wturw7i9C0G8NU4d7LsqVmKCCXZjHdDu+Qt
	a31HHi9V2S8RdOm3N57A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5US-0002Kw-SB; Fri, 25 Jan 2019 17:42:04 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5UQ-0002KY-Ep
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 17:42:03 +0000
Received: by mail-wr1-x444.google.com with SMTP id p7so11239862wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 09:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KB5hRAPY3O95oNsGa06XKA/vJaO61M8l8JOqzf1yAfU=;
 b=G3As3HaviClRz2UHJzmUlc3x05U/S7U4uvea3knWdyPLzs8wk+IStcTO2YtucFwFd/
 cg/twdjSKDm46qBnXy42yKNq30haVO5PvoEp9dGGzzxQVhMcSfeI+bCOYsDcGuWlH6H7
 H4PS4QxMMv6b8xVjgDPHCu5gO9El9Rnw5wGwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KB5hRAPY3O95oNsGa06XKA/vJaO61M8l8JOqzf1yAfU=;
 b=LyhqoqHnL4HVb0gO/HzCMYCMISV6RtQtg7nmcw/PCCrHAAxfOcE4fNAQ0k9gXD/Cxv
 CJbCAwQ69nYhUHL0wE7Ha1dSxZK/bFj+qwYy/0/aUgj1pHJ3GLEGMJGe9bEMofJELA7I
 P1xbAjRQITxcB2Malm62aA6xJ2auenwQQcNMjoiHh1cNXCXPWsTmtQmBqmagGzvORANo
 mV+Aj/13h+Jh2D47Uc99Eaxz/HF/HSVSoA7e8Uyg9QNiRR0ylzq1GKlMc+ME2FfQln85
 Do6e9n0UJ9pbq5LP6jkBGszBt3lePgpJhs3C0HkcZPn7PT3y5fiUg96UrOUyAsgRZQsm
 JIkw==
X-Gm-Message-State: AJcUukdDSyl+07dQT4OvdkD+Y1s89IPCUg9auSYoTz80f4gMrqPAo4QJ
 CgXdKHtf8wW/EgMqT0GtagXlDbN6oWF0BRaI049g2A==
X-Google-Smtp-Source: ALg8bN6Z2dlCm2gFbOWA8Rz+eqROIb4vmS+NSKlqmwCbSqG4hM6TmiSXL/fZ0qgxxQb9Suc4RuDtpc886aQTGwQFrd8=
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr12045757wrs.75.1548438120630; 
 Fri, 25 Jan 2019 09:42:00 -0800 (PST)
MIME-Version: 1.0
References: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
 <107a6e2e-ddd8-cbc1-5680-1b5899665327@arm.com>
In-Reply-To: <107a6e2e-ddd8-cbc1-5680-1b5899665327@arm.com>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 25 Jan 2019 09:41:48 -0800
Message-ID: <CALAqxLW9B6zZi=iQK02QEcAq=xzBiZ-xO-18t2izsKgJstzfmQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_094202_503446_BF638D85 
X-CRM114-Status: GOOD (  13.04  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Ryan Grachek <ryan@edited.us>,
 Alistair Strachan <astrachan@google.com>, Wei Xu <xuwei5@hisilicon.com>,
 lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "stable #4 . 17+" <stable@vger.kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 3:18 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi John,
>
> On 23/01/2019 20:06, John Stultz wrote:
> > From: Alistair Strachan <astrachan@google.com>
> >
> > This reverts commit abd7d0972a192ee653efc7b151a6af69db58f2bb. This
> > change was already partially reverted by John Stultz in commit
> > 9c6d26df1fae ("arm64: dts: hikey: Fix eMMC corruption regression").
> >
> > This change appears to cause controller resets and block read failures
> > which prevents successful booting on some hikey boards.
>
> FWIW, you might want to have a play with the pinctrl settings - I've
> seen various flakiness with HS200 eMMCs on Rockchip boards which could
> be solved by bumping up the drive strength.
>

Hm. Thanks for the tip. I'll have to dig around to see if that can
help. In the meantime though, I think the revert is the right
solution, as this is currently blocking some boards from booting
mainline.  We can then look to re-enable HS200 mode if we can sort out
the issues we saw with boards using hynix mmc chips.

thanks
-john

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
