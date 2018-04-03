From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Apr 2018 15:34:21 +0800
Subject: [PATCH v5 01/13] ARM: move cputype definitions into another file
In-Reply-To: <20180403092724.607e8e37@dell-desktop.home>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-2-mylene.josserand@bootlin.com>
 <CAGb2v64GL=1UcYs1tFp-mS07vbHBao82SEhyzUrUHB++2-EKBg@mail.gmail.com>
 <20180403092724.607e8e37@dell-desktop.home>
Message-ID: <CAGb2v67RduaktYimLAuFwYB=Q8qD8f3AbZmoX5QssAGDtWwS6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2018 at 3:27 PM, Myl?ne Josserand
<mylene.josserand@bootlin.com> wrote:
> Hi Chen-Yu,
>
> Thank you for your review!
>
> On Tue, 3 Apr 2018 14:52:45 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
>> On Tue, Apr 3, 2018 at 2:18 PM, Myl?ne Josserand
>> <mylene.josserand@bootlin.com> wrote:
>> > To add the support for SMP on sun8i-a83t, we will use some
>> > definitions in an assembly file so move definitions into
>> > another file to separate C functions and macro defintions.
>>
>> Instead of moving the definitions, you could guard all the C
>> stuff in "#ifndef __ASSEMBLY__". AFAIK a few header files do that.
>
> Oh, right. It is better with this check so I will use that in the next
> iteration of my series.

I'm not sure about the policy, but I kind of assume any header under
"asm" would be usable in assembly files, so the guard would be better.

ChenYu
