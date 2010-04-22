From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 21 Apr 2010 17:07:50 -0700
Subject: [PATCH 1/2] omap: pm34xx: Enable IO / IO-CHAIN wakeups for PER
In-Reply-To: <1271295665-26187-1-git-send-email-mike@android.com> (Mike Chan's
	message of "Wed\, 14 Apr 2010 18\:41\:04 -0700")
References: <1271295665-26187-1-git-send-email-mike@android.com>
Message-ID: <87aasw5oyx.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Chan <mike@android.com> writes:

> IO events can also come from GPIO modules, which reside in the PER domain.
> It is possible for the PER to enter RET while CORE is still in ON.
> If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will not
> wakeup in this case, unless we enable it.
>
> Signed-off-by: Mike Chan <mike@android.com>

Hi Mike,

I'm a little puzzled on this one.  My understanding is that the IO pad
is only armed when CORE is in RET or OFF.

I need to dig a little more in the TRM on this one to clarify.

If CORE is staying on, it might be that your GPIO module level wakeups
are not being configured correctly.  Please check the 'Known Problems'
section of the OMAP PM wiki[1], search for 'GPIO module-level wakeups'

Kevin

[1] http://elinux.org/OMAP_Power_Management#Known_Problems
