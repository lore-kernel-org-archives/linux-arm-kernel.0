From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Fri, 13 May 2011 15:08:59 +0300
Subject: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing
	preprocessor.
In-Reply-To: <20110513113013.GP31483@atomide.com>
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>
	<20110513113013.GP31483@atomide.com>
Message-ID: <BANLkTinNVbViwjAcrOqfR+-ZJ+i1DF9Hdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 2:30 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Vladimir Zapolskiy <vzapolskiy@gmail.com> [110512 17:35]:
>> This mass change reduces homogeneous data chunks along clock
>> definitions. No semantical difference is added to the change,
>> and still it could be introduced easily.
>>
>> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
>> ---
>> ?arch/arm/mach-omap2/clock44xx_data.c | 3313 +++++++++-------------------------
>> ?1 files changed, 848 insertions(+), 2465 deletions(-)
>
> Hehehe, the diffstat certainly looks good :)
>
> This would be best done for all of them using some
> perl/sed/python script. And could be done for the hwmod data
> too. Do you already have something like that available?
>
Unfortunately I don't have an automated tool, but that would be great
to have such a script. For this time I've checked the correctness of the
change comparing the preprocessed output.

In fact if nobody has serious objections about the nature of the change
itself, then I'd like to continue with similar modifications for other OMAP
specific massive data files, hopefully there is a lot of redundant data to
eliminate :)

I can try to do that starting from writing the script for automation,
though I don't have a strong feeling that it's a straightforward task,
and preprocessed code check and/or runtime check might be preferable.

> Paul and & Benoit, what's your take on doing something like
> this? I'd assume updating your data generation scripts would
> be trivial?
>

With best wishes,
Vladimir
