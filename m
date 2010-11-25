From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 25 Nov 2010 19:38:59 +0100
Subject: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
	disabled
In-Reply-To: <alpine.DEB.2.00.1011251103480.20215@utopia.booyaka.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
	<AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
	<alpine.DEB.2.00.1011251103480.20215@utopia.booyaka.com>
Message-ID: <AANLkTi=L7COp0gxEG_ECabfa=eA7FU2W8-2zqqydV+Hi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On Thu, Nov 25, 2010 at 7:15 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Thu, 25 Nov 2010, Jean Pihet wrote:
>
>> On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> >
>> > The console semaphore must be held while the OMAP UART devices are
>> > disabled, lest a console write cause an ARM abort (and a kernel crash)
>> > when the underlying console device is inaccessible. ?These crashes
>> > only occur when the console is on one of the OMAP internal serial
>> > ports.
>> This does not fix the issue for me on Beagle (console on ttyO2).
>>
>> Doing:
>> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
>> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
>> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
>> and waiting 5 seconds hangs the console.
>
> By the way, I just tried this on a Beagle 35xx rev C2, with Tony's commit
> 063d907edaf3fbf9776c189c3e02f2c7a129d18c, and did not see any hang. ? Are
> you using a linux-omap kernel?
Yes this is using l-o master on Beagle B5.

>
>
> - Paul

Jean
