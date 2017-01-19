From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 19 Jan 2017 11:55:24 +0100
Subject: [PATCH v3 09/13] sata: ahci: export ahci_do_hardreset() locally
In-Reply-To: <20170118182826.GA1451@mtj.duckdns.org>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
 <1484745601-4769-10-git-send-email-bgolaszewski@baylibre.com>
 <20170118182826.GA1451@mtj.duckdns.org>
Message-ID: <CAMpxmJULuF3cB7+Vy_qeWkTjooHvx8yk70w59Q=XNd0aAREcuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-18 19:28 GMT+01:00 Tejun Heo <tj@kernel.org>:
> Hello, Bartosz.
>
> On Wed, Jan 18, 2017 at 02:19:57PM +0100, Bartosz Golaszewski wrote:
>> We need a way to retrieve the information about the online state of
>> the link in the ahci-da850 driver.
>>
>> Create a new function: ahci_do_hardreset() which is called from
>> ahci_hardreset() for backwards compatibility, but has an additional
>> argument: 'online' - which can be used to check if the link is online
>> after this function returns.
>
> Please just add @online to ahci_hardreset() and update the callers.
> Other than that, the sata changes look good to me.
>

Are you sure? There are 23 places in drivers/ata/ where the .hardreset
callback is assigned. I'd prefer not to change the drivers I can't
test. Besides all other **reset callbacks take three arguments -
should we really only change one of them for a single driver's needs?

Thanks,
Bartosz
