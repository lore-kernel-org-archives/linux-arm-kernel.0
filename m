From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 29 Jan 2016 16:26:03 +0100
Subject: [PATCH 1/7] usb: gadget: pxa25x_udc: move register definitions
 from arch
In-Reply-To: <2664702.bXd9nOWVFO@wuerfel> (Arnd Bergmann's message of "Fri, 29
 Jan 2016 11:07:18 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
 <87vb6c7mug.fsf@belgarion.home> <2664702.bXd9nOWVFO@wuerfel>
Message-ID: <87egd076gk.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Friday 29 January 2016 10:32:07 Robert Jarzmik wrote:
>> > This addresses both issues by moving all the definitions into the
>> > pxa25x_udc driver itself. It turns out the only difference between
>> > them was 'UDCCS_IO_ROF', and that could well be a mistake when it
>> > was incorrectly copied from pxa25x to ixp4xx.
>> Hi Arnd,
>> 
>> Is there a reason to have chosen to move into pxa25_udc.c instead of
>> drivers/usb/gadget/udc/pxa25x_udc.h ? pxa27x_udc has a .h in the same directory
>> with register definitions, hence the question.
>
> Yes: The register definitions are only used in a single .c file and
> are not an interface between files, so it's better to have them in
> the file that uses them.
>
> I could have continued the cleanup and moved the two headers into the
> respective drivers as well, but I had to stop somewhere ;-)
Fair enough.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
