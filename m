From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 6 Oct 2014 15:14:05 +0900
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <20141006060347.GB1266@katana>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <2257006.dpJJ6zLgnP@avalon> <20141006060347.GB1266@katana>
Message-ID: <CANqRtoRPus-fQTP7Ewiqhi8WeVK_=yEqa5oDkQ5r-s9y0cNMMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Oct 6, 2014 at 3:03 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> >   - While the serial console on r8a7790 was switched from SCIF0 to
>> >     SCIFA0 recently, I believe r8a7990 still needs to use SCIF0 instead
>> >     of SCIFA0, as that's what the bootloader has configured.
>>
>> Good point. Wolfram, any opinion about this ?
>
> IMO we should only use SCIFA if it uses the same wires as SCIF. This
> is the case for Lager (7790). Dunno about other boards.

>From my side I think we should let our users decide for themselves. So
to me it would make sense to be able to assign various devices like
UART, SPI and I2C to whatever pins that the user wants during run
time, and use DT to point out what the hardware possibilities look
like. Right now we describe one setting in DT, and it smells like a
software policy to me. =)

Cheers,

/ magnus
