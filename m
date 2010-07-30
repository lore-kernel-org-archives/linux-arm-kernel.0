From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 30 Jul 2010 13:19:40 +0800
Subject: [PATCH 10/13] [ARM] pxa/balloon3: PCMCIA Support
In-Reply-To: <201007300712.54027.marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<201007300641.51952.marek.vasut@gmail.com>
	<AANLkTinHT8sB4VO26DJLDjhpu8WQA0_PcO8C77rpj3XS@mail.gmail.com>
	<201007300712.54027.marek.vasut@gmail.com>
Message-ID: <AANLkTin=TgNd4tn-ZQgcYhyf0qsXDT5Au+bA0jgHdw6u@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 1:12 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne P? 30. ?ervence 2010 07:02:46 Eric Miao napsal(a):
>> >> erm. Why move the FPGA/CPLD register definitions out of balloon3.h
>> >> (along with the others) and put them in balloon3.c?
>> >> Is that really good kernel form?
>> >
>> > They are not used anywhere else so they don't need to be in that file
>> > publically available.
>>
>> If the FPGA/CPLD is _not_ solely for the purpose of CF/PCMCIA,
>> nor it is like an MFD device where the functionality can be clearly
>> separated from different ranges of registers, I'd agree with Wookey
>> better to keep them in balloon3.h.
>
> Well the registers used are solely for PCMCIA (or rather CF socket on the board,
> which clears your question below).

I see something like:

#define BALLOON3_NANDIO_IO_REG         (BALLOON3_FPGA_VIRT + 0x00e00000)
 /* fpga/cpld interrupt control register */
 #define BALLOON3_INT_CONTROL_REG       (BALLOON3_FPGA_VIRT + 0x00e0000C)

But yeah, I don't know balloon3 board much, so it would be good
to have Wookey's Ack on this. Otherwise the patch looks OK to
me.
