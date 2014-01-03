From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jan 2014 15:34:37 +0100
Subject: [PATCH 01/17] ARM: spear: Remove deprecated IRQF_DISABLED flag
In-Reply-To: <52C5B52E.6080609@linaro.org>
References: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
 <201401021929.46581.arnd@arndb.de> <52C5B52E.6080609@linaro.org>
Message-ID: <201401031534.37533.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 January 2014, Daniel Lezcano wrote:
> On 01/02/2014 07:29 PM, Arnd Bergmann wrote:
> > On Monday 30 December 2013, Daniel Lezcano wrote:
> >> This flag is a NOOP and scheduled to be removed
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > Thanks for sending this series. I think the patches are duplicates of stuff that
> > Michael Opdenacker has sent before (actually multiple times). I have no problem
> > applying either version into arm-soc, but I think it would be better to attribute
> > them to Michael, since he came first. Can you two please coordinate and send a
> > single pull request for the arm-soc related patches that haven't made it into
> > linux-next yet?
> 
> Michael removed the flag for:
> 
> pxa (ed7936f913456e4c01aed75deba6cfaf830fa8cf)
> samsung (fa53d5cdbffbce421c3bd2f937b5626fc044fedc)
> avr32 (7155530d9eb692994d208836e4965da06b17c99d)
> ep93xx (3a71ae4796fdaedbdbdab94660b7b7b5bfe61d1d)
> plat-orion (eb4d552b933ac59c0c8e0604ff435c5208a82679)
> 
> The patchset I sent is on top of arm/for-next and finishes to remove 
> this flag for arch/arm. It should not overlap with what Michael did.
> 
> I'm ok to attribute the patchset to Michael if that can help to accept 
> this patchset and kill this flag for arch/arm.

IIRC, Michael actually sent patches for all uses in the entire kernel
previously, but relied on sub-maintainers to pick them up one by one.
Some patches already got 'Acked-by' replies, which I'd like to keep.

It's probably time to do a bigger sweeping change now and kill it for
good, bypassing the remaining maintainers that haven't acted so far.
We can certainly carry the patches related to arm-soc, and I think
it's worth trying once more to get the scsi patches merged, since there
is a bunch of them. Everything else can probably go directly as a
single pull-request to Linus, or perhaps via Andrew Morton.

	Arnd
