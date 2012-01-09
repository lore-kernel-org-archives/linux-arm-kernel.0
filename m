From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 9 Jan 2012 18:41:34 +0530
Subject: [PATCH v2 1/2] PM / Domains: Add OF support
In-Reply-To: <201201082223.18603.rjw@sisk.pl>
References: <1325931055-14486-1-git-send-email-thomas.abraham@linaro.org>
 <1325931055-14486-2-git-send-email-thomas.abraham@linaro.org>
 <201201082223.18603.rjw@sisk.pl>
Message-ID: <CAJuYYwSs+PTzhNuS5ZEvr2koD_+DSghKtcvytAd7NbDGm178XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

2012/1/9 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday, January 07, 2012, Thomas Abraham wrote:
>> A device node pointer is added to generic pm domain structure to associate
>> the domain with a node in the device tree. The platform code parses the
>> device tree to find available nodes representing the generic power domain,
>> instantiates the available domains and initializes them by calling
>> pm_genpd_init().
>>
>> Nodes representing the devices include a phandle of the power domain to
>> which it belongs. As these devices get instantiated, the driver code
>> checkes for availability of a power domain phandle, converts the phandle
>> to a device node and uses the new pm_genpd_of_add_device() api to
>> associate the device with a power domain.
>>
>> pm_genpd_of_add_device() runs through its list of registered power domains
>> and matches the OF node of the domain with the one specified as the
>> parameter. If a match is found, the device is associated with the matched
>> domain.
>>
>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>
> I can take this patch for 3.4, but your [2/2] depends on it, so I'm not
> sure how to handle that. ?If you want me to take the other patch too,
> it'll need ACKs from the Exynos maintaniers.

Thanks. There are some comments on the [2/2] patch which I will work
on. I will complete the rework and try to get the ack for the patch.

Regards,
Thomas.

>
> Thanks,
> Rafael

[...]
