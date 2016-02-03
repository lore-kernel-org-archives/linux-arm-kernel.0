From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 Feb 2016 12:26:10 -0600
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
Message-ID: <56B24642.8090105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fu Wei wrote:
> Actually,
> the SBSA watchdog driver should support only  half-timeout for panic
> the user cannot configure the length of "panic time",  He can only
> enable it, and it is automatically set to 1/2 timeout.
>
> we don't need pre-timeout here.
>
> Hope I understand you correctly:-)  sorry for your confusion
>
>> >
>> >So when pre-timeout occurs, the interrupt handler calls panic() or whatever
>> >it's supposed to do.
> Actually,
> So when 1/2 timeout occurs, the interrupt handler calls panic() or
> whatever it's supposed to do.
>

I understand all that.  What I'm saying is that, in the future, when 
pre-timeout support is added to the watchdog layer, I think it makes 
sense to modify this driver to use pre-timeout support.
