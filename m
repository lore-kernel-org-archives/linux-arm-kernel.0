From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 14 Aug 2013 11:25:02 +0200
Subject: [PATCH v2 4/5] PCI: mvebu: add support for reset on GPIO
In-Reply-To: <20130814090715.GA2084@ulmo>
References: <1376396724-32048-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376396724-32048-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130814090715.GA2084@ulmo>
Message-ID: <520B4CEE.2050508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 11:07 AM, Thierry Reding wrote:
> On Tue, Aug 13, 2013 at 02:25:23PM +0200, Sebastian Hesselbarth wrote:
> [...]
>> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> [...]
>> @@ -897,6 +904,30 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> [...]
>> +			u32 reset_udelay = 20000;
> [...]
>> +			udelay(reset_udelay);
>
> udelay(20000) is probably not a good idea. You should probably use
> something like usleep_range() or msleep() here. Also see:
>
> 	Documentation/timers/timers-howto.txt

Thierry,

thanks for mentioning this. I clearly got distracted from ms to us
switch due to the different reset API convention. As the delay will
be most likely 10ms+, we should change the above to
msleep(reset_udelay/1000) instead.

Sebastian
