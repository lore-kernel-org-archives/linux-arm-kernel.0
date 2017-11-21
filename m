From: pbrobinson@gmail.com (Peter Robinson)
Date: Tue, 21 Nov 2017 10:03:53 +0000
Subject: [GIT PULL 1/2] bcm2835-dt-fixes-2017-10-06
In-Reply-To: <CAM9fo8MktM-WX-AGFCLeCrcoRDR4XjR09BGcbNb5X4G4yVaU2A@mail.gmail.com>
References: <20171006220504.7776-1-eric@anholt.net>
 <edb03edb-f2a6-549e-6060-eccfae554d92@gmail.com>
 <CAJsfgeU5Zq-2zSfto8WUZ5Xud1Ksedu9XdLG9pWR7YBZGVaHBA@mail.gmail.com>
 <CALeDE9NsjYHpaR6kyHgABGr2eE=EhpJstttK60WwRkAj0u1m7Q@mail.gmail.com>
 <910a98ca-57f6-baca-73ac-f6c8c1ff04db@i2se.com>
 <CALeDE9Oi+DvoJ6X22ButaQxHNyqBzg=H1-mb69_g-rp4RR_fqw@mail.gmail.com>
 <F3464528-76E5-4F11-BD58-DEB56410687B@holtmann.org>
 <CALeDE9OySr2LpcedpTHnz89aFYAk2CknKGHeVx+4ecFCemYZPw@mail.gmail.com>
 <CAM9fo8MktM-WX-AGFCLeCrcoRDR4XjR09BGcbNb5X4G4yVaU2A@mail.gmail.com>
Message-ID: <CALeDE9NpTQCSC7AJ1NhkNuA-FgMQSme8LUJtyizXirthCh6chA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Loic,

>> With 4.14 I get the following, the address doesn't look right, do you
>> have a link to the serdev patch headed to 4.15?
>>
>> # hciconfig
>> hci0:   Type: Primary  Bus: UART
>>         BD Address: AA:AA:AA:AA:AA:AA  ACL MTU: 1021:8  SCO MTU: 64:1
>>         DOWN
>>         RX bytes:542 acl:0 sco:0 events:11 errors:0
>>         TX bytes:77 acl:0 sco:0 commands:17 errors:0
>
>
> HCI link seems ok since you have some events/commands in the stats.
> It could be a firmware issue, missing or at the wrong place (BCM43xxx.hcd).
> Does the hci_bcm request firmware call fail ? (dev_info message).

So it seems it's actually working fine albeit the strange mac addr, no
idea what I was trying before, although there's an error about loading
firmware:

[   31.035291] Bluetooth: hci0: BCM: chip id 94
[   31.035801] Bluetooth: hci0: BCM: features 0x2e
[   31.037483] Bluetooth: hci0: BCM43430A1
[   31.037498] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
[   31.037694] bluetooth hci0: Direct firmware load for
brcm/BCM43430A1.hcd failed with error -2
[   31.037704] Bluetooth: hci0: BCM: Patch brcm/BCM43430A1.hcd not found

By adding a firmware [1] to the location it actually now stops
working, although shows up with a hciconfig, and had the following
errors.

[   26.078038] Bluetooth: hci0: BCM: chip id 94
[   26.096797] Bluetooth: hci0: BCM: features 0x2e
[   28.130753] Bluetooth: hci0 command 0x0c14 tx timeout
[   36.322725] Bluetooth: hci0: BCM: Reading local name failed (-110)

Thanks,
Peter
