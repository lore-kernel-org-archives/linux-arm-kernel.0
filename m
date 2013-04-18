From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 18 Apr 2013 15:10:42 +0100
Subject: [PATCH v11 0/3] Another round of ARMv7-M patches
In-Reply-To: <20130417193746.GR30416@pengutronix.de>
References: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <516EDEDA.1000108@arm.com> <20130417193746.GR30416@pengutronix.de>
Message-ID: <516FFEE2.1070304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/04/13 20:37, Uwe Kleine-K?nig wrote:
> Hello,
>
> On Wed, Apr 17, 2013 at 06:41:46PM +0100, Jonathan Austin wrote:
>> The only comment I have left is that I'd really like the
>> BASEADDRESS_V7M_SCB namespaced like the rest of the V7M defines
> The idea behind this naming is that V7M_SCB_BASEADDRESS is in the same

Do you mean is *not* in?

> namespace as V7M_SCB_CPUID so I opened a new namespace for base
> addresses. Don't you like it only because it's new?

I think because
readl(V7M_SCB_BASEADDRESS + V7M_SCB_CPUID)

reads more cleanly than

readl(BASEADDRESS_V7M_SCB + V7M_SCB_CPUID)

But it isn't a big enough issue to delay merging these - more a 
preference/style issue. As you ask: does anyone else have any thoughts?

Jonny
> Do others have
> thoughts here?
>
>> With that said, please feel free to add for the series:
>>
>> Reviewed-by: Jonathan Austin <jonathan.austin@arm.com>
>> Tested-by: Jonathan Austin <jonathan.austin@arm.com
> Thanks
> Uwe
>
