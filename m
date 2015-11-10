From: dbrignoli@audioscience.com (Delio Brignoli)
Date: Tue, 10 Nov 2015 11:23:35 +0100
Subject: Minimal support for dm814x
In-Reply-To: <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
Message-ID: <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Nov 2015, at 09:50, Matthijs van Duin <matthijsvanduin@gmail.com> wrote:
> On 9 November 2015 at 16:06, Tony Lindgren <tony@atomide.com> wrote:
>> The PLL support is still missing, so it relies on the bootloader
>> configured PLL values for now. I'm hoping to post PLL support patches over
>> next few weeks and then we can have that and more devices working for v4.5.
> 
> Ah, yes, configuring a DPLL-LJ is fun.. figuring out how to write the
> desired ratio as M/(M2*(1+N)) while simultaneously satisfying all
> constraints on M, N, M2, refclk, and dco. :-)

Yes, indeed. We have the additional requirement of being able to adjust the frequency (by a relatively small amount) without loss of lock. Recalculating the DCO mode and M,N,M2 from scratch each time based on the target frequency, like was done in the 2.6.37 based tree from TI was not acceptable, so we try to change m2 first to see if we can reach the target frequency and fall back to recalculate parameters from scratch if that fails.

BTW, are you aware of section 2.1.2 of ?TMS320DM814x DaVinci Digital Media Processors Silicon Revisions 3.0, 2.1?? <http://www.ti.com/lit/er/sprz343c/sprz343c.pdf>

Regards
?
Delio
