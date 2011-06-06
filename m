From: khilman@ti.com (Kevin Hilman)
Date: Mon, 06 Jun 2011 15:32:29 -0700
Subject: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
In-Reply-To: <BANLkTingmUNvZO_szivRkmn7LRO4L5A+5Q@mail.gmail.com> (Colin
	Cross's message of "Sat, 4 Jun 2011 19:37:54 -0700")
References: <1307214239-16316-1-git-send-email-ccross@android.com>
	<BANLkTingmUNvZO_szivRkmn7LRO4L5A+5Q@mail.gmail.com>
Message-ID: <87r576wpz6.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross <ccross@android.com> writes:

> On Sat, Jun 4, 2011 at 12:03 PM, Colin Cross <ccross@android.com> wrote:
>> Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
>> causing only the last bit set to take effect, resulting in lost
>> wakeups when the GPIO controller is in idle.
>>
>> Replace direct writes to IRQWAKEN with writes to SETWKUENA and
>> CLEARWKUEN.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>

[...]

>
> Todd pointed out that the OMAP4 TRM says not to use SETWKUENA and
> CLEARWKUENA.  

In my GPIO cleanups, I was wondering why the set/clear registers were
not used here. Todd, can you give the TRM version & reference for this?
I didn't find anything after a quick scan/search.

Thanks,

Kevin
