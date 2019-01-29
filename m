Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B9EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:17:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C7A20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C0l3jub9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C7A20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qYtWM5oPEFsac9WDjNyffemktIkZGwOHNhIitlUnLw8=; b=C0l3jub9Ys3HJa
	2H83r0TZfkBC3Dw80b5V05I17smDaiupBCZI1Oo4ld1hlyy0I0BNvZIaQ/po8eRpVoKEMKlsCVJhs
	ochKma4ZJC1YhvU9dGJaGVMeUg2gxFyPGEMYJJEl76wAgTqeEIDhAK4dTOx24WoH/WiaC+EvbPE6/
	oftK1XLgbhL7t+gPs55MgaGKOFMojtPzPWeMNc+batT8fQZ2hRLLMGehVuZk8vfXPQwwesJRMaDav
	f+l55UTgyr3Z0xYgma63y77wvL4x6mBHiLGrniwfnPy/uWPYkgcKuQdR7yVYGdKCpSa8q/MDcHTqN
	dm2PrbgBK2lBwKcoJSwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPVr-0000WD-6m; Tue, 29 Jan 2019 09:16:59 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPVn-0000VD-4C; Tue, 29 Jan 2019 09:16:57 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id D25E2FB03;
 Tue, 29 Jan 2019 10:16:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gK_4hb_nCtb; Tue, 29 Jan 2019 10:16:51 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 9CEA3435AD; Tue, 29 Jan 2019 10:16:51 +0100 (CET)
Date: Tue, 29 Jan 2019 10:16:51 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] input: goodix - support Goodix gt5688
Message-ID: <20190129091651.GA8497@bogon.m.sigxcpu.org>
References: <20190128170310.GA305@bogon.m.sigxcpu.org>
 <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_011655_325563_0BC4CD2B 
X-CRM114-Status: GOOD (  11.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,
On Mon, Jan 28, 2019 at 07:24:33PM +0100, Bastien Nocera wrote:
> On Mon, 2019-01-28 at 18:03 +0100, Guido G=FCnther wrote:
> > From what I've seen in vendor trees it's fine to treat this as gt1x=B9.
> > =

> > [1]: https://github.com/TadiT7/android_kernel_mtk-4.4/tree/master/drive=
rs/input/touchscreen/mediatek/GT5688
> =

> Can you please point to the exact line of code that makes you say that?
> I'm not saying it's not compatible, but it's not the same driver that
> the current goodix.c was based on, or even goodix.c.
>
> Can you please elaborate?

I basically looked at the registers uses for the config update:

https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/=
touchscreen/mediatek/GT5688/include/gt1x_tpd_common.h#L152
https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/=
touchscreen/mediatek/GT5688/gt1x_generic.c#L430

That and the fact that the driver is doing it's job well made me believe
that's good for base support. Things like hotknot, gesture wakeup and
proximity sensor will need additional work.

> Finding that data in the specs would also be fine:
> https://github.com/hadess/gt9xx/tree/master/specifications

https://github.com/hadess/gt9xx/pull/3

Cheers,
 -- Guido

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
