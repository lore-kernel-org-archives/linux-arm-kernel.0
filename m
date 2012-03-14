From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 Mar 2012 12:16:16 -0600
Subject: [RFC PATCH] of: DMA helpers: manage generic requests specification
In-Reply-To: <4F60D9BB.9060709@atmel.com>
References: <4F22DEF2.5000807@ti.com>
 <1330527248-4350-1-git-send-email-nicolas.ferre@atmel.com>
 <20120305153648.GG27229@ponder.secretlab.ca> <4F60D9BB.9060709@atmel.com>
Message-ID: <4F60E070.8040003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 11:47 AM, Nicolas Ferre wrote:
...
> I do have the will to avoid the treats of memory corruption in case of
> malformed DT data, as Stephen was saying. But, on the other hand I do
> not know really if this can happen: if the .xlate() function which is
> provided by the DMA controller is well written, it should check for
> proper args_count or maximum string size. I do not have the feeling that
> adding an enum will enforce the security here.
> 
> Do you know a way to enforce security of this "void *" parameter or the
> check of number of cells + the due diligence of .xlate() function
> writers will be enough?

I guess if the only source of the data is a driver's of_xlate function,
and it's only being passed back to that same driver and never
interpreted elsewhere, then its probably reasonable to assume that's
enough for safety.
