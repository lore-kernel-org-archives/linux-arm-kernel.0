From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 17 Aug 2013 01:36:19 -0300
Subject: [PATCH] ARM: fiq: Cast the first argument of flush_icache_range()
In-Reply-To: <CAOesGMgi3f4sYN9S7ywXqbLEjYaGcNCQ+_YTQYkv-UegunaZeg@mail.gmail.com>
References: <1376613333-7021-1-git-send-email-festevam@gmail.com>
 <CAOesGMgi3f4sYN9S7ywXqbLEjYaGcNCQ+_YTQYkv-UegunaZeg@mail.gmail.com>
Message-ID: <CAOMZO5DnrrPY4US5MVVVUaTW-ha2NLoOFG3GauDovVE+M6F5dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 17, 2013 at 1:24 AM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Aug 15, 2013 at 5:35 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Commit 2ba85e7af4 (ARM: Fix FIQ code on VIVT CPUs) causes the following build
>> warning:
>>
>> arch/arm/kernel/fiq.c: In function 'set_fiq_handler':
>> arch/arm/kernel/fiq.c:92:3: warning: passing argument 1 of 'cpu_cache.coherent_kern_range' makes integer from pointer without a cast [enabled by default]
>> arch/arm/kernel/fiq.c:92:3: note: expected 'long unsigned int' but argument is of type 'void *'
>>
>> Cast it as '(unsigned long)base' to avoid the warning.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
> This warning just showed up on mainline with the last arm fixes.
> Please send to the patch tracker.

Yes, I have already sent it to the patch system:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7819/1

Regards,

Fabio Estevam
