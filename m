From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 25 Jul 2017 10:40:14 +0100
Subject: [PATCH v5 00/19] coresight: Support for ARM Coresight SoC-600
In-Reply-To: <CANLsYkxGey6K=ybLnzNGj6utvwJXn=c+WXryr0YB6uEqcT-zmQ@mail.gmail.com>
References: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkxGey6K=ybLnzNGj6utvwJXn=c+WXryr0YB6uEqcT-zmQ@mail.gmail.com>
Message-ID: <43a8483f-4afe-b9c8-f19a-c7b49350f004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/17 18:15, Mathieu Poirier wrote:
> On 20 July 2017 at 04:17, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> This series adds support for ARM Coresight SoC-600 IP, which implements
>> Coresight V3 architecture. It also does some clean up of the replicator
>> driver namings used in the driver to prevent confusions to the user.
>>
>> The SoC-600 comes with an improved TMC which supports new features,
>> including Save-Restore, Software FIFO2 mode (for streaming the trace
>> data over functional I/O like USB/PCI), and other changes AXICTL settings.
>>
>> This series supports Save-Restore feature of the new ETR by reusing
>> the driver to perform additional setups required in case we are dealing
>> with an IP which supports it. Towards this we keep track of the
>> capabilities of the given TMC ETR. Some of the features are advertised
>> via DEVID register (address width, scatter gather support), while some
>> are not (save-restore). So we attach a static capability mask with the
>> device PID for the unadvertised features and detect the rest at device
>> probe. The driver now detects the AXI address width if advertised via
>> DEVID.
>>
>> Tested on Juno (with Coresight SoC 400) and an FPGA based system
>> for SoC 600.
>
> Good day,
>
> Other than the two remarks I'm good with this set.  Since going for
> another iteration is time consuming for both of us I can make the
> modifications on my side - just let me know.

Mathieu,

Yes, I am happy with that. Thank you for the offer, it does save a lot
of time !

Cheers
Suzuki
