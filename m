From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 03 Dec 2014 17:12:32 +0530
Subject: [PATCH 3/3] clk: samsung: remove unnecessary inclusion of header
 files from clk.h
In-Reply-To: <547DD98D.3000101@samsung.com>
References: <1411796519-19417-1-git-send-email-pankaj.dubey@samsung.com>
 <1411796519-19417-4-git-send-email-pankaj.dubey@samsung.com>
 <547DD98D.3000101@samsung.com>
Message-ID: <547EF728.90505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Tuesday 02 December 2014 08:53 PM, Sylwester Nawrocki wrote:
> Hi Pankaj,
>
> On 27/09/14 07:41, Pankaj Dubey wrote:
>> Let's remove unnecessary include of header files from clk.h and add
>> required one in clk.c
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   drivers/clk/samsung/clk.c |    3 ++-
>>   drivers/clk/samsung/clk.h |    4 ----
>>   2 files changed, 2 insertions(+), 5 deletions(-)
>>
> Please make sure there is no build breaks with various configs when
> sending patches.

I am sure that I compile tested this before submitting. Looks like 
following commit [1] needs "linux/syscore-ops.h" in clk.c, before that 
it was not needed.

1: clk: samsung: Factor out the common code to clk.c [SHA_ID: 
16a9013b83b5106c83cf]

Anyways, I can see patches are not getting cleanly applied so, just now 
I resend them [2] after rebasing please have a look.

2: http://comments.gmane.org/gmane.linux.kernel.samsung-soc/40639

Thanks,
Pankaj Dubey
>
> --
> Regards,
> Sylwester
>
