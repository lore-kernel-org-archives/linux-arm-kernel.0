From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 30 Oct 2013 08:53:08 -0700
Subject: [GIT PULL] prefetch support for 3.13
In-Reply-To: <20131030152553.GD16735@n2100.arm.linux.org.uk>
References: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
 <527124B3.9090305@nvidia.com> <20131030152553.GD16735@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1310300846520.12006@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, 30 Oct 2013, Russell King - ARM Linux wrote:

> On Wed, Oct 30, 2013 at 08:24:35AM -0700, Paul Walmsley wrote:
>> Hi Will et al.,
>>
>> On 10/09/2013 10:13 AM, Will Deacon wrote:
>>> Hi Russell,
>>>
>>> Please pull the following patches for 3.13. They add support for the pldw
>>> instruction (prefetch with intent to modify) in ARMv7 SMP cores, which is
>>> then used to gain a measurable performance boost for particular atomic
>>> sequences.
>>
>> Looks like the pldw changes require binutils >= 2.21.  Might be worth
>> considering a patch to update Documentation/Changes?
>
> Not really - because that says "for all architectures the minimum
> requirement is now 2.21 or later" and that's certainly not the case.
>
> It's only ARMv7 which requires this.

Would you consider something like the following?


- Paul

From: Paul Walmsley <pwalmsley@nvidia.com>
Date: Wed, 30 Oct 2013 08:51:26 -0700
Subject: [PATCH] Documentation/Changes: update binutils version requirement
  for ARMv7 builds

ARMv7 builds now make use of the pldw opcode and the ".arch_extension mp"
pragma.  These aren't supported in binutils prior to 2.21.  So, update
Documentation/Changes accordingly.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
---
  Documentation/Changes | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/Documentation/Changes b/Documentation/Changes
index b175808..97fcbdf 100644
--- a/Documentation/Changes
+++ b/Documentation/Changes
@@ -67,6 +67,9 @@ assembling the 16-bit boot code, removing the need for as86 to compile
  your kernel.  This change does, however, mean that you need a recent
  release of binutils.

+ARMv7 builds require binutils 2.21 or later due to the use of the pldw
+opcode and ".arch_extension mp".
+
  Perl
  ----

-- 
1.8.1.5
