Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A42C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:10:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B37520656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A8yEAjMW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="G2E7/m8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B37520656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o+GUmklIedpe+d/GC2yDRmal6AqnCdn+7eVshoOMPtA=; b=A8yEAjMWoUxZ/SlTFn7BDFftH
	4vgnWSj0ZyU4g5fBM8TPTbbzI2GNLGDi/miyotdtaExBVVBmxWb0mLKFJZiiDy314ws3JKyZT5epv
	SslcJwPbpPd6fAlNC7fMbtvpquXH11JnGmiPJ+yPuQcpzvEhnxEaGt8MWvv/xXmS8CgUv2ADursZ+
	28CNUGiXLnbC1mIDNetjnmfahbkZedEizpv5jFmKjrkBLdQTR7QtMU1Njck/n0qB5SEYLakI1S5wi
	oIVKRt6/FcbD+zF64q4XQAlnXIbjiIuyQ3CtsyEuTHOFWd7ahjFILW4Hv+K4s6rzTn8YqSbHj+IrN
	Cx8UboLNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjJo4-0001ox-J5; Tue, 15 Jan 2019 08:10:44 +0000
Received: from mout.web.de ([212.227.15.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjJnz-0001oO-Pf
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 08:10:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1547539818;
 bh=MAN108uWwVtVrknyVdr+BAS/PlzEbAMd1qfMTGIUQNo=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=G2E7/m8w5pIBm2NnoRewPyJT5t6rsjNzt5W2Se1ZQyb0wtWb2iDd8WFC3VA3JdCBm
 PmmB7qs/K6UesS+5lU+iGCPZWoMEhprFT/3gq6nzhMXkDjleIFp2d/P1uNshS0IU+V
 TTBS2xuzlivfd2o/QDLIdJ9VurybqqyTMak1bkEQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.57.47]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40na-1habAu28qQ-00rUcg; Tue, 15
 Jan 2019 09:10:18 +0100
Subject: Re: [PATCH] arm64: dts: hikey: Give wifi some time after power-on
From: Jan Kiszka <jan.kiszka@web.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, John Stultz <john.stultz@linaro.org>
References: <6ccac7db-3ab7-e396-90be-8681a8ee336b@web.de>
 <CALAqxLXz_s6B=NzSp17Lj6xMTYybEsMh4jDR8COXnWQCnFTrsw@mail.gmail.com>
 <CAPDyKFrY58-x3SsUwhfrLvf=hayhdjQZJWqUpmegArmnEsWATg@mail.gmail.com>
 <e4977d44-567a-5266-4617-ba62d194a666@web.de>
Message-ID: <0a6e6ca5-3ea0-4f6a-63f1-96187700a4bc@web.de>
Date: Tue, 15 Jan 2019 09:10:14 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <e4977d44-567a-5266-4617-ba62d194a666@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:GRZvb2sTYY1qsOBY///dqqG7dGY9TgXIXWJXQ2yQL8h/9KBeVk7
 zxsgVFEuWoXmUSvYAGDWabjrCoGfaHhJZcEqYr1pkslIOMPm90zbyRupc38E5toF3LuxbWx
 gBJI47IPMGhPy7Jk5c6zZx5+JYv42LljbXfFfLlZM4U3kFiUejRpS1ZnKXBHANFwMNar6c6
 jNGOpuOXjd/4jjqjueZCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J4sACAHsxto=:zqItOS0EA/+dtHCp8IJvz6
 EXXP0g7KnAopIjQmGLgCT7y94/Jr32aF+K6dfKVN0YL9Uzh7s18LyosQeJopb4Zs9KKKhFvR+
 nsc9FP08J372SKm6HeG4pI6V+GmwICpv/Llv5hGfnlj+W3Vn6XM4fl+gz5WXS6firo5PWun+B
 JUDJ/2D2j+Eri6+Dbhh/8r9YNnfKPM/xtoxobwC3fSLSF/vRkHw6WqJqqUmx3SOvlGciYMyBz
 8LNl0WBGfoVPyU/fEVQ0lAm9m+BEiRIIsDuyVUvU0wQzUhxsRqq4ZwmWRyZHCEJv4+oEtiISz
 ofAURnTVo9LtM8tuB9KwJ3zFpRRR8Cz8mxIGfquqzJdjM8FgvJMRiGJTsZHLcdhU6eocoTY/b
 Nn06EfQtl75+j88w9UV2UEsa6iFbr4+QKIuavlGLbna7DxhTSRKn2DZDmLSfKXlP5VMAUEWRe
 C9F390AeCCfrM0/OM7+3NEoB71EKjxlrH5fS+i26sCFmrJb1X5anRJ4iKKT2qJVUfqyKII3HH
 pkwI5ASE1AIi9f1l9MXPVuqbfn6jHqt8wNqstTK0yJrb5mP/L0c0TMGY6o3MyAlAeCNOYA0ly
 aWaFRiN3TH0WFuckVheYjkrl/lUZgu6hMR+qNenyxh8ZfNiv9D0VYHs+b3DFlWGbQZJzaE/cd
 r0GeqleIl2SnU3iF1/eaU8sqYjQ3BRZWTNgZBa32eNb8ARsd7lzPA++SyCNcTc/3l8lp07oSD
 HxLXEFBokd8htSeLtMDsxbtmM/fyKnWpb0hfPzLqLNpDXB7k44iqVtz/5+YoV7vLLxF8RsTWl
 LsmmbPwjclqUSm/9QqA7vaawGBcAZfEuMjWQqAeB9AkL8y/08uTaSyx6Z/022YYoBopq6FNND
 bJlMlmNf7eutRlGzhsDTNo7sC6ATqBDSuk3dX363P9tsjnXeFNRA1XOxgrVPGd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_001040_173620_085DAB4E 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, Ryan Grachek <ryan@edited.us>,
 Tony Lindgren <tony@atomide.com>, Ricardo Salveti <rsalveti@rsalveti.net>,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, KISHON VIJAY ABRAHAM <kishon@ti.com>, "Reizer,
 Eyal" <eyalr@ti.com>, Kalle Valo <kvalo@codeaurora.org>,
 Valentin Schneider <valentin.schneider@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Mishol,
 Guy" <guym@ti.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06.01.19 10:53, Jan Kiszka wrote:
> On 03.01.19 22:32, Ulf Hansson wrote:
>> On Wed, 2 Jan 2019 at 23:21, John Stultz <john.stultz@linaro.org> wrote:
>>>
>>> Adding a few folks to cc from the thread here:
>>> https://patchwork.kernel.org/patch/10734021/
>>>
>>> As this sounds like a very similar issue.
>>> thanks
>>> -john
>>
>> John, thanks for looping me in.
>>
>>>
>>> On Sun, Dec 30, 2018 at 3:38 AM Jan Kiszka <jan.kiszka@web.de> wrote:
>>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Somewhere along recent changes to power control of the wl1835, power-on
>>>> became very unreliable on the hikey, failing like this:
>>>>
>>>> wl1271_sdio: probe of mmc2:0001:1 failed with error -16
>>>> wl1271_sdio: probe of mmc2:0001:2 failed with error -16
>>>>
>>>> After playing with some dt parameters and comparing to other users of
>>>> this chip, it turned out we need some power-on delay to make things
>>>> stable again. In contrast to those other users which define 200 ms, the
>>>> hikey is already very happy with 1 ms.
>>
>> According to the discussions we had so far, this doesn't sound like
>> the correct solution.
>>
>> I am intending to post patch soon, however, I am not sure exactly what
>> solution to pick yet. I will keep you on cc - and of course I
>> appreciate if you could help to test.
>>
> 
> FWIW, the Ultra96 is also affected. Here I worked around it by using a 10 ms 
> power-on delay. The original workaround from the other thread did not help. 
> Looking forward to the proper fix now!
> 

Any news on this regression?

Jan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
