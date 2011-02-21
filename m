From: drasko.draskovic@gmail.com (Drasko DRASKOVIC)
Date: Mon, 21 Feb 2011 15:25:27 +0100
Subject: Question About Linux Memory Mapping
In-Reply-To: <20110221131325.GP14495@n2100.arm.linux.org.uk>
References: <201102192122.53746.marek.vasut@gmail.com>
	<919555.44803.qm@web161702.mail.bf1.yahoo.com>
	<AANLkTikdPrjHRFc6bD1VsN3MCZkKD0dVSNq1ijgp7qz9@mail.gmail.com>
	<20110221131325.GP14495@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim=YHZ96TrQZKK7=Nsg4Pc6VCKwkTQ-OsU-hZrd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 2:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 21, 2011 at 01:13:16PM +0100, Drasko DRASKOVIC wrote:
>> Thanks for your answers.
>>
>> I can see now that "mem" parameter is parsed in
>> arch/arm/kernel/setup.c, as Nicolas underlined. However, in my case
>> early_mem() is never called during the Linux boot.
>>
>> Does anybody have an idea why ?
>
> Maybe the command line setting is being ignored by your boot loader
> and the one built-in to the kernel is being used?
>
> Maybe your kernel is configured to ignore the command line supplied
> by your boot loader?
>
> Maybe you're setting it in the kernel build but not realising that
> the boot loader passed one is being used instead?

Turns out that I had badly formatted command line parameters. After
correcting this everything works fine.

Thanks again for the help.

BR,
Drasko
