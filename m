From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 11 Nov 2014 22:29:45 -0800
Subject: [GIT PULL] Broadcom Cygnus SoC defconfig changes
In-Reply-To: <20141109001302.GB11947@quad.lixom.net>
References: <1414698612-26216-1-git-send-email-f.fainelli@gmail.com>
 <20141109001302.GB11947@quad.lixom.net>
Message-ID: <CAGVrzcbQG7qZNOoocgpbV=pf3Jv9mwAfsb=Eq2tiFfMa_pAPZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-08 16:13 GMT-08:00 Olof Johansson <olof@lixom.net>:
> On Thu, Oct 30, 2014 at 12:50:09PM -0700, Florian Fainelli wrote:
>> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
>>
>>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
>>
>> are available in the git repository at:
>>
>>   http://github.com/brcm/linux.git tags/arm-soc/for-3.18/cygnus-defconfig-v9
>>
>> for you to fetch changes up to aa0204801143ee2d47e9e8dd5f39cdddd5613b4b:
>>
>>   ARM: multi_v7_defconfig: Enable Broadcom Cygnus (2014-10-30 11:01:35 -0700)
>
> Hi Florian,
>
> Apologies for the delay in dealing with this pull request.
>
>> ----------------------------------------------------------------
>> This patchset contains initial support for Broadcom's Cygnus SoC based on our
>> iProc architecture. Initial support is minimal and includes just the mach
>> platform code, clock driver, and a basic device tree configuration. Peripheral
>> drivers will be submitted soon, as will device tree configurations for other
>> Cygnus board variants.
>>
>> These are the defconfig parts of the changes
>>
>> ----------------------------------------------------------------
>> Jonathan Richardson (1):
>>       ARM: cygnus defconfig : Initial defconfig for Broadcom Cygnus SoC
>>
>> Ray Jui (1):
>>       ARM: multi_v7_defconfig: Enable Broadcom Cygnus
>>
>> Scott Branden (1):
>>       ARM: bcm_defconfig/multi_v7_defconfig: remove one level of menu from Kconfig
>>
>>  arch/arm/configs/bcm_cygnus_defconfig | 237 ++++++++++++++++++++++++++++++++++
>>  arch/arm/configs/bcm_defconfig        |   3 +-
>>  arch/arm/configs/multi_v7_defconfig   |  21 ++-
>
> Please send multi_v7_defconfig updates as a patch instead of including in
> a merge request. We ask for this because it's a file that many maintainers
> touch and it's easy that we get lots of conflicts otherwise.
>
> As far as the bcm_cygnus_defconfig: Since new platforms are multiplatform
> enabled by default, we normally only prefer to have one defconfig per vendor.
> We've made exceptions in cases where the families are very different, but in
> general one defconfig per vendor should be sufficient.
>
> I.e. please enable the cygnus options in bcm_defconfig instead of adding a new
> one.

Alright, so just to make sure I get this right:

- there are two patches from Scott and Ray which enable Cygnus in
mutli_v7_defconfig that I should send a separate patches
- adding Cygnus to bcm_defconfig can be part of a separate pull request

>
>
> -Olof



-- 
Florian
