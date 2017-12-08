From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 8 Dec 2017 14:48:49 +0100
Subject: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
In-Reply-To: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
Message-ID: <CAJZ5v0g8v3mwCZOCXHsy_0iA+0RzFFhBxfo4f_cEv5QVLEccsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 10:10 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Introduce new ACPI and OF device ids for thw HW along with the helper
> functions.
>
> Changes from v6:
> * add const to the device callback parameter in fwnode.
> * reorganize the callbacks in the code
> * rename get_match_data() as device_get_match_data()
> * place pointer checks into acpi_get_match_data()
>
> Sinan Kaya (7):
>   Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
>   ACPI / bus: Introduce acpi_get_match_data() function
>   device property: Introduce a common API to fetch device match data
>   OF: properties: Implement get_match_data() callback
>   ACPI: properties: Implement get_match_data() callback
>   dmaengine: qcom_hidma: Add support for the new revision
>   dmaengine: qcom_hidma: Add identity register support
>
>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 +--
>  drivers/acpi/bus.c                                 | 18 ++++++++++
>  drivers/acpi/property.c                            |  8 +++++
>  drivers/base/property.c                            |  7 ++++
>  drivers/dma/qcom/hidma.c                           | 41 ++++++++++------------
>  drivers/of/property.c                              |  8 +++++
>  include/linux/acpi.h                               |  6 ++++
>  include/linux/fwnode.h                             |  4 +++
>  include/linux/property.h                           |  2 ++
>  9 files changed, 74 insertions(+), 24 deletions(-)
>
> --

The series is fine by me, by how do you want to route it?

Thanks,
Rafael
