From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 6 Jun 2016 18:10:16 +0100
Subject: [RFC PATCH 0/2] scpi: Add SCPI framework to handle vendors
 variants
In-Reply-To: <574BFA13.40009@baylibre.com>
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
 <57472450.4000709@arm.com> <574802AF.2080909@baylibre.com>
 <574BFA13.40009@baylibre.com>
Message-ID: <5755AE78.4030104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/05/16 09:30, Neil Armstrong wrote:
> On 05/27/2016 10:17 AM, Neil Armstrong wrote:

>
> While looking for other ARMv8 based platform, I found that the RK3368
> platform has the same SCPI implementation as Amlogic.
>
> They extended it with DDR, system and thermal commands.
>
> Look at :
> https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/drivers/mailbox/scpi_cmd.h
>
>https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/driver/mailbox/scpi_protocol.c
>
> So the SCPI must have a framework to allow different protocol
> versions, and must allow command extension. Grouping Rockchip and
> Amlogic should be done, thus needing a generic name like vendor_scpi
> or with a version.
>
> Sudeep, could you somehow find out which version of the protocol
> AmLogic and Rockchip based their SCPI development ?
>
>

As Caesar Wang replied, they had a previous version of SCPI and I
suggested on how to extend the command set previously in private.
Not sure whats the progress on that

Anyways I had a look at geekbox driver and it looks mostly based on the
initial driver I wrote for initial SCPI versions. I am worried that your
extension might help people to develop their own protocol instead of
following the existing standards. SCPI is published now, so I vendors
use that rather than making up their own. Also ARM is trying to
standardize something in this area like PSCI, but that may take little
more time as it's under discussion with vendors.

Though this initial version of SCPI is not published, I am sure it is
almost same as v1.0 except that the CMD is not part of payload like
v1.0. In v1.0 it's part of payload and the mailbox is used just for
doorbell mechanism.

IMO, we can add some compatible to indicate the pre v1.0 protocol
and add the support to the existing driver itself. Let me know your
thoughts.

-- 
Regards,
Sudeep
