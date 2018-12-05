Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38410C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C3E2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pe9y+QeA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffLNTnsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C3E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ob4bS51xNI8z4SjYzkIFq86tlkR4HNsbrdDVCZvWx2U=; b=pe9y+QeAaH0pGP
	W8rEZZDJhMKpsyT2PZr1bbfTkgAAOYdSoNrcoIfmATw8l8DebvR2qcsK2nN2fc8vvaJ4OzK8gbiHE
	17TsVYfLRALzWyvTYIWg2cVvu6xhvgpHBAmIYE2Q41vWxu9BIHjSgzyoOTup++uZtBNJ1jKC8pxVZ
	/Msd5MRwLT324dNqFcACfJ9s8TBkCYJX5g50BJxkUqUlxWGFrS1/W9uojp5z93miUAjqTqU3qdd9M
	folmlkkBi25YB77LqjdX/xh9sOVup/aEIuaJW1l7zCIg0zuAMOLEPc5gv0ZFmoM/2lxuVNPOCy+Nm
	8dMI6KnaVLIdsbkTLO+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaQO-0006Ru-J8; Wed, 05 Dec 2018 16:53:24 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaQL-0006RF-E6
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:53:22 +0000
Received: by mail-wm1-x343.google.com with SMTP id q26so13574452wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mDrCN/Mp0vQAx4fyGKjrwwCQC5eoBvOR+4uuuKjSJ+A=;
 b=ffLNTnsTMQRuUwdl03LvK6WBeP2/nsw4aEuVK4RG1AX117vrIbgePdPTzHpP2rh29Y
 /PFwlPE2GFGuQBwRkD9PpNnKYJ8di43acTlIciXH+ilYp+yMiXHDTPWrK0H5dmc5wCGd
 NM5zXR9PCB+xIFFBpOh3QzVgd6t7HqrzMaTt3i7qt5XQh1TmWpHIVOPvKvKcvIiJTHOf
 MjEMKnBJAKVTdgGAbwOwZJRoblYvOSW5xQHv9ksDVdDIe7UaEzWtaYYPPJDFPPuT/8e0
 R83kTGRXJkxGppy43+8SpVmpMF6Mmi5gapLafSr3yWFHZ2Z3yr5uuBube37IC0RpjfvX
 +xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mDrCN/Mp0vQAx4fyGKjrwwCQC5eoBvOR+4uuuKjSJ+A=;
 b=Cv1nf/wnak5v2Z3l9bfzK1ebO/NH4CyEy5jin+T/SZUVpYMyYOWcWcwITC38M/FxMq
 oQC3TsepmUSyRVikGy/KVn2tqTYlGE7+qCSGyz4GZQ7+o1wzasNHQoiPRXtE44UaBpL3
 s3L/4yZU2rcYqRNminj5l/NQRPndTfZ0WFrEYZuKiXoADs34SAknUGE7ktn79irV5c+4
 3grIEoua/icWVH7Y2p8tpCNiMvhGg/USIrf9SIYpD5frWD/I2QAfGC66qDs4kvXHEta6
 dalsFesqWv8InuG/o9d/mNDGtoZc/Awg+UrSv6d4hxtxwBGC4RtoA7Y76mITHxmV5upa
 saTA==
X-Gm-Message-State: AA+aEWbPVs3b+DgKWEExcmHyTBFQfuth3FmdAR2F2qCNbiRXBilrIEyb
 rT+0ajBKyjKHUyWHaQjK4CFbWtAx
X-Google-Smtp-Source: AFSGD/WFOI49jCEMZag/gz/dvw/Kc2oYBzyx3X+h8Furmn21gj7jrPLIsh/ALP54pPhhYsjD7jUCkQ==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr12681841wmf.17.1544028789287; 
 Wed, 05 Dec 2018 08:53:09 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz.
 [86.49.110.70])
 by smtp.gmail.com with ESMTPSA id d2sm13529666wro.88.2018.12.05.08.53.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 08:53:08 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: dts: renesas: r8a77965: Add CAN controller
 nodes
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20181118173327.4704-1-marek.vasut+renesas@gmail.com>
 <20181118230250.GA2553@kunai>
 <6ffce819-4d8e-e54a-ba82-0845c36a6ec4@gmail.com>
 <CAMuHMdUjONJYypV0a5wnxyBx+sUMHzRwZObQ=d7xFG2ZSCM3Ag@mail.gmail.com>
 <8808d836-2454-4166-fbe0-02849e52792b@gmail.com>
 <CAMuHMdWrNjmCmAuKjp=J2bUhXtXCNbNE2QHyT0df3AYF8ua9JA@mail.gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a685e1ab-4d00-2214-9339-3b57a537f6c2@gmail.com>
Date: Wed, 5 Dec 2018 17:50:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWrNjmCmAuKjp=J2bUhXtXCNbNE2QHyT0df3AYF8ua9JA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_085321_473503_4E7CD4F9 
X-CRM114-Status: GOOD (  20.48  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Takeshi Kihara <takeshi.kihara.df@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/21/2018 08:37 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Wed, Nov 21, 2018 at 12:33 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 11/19/2018 10:00 AM, Geert Uytterhoeven wrote:
>>> On Mon, Nov 19, 2018 at 12:46 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> On 11/19/2018 12:02 AM, Wolfram Sang wrote:
>>>>> On Sun, Nov 18, 2018 at 06:33:26PM +0100, Marek Vasut wrote:
>>>>>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>>>>>
>>>>>> This patch adds CAN{0,1} controller nodes for the R8A77965 SoC.
>>>>>>
>>>>>> Based on several similar patches of the R8A7795 device tree
>>>>>> by Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
>>>>>> and Geert Uytterhoeven <geert+renesas@glider.be>.
>>>>>>
>>>>>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>>>>> Cc: Rob Herring <robh@kernel.org>
>>>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>>>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>
>>>>> Were you able to do some testing using EXIO connectors? Would be nice to
>>>>> know what was tested.
>>>>
>>>> Not on the M3N, since I don't see it broken out on the EXIO ; is it
>>>> really there ? It'd be easy to test on M3NSK with KF, but I don't have
>>>> either KF or M3NSK.
>>>
>>> Please have a look at EXIO Connector D, pins 13/14/15.
>>
>> That's LBSC WE1n/WE0n/CS0n on S-XS . Is there something I obviously
>> don't see ?
> 
> Unless you connect an expansion card to the Ex Memory Connector,
> these signals are free to use, and can be pinmuxed to a CAN function.

Tested-by: Marek Vasut <marek.vasut@gmail.com>

on M3N Salvator-XS with a rats-nest MCP2551 setup on EXIO-D and Peak
CANFD USB.

-- 
Best regards,
Marek Vasut

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
