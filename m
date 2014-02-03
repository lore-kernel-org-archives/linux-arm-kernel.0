From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 3 Feb 2014 18:15:44 +0000
Subject: [PATCH v4 2/5] arm: add new asm macro update_sctlr
In-Reply-To: <20140203165718.GO14112@mudshark.cambridge.arm.com>
References: <1389445524-30623-3-git-send-email-leif.lindholm@linaro.org>
 <20140122112055.GF1621@mudshark.cambridge.arm.com>
 <20140129182805.GF11329@bivouac.eciton.net>
 <1391029124.2488.50.camel@deneb.redhat.com>
 <20140130131247.GG11329@bivouac.eciton.net>
 <20140203103415.GA12187@mudshark.cambridge.arm.com>
 <20140203155542.GI11329@bivouac.eciton.net>
 <20140203160051.GG14112@mudshark.cambridge.arm.com>
 <20140203164636.GJ11329@bivouac.eciton.net>
 <20140203165718.GO14112@mudshark.cambridge.arm.com>
Message-ID: <20140203181544.GK11329@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 04:57:18PM +0000, Will Deacon wrote:
> > mov[tw]: why?
> > Then we end up battling different available immediate fields in A32/T32
> > instruction sets and v5/v6/v7 architecture versions.
> 
> I was making the assumption that UEFI was going to be v7 only... is this not
> true?

There is no such requirement in the specification.
It even mentions requirements for ARMv4 in one place :)

But I also don't understand why ldr= should be avoided.
This is not performance sensitive (called once on system boot), and
it's already executing with the caches off, so even if it ends up
being a literal load it does not pollute.

/
    Leif
