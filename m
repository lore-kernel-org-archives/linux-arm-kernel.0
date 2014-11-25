From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 25 Nov 2014 22:53:37 +0530
Subject: [PATCH] thermal: exynos: add optional sclk support
In-Reply-To: <20141125051803.GA29240@developer>
References: <1416642356-8694-1-git-send-email-a.kesavan@samsung.com>
 <CAGTfZH1T-pRmETfQUs1Scy1TLfA_DG9fEZGY83my7WVwtujqRQ@mail.gmail.com>
 <CAM4voa=XUrkvH7EDk+j_FPX6pB3gLCHsAjDUMQacZ4AWyNEaNQ@mail.gmail.com>
 <20141124114845.0a03eeb4@amdc2363>
 <CAM4voakNTe5x1Mur0J9PNbxW0XCMiXm_hfpPgHF0bKwnMbYNAw@mail.gmail.com>
 <20141124175242.GA1351@developer>
 <CAM4voamP98hs+5Ey-qhy++HnmS0+8YLK8Fey_YCuzgBWDvzPKA@mail.gmail.com>
 <20141125051803.GA29240@developer>
Message-ID: <CAM4voanzKntsLWKBvbJt_cnZhXZiL9JwENyou9pD-5BtYeEjqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

On Tue, Nov 25, 2014 at 10:48 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> Abhilash,
>
> Hi,
>
> On Tue, Nov 25, 2014 at 08:00:50AM +0530, Abhilash Kesavan wrote:
> <big cut>
>
>> >>
>> >> Lukasz, thanks for the review.
>> >>
>> >> Chanwoo, are you OK with this ? If so, I will post a v2 with this and
>> >> the other changes you suggested.
>> >
>> > Is this a mandatory or a optional clk? What happens if the chip has the
>> > clock, but you fail to get it in this code?
>>
>> This is mandatory on Exynos7 but not on the older SoCs. On Exynos7 if
>> this clock is disabled then the TMU will not function.
>>
>
>
> It means, that only on Exynos7, outputing a dev_err is the right thing
> to do. On other SoCs versions, it does not make sense at all requesting
> this clock.

OK

>
>> >
>> > Think the rule of thumb is to at least warn the user that you are
>> > bailing to the defaults, because you failed to get the clock, when you
>> > were supposed to.
>> >
>> > Besides, warning / logging (even if it is in debugging mode) the user
>> > that you failed to get a clock, when the board / platform does not
>> > support it, sounds at least bogus for them.
>>
>> So, you would rather that I go with Chanwoo's approach of adding a
>> per-soc flag indicating the presence of this clock ?
>>
>
> Yes.

Thanks for the clarification, will post v2 tomorrow.

Abhilash

>
> BR,
>
> Eduardo Valentin
>
>> Regards,
>> Abhilash
