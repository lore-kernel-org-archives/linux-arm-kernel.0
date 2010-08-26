From: xiyou.wangcong@gmail.com (=?utf-8?Q?Am=C3=A9rico?= Wang)
Date: Thu, 26 Aug 2010 13:54:17 +0800
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <op.vh01hi2m7p4s8u@localhost>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100826095857.5b821d7f.kamezawa.hiroyu@jp.fujitsu.com>
	<op.vh0wektv7p4s8u@localhost>
	<20100826115017.04f6f707.kamezawa.hiroyu@jp.fujitsu.com>
	<20100826124434.6089630d.kamezawa.hiroyu@jp.fujitsu.com>
	<op.vh01hi2m7p4s8u@localhost>
Message-ID: <20100826055417.GA5157@cr0.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 26, 2010 at 06:01:56AM +0200, Micha? Nazarewicz wrote:
>KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>>128MB...too big ? But it's depend on config.
>
>On embedded systems it may be like half of the RAM.  Or a quarter.  So bigger
>granularity could be desired on some platforms.
>
>>IBM's ppc guys used 16MB section, and recently, a new interface to shrink
>>the number of /sys files are added, maybe usable.
>>
>>Something good with this approach will be you can create "cma" memory
>>before installing driver.
>
>That's how CMA works at the moment.  But if I understand you correctly, what
>you are proposing would allow to reserve memory *at* *runtime* long after system
>has booted.  This would be a nice feature as well though.
>

Yeah, if we can do this, that will avoid rebooting for kdump to reserve
memory.

Thanks.
