From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Mar 2018 12:13:53 +0000
Subject: PSCI version misdetection
In-Reply-To: <CAOMZO5Cj=p813_aQMzXPSX3+tqJjsiPhML7N2qQv0JTREWufWQ@mail.gmail.com>
References: <CAOMZO5BbxFTfD_ZsL5zVhHU5Ue_J_YGBW35AwNx=PVpu6WsqwQ@mail.gmail.com>
 <20180312100247.qd2cph56bhypzwp7@salmiak>
 <CAOMZO5BJ2GuqZS=9C6sA=JXif64OcL1gAbaxbpfdCYEGVM7ZTQ@mail.gmail.com>
 <20180312113604.p36tgtsszfunk2qp@lakrids.cambridge.arm.com>
 <CAOMZO5Cj=p813_aQMzXPSX3+tqJjsiPhML7N2qQv0JTREWufWQ@mail.gmail.com>
Message-ID: <20180312121352.v6rk5xiojjt6fuo7@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 08:56:41AM -0300, Fabio Estevam wrote:
> Hi Mark,
> 
> On Mon, Mar 12, 2018 at 8:36 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Ok. AFAICT, you need to implement psci_version, and any other mandatory
> > PSCI features such as affinity info in your board code, as otherwise the
> > default weak implementation is used.
> 
> Thanks for your clarification.
> 
> I did as suggested and implemeted psci_version (in the same way as ls1021xa):
> https://pastebin.com/ZfJkN2HC
> 
> and now I get:
> 
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.0 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.

Cool!

As I mentioned, you must also implement the other mandatory PSCI 1.0
features:

* AFFINITY_INFO -- this is necessary for correct synchronization of
  CPU_OFF calls.

* CPU_SUSPEND -- this can simply return INVALID_PARAMETERS for all
  power_state arguments.

Thanks,
Mark.
