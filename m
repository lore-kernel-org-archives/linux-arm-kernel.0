From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 27 Apr 2012 08:41:11 +1000
Subject: [PATCH 04/17] ARM: ep93xx: use machine specific hook for late init
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F002069887EDC4@AUSP01VMBX24.collaborationhost.net>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-5-git-send-email-shawn.guo@linaro.org>
 <4F99B9EB.6060806@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F002069887EDC4@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F99CF07.5020006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/04/12 07:49, H Hartley Sweeten wrote:

> On Thursday, April 26, 2012 2:11 PM, Ryan Mallon wrote:
>> On 27/04/12 01:38, Shawn Guo wrote:
>>
>>> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>>> Cc: Ryan Mallon <rmallon@gmail.com>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>
>>
>> Why do we want this? It increases the size of the code and changes
>> a static function to a non-static one that now requires ifdefery
>> to handle the !CONFIG_CRUNCH case. I don't see the value in this
>> patch?
> 
> Ryan,
> 
> See Shawn's "[PATCH 00/17] arch/arm/mach-* late_initcall cleanup".
> 
> I haven't looked closely at this yet. I think there may be some platforms
> where the late_initcall's might cause a problem when making an ARM
> unified kernel.


Hmm, I see. It's a bit annoying that it makes the code less clean, but I
can't really see any other nice way of doing it :-/.

~Ryan
