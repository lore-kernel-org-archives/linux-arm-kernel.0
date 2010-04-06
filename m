From: minchan.kim@gmail.com (Minchan Kim)
Date: Tue, 6 Apr 2010 13:15:12 +0900
Subject: [PATCH] mm: Check if any page in a pageblock is reserved before
	marking it MIGRATE_RESERVE
In-Reply-To: <1270523356-1728-1-git-send-email-arve@android.com>
References: <20100405101424.GA21207@csn.ul.ie>
	<1270523356-1728-1-git-send-email-arve@android.com>
Message-ID: <k2g28c262361004052115ie21bd036hcbdbdb7750f2942b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 6, 2010 at 12:09 PM, Arve Hj?nnev?g <arve@android.com> wrote:
> This fixes a problem where the first pageblock got marked MIGRATE_RESERVE even
> though it only had a few free pages. This in turn caused no contiguous memory
> to be reserved and frequent kswapd wakeups that emptied the caches to get more
> contiguous memory.

It would be better to add following your description of previous mail thread.
It can help others understand it in future.

On Fri, Apr 02, 2010 at 05:59:00PM -0700, Arve Hj?nnev?g wrote:
...
"I think this happens by default on arm. The kernel starts at offset
0x8000 to leave room for boot parameters, and in recent kernel
versions (>~2.6.26-29) this memory is freed."


-- 
Kind regards,
Minchan Kim
