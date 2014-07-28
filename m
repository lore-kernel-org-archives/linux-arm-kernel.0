From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Jul 2014 19:14:56 +0100
Subject: [PATCH 2/2] ARM: LPAE: reduce damage caused by idmap to virtual
 memory layout
In-Reply-To: <20140722153635.25088.14197.stgit@buzz>
References: <20140722153623.25088.37742.stgit@buzz>
 <20140722153635.25088.14197.stgit@buzz>
Message-ID: <20140728181456.GO15536@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 04:36:35PM +0100, Konstantin Khlebnikov wrote:
> idmap layout combines both phisical and virtual addresses.
> Everything works fine if ram physically lays below PAGE_OFFSET.
> Otherwise idmap starts punching huge holes in virtual memory layout.
> It maps ram by 2MiB sections, but when it allocates new pmd page it
> cuts 1GiB at once.
> 
> This patch makes a copy of all affected pmds from init_mm.
> Only few (usually one) 2MiB sections will be lost.
> This is not eliminates problem but makes it 512 times less likely.

I'm struggling to understand your commit message, but making a problem `512
times less likely' does sound like a bit of a hack to me. Can't we fix this
properly instead?

Will
