From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 21 Nov 2012 10:06:16 +0000
Subject: [PATCH V4 1/3] of: introduce for_each_matching_node_and_match()
In-Reply-To: <201211210953.20552.arnd@arndb.de>
References: <1353453142-4973-1-git-send-email-swarren@wwwdotorg.org>
 <201211210953.20552.arnd@arndb.de>
Message-ID: <CACxGe6u5UBqVPrBqwn9rhjuBx4uCuuHKU=FcvSp0GJ2G8ogSNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 9:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 20 November 2012, Stephen Warren wrote:
>> However, this results in iterating over table twice; the second time
>> inside of_match_node(). The implementation of for_each_matching_node()
>> already found the match, so this is redundant. Invent new function
>> of_find_matching_node_and_match() and macro
>> for_each_matching_node_and_match() to remove the double iteration,
>> thus transforming the above code to:
>>
>>     for_each_matching_node_and_match(np, table, &match)
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>
> This look useful, but I wonder if the interface would make more sense if you
> make the last argument to the macro a normal pointer, rather than a
> pointer-to-pointer. You can take the reference as part of the macro.

To me that makes for harder to understand code. It *looks* like an
argument to a normal function call, but it gets changed by the caller.

g.
