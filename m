From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 16 Jan 2015 19:55:51 +0100
Subject: [PATCH v7 15/20] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <54B91C0D.1050804@arm.com>
References: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
 <1421253084-9663-16-git-send-email-andre.przywara@arm.com>
 <20150115122145.GU26222@cbox> <54B91C0D.1050804@arm.com>
Message-ID: <CAMJs5B8-Zgoq688FFYf2wnGGo3TVRLSZ_s4ETG9Uyh2ie2ouAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 3:11 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi Christoffer,
>
> On 15/01/15 12:21, Christoffer Dall wrote:
>> On Wed, Jan 14, 2015 at 04:31:19PM +0000, Andre Przywara wrote:
>>> With everything separated and prepared, we implement a model of a
>>> GICv3 distributor and redistributors by using the existing framework
>>> to provide handler functions for each register group.
>>>
>>> Currently we limit the emulation to a model enforcing a single
>>> security state, with SRE==1 (forcing system register access) and
>>> ARE==1 (allowing more than 8 VCPUs).
>>>
>>> We share some of the functions provided for GICv2 emulation, but take
>>> the different ways of addressing (v)CPUs into account.
>>> Save and restore is currently not implemented.
>>>
>>> Similar to the split-off of the GICv2 specific code, the new emulation
>>> code goes into a new file (vgic-v3-emul.c).
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>
>>
>> Drum roll....
>>
>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>
> Awesome, many thanks for that!
> If you need any help with any kind of merging/rebasing GIC related
> patches (the VFIO stuff for instance), please let me know.
>
Thanks, I'm still brewing on the remaining
we-allow-some-dynamic-vgic-init stuff for gicv3 and whether we need to
change that before merging this.

-Christoffer
