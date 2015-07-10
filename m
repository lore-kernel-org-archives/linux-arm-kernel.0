From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Jul 2015 09:43:52 +0100
Subject: [PATCH v3 14/15] PCI/MSI: pci-xgene-msi: Get rid of struct
 msi_controller
In-Reply-To: <CADaLNDm9o8XH749ocy4eJO=1T_w0AAFa1UZJLiFGrgR=5Aqjcg@mail.gmail.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
 <1436289485-28230-15-git-send-email-marc.zyngier@arm.com>
 <CADaLNDm9o8XH749ocy4eJO=1T_w0AAFa1UZJLiFGrgR=5Aqjcg@mail.gmail.com>
Message-ID: <559F85C8.7000403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Duc,

On 09/07/15 23:12, Duc Dang wrote:
> On Tue, Jul 7, 2015 at 10:18 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> The XGene MSI driver only uses the msi_controller structure as
>> a way to match the host bridge  with its MSI HW, and thus the
>> msi_domain.
>>
>> But now that we can directly associate an msi_domain with a device,
>> there is no use keeping this msi_controller around.
>>
>> Just remove all traces of msi_controller from the driver.
>>
> Thanks, Marc.
> 
> I tested this patch set and it works on my APM X-Gene evaluation platform.

Ah, thanks! I did that as a side effort, but didn't have a chance to
test it (who the *&%^!! decided to mount this board in a 1U chassis
without an angle bracket for the PCIe bus? Seriously???).

> The xgene_pcie_msi_enable (in driver/pci/host/pci-xgene.c), which is
> used to get msi_controller for X-Gene PCIe port,
> also becomes unnecessary with this patch set. I will post a clean-up
> patch when your changes are accepted.

Yeah, I didn't want to touch too much of it without any testing.

> You can add my tested-by if you want:
> 
> Tested-by: Duc Dang <dhdang@apm.com>

Thanks a lot for that,

	M.
-- 
Jazz is not dead. It just smells funny...
