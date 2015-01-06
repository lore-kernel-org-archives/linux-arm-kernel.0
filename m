From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Jan 2015 14:01:50 +0100
Subject: [PATCH] Revert 9fc2105aeaaf56b0cf75296a84702d0f9e64437b to fix
 pyaudio (and probably more)
In-Reply-To: <alpine.LFD.2.11.1501052259230.18844@knanqh.ubzr>
References: <20150104190123.GA20153@amd> <20150105121126.GA10116@arm.com>
 <alpine.LFD.2.11.1501052259230.18844@knanqh.ubzr>
Message-ID: <1923550.h5Fs9u5gUy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 January 2015 23:09:00 Nicolas Pitre wrote:
> 
> Now here's the bogomips hard limit gone:
> 
> ----- >8
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date: Mon, 5 Jan 2015 22:43:56 -0500
> Subject: [PATCH] ARM: loop_udelay: remove bogomips value limitation
> 
> Now that we don't support ARMv3 anymore, the loop based delay code can
> convert microsecs into number of loops using a 64-bit multiplication.
> This allows us to lift the hard limit of 3355 on the bogomips value with
> loops_per_jiffy that can safely span the full 32-bit range.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

I think we still build RPC with gcc -march=armv3. Is that a problem
with this patch?

	Arnd
