From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Thu, 31 May 2018 14:51:22 +0300
Subject: [PATCH v2 1/5] crypto: ccree: correct host regs offset
In-Reply-To: <20180529161248.fphjnceozoyxqy7v@verge.net.au>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-2-git-send-email-gilad@benyossef.com>
 <20180529161248.fphjnceozoyxqy7v@verge.net.au>
Message-ID: <CAOtvUMfoyuaGac29WUYqvfRr1S7Fof3FgMZo_3K7EaozqbeT6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 7:12 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, May 24, 2018 at 03:19:06PM +0100, Gilad Ben-Yossef wrote:
>> The product signature and HW revision register have different offset on the
>> older HW revisions.
>> This fixes the problem of the driver failing sanity check on silicon
>> despite working on the FPGA emulation systems.
>>
>> Fixes: 27b3b22dd98c ("crypto: ccree - add support for older HW revs")
>
> Did the above introduce a regression that is fixed by this patch
> or did it add a feature that only works with this patch?
>

Sort of in between - the first patch made more devices work but
unreliability (it will sometime work, sometime doesn't).
This one make it work reliably.

> In the case of the latter I would drop the Fixes tag,
> but I don't feel strongly about it.
>
>> Cc: stable at vger.kernel.org
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> Minor not below not withstanding,
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thank you for the review and help :-)

Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
