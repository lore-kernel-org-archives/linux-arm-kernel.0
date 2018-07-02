From: david@lechnology.com (David Lechner)
Date: Mon, 2 Jul 2018 13:13:40 -0500
Subject: [PATCH v7 00/10] Introduce the Counter subsystem
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
Message-ID: <603b0373-f1e1-5938-fa53-8328c9a5964f@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2018 04:06 PM, William Breathitt Gray wrote:
> I decided to strip down these devices to arrive at the core essence of
> what constitutes a "counter device" and therefore design a "generic
> counter" abstraction to better represent these devices and prevent the
> ambiguity we discovered with the existing IIO Counter interface. This
> abstraction became the Generic Counter paradigm, which is explained in
> detail within the Documentation/driver-api/generic-counter.rst file
> introduced by this patchset.

I'm curious if you have given any thought to the time aspect of counters.
I am interested in the rate at which the counters are counting (e.g. how
many counts per second). I realize that you can calculate this in
userspace or in the kernel using the system timer, but it is not very
accurate since Linux is not a realtime OS. So, I would like to get the
rate directly from the hardware. For example, the TI eQEP[1], like the
one found in BeagleBones, has a couple ways of measuring time (see link
for details).

[1]: http://www.ti.com/lit/ug/sprug05a/sprug05a.pdf
