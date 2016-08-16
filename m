From: julien.grall@arm.com (Julien Grall)
Date: Tue, 16 Aug 2016 19:01:26 +0100
Subject: [PATCH 0/4] boot-wrapper: arm64: Xen support
In-Reply-To: <20160620150934.1729-1-andre.przywara@arm.com>
References: <20160620150934.1729-1-andre.przywara@arm.com>
Message-ID: <2db06642-e288-a158-0b0d-56ef43ece276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

Do you plan to send a new version of this series?

Cheers,

On 20/06/2016 16:09, Andre Przywara wrote:
> These patches allow to include a Xen hypervisor binary into a boot-wrapper
> ELF file, so that a Foundation Platform or a Fast Model can boot a Xen
> system (including a Dom0 kernel).
> This has been floating around for a while, I just updated the patches
> to apply on the latest boot-wrapper tree. Also I increased Xen's load
> address to accomodate for Dom0 kernels bigger than 16 MB.
> For testing this just add: "--with-xen=/path/to/xen/xen/xen" to the
> ./configure command line and feed the resulting xen-system.axf file to
> the model.
>
> Cheers,
> Andre.
>
> Christoffer Dall (3):
>   Support for building in a Xen binary
>   Xen: Support adding DT nodes
>   Explicitly clean linux-system.axf and xen-system.axf
>
> Ian Campbell (1):
>   Xen: Select correct dom0 console
>
>  .gitignore    |  1 +
>  Makefile.am   | 38 +++++++++++++++++++++++++-------------
>  boot_common.c |  4 ++--
>  configure.ac  | 26 +++++++++++++++++++++++++-
>  model.lds.S   | 14 ++++++++++++++
>  5 files changed, 67 insertions(+), 16 deletions(-)
>

-- 
Julien Grall
