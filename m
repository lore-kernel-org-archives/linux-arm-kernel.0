From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jan 2013 09:27:24 -0700
Subject: [PATCH 1/2] ARM: tegra: config: enable SERIAL_TEGRA
In-Reply-To: <50F78030.6080305@nvidia.com>
References: <1358341572-8154-1-git-send-email-ldewangan@nvidia.com>
 <50F6EA0A.4080904@wwwdotorg.org> <50F78030.6080305@nvidia.com>
Message-ID: <50F8266C.5030605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 09:38 PM, Laxman Dewangan wrote:
> On Wednesday 16 January 2013 11:27 PM, Stephen Warren wrote:
>> On 01/16/2013 06:06 AM, Laxman Dewangan wrote:
>>> Enable high speed serial driver for tegra platform.
>> Thanks, I've applied patch 1 to Tegra's for-3.9/defconfig branch and
>> patch 2 to Tegra's for-3.9/dt branch.
>>
>> Just as an FYI, the dt branch is merged into my for-next branch, and
>> sent upstream, before the defconfig branch, so your patch order was
>> reversed relative to that, but it's not an issue here.
> 
> Thanks for applying it. There is no issue on the reversing the sequence.
> 
> 
>> Question: How do I test this; do I just fire up bluez(?) and point it at
>> the UARTC serial port, or is there more to it?
> 
> I tested this in may pieces, not with the bluez.
> I tested this in downstream with linux-next dma, this new serial driver,
> some hacks in the board files with bluetooth.
> 
> Then I tested this again on linux-next with some hacks in board-dt filew
> with invoking  the driver from cardhu dts file. In this I tested driver
> registration, basic write is wokring or not with some register
> dump/interrupt, Not checked data integrity as not connected the serial
> sniffer. The idea is that nothing should be crash in linux-next. The
> basic driver code is already tested with bluetooth.

Well, my question was more about what user-space tools/configuration/...
do I need to bring up Bluetooth to test this? I assume that now both the
driver and DT patches are in linux-next, I shouldn't have to touch the
kernel at all to make this work?
