From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 17 Mar 2015 08:41:03 +0100
Subject: [PATCH v2 4/5] PCI: designware: Add disable IO support
In-Reply-To: <3714853.Vuc23EfWdL@wuerfel>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
 <1426515635-9466-5-git-send-email-gabriel.fernandez@linaro.org>
 <582D947C-1229-4DD9-BC82-812D1560C49E@codeaurora.org>
 <3714853.Vuc23EfWdL@wuerfel>
Message-ID: <CAG374jBqtw8sW-ZpMJFQUR0skdh+oX_F120hc90ssAYHzrF15g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Ok i will try the same way that pci-versatile.c

Thanks.

Gabriel

On 16 March 2015 at 21:00, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 16 March 2015 13:00:51 Kumar Gala wrote:
>> On Mar 16, 2015, at 9:20 AM, Gabriel FERNANDEZ <gabriel.fernandez@st.com> wrote:
>>
>> > ST sti SoCs PCIe IPs are built around DesignWare IP Core.
>> > But in these SoCs PCIe IP doesn't support IO.
>> >
>> > This patch adds the possibility to disable it through
>> > a DT property, by creating an empty IO window and by
>> > removing PCI_COMMAND_IO from the setup register.
>> >
>> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>> > ---
>> > .../devicetree/bindings/pci/designware-pcie.txt    |  2 ++
>> > drivers/pci/host/pcie-designware.c                 | 24 ++++++++++++++++++++--
>> > drivers/pci/host/pcie-designware.h                 |  1 +
>> > 3 files changed, 25 insertions(+), 2 deletions(-)
>>
>> Why not just update the code such that if the ranges doesn?t have an IO
>> space rather than introducing a new DT property?
>
> I suspect we can simplify this now by changing over the designware PCI
> code from pci_common_init_dev to calling pci_scan_root_bus() in the
> same way that pci-versatile.c does. This would also clean up some
> other areas of the driver and let you do proper error handling
> in the probe.
>
>         Arnd
