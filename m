From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Aug 2013 14:44:49 +0100
Subject: [PATCHv3 2/5] arm64: factor out spin-table boot method
In-Reply-To: <alpine.LFD.2.03.1308141348130.14472@syhkavp.arg>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
 <1376497228-20543-3-git-send-email-mark.rutland@arm.com>
 <alpine.LFD.2.03.1308141348130.14472@syhkavp.arg>
Message-ID: <20130830134449.GE4650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 06:51:09PM +0100, Nicolas Pitre wrote:
> On Wed, 14 Aug 2013, Mark Rutland wrote:
> > The smp.pen.text section is also removed, as the pen can live in
> > head.text without problem.
> 
> Why was there a special section for the pen code initially?

Grep'ing the old git logs for the arm64 development, it looks like it
was introduced as part of the first proposal for the booting protocol
where all the CPUs got into the kernel at the same time (secondaries at
offset 0x80). IIRC you nak'ed this during the private review but we
forgot about this section.

-- 
Catalin
