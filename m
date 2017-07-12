From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Jul 2017 15:39:42 +0530
Subject: cpufreq: frequency scaling spec in DT node
In-Reply-To: <9476e8ee-24ae-1676-067b-18a867892894@free.fr>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <20170629143432.GM29665@vireshk-i7>
 <405bfa30-b083-2690-5747-aa1cd423e576@free.fr>
 <20170711102514.GC17115@vireshk-i7>
 <c0838592-5613-660d-56fc-e7022a38a86d@free.fr>
 <20170712034150.GD17115@vireshk-i7>
 <9476e8ee-24ae-1676-067b-18a867892894@free.fr>
Message-ID: <20170712100942.GF1679@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-07-17, 11:58, Mason wrote:
> I would object to the characterization of "just a PLL" :-)
> 
> The PLL outputs "garbage" before actually "locking" a target
> frequency. It is not possible for the CPU to blindly change
> the PLL settings, because that crashes the system.
> 
> The bootloader implements the steps required to change said
> settings, so the strategy has been: have Linux use whatever
> PLL frequency the bootloader programs.
> 
> Behind the PLL, there is a glitch-free divider, which is able
> to divide the PLL output without crashing the system. I've
> been using that divider for DFS.
> 
> drivers/clk/clk-tango4.c

Okay, got it now.

Yes, you *really* need to create these OPPs dynamically. I am
convinced now :)

-- 
viresh
