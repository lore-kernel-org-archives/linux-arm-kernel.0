From: dianders@google.com (Doug Anderson)
Date: Thu, 9 Jul 2015 09:25:53 -0700
Subject: [PATCH v2 0/9] regulator: pwm-regulator: Introduce continuous-mode
In-Reply-To: <20150709151429.6daf8fcb@bbrezillon>
References: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
 <20150709083041.3b203eb1@bbrezillon> <20150709115158.GA3445@x1>
 <20150709151429.6daf8fcb@bbrezillon>
Message-ID: <CAD=FV=UkSgx0zRyJ6M2AqvWd3=jMr01ZXLC__8zr3awsYh5kyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 9, 2015 at 6:14 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
>> If you wish to add a 3rd mode, then I'm sure Mark will accept
>> submissions, but I think what you are suggesting would be pretty
>> complex and out-of-scope of what this patch-set is trying to achieve.
>
> Okay, still don't get the need to add a new mode which is almost doing
> the same thing when we could have implemented it in a generic way in the
> first place. But if your version has already been accepted then I think
> I'll have to propose a new mode :-/.
>
>>
>> As a side note, then if the voltage isn't directly proportional to the
>> duty cycle on a large scale i.e. max => min, then it will not likely
>> be very accurate between say table entries 1 => 2, or 4 => 5, etc.
>>
>> What I suggest you do in your case is provide a larger table with all
>> of the values you find interesting, as it sounds like your PWM
>> regulator isn't doing what one would normally expect.
>
> Well, I do not exactly agree here. Yes if you want to have a precise
> mapping you'll have to add more entries in your voltage table, but
> using linear interpolation between two points can be precise enough on
> some ranges and prevent one to define a complete voltage table in the
> DT.
>
> Doug, could give more details about the regulator used on the veyron
> board ?

There's no need for a new mode as far as veyron is concerned.  The pwm
regulator on veyron (as far as I understand it) acts the way that Lee
describes.  Try doing the math on the values in the table and you
should see that it's as linear as it can be while still using integral
duty cycles.

Originally I only suggested using "linear interpolation" because:

* It meant no bindings change, which is always nice to avoid.

* It meant that old devices got this new mode, which is probably the
right thing anyway (I think).  Maybe nobody has published DTS files
with pwm-regulator, so the point is moot.


-Doug
