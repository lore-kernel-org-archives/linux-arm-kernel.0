From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 15 Feb 2013 08:56:18 +0200
Subject: [PATCH 7/9] remoteproc: omap: depend on OMAP_MBOX_FWK
In-Reply-To: <20130214225557.GI11362@atomide.com>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-8-git-send-email-arnd@arndb.de>
 <20130214225557.GI11362@atomide.com>
Message-ID: <CAK=WgbaPGOi+=zR0VNMZ+iJxd0NEzxXG86EBSsT+4u9tH=rCSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 12:55 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Arnd Bergmann <arnd@arndb.de> [130214 14:51]:
>> Patch a62a6e98 "ARM: OMAP2+: Disable code that currently does not work
>> with multiplaform" makes the OMAP_MBOX_FWK option depend on !MULTIPLATFORM,
>> which means we cannot simply select that symbol from OMAP_REMOTEPROC.
>>
>> Turning the 'select' into 'depends on' ensures that all dependencies
>> are correct until OMAP_MBOX_FWK loses its dependency.
>>
>> Without this patch, building allmodconfig results in:
>>
>> drivers/remoteproc/omap_remoteproc.c:31:26: fatal error: plat/mailbox.h: No such file or directory
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>

Feel free to take this via your tree - thanks.
