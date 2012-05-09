From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 09 May 2012 14:35:59 +0200
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
Message-ID: <4FAA64AF.9010507@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2012 11:27 AM, Linus Walleij wrote:
> On Wed, May 2, 2012 at 6:27 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> [...]
>>> IIRC had pointed Lars to this API, but quick check of code reveals that
>>> this is unused. I think returning residue as remaining bytes of current
>>> "block" makes sense. This easily gives knowledge of where DMA pointer is
>>> wrt current ongoing transaction. Was that your meaning of end of cyclic
>>> buffer, not sure what end means here?
>>
>> I think the residue thing was something Linus created, which is why he's
>> included in this thread...
> 
> Lars-Peter Clausen is the person writing the ALSA SoC wrapper.
> Lars-Peter: do you have plans to implement residue calls for
> getting buffer position?
> 

At the time the ALSA wrapper was written there were no DMA engine
implementations which actually provided residue information, so that's why I
left it out. But it is really straight forward to add it, given that we can
agree on a common definition of what the residue should be for cyclic
transfers. Russel's suggestion to define it as the number of bytes until the
end of the buffer is in my opinion the best option.

- Lars
