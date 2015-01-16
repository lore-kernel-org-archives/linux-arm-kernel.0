From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 16 Jan 2015 09:42:23 +0800
Subject: [RFC V6 2/3] arm:add bitrev.h file to support rbit instruction
In-Reply-To: <20150114163800.GZ12302@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103E010D18273@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18275@CNBJMBX05.corpusers.net>
 <20141113235322.GC4042@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103E010D1829B@CNBJMBX05.corpusers.net>
 <20141114095812.GG4042@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103E688B313C6@CNBJMBX05.corpusers.net>
 <20150108184059.GZ12302@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103EDAF89E195@CNBJMBX05.corpusers.net>
 <20150109111048.GE12302@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103EDAF89E198@CNBJMBX05.corpusers.net>
 <20150114163800.GZ12302@n2100.arm.linux.org.uk>
Message-ID: <35FD53F367049845BC99AC72306C23D103EDAF89E1B0@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Thursday, January 15, 2015 12:38 AM
> To: Wang, Yalin
> Cc: 'Ard Biesheuvel'; 'Will Deacon'; 'linux-kernel at vger.kernel.org';
> 'akinobu.mita at gmail.com'; 'linux-mm at kvack.org'; 'Joe Perches'; 'linux-arm-
> kernel at lists.infradead.org'
> Subject: Re: [RFC V6 2/3] arm:add bitrev.h file to support rbit instruction
> 
> On Fri, Jan 09, 2015 at 08:40:56PM +0800, Wang, Yalin wrote:
> > Oh, I see,
> > How about change like this:
> > +	select HAVE_ARCH_BITREVERSE if ((CPU_V7M || CPU_V7) && !CPU_V6 &&
> > +!CPU_V6K)
> > I am not sure if I also need add some older CPU types like !CPU_ARM9TDMI
> &&?!CPU_ARM940T ?
> >
> > Another solution is:
> > +	select HAVE_ARCH_BITREVERSE if ((CPU_32V7M || CPU_32V7) && !CPU_32V6
> > +&& !CPU_32V5 && !CPU_32V4 && !CPU_32V4T && !CPU_32V3)
> >
> > By the way, I am not clear about the difference between CPU_V6 and
> > CPU_V6K, could you tell me? :)
> 
> I think
> 
> 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> 
> is sufficient - we don't support mixing pre-v6 and v6+ CPU architectures
> into a single kernel.
> 
Ok, I will re-send a patch. 

Thanks
