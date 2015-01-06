From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 6 Jan 2015 15:50:39 -0500 (EST)
Subject: [PATCH] Revert 9fc2105aeaaf56b0cf75296a84702d0f9e64437b to fix
 pyaudio (and probably more)
In-Reply-To: <1923550.h5Fs9u5gUy@wuerfel>
References: <20150104190123.GA20153@amd> <20150105121126.GA10116@arm.com>
 <alpine.LFD.2.11.1501052259230.18844@knanqh.ubzr>
 <1923550.h5Fs9u5gUy@wuerfel>
Message-ID: <alpine.LFD.2.11.1501061519090.18844@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Jan 2015, Arnd Bergmann wrote:

> On Monday 05 January 2015 23:09:00 Nicolas Pitre wrote:
> > 
> > Now here's the bogomips hard limit gone:
> > 
> > ----- >8
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Date: Mon, 5 Jan 2015 22:43:56 -0500
> > Subject: [PATCH] ARM: loop_udelay: remove bogomips value limitation
> > 
> > Now that we don't support ARMv3 anymore, the loop based delay code can
> > convert microsecs into number of loops using a 64-bit multiplication.
> > This allows us to lift the hard limit of 3355 on the bogomips value with
> > loops_per_jiffy that can safely span the full 32-bit range.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> I think we still build RPC with gcc -march=armv3. Is that a problem
> with this patch?

It is.

Tangential question: does anyone still own a working RPC?

For sure we no longer support the RPC unless it is fitted with a SA110.  
And IIRC the reason why -march=armv3 is used in that case has to do with 
the RPC memory bus not able to accommodate the SA110's LDRH/STRH 
instructions. However it should be able to execute UMULL regardless.

Now I could add ".arch armv7-a" in the file to make it compile for RPC.  
I can't just make it ".arch armv4" as this prevents Thumb2 compilation 
for that file.

Other ideas?


Nicolas
