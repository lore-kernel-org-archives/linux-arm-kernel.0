From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 27 Sep 2012 09:40:20 -0600
Subject: [RFC PATCH 2/3] ARM: use cmd_dtc_cpp for compilation of *.dts-cpp
 to *.dtb
In-Reply-To: <20120927054700.GN17667@game.jcrosoft.org>
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
 <1348599998-2729-3-git-send-email-swarren@wwwdotorg.org>
 <20120927054700.GN17667@game.jcrosoft.org>
Message-ID: <50647364.7090501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 11:47 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:06 Tue 25 Sep     , Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> This allows DT source files to use the C pre-processor. A new file
>> extension is introduced for this purpose, since use of the pre-processor
>> must be optional; any property or node name that starts with "#" must be
>> escaped to prevent the pre-processor attempting to interpret it as a
>> directive. For this reason, skeleton.dtsi-cpp is introduced for *.dts-cpp
>> to include.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  arch/arm/boot/Makefile              |    3 +++
>>  arch/arm/boot/dts/skeleton.dtsi-cpp |   13 +++++++++++++
>>  2 files changed, 16 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/skeleton.dtsi-cpp
>>
>> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
>> index 3fdab01..c5d7fca 100644
>> --- a/arch/arm/boot/Makefile
>> +++ b/arch/arm/boot/Makefile
>> @@ -65,6 +65,9 @@ targets += $(dtb-y)
>>  $(obj)/%.dtb: $(src)/dts/%.dts FORCE
>>  	$(call if_changed_dep,dtc)
>>  
>> +$(obj)/%.dtb: $(src)/dts/%.dts-cpp FORCE
>> +	$(call if_changed_dep,dtc_cpp)
>> +
>
> move this to Makefile.build so we wan use it acroos arch

That would be an unrelated cleanup patch; the existing *.dts->*.dtb rule
is not there.
