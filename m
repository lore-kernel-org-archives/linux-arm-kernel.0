From: nm@ti.com (Menon, Nishanth)
Date: Thu, 19 Jul 2012 04:21:29 -0500
Subject: [PATCH 04/10] ARM: OMAP: omap_device: register to the per-device
 PM QoS framework
In-Reply-To: <4FE1A8D4.1060003@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
 <1339686361-11526-5-git-send-email-j-pihet@ti.com> <4FE1A8D4.1060003@ti.com>
Message-ID: <CAOMWX4eDOsM_oFjOZQuMnnN=T7a+3i_omiHrOGdvuEtu8PWbjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 5:41 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>>
>> +       /* Look for the platform device for the constraint target device
>> */
>> +       pdev = to_platform_device(dev_pm_qos_req->dev);
>> +
>> +       /* Try to catch non platform devices */
>> +       if (pdev->name == NULL) {
>
>
> Is this a safe way to catch non platform devices?

in addition, we should check !pdev before attempting to dereference
and check for pdev->name

Regards,
Nishanth Menon
