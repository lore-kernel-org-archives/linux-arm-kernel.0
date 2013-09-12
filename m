From: cinifr@gmail.com (cinifr)
Date: Fri, 13 Sep 2013 00:07:07 +0800
Subject: [PATCH 3/4] Add physical count arch timer support for clocksource
 in ARMv7.
In-Reply-To: <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
 <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
Message-ID: <CAK3cCBwu4somtfc9J1ZDVcC-iYD1qDJwSWzWeOomTqY9tQA2kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>This cannot be a compile-time option as above in a multiplatform build.
>Other paltforms (e.g. KVM guests) *must* use the virtual counters to get
>any semblance of a consistent view of time.
Yes I accept compile-time option is not perfect  in my pre email,
But,Why Ohter paltforms *must* use the virtual counters? I think KVM
should not limit how to use arch timer in its guest OS. Of cause, if
KVM guest use vct can be more efficiency then that use pct. but KVM
should and must support guest OS to access pct.

>Why can the bootloader not be fixed to set CNTVOFF (or to boot the
>kernel in Hyp mode)?
I want kernel should try its best to boot and run with  the bootloader
not be fixed.
BTW, I also hope all bootloader fix the problem.
