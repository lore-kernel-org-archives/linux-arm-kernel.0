From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 31 Oct 2014 10:03:27 +0800
Subject: [RFC V5 3/3] arm64:add bitrev.h file to support rbit instruction
In-Reply-To: <20141030120127.GC32589@arm.com>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
 <1414392371.8884.2.camel@perches.com>
 <CAL_JsqJYBoG+nrr7R3UWz1wrZ--Xjw5X31RkpCrTWMJAePBgRg@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E010D1825F@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18260@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18261@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18264@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18265@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18266@CNBJMBX05.corpusers.net>
 <20141030120127.GC32589@arm.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D1826F@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Thursday, October 30, 2014 8:01 PM
> To: Wang, Yalin
> Cc: 'Rob Herring'; 'Joe Perches'; 'Russell King - ARM Linux'; 'linux-
> kernel at vger.kernel.org'; 'akinobu.mita at gmail.com'; 'linux-mm at kvack.org';
> 'linux-arm-kernel at lists.infradead.org'
> Subject: Re: [RFC V5 3/3] arm64:add bitrev.h file to support rbit
> instruction
> 
> > +static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
> > +{
> > +	if (__builtin_constant_p(x)) {
> > +		x = (x >> 16) | (x << 16);
> > +		x = ((x & 0xFF00FF00) >> 8) | ((x & 0x00FF00FF) << 8);
> > +		x = ((x & 0xF0F0F0F0) >> 4) | ((x & 0x0F0F0F0F) << 4);
> > +		x = ((x & 0xCCCCCCCC) >> 2) | ((x & 0x33333333) << 2);
> > +		return ((x & 0xAAAAAAAA) >> 1) | ((x & 0x55555555) << 1);
> 
> Shouldn't this part be in the generic code?

Good  idea, I will change this part into linux/bitrev.h .
Thanks
