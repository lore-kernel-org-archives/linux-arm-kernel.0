From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 12 Dec 2017 13:24:52 -0800
Subject: [linux-sunxi] [PATCH v2 3/6] ARM: sun4i: Convert to CCU
In-Reply-To: <20171212172635.2utwz3koyo5iwglt@plaes.org>
References: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
 <4357a69da97f46a324eec4c766f4bc9d9e7733ff.1490545262.git-series.plaes@plaes.org>
 <CAOi56cUjqjcZRz6VSwUWcrW=4RQyqyZHtm1vuM3HT2ypdPJ78g@mail.gmail.com>
 <20171212172635.2utwz3koyo5iwglt@plaes.org>
Message-ID: <CAOi56cUeRrKQnJ-akJPB160-60aBzy64bDgFeoqMpHRJSCnDeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 9:26 AM, Priit Laes <plaes@plaes.org> wrote:
> On Mon, Dec 11, 2017 at 02:22:30PM -0800, Kevin Hilman wrote:
>> On Sun, Mar 26, 2017 at 10:20 AM, Priit Laes <plaes@plaes.org> wrote:
>> > Convert sun4i-a10.dtsi to new CCU driver.
>> >
>> > Signed-off-by: Priit Laes <plaes@plaes.org>
>>
>> I finally got around to bisecting a mainline boot failure on
>> sun4i-a10-cubieboard that's been happening for quite a while.  Based
>> on on kernelci.org, it showed up sometime during the v4.15 merge
>> window[1].  It bisected down to this commit (in mainline as commit
>> 41193869f2bdb585ce09bfdd16d9482aadd560ad).
>>
>> When it fails, there is no output on the serial console, so I don't
>> know exactly how it's failing, just that it no longer boots.
>
> We tried out latest 4.15 with various compilers and it works:
> - gcc version 7.1.1 20170622 (Red Hat Cross 7.1.1-3) (GCC) - A10 Gemei G9 tablet
> - gcc 7.2.0-debian - A10 Cubieboard

And you can reproduce the bug with gcc5 or gcc6?

Very strange that a DT only patch would cause a gcc related regression
and if it does, it should be investigated.  I don't think requiring
gcc7 is an appropriate solution.

@Chen-Yu, @Maxime: are you guys OK with requiring gcc7 for working
upstream boot for A10?

Kevin
