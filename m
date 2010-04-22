From: mike@android.com (Mike Chan)
Date: Wed, 21 Apr 2010 17:50:12 -0700
Subject: [PATCH 1/2] omap: pm34xx: Enable IO / IO-CHAIN wakeups for PER
In-Reply-To: <87aasw5oyx.fsf@deeprootsystems.com>
References: <1271295665-26187-1-git-send-email-mike@android.com>
	<87aasw5oyx.fsf@deeprootsystems.com>
Message-ID: <s2y8bb80c381004211750hd8d62be8hfa0bead1dbfa8d2b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 5:07 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Mike Chan <mike@android.com> writes:
>
>> IO events can also come from GPIO modules, which reside in the PER domain.
>> It is possible for the PER to enter RET while CORE is still in ON.
>> If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will not
>> wakeup in this case, unless we enable it.
>>
>> Signed-off-by: Mike Chan <mike@android.com>
>
> Hi Mike,
>
> I'm a little puzzled on this one. ?My understanding is that the IO pad
> is only armed when CORE is in RET or OFF.
>

The issue we are seeing is when the device is active but idle, if CORE
is ON and PER is in RET and the omap is sitting in swfi. If the user
presses a keypad button, IO pad doesn't wake us out of idle. Setting a
wakeup if PER or CORE goes into RET solve this.

> I need to dig a little more in the TRM on this one to clarify.
>

I was looking at 4.11.2.2 I/O Wake-Up Mechanism (pg 421)

> If CORE is staying on, it might be that your GPIO module level wakeups
> are not being configured correctly. ?Please check the 'Known Problems'
> section of the OMAP PM wiki[1], search for 'GPIO module-level wakeups'
>

I will check to see if we have somethign mis-configured.

-- Mike

> Kevin
>
> [1] http://elinux.org/OMAP_Power_Management#Known_Problems
>
