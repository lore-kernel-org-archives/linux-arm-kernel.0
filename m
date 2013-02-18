From: mmarek@suse.cz (Michal Marek)
Date: Mon, 18 Feb 2013 14:26:17 +0100
Subject: [RFC 1/2] Makefile: Add arch/arch/$(hdr-arch)/boot in header
 include path
In-Reply-To: <511E617E.6080206@wwwdotorg.org>
References: <1360918364-27960-1-git-send-email-hdoyu@nvidia.com>
 <511E617E.6080206@wwwdotorg.org>
Message-ID: <51222BF9.3040802@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.2.2013 17:25, Stephen Warren wrote:
> On 02/15/2013 01:52 AM, Hiroshi Doyu wrote:
>> This patch allows kernel source to include those DT
>> headers. For example:
>>
>> + #include <dts/tegra20-car.h>
>>
>> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
>> ---
>>  Makefile |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 0b4bf62..7f54cdb 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -364,7 +364,7 @@ LINUXINCLUDE    := \
>>  		-I$(srctree)/arch/$(hdr-arch)/include \
>>  		-Iarch/$(hdr-arch)/include/generated \
>>  		$(if $(KBUILD_SRC), -I$(srctree)/include) \
>> -		-Iinclude \
>> +		-Iinclude -Iarch/$(hdr-arch)/boot \

Would it be possible to use a new directory for this? At least POWER and
x86 have several unrelated headers in their arch/*/boot that are only
meant for the bootstrap code.

Michal
