From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 Jun 2016 15:04:47 -0700
Subject: [GIT PULL 6/7] Broadcom defconfig changes for 4.8 Part 1
In-Reply-To: <57686366.1020200@broadcom.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
 <1466128575-5378-6-git-send-email-f.fainelli@gmail.com>
 <20160620055416.GI2329@localhost> <57686366.1020200@broadcom.com>
Message-ID: <CAOesGMhpf3bo61CZOy1eMaUnYqWgV6gLoEAAnWRKrWem_WBa+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 2:43 PM, Scott Branden
<scott.branden@broadcom.com> wrote:
> Hi Olof,
>
>
> On 16-06-19 10:54 PM, Olof Johansson wrote:
>>
>> On Thu, Jun 16, 2016 at 06:56:14PM -0700, Florian Fainelli wrote:
>>>
>>> The following changes since commit
>>> 1a695a905c18548062509178b98bc91e67510864:
>>>
>>>    Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>    http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/defconfig
>>>
>>> for you to fetch changes up to 41463c3e6eae3dfa4377069966ed02b4ba378e79:
>>>
>>>    ARM: Remove bcm_defconfig (2016-06-16 13:40:49 -0700)
>>>
>>> ----------------------------------------------------------------
>>> This pull request contains defconfig changes for Broadcom ARM-based SoCs:
>>>
>>> - Florian enables support for the BCM63xx DSL SoCs basic peripherals,
>>> enables
>>>    the networking subsystems for Set Top Box SoCs, enables the PWM,
>>> watchdog and
>>>    the AHCI controller and SATA PHY drivers
>>>
>>> - Florian removes the bcm_defconfig file which is no longer useful and
>>> updates
>>>    multi_v7_defconfig to include the Kona watchdog to provide proper
>>> reboot for the
>>>    Broadcom Kona platforms
>>>
>>> Please note that Tejun Heo has queued a patch which renames AHCI_BRCMSTB
>>> into
>>> AHCI_BRCM, to avoid two patches in a row, we just enable AHCI_BRCM to be
>>> future
>>> proof
>>
>>
>> So, you say that bcm_defconfig is no longer useful. While I'm happy to see
>> the
>> number of defconfigs go down, I'd like to clarify that we do still see
>> per-SoC
>> defconfigs somewhat useful, in that they are a lot closer to what someone
>> would
>> want to use for defconfig in a product kernel based on the SoC. It's
>> easier to
>> start from the SoC-specific defconfig and remove pieces that aren't needed
>> than
>> to start from multi_v7_defconfig.
>
> I completely agree that per-SoC defconfigs are extremely useful. I attempted
> to do so for Cygnus and would like to for other Broadcom SoCs as well.
> Unfortunately Arnd's policy was one defconfig per company. This prevents use
> from doing so. Broadcom has a variety of SoCs and families. Some share
> technology, others are entirely different. On the projects I work with we
> don't use multi_v7_defconfig nor do our customers. We use per SoC
> defconfigs.

Yeah, I'm with Arnd on this in general; we can't do a crazy number of
defconfigs -- which is why I said it's a starting point for further
paring down. Still, given the variety of platforms from Broadcom it's
likely too broad to be useful. Removing it makes sense.

> So, as it stands bcm_defconfig is of little use to us. We are able to
> upstream everything into the kernel except for the defconfig file. We are
> forced to maintain these internally. Yet we are able to upstream dts files
> which are per board...

There's a huge difference in the cost of carrying a defconfig vs a dts
file. A dts file is very cheap to compile and carry, while each
defconfig adds a significant amount of time spent on build coverage.


-Olof
