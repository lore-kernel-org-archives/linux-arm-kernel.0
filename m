From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 19 Mar 2013 12:00:27 +0900
Subject: [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support V2
In-Reply-To: <201303181432.20107.arnd@arndb.de>
References: <20130318143203.26687.98180.sendpatchset@w520>
 <20130318143231.26687.41252.sendpatchset@w520>
 <201303181432.20107.arnd@arndb.de>
Message-ID: <CANqRtoQjU+tKw=VVdSUgiau_=RE+YdcekVF4dw9S+z4gRRzX2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 18, 2013 at 11:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 18 March 2013, Magnus Damm wrote:
>> Both platform devices and DT devices are added in this
>> patch. The platform device versions are used to provide
>> a static interrupt map configuration for board code
>> written in C.
>
> I had not noticed this part with the first version. Why is this required?
> I thought you would always have the DTS in there, so that can be used to
> provide the resources even for static platform devices.

Right now there is an intentional difference between the "C" version
of the board code and the DT-only version:

The "C" version of board code relies on DTS for architected timer and
GIC. Besides that, platform devices are used. Other devices in DTS are
not used at this point.

The DT version (DT_MACHINE_START in setup-r8a73a4.c) is using DTS only.

Would you like me to  change to "C" version of the code to use DTS to
describe more devices?

Thanks,

/ magnus
