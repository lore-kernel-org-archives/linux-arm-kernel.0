From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Tue, 7 Feb 2017 12:42:11 +0100
Subject: [PATCHv3 1/2] arch: Move CONFIG_DEBUG_RODATA and
 CONFIG_SET_MODULE_RONX to be common
In-Reply-To: <1486427518-14819-2-git-send-email-labbott@redhat.com>
References: <1486427518-14819-1-git-send-email-labbott@redhat.com>
 <1486427518-14819-2-git-send-email-labbott@redhat.com>
Message-ID: <20170207114211.GB4973@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 04:31:57PM -0800, Laura Abbott wrote:
> 
> There are multiple architectures that support CONFIG_DEBUG_RODATA and
> CONFIG_SET_MODULE_RONX. These options also now have the ability to be
> turned off at runtime. Move these to an architecture independent
> location and make these options def_bool y for almost all of those
> arches.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: Make these configs selectable for arm. Include some documentation about
> how the setup of the optional Kconfigs work as well. Stop spelling 'kenrel'
> in prompt text.
> ---
>  Documentation/security/self-protection.txt |  6 ++++++
>  arch/Kconfig                               | 34 ++++++++++++++++++++++++++++++
>  arch/arm/Kconfig                           |  4 ++++
>  arch/arm/Kconfig.debug                     | 11 ----------
>  arch/arm/mm/Kconfig                        | 12 -----------
>  arch/arm64/Kconfig                         |  5 ++---
>  arch/arm64/Kconfig.debug                   | 11 ----------
>  arch/parisc/Kconfig                        |  1 +
>  arch/parisc/Kconfig.debug                  | 11 ----------
>  arch/s390/Kconfig                          |  5 ++---
>  arch/s390/Kconfig.debug                    |  3 ---
>  arch/x86/Kconfig                           |  5 ++---
>  arch/x86/Kconfig.debug                     | 11 ----------
>  13 files changed, 51 insertions(+), 68 deletions(-)

For the s390 bits:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
