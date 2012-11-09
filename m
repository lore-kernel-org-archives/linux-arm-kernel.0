From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 9 Nov 2012 10:29:43 -0600
Subject: [PATCH] ARM: OMAP2+: Prevent redefinition errors for soc.h
In-Reply-To: <20121109162259.GO6801@atomide.com>
References: <1352477961-7634-1-git-send-email-jon-hunter@ti.com>
 <20121109162259.GO6801@atomide.com>
Message-ID: <509D2F77.6090702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/09/2012 10:22 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [121109 08:21]:
>> If the header soc.h is included more than once in a source (for example
>> once directly by the source file and once indirectly by another header
>> file), then the compiler will generate redefintion errors for the macros
>> in soc.h. Prevent this by only allowing the content in soc.h to be
>> included once.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>
>> Please note that I ran into this problem when rebasing my dmtimer fixes
>> series [1] on Tony's Linux-OMAP master branch. I am including plat/cpu.h
>> in dmtimer.h and I found several other files including dmtimer.h are also
>> including soc.h and so generate a lot of errors.
>>
>> [1] http://marc.info/?l=linux-omap&m=135231490218361&w=2
> 
> As these headers are private to mach-omap2, I'd rather not allow including
> them more than once so we can eventually clean up the includes further.
> 
> We should include the headers directly where used, except for the
> legacy board-*.c files that will be going away anyways.
> 
> Including the files directly should fix this easily, if not let me
> know.

The alternative fix is to ensure anyone including dmtimer.h also
includes soc.h. However, I did not know if we should have such a
dependency. If you are ok with that then that is what I will do for now.
It is not a massive change.

Cheers
Jon
