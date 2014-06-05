From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 5 Jun 2014 15:59:15 +0300
Subject: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <CAL_JsqLh7kqnufNaWKdOEFb=m2mViFX4kTGMHOKmHuTAVMr+fA@mail.gmail.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>	<1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
 <CAL_JsqLh7kqnufNaWKdOEFb=m2mViFX4kTGMHOKmHuTAVMr+fA@mail.gmail.com>
Message-ID: <539069A3.9010100@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, will remove.

- Mikko

On 05/06/14 15:18, Rob Herring wrote:
> On Wed, Jun 4, 2014 at 6:32 AM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
>> This adds support for the integrated AHCI-compliant Serial ATA
>> controller present on the NVIDIA Tegra124 system-on-chip.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>
> [...]
>
>> +static int tegra_ahci_probe(struct platform_device *pdev)
>> +{
>> +       const struct of_device_id *match;
>> +       struct ahci_host_priv *hpriv;
>> +       struct tegra_ahci_priv *tegra;
>> +       int ret;
>> +
>> +       match = of_match_device(tegra_ahci_of_match, &pdev->dev);
>
> This is not needed.
>
>> +       if (!match)
>> +               return -EINVAL;
>> +
