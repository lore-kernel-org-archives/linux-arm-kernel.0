From: lho@apm.com (Loc Ho)
Date: Thu, 27 Feb 2014 12:02:32 -0800
Subject: [PATCH v12 3/4] PHY: add APM X-Gene SoC 15Gbps Multi-purpose PHY
 driver
In-Reply-To: <20140227190259.GC4862@saruman.home>
References: <1393524848-8207-1-git-send-email-lho@apm.com>
 <1393524848-8207-2-git-send-email-lho@apm.com>
 <1393524848-8207-3-git-send-email-lho@apm.com>
 <1393524848-8207-4-git-send-email-lho@apm.com>
 <20140227190259.GC4862@saruman.home>
Message-ID: <CAPw-ZTkB9LhWmw3+WMTF-0tAwGibugxmCAu2VgNkmGaa6ojJUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Balbi,

>> +/*
>> + * This function is used to configure the PHY to operation as either SATA Gen1
>> + * or Gen2 speed.
>> + */
>> +static void xgene_phy_sata_force_gen(struct xgene_phy_ctx *ctx,
>> +                                  int lane, int gen)
>
> why do you need to *force* the generation ? Is this because of some
> silicon errata ? It almost seems like this should be done through link
> negotiation between both link partners.

You can call this as an errata or limitation of the underlying PHY IP.
As start, the PHY is configured with auto neg up to 6Gbps (or Gen3
speed). After link up, we will know whether it is Gen1 (1.5Gbps), Gen2
(3.0Gbps), or Gen3 (6.0Gbps). In order to ensure reliability, the PHY
needs to be configured at specified speed. For this reason and after
link up, the PHY is re-trained for the linked up speed.

-Loc
