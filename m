From: james.morse@arm.com (James Morse)
Date: Thu, 28 Apr 2016 13:23:32 +0100
Subject: [PATCH v9 12/14] PM / Hibernate: Call flush_icache_range() on
 pages restored in-place
In-Reply-To: <20160428121517.GF24693@arm.com>
References: <1461775633-29715-1-git-send-email-james.morse@arm.com>
 <1461775633-29715-13-git-send-email-james.morse@arm.com>
 <20160428121517.GF24693@arm.com>
Message-ID: <572200C4.90701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 28/04/16 13:15, Will Deacon wrote:
> On Wed, Apr 27, 2016 at 05:47:11PM +0100, James Morse wrote:
>>  kernel/power/swap.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>> index 12cd989dadf6..a30645d2e93f 100644
>> --- a/kernel/power/swap.c
>> +++ b/kernel/power/swap.c
>> @@ -37,6 +37,14 @@
>>  #define HIBERNATE_SIG	"S1SUSPEND"
>>  
>>  /*
>> + * When reading an {un,}compressed image, we may restore pages in place,
>> + * in which case some architectures need these pages cleaning before they
>> + * can be executed. We don't know which pages these may be, so clean the lot.
>> + */
>> +bool clean_pages_on_read = false;
>> +bool clean_pages_on_decompress = false;
> 
> Should these be static?

Bother, yes.

(They probably shouldn't be explicitly initialised either...)


Thanks,

James
