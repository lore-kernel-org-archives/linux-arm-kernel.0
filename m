From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Jul 2017 09:11:50 +0530
Subject: cpufreq: frequency scaling spec in DT node
In-Reply-To: <c0838592-5613-660d-56fc-e7022a38a86d@free.fr>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <20170629143432.GM29665@vireshk-i7>
 <405bfa30-b083-2690-5747-aa1cd423e576@free.fr>
 <20170711102514.GC17115@vireshk-i7>
 <c0838592-5613-660d-56fc-e7022a38a86d@free.fr>
Message-ID: <20170712034150.GD17115@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-07-17, 13:09, Mason wrote:
> I apologize for being unclear.
> 
> What I meant is that the bootloader originally set the max frequency
> to 1206 MHz. The OPP table in DTS was written based on that value.
> 
> Later, someone changed the bootloader code to set a slightly higher
> max frequency. When I flashed the new bootloader on my board, the
> OPP table no longer matches the actual frequency.
> 
> But I am not notified when bootloader authors change max frequencies,
> which is why I wrote "changed the max freq behind my back".
> 
> Again, sorry for the confusing statements.
> 
> (The bootloader is not DT-aware, so it leaves the DT untouched.)

Here we go. Finally I have understood what the problem you are facing is :)
And yes, it was really not clear to me until now. I though that someone just
changed the max in DT and that's making things go bad :)

Anyway, how does the bootloader control the max frequency? For the boards I
worked on, its just a PLL that the kernel needs to set and kernel can choose to
program it the way it wants to irrespective of the way bootloader has worked on
it.

> Maybe this is the real issue that needs to be addressed,
> rather than the symptoms that turn up later because of
> the root issue.

Sure, I just need a bit more of input from you :)

-- 
viresh
