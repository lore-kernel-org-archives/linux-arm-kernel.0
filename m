From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Thu, 16 Feb 2012 16:24:36 +0100
Subject: [PATCH 1/2] ARM: remove memmove from boot/compressed/string.c
In-Reply-To: <20120216150933.GD19779@game.jcrosoft.org>
References: <1329404057-26346-1-git-send-email-michael.opdenacker@free-electrons.com>
 <1329404057-26346-2-git-send-email-michael.opdenacker@free-electrons.com>
 <20120216150933.GD19779@game.jcrosoft.org>
Message-ID: <4F3D1FB4.7070901@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On 02/16/2012 04:09 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:54 Thu 16 Feb     , Michael Opdenacker wrote:
>> This patch removes the memmove function from boot/compressed/string.c
>> - This definition conflicts with the one in lib/decompress_unxz.c
>>   This change is required to support xz compression on ARM.
>> - memmove is not used in any of the other decompressors
>>   in lib/decompress_*.c
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
>> ---
>>  arch/arm/boot/compressed/string.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/compressed/string.c b/arch/arm/boot/compressed/string.c
>> index 36e53ef..369443a 100644
>> --- a/arch/arm/boot/compressed/string.c
>> +++ b/arch/arm/boot/compressed/string.c
>> @@ -40,6 +40,7 @@ void *memcpy(void *__dest, __const void *__src, size_t __n)
>>  	return __dest;
>>  }
>>  
>> +/*
>>  void *memmove(void *__dest, __const void *__src, size_t count)
>>  {
>>  	unsigned char *d = __dest;
>> @@ -55,6 +56,7 @@ void *memmove(void *__dest, __const void *__src, size_t count)
>>  		d[count] = s[count];
>>  	return __dest;
>>  }
>> +*/
> so why not drop it cleanly
Oooops. Well spotted. You no longer see the obviously stupid stuff in
your own code.

I'll send an update soon.

Thanks!

Michael.

-- 
Michael Opdenacker, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 484 253 396
