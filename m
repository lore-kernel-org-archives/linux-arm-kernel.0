From: benoit.fouet@free.fr (Benoit Fouet)
Date: Wed, 21 Oct 2009 09:04:38 +0200
Subject: [PATCH] Use CONFIG_VECTORS_BASE instead of hardcoded 0xffff0000.
In-Reply-To: <20091020201009.GA14305@n2100.arm.linux.org.uk>
References: <1256054856-20404-1-git-send-email-benoit.fouet@free.fr>
	<63386a3d0910201251n4e6fec18le5a2d2cd0941be78@mail.gmail.com>
	<20091020201009.GA14305@n2100.arm.linux.org.uk>
Message-ID: <20091021090438.0ec458dd.benoit.fouet@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, 20 Oct 2009 21:10:09 +0100 Russell King - ARM Linux wrote:
> On Tue, Oct 20, 2009 at 09:51:35PM +0200, Linus Walleij wrote:
> > I think we'd rather get rid of CONFIG_VECTORS_BASE
> > with that hex value, this config value could for example
> > be CONFIG_VECTORS_LOW | CONFIG_VECTORS_HIGH, mutually
> > exclusive instead, and then _LOW will basically never be used
> > and things become simpler, I think having a hex value for
> > CONFIG_VECTORS_BASE is actually confusing since that
> > may give people the (false) idea that this can be set to anything.
> 
> In the MMU case, there are only two possible addresses for the vectors -
> 0x00000000 or 0xffff0000.  Which is in play is entirely dependent on the
> state of the V bit in the control register.
> 

Reading the DDI0344D (Cortex A8 r2p1 trm), it seemed to me that this
was configurable with the security extension:
http://infocentre.arm.com/help/topic/com.arm.doc.ddi0344d/Babfbcae.html

although my patch was very likely the wrong approach (changing
VECTORS_BASE does not really make sense, as this is the one that can
not be remapped), there are still processors in the wild in which you
can configure the base address of the exception vectors.

Ben
