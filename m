From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Feb 2011 10:10:42 -0000
Subject: [PATCHv2] ARM: perf/oprofile: fix off-by-one in stack check
In-Reply-To: <1297223767-12827-1-git-send-email-rabin.vincent@stericsson.com>
References: <001401cbc7a8$f5dee5d0$e19cb170$@deacon@arm.com>
	<1297223767-12827-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <001c01cbc841$9c1d33a0$d4579ae0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

> Since tail is the previous fp - 1, we need to compare the new fp with tail + 1
> to ensure that we don't end up passing in the same tail again, in order to
> avoid a potential infinite loop in the perf interrupt handler (which has been
> observed to occur).  A similar fix seems to be needed in the OProfile code.
> 
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> ---
> v2: refined check as per Will's comment
> 
>  arch/arm/kernel/perf_event.c |    2 +-
>  arch/arm/oprofile/common.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Looks good, thanks.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
