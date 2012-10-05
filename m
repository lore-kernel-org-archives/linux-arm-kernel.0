From: cjb@laptop.org (Chris Ball)
Date: Fri, 05 Oct 2012 10:48:08 -0400
Subject: [PATCH] ARM: pxa: Fix build error caused by sram.h rename
In-Reply-To: <201210022027.45461.arnd@arndb.de> (Arnd Bergmann's message of
 "Tue, 2 Oct 2012 20:27:45 +0000")
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-7-git-send-email-arnd@arndb.de>
 <87fw5wofwm.fsf_-_@octavius.laptop.org>
 <201210022027.45461.arnd@arndb.de>
Message-ID: <87d30xgel3.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Oct 02 2012, Arnd Bergmann wrote:
> On Tuesday 02 October 2012, Chris Ball wrote:
>> Commit 293b2da1b61 ("ARM: pxa: move platform_data definitions")
>> renamed arch/arm/mach-mmp/include/mach/sram.h to
>> include/linux/platform_data/dma-mmp_tdma.h, but didn't update
>> mmp-pcm.c which uses the header.  Fix the build error.
>> 
>> Signed-off-by: Chris Ball <cjb@laptop.org>
>> ---
>>  sound/soc/pxa/mmp-pcm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Sorry I didn't catch this earlier. The file was only recently added
> and somehow didn't appear in my build tests.

Thanks.  Do you want to send this to mainline, or should Mark do it?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
