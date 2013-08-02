From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 02 Aug 2013 15:08:56 +0200
Subject: [PATCHv2 3/9] ARM: kirkwood: remove support for legacy booting of
 Guruplug
In-Reply-To: <20130802124932.GX5882@titan.lakedaemon.net> (Jason Cooper's
 message of "Fri, 2 Aug 2013 08:49:32 -0400")
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130802124932.GX5882@titan.lakedaemon.net>
Message-ID: <87txj8tf2v.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

> On Thu, Aug 01, 2013 at 05:07:29PM +0200, Thomas Petazzoni wrote:
>> The Kirkwood Guruplug platform has already been converted to the
>> Device Tree, so we can remove the legacy booting option for this
>> platform.
>> 
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  arch/arm/mach-kirkwood/Kconfig          |   7 --
>>  arch/arm/mach-kirkwood/Makefile         |   1 -
>>  arch/arm/mach-kirkwood/guruplug-setup.c | 133 --------------------------------
>>  3 files changed, 141 deletions(-)
>>  delete mode 100644 arch/arm/mach-kirkwood/guruplug-setup.c
>> 
> ...
>> diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
> ...
>> -static struct mv_sata_platform_data guruplug_sata_data = {
>> -	.n_ports	= 1,
>> -};
>
> This just caught my eye.  iirc, there were two flavors of the Guruplug,
> the Guruplug, and the Guruplug Server Plus (had eSATA plus something
> else).

the difference between the guruplug server and the server plus is that
there's one extra ethernet port and a eSATA port on server plus
(iirc, there's also the guruplug display but it's a very different
beast)

Arnaud
