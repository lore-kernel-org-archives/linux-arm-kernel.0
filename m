From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Thu, 10 Mar 2011 15:05:27 +0200
Subject: [RFC PATCHv1 0/2] Export SoC info through sysfs
In-Reply-To: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
Message-ID: <20110310130527.GA2154@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Back after long silent :-)

On Wed, Mar 09, 2011 at 05:59:19PM +0100, ext Maxime Coquelin wrote:
> Here is the first version of the proposal to export SoC related information to user-space through sysFS interface.
> 
> This serie is to continue what has been discussed on the "socinfo" thread created by Eduardo Valentin:
> https://lkml.org/lkml/2010/5/11/364

Thanks for taking this further. Looks much more promising now :-).

> 
> The first patch introduces the common part, which provides an interface to the platform to register its name, and exports platform-defined IDs to user-space.
> The IDs strings can be provided in two ways: either with a pointer to the string, or by a callback returning the string.

Do you mind refreshing my memory why we need two ways of providing data to these attributes?
I mean, I think if we provide the attribute value during registration time should be enough
and simpler.

Unless you guys are talking about attributes with changes over the time, I don't really see
the need for the callback there. At least from the original scope, I don't see any attributes
which would be exported under soc info which would change over the time.

Or am I missing something?

> 
> The second patch is given as example for the ux500 architecture. It registers with the machine name "DB8500", and exports 3 informations (SoC unique ID, sili
> con revision and silicon process).
> 
> Here is the output for DB8500:
> root at ME:/sys/devices/system/soc ls -l
> -r--r--r--    1 root     root         4096 Jan 11 02:43 mach_name
> -r--r--r--    1 root     root         4096 Jan 11 02:43 process
> -r--r--r--    1 root     root         4096 Jan 11 02:43 revision
> -r--r--r--    1 root     root         4096 Jan 11 02:43 soc_id
> root at ME:/sys/devices/system/soc cat mach_name
> DB8500
> root at ME:/sys/devices/system/soc cat process
> Standard
> root at ME:/sys/devices/system/soc cat revision
> 2.0
> root at ME:/sys/devices/system/soc cat soc_id
> 2ba07ce9e5835d6185321e9577462ef2ea2129cf
> 
> Any comments are welcome.
> 
> Note that I will be off from 13th to 21th of March.
> 
> Regards,
> Maxime
> 
> -------------------------------------------------------------------------------
> 
> Maxime Coquelin (2):
>   Export SoC info through sysfs
>   ux500: Export U8500 SoC info through sysfs
> 
>  arch/arm/mach-ux500/id.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/base/Kconfig     |    4 ++
>  drivers/base/Makefile    |    1 +
>  drivers/base/soc.c       |   88 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h  |   33 ++++++++++++++++
>  5 files changed, 222 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/soc.c
>  create mode 100644 include/linux/sys_soc.h

-- 
Eduardo Valentin
