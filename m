From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 7 Sep 2010 14:45:29 +0800
Subject: [PATCH] ARM: pxa: Enable U2D only in case PXA3xx is enabled
In-Reply-To: <4C85DB2B.6020407@compulab.co.il>
References: <1283806389-18128-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTintMS3-+tj5JoBoF4o+7WY9E4gZh3_szNsnNyS6@mail.gmail.com>
	<4C85D40C.5090209@compulab.co.il>
	<AANLkTikfJ+pcY4aQMhGE7FpGapyGeXauGAqW8cUiXB82@mail.gmail.com>
	<4C85DB2B.6020407@compulab.co.il>
Message-ID: <AANLkTi=azT7tU2Fznn3X1TXKFg9GoCUJAmhckaF_U=Hz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 7, 2010 at 2:26 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> ?On 09/07/10 09:11, Eric Miao wrote:
>> On Tue, Sep 7, 2010 at 1:56 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>> ?On 09/07/10 05:26, Eric Miao wrote:
>>>> On Tue, Sep 7, 2010 at 4:53 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>> In case PXA3xx support isn't enabled in kernel, the pxa3xx_u2d_start_hc()
>>>>> and pxa3xx_u2d_stop_hc() functions are undefined. Encapsulate their callings
>>>>> with #ifdef CONFIG_PXA3xx macro.
>>>>>
>>>> This isn't necessary. cpu_is_pxa3xx() will expand to zero if CONFIG_PXA3xx
>>>> isn't defined, and the whole if () statement will be optimized away by the
>>>> compiler.
>>> That was my intention, but I haven't checked if it really does the job.
>> It didn't. But I proposed a fix hours ago and it seemed to work. Tested
>> by Marek.
>
> Oh.. now I see this:
> [PATCH] pxa: fix cpu_is_pxa*() not expanded to zero when not configured
>
> This only fixes the problem for cpu's other then pxa3xx,
> we still need one of the proposed fixes for pxa3xx based boards,
> that don't use U2DC, right?

Exactly right.
