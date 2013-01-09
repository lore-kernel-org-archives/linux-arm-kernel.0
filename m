From: olof@lixom.net (Olof Johansson)
Date: Tue, 8 Jan 2013 19:13:05 -0800
Subject: [GIT PULL] ARM: arm-soc fixes for 3.8-rc
In-Reply-To: <CA+55aFxxv2h8TAxvwprdQEpaz4Ww5ime+t8rmpjnjv2t-mWYaQ@mail.gmail.com>
References: <20130108184920.GA1258@quad.lixom.net>
 <CA+55aFxxv2h8TAxvwprdQEpaz4Ww5ime+t8rmpjnjv2t-mWYaQ@mail.gmail.com>
Message-ID: <CAOesGMgdV1dD5stpCiWVO8kL+E9U4+_3Zc7gUQ0YEiah4t1LbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 8, 2013 at 6:57 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jan 8, 2013 at 10:49 AM, Olof Johansson <olof@lixom.net> wrote:
>>
>> A slightly larger delta than I'd ideally want by now, in part due to some
>> of the OMAP PM fixes that's adding a bit of code. I decided to include
>> it instead of push it to 3.9, but from here on out we'll be stricter.
>
> Ugh. Not only that, but:
>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes
>
> you have both a branch called "fixes" and a tag called "fixes".
> Ambiguous. And when you ask me to pull like the above, it actually
> picks the branch, not the tag.
>
> Don't do this. Either use the unambiguous name ("tags/fixes" rather
> than just "fixes") or don't push out branches and tags that have the
> same name.

I switched from the latter to the former a while back, and should
probably switch back. What happened in this case is that the tag
hadn't mirrored out from ra yet, so git request-pull fell back to the
branch name instead and I didn't notice. :(

A non-ambiguous name will still fall back to the branch name instead
of the (differently named) tag, but it'll be easier to catch when I
check the pull request contents before sending it.

Or maybe a better solution is to make git request-pull throw an error
if there is a local signed tag for the request, but none is found on
the server (or has different contents). I'll take a look at that.


-Olof
