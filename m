From: zonque@gmail.com (Daniel Mack)
Date: Tue, 31 May 2011 10:52:48 +0200
Subject: Freescale i.mx25 SDIO/Libertas issue
In-Reply-To: <BANLkTika2NNTmWNBmLC60GVMLTzXUS5X+A@mail.gmail.com>
References: <4DE2F84D.8080907@bluewatersys.com>
	<BANLkTi=j3UXV6FMS6vkA+Vrpt3JjsNwMiA@mail.gmail.com>
	<BANLkTika2NNTmWNBmLC60GVMLTzXUS5X+A@mail.gmail.com>
Message-ID: <BANLkTinhWKj+QDrNjVnDNswYpiTkAijphw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 4:03 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Daniel,
>
> On Mon, May 30, 2011 at 6:50 AM, Daniel Mack <zonque@gmail.com> wrote:
>> On Mon, May 30, 2011 at 3:52 AM, Andre Renaud <andre@bluewatersys.com> wrote:
>>> Hello,
>>> I am trying to use a Wi2Wi 802.11b/g (W2CBW009S) module attached to an
>>> i.MX25 cpu, specifically the i.MX25 PDK from freescale, although I've
>>> also tried it on a DeviceSolutions Topaz i.MX25. However it is unable to
>>> fully load the driver, leaving me with the following in the logs:
>>> [ ? 30.149097] libertas_sdio mmc0:0001:1: (unregistered net_device):
>>> command 0x00a9 timed out
>>> [ ? 30.153759] libertas_sdio mmc0:0001:1: (unregistered net_device):
>>> Timeout submitting command 0x00a9
>>> [ ? 30.158843] libertas_sdio mmc0:0001:1: (unregistered net_device):
>>> PREP_CMD: command 0x00a9 failed: -110
>>> [ ? 30.164126] libertas_sdio mmc0:0001:1: (unregistered net_device):
>>> CMD_FUNC_INIT cmd failed
>>> This wifi chip is based around the Marvell 8688 core.
>>>
>>> I have also tried using an 8686 device, and in that case it is unable to
>>> even complete loading the firmware, failing with the following:
>>> [ ? 14.753132] libertas_sdio: Firmware req_size: 17
>>> [ ? 14.755713] libertas_sdio: failed to load firmware: -5
>>> [ ? 14.759272] libertas_sdio: probe of mmc0:0001:1 failed with error -5
>>> Note: I added the 'req_size: ' debugging message in
>>
>> I assume this error happens after the driver uploaded the helper
>> firmware and switched to multi-block transfers?
>>
>> Which kernel version are you working on? I'm asking because I fixed a
>> similar bug some months ago which I happend to see an a MX31 CPU with
>> a 8686 attach to the SDIO bus. The MX3 MMC controller has bug severe
>> bug in its CRC calculation code which causes multi-block transfers on
>> a 4-bit bus to fail, and hence the only solution was to switch to a
>> 1-bit bus. But I don't known whether this also affects MX25 cores.
>
> The MX25 has a different SD controller (eSDHC) than the one found on
> MX31 and such issue is not present.

Ah ok. Thanks for the clarification.

Daniel
