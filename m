From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Mon, 30 Jul 2018 09:57:30 -0700
Subject: [PATCH v2 0/7] Add clock config and pm support to bcm iProc mdio
 mux
In-Reply-To: <20180728213233.GH4792@lunn.ch>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <20180728213233.GH4792@lunn.ch>
Message-ID: <53a99d1b-f945-2ab6-d564-d4837fb8639d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Andrew,

On 18-07-28 02:32 PM, Andrew Lunn wrote:
> On Fri, Jul 27, 2018 at 02:23:26PM -0700, Arun Parameswaran wrote:
>> Hi,
>> The patchset is based on David Miller's "net-next" repo.
>>
>> The patchset extends the Broadcom iProc mdio mux to add support for
>> suspend/resume and the ability to configure the internal clock
>> divider. The patchset also sets the scan control register to
>> disable external master access.
> 
> Hi Arun
> 
> It would be good to modify the .dtsi files to make use of the new
> clock properties.
> 
The clock is done primarily for the newer Omega SoC. I hope, we will
upstream the devicetree file for Omega soon.

The existing NS2 and Stingray SoC's, default to proper values in the
hardware registers, so they did not need to specify the clock. They
will also work over sleep cycles for the same reason.

But, I will ask around to see if we can add the clock for those
SoC's as well.

Thanks
Arun

>       Andrew
> 
