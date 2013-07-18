From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 18 Jul 2013 12:21:38 +0200
Subject: [PATCH v4 5/5] ASoC: atmel-ssc: remove clk_disable_unprepare
 call from critical section
In-Reply-To: <20130718095337.GD22506@sirena.org.uk>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
 <1374133720-27362-1-git-send-email-b.brezillon@overkiz.com>
 <20130718095337.GD22506@sirena.org.uk>
Message-ID: <51E7C1B2.8000206@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2013 11:53, Mark Brown wrote:
> On Thu, Jul 18, 2013 at 09:48:40AM +0200, Boris BREZILLON wrote:
>> clk_prepare/unprepare (and indirectly clk_prepare_enable/disable_unprepare)
>> may sleep and thus cannot be called in critical section.
> I'm missing patches 1-4?
I can send you the whole series if you want (already sent to LKML and 
LAKML).

But I'd like to understand who I should send patches from this series to.

Here's my approach:
1) send all patches of the series to at91 maintainers (as they are 
directly concerned).
2) send all patches of the series LKML and LAKML
3) send each patch of the series to the persons and mailing lists 
concerned by this patch :
     contributors and maintainers (retrieved by get_maintainer.pl script)

Could you tell me if I'm doing something wrong?

Thanks

Best Regards,

Boris
