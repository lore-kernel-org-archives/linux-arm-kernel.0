From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 08 Mar 2015 18:14:11 +0100
Subject: [PATCH v3 5/9] mtd: pxa3xx_nand: add support for the Marvell
 Berlin nand controller
In-Reply-To: <54FA6DFC.1070904@free-electrons.com> (Ezequiel Garcia's message
 of "Sat, 07 Mar 2015 00:18:20 -0300")
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425555085-29531-6-git-send-email-antoine.tenart@free-electrons.com>
 <54FA6DFC.1070904@free-electrons.com>
Message-ID: <87oao3xvh8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

> Hi Antoine,
>
> On 03/05/2015 08:31 AM, Antoine Tenart wrote:
> [..]
>> +
>> +static struct pxa3xx_nand_flash berlin_builtin_flash_types[] = {
>> +{ "4GiB 8-bit",    0xd7ec, 128, 8192,  8,  8, 4096 },
>> +{ },
>
> IMHO, supporting a specific flash shouldn't be part of this patch.
>
> In any case, why do you need this? If you can share the details about
> this device, it would be interesting for me to take a look.
>
> This driver's open-coded, legacy-style flash detection is nasty, and the
> only reason I've kept it is to avoid breaking some wacky user with some
> old board. In fact, maybe we can just kill it so nobody thinks it's sane.

I think you'll kill the zylonite board, and I'll nack it if that's the case. At
least that's what happened when I tried to use onfi default values last time in
barebox development.

I can test your changes, but if the specific zylonite nand (ie. nand id 0xba20,
ie. pxa310 embedded flash) gets broken, I'm against the removal of the legacy
timings removal.

And all of this because zylonite is my main vehicle as pxa3xx maintainance.

Cheers.

--
Robert
