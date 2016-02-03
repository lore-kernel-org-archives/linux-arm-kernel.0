From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 Feb 2016 12:08:59 -0600
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
Message-ID: <56B2423B.1020109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fu Wei wrote:
> Actually I am taking your suggestion to avoid touching WCV in
> interrupt routine.
> So even we have pre-timeout support , it is useless for this
> panic-on-half-timeout feature,
> because pre-timeout  == timeout / 2 (always).
>
> So maybe I misunderstand your suggestion,
> could you let me know : why we want pre-timeout here?

Maybe I'm confused.

For pre-timeout, I think the SBSA watchdog driver should support only 
half-timeout.  That is, the user cannot configure the length of the 
pre-timeout with this driver.  He can only enable it, and it is 
automatically set to 1/2 timeout.

So when pre-timeout occurs, the interrupt handler calls panic() or 
whatever it's supposed to do.

So "pre-timeout  == timeout / 2 (always)" is exactly what we want.
