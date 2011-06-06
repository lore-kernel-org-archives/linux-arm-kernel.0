From: toddpoynor@google.com (Todd Poynor)
Date: Mon, 6 Jun 2011 16:05:22 -0700
Subject: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
In-Reply-To: <87r576wpz6.fsf@ti.com>
References: <1307214239-16316-1-git-send-email-ccross@android.com>
	<BANLkTingmUNvZO_szivRkmn7LRO4L5A+5Q@mail.gmail.com>
	<87r576wpz6.fsf@ti.com>
Message-ID: <20110606230522.GA16590@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 03:32:29PM -0700, Kevin Hilman wrote:
> Colin Cross <ccross@android.com> writes:
> 
> > On Sat, Jun 4, 2011 at 12:03 PM, Colin Cross <ccross@android.com> wrote:
> >> Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
> >> causing only the last bit set to take effect, resulting in lost
> >> wakeups when the GPIO controller is in idle.
> >>
> >> Replace direct writes to IRQWAKEN with writes to SETWKUENA and
> >> CLEARWKUEN.
> >>
> >> Signed-off-by: Colin Cross <ccross@android.com>
> 
> [...]
> 
> >
> > Todd pointed out that the OMAP4 TRM says not to use SETWKUENA and
> > CLEARWKUENA.  
> 
> In my GPIO cleanups, I was wondering why the set/clear registers were
> not used here. Todd, can you give the TRM version & reference for this?
> I didn't find anything after a quick scan/search.

http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?templateId=6123&navigationId=12037

OMAP4460 Multimedia Device Silicon Revision 1.0 Version E
February 2011?Revised May 2011

p. 5357 Table 25-68. GPIO_CLEARWKUPENA

"Caution: This register is kept for backward software compatibility. Use
GPIO_IRQWAKEN_0 and GPIO_IRQWAKEN_1 instead."

OMAP4430 TRM is similar.


Todd
