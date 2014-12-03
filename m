From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 03 Dec 2014 13:04:20 +0100
Subject: [PATCH 3/3] clk: samsung: remove unnecessary inclusion of header
 files from clk.h
In-Reply-To: <547EF728.90505@samsung.com>
References: <1411796519-19417-1-git-send-email-pankaj.dubey@samsung.com>
 <1411796519-19417-4-git-send-email-pankaj.dubey@samsung.com>
 <547DD98D.3000101@samsung.com> <547EF728.90505@samsung.com>
Message-ID: <547EFC44.2030105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/14 12:42, Pankaj Dubey wrote:
> Hi Sylwester,
> 
> On Tuesday 02 December 2014 08:53 PM, Sylwester Nawrocki wrote:
>> Hi Pankaj,
>>
>> On 27/09/14 07:41, Pankaj Dubey wrote:
>>> Let's remove unnecessary include of header files from clk.h and add
>>> required one in clk.c
>>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> ---
>>>   drivers/clk/samsung/clk.c |    3 ++-
>>>   drivers/clk/samsung/clk.h |    4 ----
>>>   2 files changed, 2 insertions(+), 5 deletions(-)
>>>
>> Please make sure there is no build breaks with various configs when
>> sending patches.
> 
> I am sure that I compile tested this before submitting. Looks like 
> following commit [1] needs "linux/syscore-ops.h" in clk.c, before that 
> it was not needed.
> 
> 1: clk: samsung: Factor out the common code to clk.c [SHA_ID: 
> 16a9013b83b5106c83cf]

OK, my apologies then for not investigating it further.

> Anyways, I can see patches are not getting cleanly applied so, just now 
> I resend them [2] after rebasing please have a look.

There is no need to resend, the patches are already applied into
my tree

git://linuxtv.org/snawrocki/samsung.git for-v3.19/clk-next

I will probably send a second pull request for Mike today.
Just need to figure out what to do with the patches addressing
the dependency of the audio clock controller control registers
on the APLL clock.

--
Regards,
Sylwester
