From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 2 Dec 2016 11:51:26 +0000
Subject: [RFC PATCH] PCI: designware: add host_init() error handling
In-Reply-To: <f2c8ebba-e51a-5f47-2d96-c75f7e086c0e@synopsys.com>
References: <1480593077-15402-1-git-send-email-srinivas.kandagatla@linaro.org>
 <f2c8ebba-e51a-5f47-2d96-c75f7e086c0e@synopsys.com>
Message-ID: <d416f9b3-20d9-0339-a4d2-9a4ba0669633@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/12/16 10:32, Joao Pinto wrote:
>
> Hi Srinivas,
>
> ?s 11:51 AM de 12/1/2016, Srinivas Kandagatla escreveu:
>>  drivers/pci/host/pci-dra7xx.c           |  4 +++-
>>  drivers/pci/host/pci-exynos.c           |  4 +++-
>>  drivers/pci/host/pci-imx6.c             |  4 +++-
>>  drivers/pci/host/pci-keystone.c         |  4 +++-
>>  drivers/pci/host/pci-layerscape.c       | 12 ++++++++----
>>  drivers/pci/host/pcie-armada8k.c        |  4 +++-
>>  drivers/pci/host/pcie-designware-plat.c |  4 +++-
>>  drivers/pci/host/pcie-designware.c      |  4 +++-
>>  drivers/pci/host/pcie-designware.h      |  2 +-
>>  drivers/pci/host/pcie-qcom.c            |  6 ++++--
>>  drivers/pci/host/pcie-spear13xx.c       |  4 +++-
>>  11 files changed, 37 insertions(+), 15 deletions(-)
>>
>
> Thanks for the patch!
>
> In my opinion your idea is good but only qcom driver is able to detect failure
> in the specific host init routine, all others have a 'return 0' even if
> something not well init. I would recomend that we take this issue a bit further
> and add the error checking to all specific pci drivers in order to make them as
> robust as qcom'.
I totally agree with you, I can give this a go in next version.

Thanks,
srini

>
> Thanks,
> Joao
>
