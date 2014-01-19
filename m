From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 19:51:48 +0100
Subject: [RFC v3 05/13] ahci-platform: Pass ahci_host_priv ptr to
 ahci_platform_data init method
In-Reply-To: <20140119113051.GD11123@htj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-6-git-send-email-hdegoede@redhat.com>
 <20140119113051.GD11123@htj.dyndns.org>
Message-ID: <52DC1EC4.3090807@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 12:30 PM, Tejun Heo wrote:
> On Sun, Jan 19, 2014 at 12:48:47AM +0100, Hans de Goede wrote:
>> Some ahci_platform_data->init methods need access to the ahci_host_priv data.
>>
>> Note:
>>
>> When calling ahci_platform_data->init the ata_host has not been allocated yet,
>> so access to ahci_host_priv through the dev argument is not possible.
>>
>> The hpriv->mmio argument may seem redundant, but it is useful for drivers
>> which live outside of drivers/ata and thus don't know the contents of the
>> ahci_platform_data data type.
>
> Wouldn't the right thing to do be moving them under drivers/ata?

Yes, but they are part of arch/arm/mach-foo, so moving them is non trivial, and
I don't want to go make these kinda changes without hardware to test. Please keep
in mind that I'm partially cleaning up other peoples mess here (the imx bits
specifically). I'm willing to do that to some extend (*). But buying an imx6q board
and fixing that is about as far as I'm willing to go.

Regards,

Hans


*) Keep in mind that this is a hobby project done in my spare time, with all
hardware bought from personal budget.
