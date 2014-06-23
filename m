From: drake@endlessm.com (Daniel Drake)
Date: Mon, 23 Jun 2014 10:40:39 +0100
Subject: [PATCH V2 0/2] Sound support for Exynos4412 Odroid X2, U3 board
In-Reply-To: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
References: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAD8Lp44h6zc2Rt2MGLjhmNG-YB0kYCWf5G7hX5JmdmBfc1PvKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 5:22 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> This series adds basic sound support for the Odroid X2/U3 boards.
> It relies on specific Exynos Audio Subsystem clock parent and
> frequencies being pre-configured.
>
> My full testing git branch has been pushed to:
> git://linuxtv.org/snawrocki/samsung.git v3.16-rc1-odroid-sound-clk

Thanks for this! I tested these patches plus the ones in your branch
to integrate with the ODROID.
I tested ODROID-U2's 3.5mm analog headphone jack output with:

# speaker-test -c 2 -t wav -l 2

On my x86 laptop this command takes ~6 seconds and produces audible output:
"Front left, front right, front left, front right"

When those words are reproduced over the speakers, there is a
corresponding message printed to stdout which synchronizes nicely.

On ODROID-U2 the same command doesn't work quite right - execution
takes only 3.5 seconds and the audible output is truncated:
"Front left, front right, front"
and the stdout messages do not really coincide with the audio being
reproduced at that time.

No pulseaudio or anything like that.

Can you reproduce this?

Thanks
Daniel
