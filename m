From: zonque@gmail.com (Daniel Mack)
Date: Wed, 14 Aug 2013 18:15:51 +0200
Subject: [v2 rebased 1/2] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <20130814124643.GP23006@n2100.arm.linux.org.uk>
References: <1376483121-11306-1-git-send-email-zonque@gmail.com>
 <20130814124643.GP23006@n2100.arm.linux.org.uk>
Message-ID: <520BAD37.1070404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.08.2013 14:46, Russell King - ARM Linux wrote:
> On Wed, Aug 14, 2013 at 02:25:20PM +0200, Daniel Mack wrote:
>> In order to report the channel's residue, we have to memorize the first
>> dma buffer position when the channel is configured.
> 
> This is actually broken, and I'm surprised that Vinod even suggested it.
> 
> Think about what happens with a scatter-gather list where the addresses
> of each element really are scattered in memory.  Let's say that the
> N'th element is at a lower address than the first element, and we're on
> that N'th element.  What happens when curr is less than chan->start_addr
> here:

Yes, you're right of course.

Then, we have no other chance than walking the list of all linked
descriptors. I just implemented this and it works. That approach also
saves us to memorize the start_addr in the channel struct.

I'll resend both patches - could you have another look?


Thanks,
Daniel
