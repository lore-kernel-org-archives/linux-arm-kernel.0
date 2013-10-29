From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 29 Oct 2013 20:18:03 +0100
Subject: [PATCH v3 02/10] spmi: Linux driver framework for SPMI
In-Reply-To: <526FE2B6.8050701@codeaurora.org>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <149bbfe89e37376cc176c3aeb6c1fab9e4fd2b91.1382985169.git.joshc@codeaurora.org>
 <526FD278.8080102@metafoo.de> <20131029155616.GG20207@joshc.qualcomm.com>
 <526FE2B6.8050701@codeaurora.org>
Message-ID: <527009EB.3010704@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2013 05:30 PM, Stephen Boyd wrote:
> On 10/29/13 08:56, Josh Cartwright wrote:
>>
>>>> +#define to_spmi_controller(d) container_of(d, struct spmi_controller, dev)
>>> Should be a inline function for better type safety.
>> Sounds good.  Will change the to_spmi_*() macros.
> 
> I was under the impression that container_of() already does type
> checking. At least it will ensure that typeof(d) == typeof(dev) in the
> above example which is about as good as it can get.

Well you'll get a warning, but the quality of the warning message is much
better when an inline function is used.

warning: initialization from incompatible pointer type

vs.

warning: Passing argument 1 of to_smpi_controller() from incompatible
pointer type. Expected struct device * got struct driver *


- Lars
