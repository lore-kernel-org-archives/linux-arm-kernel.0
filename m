From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 1 Mar 2016 06:52:46 +0100
Subject: [PATCH 5/6] clk: bcm2835: correctly enable fractional clock
 support
In-Reply-To: <87lh63jd4f.fsf@eliezer.anholt.net>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
 <1456745963-2403-6-git-send-email-kernel@martin.sperl.org>
 <87mvqj5k9r.fsf@eliezer.anholt.net>
 <0ED2FB7F-B112-487B-B222-08E5FAEE27F9@martin.sperl.org>
 <87lh63jd4f.fsf@eliezer.anholt.net>
Message-ID: <79C68128-C4B6-4AE2-9177-6A961573F90B@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 01.03.2016, at 00:44, Eric Anholt <eric@anholt.net> wrote:
> 
> Once again, trusting the docs turns out to be a bad idea.  You're right,
> the non-MASH clocks *do* have a bit 9 to enable fractional mode.  Sigh.
> 
> So, this patch is:
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

The only really reliable ?docs? on registers I have found outside
of probably signing a NDA are those header files for the VC4 provided
by broadcom. 

That is why I have taken the effort to translate those into something
much more easily readable/searchable (i.e html pages on the web).

And that is where I have ?guessed? all the information on the clock
tree structure.

The main thing that is sometimes missing from those documents is
some extra context like: what is that pllt clock with a mux of
8 parent clocks (not 4 or 16 as typical) and what do those
corresponding 4 counter really do?

See:
https://github.com/msperl/rpi-registers/blob/master/md/Region_CM.md#cm_plltctl

Martin
