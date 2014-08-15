From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 15 Aug 2014 08:43:23 -0500
Subject: [PATCHv2 3/3] ARM: dts: socfpga: memreserve first 4KB for SMP code
In-Reply-To: <20140815112758.GE15621@leverpostej>
References: <1408050814-28595-1-git-send-email-dinguyen@opensource.altera.com>
 <1408050814-28595-4-git-send-email-dinguyen@opensource.altera.com>
 <20140815112758.GE15621@leverpostej>
Message-ID: <53EE0E7B.4010208@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 8/15/14, 6:27 AM, Mark Rutland wrote:
> Hi Dinh,
> 
> On Thu, Aug 14, 2014 at 10:13:34PM +0100, dinguyen at opensource.altera.com wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> The SOCFPGA's SMP code uses 0x0 for as the location for the trampoline to
>> bring secondary cores online. This patch adds a /memreserve/ section to
>> reserve the first 4K for the SMP trampoline code.
> 
> I'm slightly confused. 
> 
> Sorry to split hairs here, but I think the comment is subtly wrong.
> 
> The trampoline code seems to be placed in this location by Linux, so
> it's not that we're protecting the trampoline code, but rather we're
> preserving the location for future use.

Yes, you're correct. Preserving this location for possible copying of
the trampoline code for SMP usage is more of a correct statement.
> 
> I take it that the reset address isn't configurable?

No, I don't believe it is on this platform.

Thanks for the review. I will spin a V3 with an updated commit message.

Dinh
