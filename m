From: stigge@antcom.de (Roland Stigge)
Date: Fri, 15 Jun 2012 14:37:45 +0200
Subject: [PATCH v2 00/23] ARM: LPC32xx specific updates for next
In-Reply-To: <CAAAP30HU7k2QC9K15V3grZvXDzy8apzBGSo8it+M4KF5wGWLZw@mail.gmail.com>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
 <201206151207.07108.arnd@arndb.de>
 <CAAAP30HU7k2QC9K15V3grZvXDzy8apzBGSo8it+M4KF5wGWLZw@mail.gmail.com>
Message-ID: <4FDB2C99.50503@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/15/2012 02:12 PM, Alexandre Pereira da Silva wrote:
> On Fri, Jun 15, 2012 at 9:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> It all looks good from my point of view, so I think we can pull it
>> for 3.6 if no other comments come.
> 
> Arn,
> 
> Please exclude "ARM: LPC32xx: Remove duplicate usb host clock init".
> It's causing problems in some LPC32XX boards.

Right - it would break USB e.g. on the EA3250 board since USB would work
only if the bootloader already did some initialization which is silently
done by PHY3250 where we didn't recognize the problem.

So please just take patches 01..22 from the lpc32xx-next branch.

I just removed patch 23 from git.antcom.de, so you can easily just pull
the branch.

Further, as Russell already pointed out, the DMA API will probably
change, but I expect that we will quickly adjust to it so no need to
worry about that.

Thanks,

Roland
