From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Nov 2010 10:12:54 -0800
Subject: [PATCH] ARM: Fix find_next_zero_bit and related assembly
In-Reply-To: <201011231528.25668.jajones@nvidia.com>
References: <1289524615-22484-1-git-send-email-jajones@nvidia.com>	<alpine.LFD.2.00.1011231625380.9313@xanadu.home>
	<201011231528.25668.jajones@nvidia.com>
Message-ID: <4CED55A6.5090608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2010 03:28 PM, James Jones wrote:
> On Tuesday 23 November 2010 13:26:47 Nicolas Pitre wrote:
>> On Thu, 11 Nov 2010, James Jones wrote:
>>> The find_next_bit, find_first_bit, find_next_zero_bit
>>> and find_first_zero_bit functions were not properly
>>> clamping to the maxbit argument at the bit level. They
>>> were instead only checking maxbit at the byte level.
>>> To fix this, add a compare and a conditional move
>>> instruction to the end of the common bit-within-the-
>>> byte code used by all the functions and be sure not to
>>> clobber the maxbit argument before it is used.
>>>
>>> Signed-off-by: James Jones <jajones@nvidia.com>
>>> Tested-by: Stephen Warren <swarren@nvidia.com>
>> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>>
>> Please send to RMK's patch system.
> Thanks for the review.  It's already in the patch system, but I updated the 
> entry to include your reviewed-by line.

Should this be sent to the stable tree too?
