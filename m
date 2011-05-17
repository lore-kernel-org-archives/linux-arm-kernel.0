From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 17 May 2011 19:48:18 +0200
Subject: [PATCH V7] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <4DD2B178.3050907@broadcom.com>
References: <1304960206-8832-1-git-send-email-zajec5@gmail.com>
	<4DD2B178.3050907@broadcom.com>
Message-ID: <BANLkTin7woaT5Uaxvh4x2jp-J10jnzSdmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/17 Arend van Spriel <arend@broadcom.com>:
> On 05/09/2011 06:56 PM, Rafa? Mi?ecki wrote:
>>
>> Broadcom has released cards based on a new AMBA-based bus type. From a
>> programming point of view, this new bus type differs from AMBA and does
>> not use AMBA common registers. It also differs enough from SSB. We
>> decided that a new bus driver is needed to keep the code clean.
>>
>> In its current form, the driver detects devices present on the bus and
>> registers them in the system. It allows registering BCMA drivers for
>> specified bus devices and provides them basic operations. The bus driver
>> itself includes two important bus managing drivers: ChipCommon core
>> driver and PCI(c) core driver. They are early used to allow correct
>> initialization.
>>
>> Currently code is limited to supporting buses on PCI(e) devices, however
>> the driver is designed to be used also on other hosts. The host
>> abstraction layer is implemented and already used for PCI(e).
>>
>> Support for PCI(e) hosts is working and seems to be stable (access to
>> 80211 core was tested successfully on a few devices). We can still
>> optimize it by using some fixed windows, but this can be done later
>> without affecting any external code. Windows are just ranges in MMIO
>> used for accessing cores on the bus.
>
> Hi Rafa?,
>
> Just some minor feedback on coding style. I wanted to make a change in
> host_pci.c to avoid changing the PCI BAR window and noticed following:

Sorry?


> 1. indentation is all spaces.

You can find spaces only for aligning text in newline after breaking
more-than-80-chars lines.


> 2. initial indent is 7 spaces, and subsequent indents are 8 spaces.

$ grep "        " ./*c | wc -l
0


> 3. pointer assignment: ptr =&var;

$ grep "=&" ./*c | wc -l
0


> 4. output parameter: foo(bar,&yabar);

$ grep ",&" ./*c | wc -l
0

-- 
Rafa?
