From: csd@broadcom.com (Christian Daudt)
Date: Fri, 26 Jul 2013 08:55:42 -0700
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726152918.GL29916@titan.lakedaemon.net>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
Message-ID: <51F29BFE.8000202@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resend in plain text]
On 13-07-26 08:29 AM, Jason Cooper wrote:
> On Fri, Jul 26, 2013 at 04:56:40PM +0200, Domenico Andreoli wrote:
>> From: Domenico Andreoli<domenico.andreoli@linux.com>
>>
>> arch/arm/mach-bcm contains a plurality of Broadcom SoCs, each configured
>> separately. As a matter of flexibility and maintenance, it needs to be
>> always included in the build.
> So if I'm building mach-kirkwood, I _have_ to build Broadcom?  What is
> the *specific* problem you're encountering that this solves?
  No it won't, as the Makefile inside mach-bcm will only pull in files 
based on ARCH_ settings. This move is so that a number different 
Broadcom SoCs can co-exist inside the mach-bcm directory.
>> Cc: Christian Daudt<csd@broadcom.com>
>> Cc:linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Domenico Andreoli<domenico.andreoli@linux.com>
>> ---
>>   arch/arm/Makefile |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: b/arch/arm/Makefile
>> ===================================================================
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -145,7 +145,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x0020
>>   # Machine directory name.  This list is sorted alphanumerically
>>   # by CONFIG_* macro name.
>>   machine-$(CONFIG_ARCH_AT91)		+= at91
>> -machine-$(CONFIG_ARCH_BCM)		+= bcm
>> +machine-y				+= bcm
>>   machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
>>   machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
>>   machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
>>
>>
This patch is already contained in Hauke's patchset from yesterday ( 
http://article.gmane.org/gmane.linux.ports.arm.kernel/254986) so you'll 
need to sync with him on it. In case yours goes in first:
Acked-by: Christian Daudt <csd@broadcom.com>

  Thanks,
    csd
