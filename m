From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 26 Apr 2012 16:49:27 -0500
Subject: [PATCH 04/17] ARM: ep93xx: use machine specific hook for late init
In-Reply-To: <4F99B9EB.6060806@gmail.com>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-5-git-send-email-shawn.guo@linaro.org>
 <4F99B9EB.6060806@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F002069887EDC4@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 26, 2012 2:11 PM, Ryan Mallon wrote:
> On 27/04/12 01:38, Shawn Guo wrote:
>
>> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>
>
> Why do we want this? It increases the size of the code and changes
> a static function to a non-static one that now requires ifdefery
> to handle the !CONFIG_CRUNCH case. I don't see the value in this
> patch?

Ryan,

See Shawn's "[PATCH 00/17] arch/arm/mach-* late_initcall cleanup".

I haven't looked closely at this yet. I think there may be some platforms
where the late_initcall's might cause a problem when making an ARM
unified kernel.

Actually I have a question about the ARM unified kernel.

Wouldn't every mach-* supported by a unified kernel have to at least
be the same ARM variant (i.e. they share a common compiler setup)?
The ep93xx is an arm920t. Are there any other mach-* types that use
that?

Regards,
Hartley
