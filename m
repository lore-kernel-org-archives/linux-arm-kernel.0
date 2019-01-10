Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F539C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:24:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D284620657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FE4ZvVa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D284620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0vmxipzacW+GOGX7nObuBIeJwJLJcjJfxCXsHC2B5Sg=; b=FE4ZvVa4OZJDdq
	4rIIPUZzN4tnLrCREpzb4fgMGw35b6uZZbb3jzpWa+cd4r6lH3/O+oRg5OSNTxW+I05GXTfzDAZjO
	BU6FEqXmW2Sif85QVrztR7s5YYk9Twrlnd339mF11J4W/pTTqpK1wd8zb0O9QzOWd8Cm4Y6e3uczn
	rdbABVVkabXPXzVxNc7w39tdd9UDyh4gpfGqky6uvYlwDD7amgVekQJXDcpvoFW+RBsDvSdzzYObu
	DWNc1ZfCO1Y67Q+KXWW79O05qI1UP+Q5ZWJWDOtDyuXg4zM1KbQVAJGtjOfx8IpCexaiQSIGsQBEt
	ODZcQB9XLzYS2XEyz9FQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghTlp-0001go-0f; Thu, 10 Jan 2019 06:24:49 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghTlm-0001gR-4J; Thu, 10 Jan 2019 06:24:47 +0000
Received: from oxbsltgw61.schlund.de ([212.227.220.199]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MFL8J-1gWkG049Pd-00Fntk; Thu, 10 Jan 2019 07:24:34 +0100
Date: Thu, 10 Jan 2019 07:24:31 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Peter Robinson <pbrobinson@gmail.com>
Message-ID: <2090321804.324042.1547101471247@email.ionos.de>
In-Reply-To: <CALeDE9PPt8yTF1FLioxz0C1kJZDYn1uYH-MoBii2Ewpo-yC3tg@mail.gmail.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <849520506.312349.1546937289972@email.ionos.de>
 <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
 <389675377.186771.1546942833612@email.ionos.de>
 <CALeDE9PPt8yTF1FLioxz0C1kJZDYn1uYH-MoBii2Ewpo-yC3tg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:6TqN9ZCsvSVsq7r4eH05cleNJGCrESoqSaGw+T4xKh1HPl8zfVI
 X3OeaXd/LbuV1jPCq5FD81UZ1IEHgcaPXJrX1AvZTQ0XG+2VQjTEU7ZdKZGDk5/3p8+oFtE
 ukJ/sEI15MRUCh6LvteERVO0z7XJn7C3TfLrnxTd+GBy+XmpN7Y+RR0/H1TZTnqCu5lVYln
 Ouv8jxGrWozBIxCJeU+3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yBYnsDfge+4=:So57UsARunepi65mXkLUgf
 8zLvrHBLZzaipFbirZDJlMfal+1Tp3s7rZtaNMlPyJY3gRLPDm+8WYiEnP6axeUr9vMk3IQpR
 /d4S1R+5gUXlr4Kk9PqwsIGBd3/aIT/Dw36PAnCWaWFvOWGAvZZr5WOSGzPnZOlTzksy40sdM
 qkIQcAAcjuYSYCtHyvRnK+USP29KW59mtMvFxDyOULVa0XiVZ8asWxcFVWi+DRp4OhgMtMXr0
 TFP2yNZNqL7OlFu1/i4wLOW2dhjlyGdgn93i7TEkgI/fkxXg1mOLdcPwrsfObyyjgsvVqGtBu
 53dIw18Rw3Ntdi1pgF5uy0Az9zIucrOonOEfgCv319/xOW3kFZeDYV5J3XG3ZkyQBy2y9+f95
 HljbPui2QDekaaGd7MOsb0tHk/ugPE2O3VzsgLYsHX4JtKxhXgIjFHsIx6xnZ6IxxgZhWYF/i
 UfO5JAUHZexLqw2EN0rHIcy8MSEBZquFTQ3iMpvV/Pjd+tZLdcC29G8UeIH3+/dTwAsp8AW4j
 znU7VRXGyEh7X72z5X5VO5kJk5jdzdE/xWPqYgxrh7F0TjLxaCCdGoCT/Ciza3uyQf4ZwdFmb
 V8NQgwtfG6102rB9Tfx7yGv6cQTM78+fdbBixWg/6pGYWWGtCFz6pAkEtMHT3KibGHSBrl55G
 csHk/JlkSeO3ENhqD7kDDZqwi/R3rJ29y+XzGVD+e8wrikuzhTFE2nQlHhU8TFop1yx39+2ub
 OH4mJ3fjchY82z5nEVy3Jb/z9zl2HndeFNPDc3nE6p9dGr7lWif2oPnD374=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_222446_524326_784DA288 
X-CRM114-Status: UNSURE (   9.96  )
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
Cc: devel@driverdev.osuosl.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 mikebrady@eircom.net, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>, nsaenzjulienne@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Peter Robinson <pbrobinson@gmail.com> hat am 10. Januar 2019 um 06:09 geschrieben:
> 
> 
> Hi Stefan,
> 
...
> 
> I get difference results with 5.0-rc1 but neither of the above apps
> work either, will follow up based on the rest of the thread there.
> 

My first step with Raspbian is to enable the Camera interface which results into an appending of the following lines to config.txt:

start_x=1
gpu_mem=128

AFAIK a smaller value for gpu_mem wont work. Please provide your settings which results in this crash.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
