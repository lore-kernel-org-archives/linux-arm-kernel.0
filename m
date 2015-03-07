From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 7 Mar 2015 23:24:08 +0100
Subject: [PATCH 1/2] arm64: juno: Add APB registers and LEDs using syscon
In-Reply-To: <20150227140600.GZ905@e106497-lin.cambridge.arm.com>
References: <1424866589-2988-1-git-send-email-linus.walleij@linaro.org>
 <20150225135512.GE12377@arm.com>
 <20150225144756.GA905@e106497-lin.cambridge.arm.com>
 <20150225150023.GJ12377@arm.com>
 <20150225151157.GC905@e106497-lin.cambridge.arm.com>
 <CACRpkdYd7ZOMt1QxhCxzhavhcd8wcWrC2j1Ce5eGP9piX=xwkQ@mail.gmail.com>
 <20150227140600.GZ905@e106497-lin.cambridge.arm.com>
Message-ID: <CACRpkdZq9n1+3sBi3g-ZTa9TaC3_PsO3ecox2gu7Vq-0rouXxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 3:06 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Fri, Feb 27, 2015 at 01:07:42PM +0000, Linus Walleij wrote:

>> Notice that the SD card slot is *ALSO* inside the box, do you mean we
>> should then also delete the uSD card support added in
>> commit 71f867ec130e3cc8e692366fdf8941ded27c727e
>> by yourself because the SD card slot is not reachable?
>> Notice that to access that card slot you even have to remove the
>> nice blue ARM boilerplate.
>
> That's not my view. I have a mobile phone with an uSD card slot, but I have to take
> the cover off (and the battery) to access it. It doesn't mean I should not be able
> to use it from kernel side because of that, only that the designer of the phone
> (and of the Juno board + box by extension) did not expect people to use it with
> covers off all the time.
>
> <virtual-tongue-in-cheek-on>
> I fail to see why you need to remove the SD card all the time. Surely opening
> the case once to put the uSD card in is enough? ;)
> </virtual-tongue-in-cheek-on>
>
>>
>> The board is obviously designed to be reachable and the top part
>> of the case is obviously designed to be taken off by professional
>> users.
>
> I'm mostly on your side, Linus, I was just looking for more use cases. Like I've said,
> most of our customers seem to keep the case closed (or at least that is what they tell
> us :) ) so I'm looking for explanations on how you use the LEDs (visual debugging for
> big-LITTLE was how Lorenzo was using them on TC2 for example).

OK now I feel bad and maybe I was not in such a good mood that day.

The LEDs I added are really useful on the other ARM reference designs,
the heartbeat gives a sign that the system is alive even if your console is
not working and that's what I appreaciate a lot about it (the
heartbeat intensity
also indicates system load).

The MMC read/write LED is as useful as the hard disk activity LED on
some older PCs, kinda nice if you want to know something is going on.

The rest of the LEDs show which CPU cores are active. This was the
original use of the LEDs on the RealView PB11MPcore and it was
appreciated by the multicore developers who could see the different
CPUs being busy with tasks.

LEDs on development boards are real nice, simply, and I think also
some deployed ARM64 server systems will have them.

Yours,
Linus Walleij
