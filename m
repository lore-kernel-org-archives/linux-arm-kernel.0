From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 27 Sep 2012 09:39:28 -0600
Subject: [RFC PATCH 1/3] kbuild: introduce cmd_dtc_cpp
In-Reply-To: <20120927054438.GM17667@game.jcrosoft.org>
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
 <1348599998-2729-2-git-send-email-swarren@wwwdotorg.org>
 <20120927054438.GM17667@game.jcrosoft.org>
Message-ID: <50647330.9030306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 11:44 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:06 Tue 25 Sep     , Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> cmd_dtc_cpp runs the C pre-processor on the input .dts file before
>> passing it to dtc for final compilation. This allows used of #define
>> within the .dts file.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  scripts/Makefile.lib |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 0be6f11..e3a149e 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -266,6 +266,9 @@ $(obj)/%.dtb.S: $(obj)/%.dtb
>>  quiet_cmd_dtc = DTC     $@
>>  cmd_dtc = $(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 $(DTC_FLAGS) -d $(depfile) $<
>>  
>> +quiet_cmd_dtc_cpp = DTC+CPP $@
>> +cmd_dtc_cpp = $(CC) -E -Wp,-MD,$(depfile) -xc $< | $(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 $(DTC_FLAGS) -
>
> this should go to Makefile.build

Hmm. Consistency with the existing cmd_dtc right above would dictate
otherwise.

> and we should keep the same nomecalture as lds with lds.S
> 
> here dts.S

I don't agree; see my previous response to the same assertion.

> and is it possible to cmd with it

I don't understand the question.
