From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Nov 2012 09:53:20 +0000
Subject: [PATCH V4 1/3] of: introduce for_each_matching_node_and_match()
In-Reply-To: <1353453142-4973-1-git-send-email-swarren@wwwdotorg.org>
References: <1353453142-4973-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201211210953.20552.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 November 2012, Stephen Warren wrote:
> However, this results in iterating over table twice; the second time
> inside of_match_node(). The implementation of for_each_matching_node()
> already found the match, so this is redundant. Invent new function
> of_find_matching_node_and_match() and macro
> for_each_matching_node_and_match() to remove the double iteration,
> thus transforming the above code to:
> 
>     for_each_matching_node_and_match(np, table, &match)
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

This look useful, but I wonder if the interface would make more sense if you
make the last argument to the macro a normal pointer, rather than a
pointer-to-pointer. You can take the reference as part of the macro.

	Arnd
