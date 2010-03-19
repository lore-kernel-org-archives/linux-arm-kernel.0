From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 19 Mar 2010 11:51:02 -0400
Subject: [PATCH 1/5] ASoC: split pxa ssp for reusing code
In-Reply-To: <20100318120907.GH3080@opensource.wolfsonmicro.com>
References: <771cded01003171929t5364eafblf2bd734e2fd1202@mail.gmail.com>
	<20100318120907.GH3080@opensource.wolfsonmicro.com>
Message-ID: <771cded01003190851r9531bf1lca1234deaf33c73d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 8:09 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 17, 2010 at 10:29:46PM -0400, Haojian Zhuang wrote:
>> From ffd197865a1114b46cc7d6b0442e4c6ece962f8b Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Wed, 17 Mar 2010 10:45:30 -0400
>> Subject: [PATCH] ASoC: split pxa ssp for reusing code
>>
>> Since basic SSP features are shared between PXA2xx and PXA168, the difference
>> is focused on clock generating. Now split ssp code into two parts. One is for
>> general ssp feature. The other is for pxa2xx parts.
>
> Could you please provide a more detailed description of what the
> differences between the two SSP implementations. ?This description is
> rather vauge and doesn't appear to 100% tie in with the implemenation -
> for example, the hw_params() implementations for the two variants seem
> *very* close to each other.
>
> It may be that some of this stuff can be handled by having a common
> hw_params() which can be called by device specific code that handles the
> differences. ?Given how fiddly the configuration of the framing is
> having two different implementations to keep in sync doesn't seem good.
>

New comment is added in this patch. In this patch, I didn't touch any
configuration in pxa2xx. I prefer to adjust it
after new ssp control of pxa910 & pxa688 implemented.

Thanks
Haojian
