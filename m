From: khilman@ti.com (Kevin Hilman)
Date: Fri, 09 Sep 2011 14:51:40 -0700
Subject: [PATCH 14/22] OMAP2+: voltage: split voltage controller (VC) code
	into dedicated layer
In-Reply-To: <CAORVsuWEZmChCjy8dJV+acosr_8N9XN0VL8-L6HWaKnZkoqqYA@mail.gmail.com>
	(Jean Pihet's message of "Wed, 7 Sep 2011 12:42:20 +0200")
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-15-git-send-email-khilman@ti.com>
	<CAORVsuWEZmChCjy8dJV+acosr_8N9XN0VL8-L6HWaKnZkoqqYA@mail.gmail.com>
Message-ID: <87vct1s7tf.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Kevin,
>
> On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
>> As part of the voltage layer cleanup, split out VC specific code into
>> a dedicated VC layer. ?This patch primarily just moves VC code from
>> voltage.c into vc.c, and adds prototypes to vc.h.
>>
>> No functional changes.
>>
>> For readability, each function was given a local 'vc' pointer:
>>
>> ? ?struct omap_vc_instance_data *vc = voltdm->vdd->vc_data;
>>
>> and a global replace of s/vdd->vc_data/vc/ was done.
>>
>> Also vc_init was renamed to vc_init_channel to reflect that this is
>> per-VC channel initializtion.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> ?arch/arm/mach-omap2/Makefile ?| ? ?2 +-
>> ?arch/arm/mach-omap2/vc.c ? ? ?| ?276 +++++++++++++++++++++++++++++++++++++++++
>> ?arch/arm/mach-omap2/vc.h ? ? ?| ? 12 ++
>> ?arch/arm/mach-omap2/voltage.c | ?264 +--------------------------------------
>> ?4 files changed, 293 insertions(+), 261 deletions(-)
>> ?create mode 100644 arch/arm/mach-omap2/vc.c
>>
> ...
>
>> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
>> new file mode 100644
>> index 0000000..98f5a4b
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/vc.c
>> @@ -0,0 +1,276 @@
>
> The copyright notice is missing.
>

oops, will add.

Thanks,

Kevin
