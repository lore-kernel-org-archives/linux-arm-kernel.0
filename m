From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 26 Mar 2015 04:09:23 +0530
Subject: [PATCH v1 1/3] phy: phy-core: allow specifying supply at port
 level
In-Reply-To: <CAE_wzQ_8YzZwizyozU-0MPLX8-hT1Y1LnfYFg+iEvQgYX7zjFg@mail.gmail.com>
References: <1426886727-537-1-git-send-email-arun.ramamurthy@broadcom.com>	<1426886727-537-2-git-send-email-arun.ramamurthy@broadcom.com>	<55133294.4040705@ti.com>
 <CAE_wzQ_8YzZwizyozU-0MPLX8-hT1Y1LnfYFg+iEvQgYX7zjFg@mail.gmail.com>
Message-ID: <5513391B.2060505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 26 March 2015 03:47 AM, Dmitry Torokhov wrote:
> On Wed, Mar 25, 2015 at 3:11 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi,
>>
>> On Saturday 21 March 2015 02:55 AM, Arun Ramamurthy wrote:
>>> Multi-port phy's may have per-port power supplies. Let's change phy core
>>> to first attempt to look up the supply at the port level, and then, if
>>> not found, check parent device.
>>
>> Why not just have every port provide the power supply if it needs?
>> I don't think checking for parent device should be present in the phy-core at
>> all.
> 
> We need to do that if we want to keep compatibility with the current
> DTSes: before this patch the supply would be always looked up on
> device and not port level.

ah okay.
so just using regulator_get_optional(&phy->dev, "phy"); should be sufficient
right? Why do we need regulator_get_optional(phy->dev.parent, "phy");?

Thanks
Kishon
