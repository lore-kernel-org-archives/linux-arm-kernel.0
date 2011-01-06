From: mkl0301@gmail.com (Lin Mac)
Date: Fri, 7 Jan 2011 02:14:12 +0800
Subject: [PATCH v3 2/2] ahci_platform: add support for CNS3xxx SoC devices
In-Reply-To: <20110106180948.GX27131@trinity.fluff.org>
References: <1294336393-920-1-git-send-email-mkl0301@gmail.com>
	<1294336393-920-3-git-send-email-mkl0301@gmail.com>
	<AANLkTinO-feQkpfoZhmOV7VyPbyL=f8KV1_Qysps04ve@mail.gmail.com>
	<20110106180948.GX27131@trinity.fluff.org>
Message-ID: <AANLkTimA4HvL2b-JAooR2out-19cEvBYUNYGFZz-VMwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/7 Ben Dooks <ben@trinity.fluff.org>:
> On Fri, Jan 07, 2011 at 02:04:33AM +0800, Lin Mac wrote:
>> Hi Jeff,
>>
>> 2011/1/7 ?<mkl0301@gmail.com>:
>> > From: Mac Lin <mkl0301@gmail.com>
>> >
>> > CNS3xxx override the softreset function of ahci_platform ahci_softreset by
>> > cns3xxx_ahci_softreset, which would retry ahci_do_softreset again with pmp=0 if
>> > pmp=15 failed, for the controller has problem receiving D2H Reg FIS of the
>> > different PMP setting of the previous sent H2D Reg FIS.
>> >
>> > Following describe the isssue with original ahci_platform driver on
>> > linux-2.6.37-rc3, arm/cns3xxx.
>> >
>> > If CONFIG_SATA_PMP is enabled, while not using multiplier and connect the disks
>> > directly to the board, the disk cannot be found due to software reset always
>
>> complicated if more SoC-specific code added.
>> I really prefer the original way.
>
> Is there a reference to the original?
v2: http://www.spinics.net/lists/linux-ide/msg39766.html

Best Regards,
Mac Lin
