From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Oct 2011 14:21:43 +0200
Subject: [PATCH 3/3] ARM 4Kstacks: Decrease poll and select stack usage,
	when using 4K stacks
In-Reply-To: <4E9E0CEA.6030102@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com> <4E9E0CEA.6030102@am.sony.com>
Message-ID: <201110201421.43747.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 October 2011, Tim Bird wrote:
> Reduce the max allowed size for struct poll_wqueue to avoid
> using too much stack space in do_select() and do_sys_poll(),
> when the kernel is using 4K stacks.
> 
> Signed-off-by: Tim Bird <tim.bird@am.sony.com>

Can you explain why this is necessary with 4K stacks? I would
expect the poll() function never to be deeply nested, so 1K
used in there doesn't sound too problematic.

	Arnd
