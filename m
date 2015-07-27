From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 08:32:39 +0530
Subject: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
In-Reply-To: <2910042.ys2zsBBKt2@amdc1976>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976>
Message-ID: <20150727030239.GG19944@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-07-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
> Isn't using u32 for storing frequency (in Hz) too small by today's
> standards?
> 
> [ Please note that the old v1 binding uses kHz not Hz. ]

I have thought about this a bit more and I am somewhat confused. Yes I
agree that u32 isn't big enough for frequencies in Hz, i.e. Max value
of 4294967295 ~ 4.29 GHz.

But the bigger problem lies with the clk API that we have today. It
declares clk-rate as a unsigned-long which is 32 bits on a 32 bit
machine and 64 bits on a 64 bit machine. And every single piece of
code reading "clock-frequency" DT property, reads it as a 32 bit value
as we reserve only a single cell for it.

Now, if we wanna change that, we need to start changing from the
clk-API itself and that's not gonna be a small task and I would leave
it to Mike/Stephen for obvious reasons :)

So, I will keep this code in sync with rest of the kernel and lets see
what Mike has to say.

-- 
viresh
