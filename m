From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 20 Oct 2009 01:02:29 +1030
Subject: [PATCH] serial/atmel_serial: Fix another fallout of the change to
	BUILD_BUG_ON
In-Reply-To: <4ADC3D3C020000780001AA10@vpn.id2.novell.com>
References: <1255417680-25609-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<200910191638.41299.rusty@rustcorp.com.au>
	<4ADC3D3C020000780001AA10@vpn.id2.novell.com>
Message-ID: <200910200102.30478.rusty@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Oct 2009 06:49:40 pm Jan Beulich wrote:
> >>> Rusty Russell <rusty@rustcorp.com.au> 19.10.09 08:08 >>>
> >How's this?  It's not quite valid C, but it "works":
> 
> But that's not what you proposed initially, i.e. generating a link time
> error if a compile time error can't be generated (and only if even a link
> time error isn't possible, a run time one should be forced).

Yeah, this was cleverer.  A compile time is nicer than link time.  And this
is *actually* what I want: a compile fail if the compiler knows enough, runtime
otherwise.

> And btw., why do you think this isn't valid C?

>From my glance at ISO C, non-positive sized variable length arrays are
invalid.  gcc here seems to give the expected results (eg. sizeof gives
a negative result).

Cheers,
Rusty.
