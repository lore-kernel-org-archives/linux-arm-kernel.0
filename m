From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Oct 2013 17:41:34 +0100
Subject: [PATCH v2 0/7] Optimize jump label implementation on ARM64
In-Reply-To: <20131014160419.GS25034@n2100.arm.linux.org.uk>
References: <1381675827-1610-1-git-send-email-liuj97@gmail.com>
 <20131014154044.GR25034@n2100.arm.linux.org.uk>
 <525C1469.4000906@gmail.com>
 <20131014160419.GS25034@n2100.arm.linux.org.uk>
Message-ID: <20131014164134.GP10491@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 05:04:20PM +0100, Russell King - ARM Linux wrote:
> > On 10/14/2013 11:40 PM, Russell King - ARM Linux wrote:
> |  In the simplest case, a `%' followed by a digit N says to output
> | operand N at that point in the string.
> | 
> |  `%' followed by a letter and a digit says to output an operand in an
> | alternate fashion.  Four letters have standard, built-in meanings
> | described below.  The machine description macro `PRINT_OPERAND' can
> | define additional letters with nonstandard meanings.
> | 
> |  `%cDIGIT' can be used to substitute an operand that is a constant
> | value without the syntax that normally indicates an immediate operand.
> | ...
> |  `%lDIGIT' is used to substitute a `label_ref' into a jump instruction.
> 
> %lDIGIT is used (but not commented upon) in the gcc extended asm
> documentation where it talks about asm gotos, so there's probably a doc
> bug here too about whether these options should be described in the
> main doc as well.
> 
> Nevertheness, this section is documenting the _internals_ of gcc, and
> it seems perverse for a gcc backend to ignore something that is
> documented as being a standard part of gcc.

I'll make sure this gets fixed.

Will
