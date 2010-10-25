From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 25 Oct 2010 11:07:34 +0800
Subject: [PATCH 01/14 v2] ARM: pxa: Introduce pxa[23]xx_map_io
In-Reply-To: <AANLkTi=Rh7HBue1w-i7VodkRw8JJBXhYnOghMLee7hGE@mail.gmail.com>
References: <1286756432-5873-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTi=Rh7HBue1w-i7VodkRw8JJBXhYnOghMLee7hGE@mail.gmail.com>
Message-ID: <AANLkTi=WwOnRFOnga-D=UM1Wa6QD1bR5CKVgTU0n1_4E@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 5:14 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Mon, Oct 11, 2010 at 8:20 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> This patch introduces pxa2xx_map_io() and pxa3xx_map_io() to distinguish between
>> PXA2xx and PXA3xx memory mapping.
>>
>> Also, fixup for platforms broken after introducing pxa2xx_map_io() and
>> pxa3xx_map_io() is included.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> ---
>> v2: Fix spitz.c containing code from patch 02/14. Thanks, Igor.

Finally got some time on this, I've come up with a refined version, the reason
is that pxa25x/pxa27x doesn't share the exact mapping since pxa25x doesn't
have Internal Memory, and that's specific to pxa27x and pxa3xx. Further leads
to pxa{25x,27x,3xx}_map_io() and thus been placed into the specific files.

Please check below and let know if it's OK:
