From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Dec 2015 08:53:09 -0600
Subject: [PATCH 0/4] ARM Versatile multi-platform support
In-Reply-To: <3265937.pryQQXUTv3@wuerfel>
References: <1449607458-16850-1-git-send-email-robh@kernel.org>
 <3265937.pryQQXUTv3@wuerfel>
Message-ID: <CAL_JsqLpD8jRZF=mh0rs8Heb3XZftUmbjr7xparFzWYnqC25iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 4:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 December 2015 14:44:14 Rob Herring wrote:
>> Arnd lit a fire under me to dust this off and get it merged. So here it
>> is. The main change from prior version is I merged all the code to a
>> single file. It's a bigger patch than I'd like, but I don't think trying
>> to do it in multiple steps is worth it.
>>
>> This is dependent on some solution for the default platform choice on
>> !MMU builds (allnoconfig) as it can't be Versatile after this series.
>> Arnd has some ideas on how to address that.
>>
>> This is tested under QEMU. Linus previously tested this on actual h/w
>> and had a problem with the display identification which needs
>> investigation or agreement to worry about it if and when someone
>> actually cares.
>
>
> Merged into next/multiplatform, thanks a lot!

Are you going to apply something for the default platform? This is
breaking allnoconfig without it.

It looks like versatile_defconfig is also broken, but perhaps due to
debug_ll changes?

Rob
