Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0271C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:26:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC5521934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c2MtGWQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC5521934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iFiLvC5l6OD7TodkvMKO8aKG3GnpEW0AtcxMHi5oloM=; b=c2MtGWQOjvk0jBemMjQMBZz+9
	6fUOU0zas6Kqpw9AJY7s4eq5r6kfYigm3zRc+Qm8UQcR9NUGyn6MjXHBnZDELMlOGiHfzWwa15Rp/
	CbYM7sBPNpjuIMK0VnHDSjcdS2t3zz2yGBkbZGpr5+9x+QzUgIdmwNOFcvdwqljpWEMqAGsOpkt9g
	1bJ9iquaCEDyRpqcbD1b/+9xLqcoaMdW4ue60+29Fe7fUvJEw/8XHbF5g/YL6jnmHEkQealIlpvUs
	grKP5rL7rVSuaLD8kttf+xnVGDM4b9dStZaEIaTlz9I6uU8UCsMj5x/o+2dEeKr3s4WsWjJuDCg4e
	JVGFxXpSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guTCR-0000Zu-Vb; Fri, 15 Feb 2019 02:25:59 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guTCO-0000Yk-Gb
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 02:25:58 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 15 Feb 2019 11:25:51 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id BB1F6180B51;
 Fri, 15 Feb 2019 11:25:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Fri, 15 Feb 2019 11:25:51 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 28C961A15B7;
 Fri, 15 Feb 2019 11:25:51 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 0C5EA120459;
 Fri, 15 Feb 2019 11:25:51 +0900 (JST)
Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
To: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org>
 <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
 <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
 <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <feb7c60c-ed9a-1ff0-0871-d9b3fc7a40dc@socionext.com>
Date: Fri, 15 Feb 2019 11:25:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_182556_664312_14CC1611 
X-CRM114-Status: GOOD (  22.52  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Takao Orito <orito.takao@socionext.com>,
 Arnd Bergmann <arnd.bergmann@linaro.org>, linux-soc@vger.kernel.org,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,


On 2019/02/15 0:18, Arnd Bergmann wrote:
> On Thu, Feb 14, 2019 at 3:44 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 13/02/2019 11:34, Sugaya, Taichi wrote:
>>> Hi,
>>>
>>> On 2019/02/12 18:06, Daniel Lezcano wrote:
>>>> On 08/02/2019 13:26, Sugaya Taichi wrote:
>>>>> Add timer driver for Milbeaut SoCs series.
>>>>>
>>>>> The timer has two 32-bit width down counters, one of which is configured
>>>>> as a clockevent device and the other is configured as a clock source.
>>>>>
>>>>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>>>>
>>>> Do want me to take it through my tree?
>>>>
>>>
>>> Yes, please.
>>>
>>> By the way, the patch series includes other sub-system drivers, so
>>> should it be splitted into each driver patch ?
>>
>> Well usually changes are per sub-systems but in case of first submission
>> you may ask linux-soc@ team to take all the patches together with the
>> acked-by tags from those subsystems maintainer.
>>
>> Added in Cc: Arnd@ and linux-soc@
>>
>> I'll wait a bit before applying the patch you clarify this.
> 
> Yes, I think merging them all together is best here.
> 
> I saw the patches fly past but did not do a complete review,
> but if all other review comments are addressed, I'd suggest
> sending the entire series for inclusion to linux-soc@vger.kernel.org
> with the Acked-by/Reviewed-by tags from subsystem maintainers
> added in.
> 
>       Arnd
> 

Thank you for suggestion.
OK. I will send the series to the ML with the Acked-by/Reviewed-by tags.

Thanks,
Sugaya Taichi


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
