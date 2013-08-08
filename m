From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 8 Aug 2013 19:13:55 +0100
Subject: angel_SWI_ARM
In-Reply-To: <52025020.1020506@codeaurora.org>
References: <CANEcUBW2OsQqN_Cm_9ThJmcmNB5oQfNvqNi_MU+DsCNAPJtaFQ@mail.gmail.com>
 <52025020.1020506@codeaurora.org>
Message-ID: <20130808181355.GC2356@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 09:48:16AM -0400, Christopher Covington wrote:
> On 08/07/2013 06:57 AM, zhaobin xv wrote:
> > Hello
> > when I read linux/arch/arm/boot/compressed/head.S
> > I can't understand :
> >  mrs    r2, cpsr        @ get current mode
> >         tst    r2, #3            @ not user?
> >         bne    not_angel
> >         mov    r0, #0x17        @ angel_SWIreason_EnterSVC
> >         swi    0x123456        @ angel_SWI_ARM
> > I want to know :
> > a) what is angel_SWI_ARM
> > b) what is angel debuger
> > c)Do the code " swi    0x123456 " make interrupt what make program
> > jump to addr 0x0000 0008
> > ,but addr 0x0000 0008 doesn't initialize.
> 
> Angel is ARM's semihosting interface.
> 
> http://infocenter.arm.com/help/topic/com.arm.doc.dui0471c/CHDJHHDI.html

I believe it's been used in the past to boot some early StrongARM based
boards like Assabet.

Since this seems to require an image to be downloaded via the serial
port, boards configured to use this are probably not self-booting.  I
doubt there are many people still using this today.


For all other configurations, the kernel is entered in SVC mode, not
User mode, so the code will be skipped.


Documentation/arm/Booting:

  For CPUs which do not include the ARM virtualization extensions, the
  CPU must be in SVC mode.  (A special exception exists for Angel)

Cheers
---Dave
