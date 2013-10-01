From: john.stultz@linaro.org (John Stultz)
Date: Tue, 01 Oct 2013 09:21:52 -0700
Subject: Status of ARM FIQ?
In-Reply-To: <F5184659D418E34EA12B1903EE5EF5FD8538E86602@seldmbx02.corpusers.net>
References: <F5184659D418E34EA12B1903EE5EF5FD8538E865F6@seldmbx02.corpusers.net>,
 <20131001092623.GA2640@localhost.localdomain>
 <F5184659D418E34EA12B1903EE5EF5FD8538E86602@seldmbx02.corpusers.net>
Message-ID: <524AF6A0.5060206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 09:04 AM, Bird, Tim wrote:
> On Tuesday, October 01, 2013 2:26 AM, Dave Martin [Dave.Martin at arm.com] wrote:
>> John Stultz has been working on the FIQ debugger for Android and may
>> have some ideas.
> The CE WG is considering sponsoring some work on the FIQ debugger, and
> some Sony teams are still very interested in this getting mainlined all the way.
> (though not the mobile phone team, for the reasons you mention - I'm pretty sure
> that FIQ is not available to us in that product segment.)
>
> Thanks very much for the info (to all who responded).
>
> John,
>
> Do you know the status of this?  Wasn't Anton Vorontsov working on this last year?
> Does anyone know what the current status of that is?

Right, Anton was working on enabling an FIQ mode kdb (along with
modifications to kdb to provide a safe kiosk mode), in order to replace
Android's FIQ debugger. The patches were sent to the lists and various
maintainers a number of times to almost no response. Sadly for us, Anton
went back to school, so the effort has stalled.

I tried to resubmit the patches (without deeply understanding them), but
again it didn't seem to get maintainer interest and the few questions
that did arise I wasn't able to answer effectively.

Its still on our todo list, and I'd love to see some progress on it, but
I just haven't been able to commit the time myself.

If anyone wants to take a look at it, Anton's work can be found here:

FIQ KDB:
git://git.linaro.org/people/jstultz/android-dev.git dev/fiq-kdb
https://git.linaro.org/gitweb?p=people/jstultz/android-dev.git;a=shortlog;h=refs/heads/dev/fiq-kdb

KDB Kiosk:
git://git.linaro.org/people/jstultz/android-dev.git dev/kdb-kiosk
https://git.linaro.org/gitweb?p=people/jstultz/android-dev.git;a=shortlog;h=refs/heads/dev/kdb-kiosk

It would be interesting to also hear feedback as to how close Anton's
kdb approach is to what you're thinking of trying to push upstream.

thanks
-john
