From: jrbenito@benito.qsl.br (Josenivaldo Benito Junior)
Date: Thu, 20 Sep 2012 18:48:07 -0300
Subject: Adding new board to Kernel
In-Reply-To: <201209191855.39859.arnd@arndb.de>
References: <CAOYb-CL9WM8wzko7CsQvYAAWKARnTkrqenBtsgchn96t=x4wyg@mail.gmail.com>
 <201209191855.39859.arnd@arndb.de>
Message-ID: <CAOYb-CLyaOc5qrLGNgfSb3q0paN1kEby-Tq3tVv8MBiMw6cAWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the info!

--*
Josenivaldo Benito Jr.*
*PU2LBD*

*Por Aur?lio Buarque de Hollanda,  elite, do franc?s ?lite, significa ?o
que h? de melhor em uma sociedade, minoria prestigiada, constitu?da pelos
indiv?duos mais aptos?.



On Wed, Sep 19, 2012 at 3:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 27 July 2012, Josenivaldo Benito Junior wrote:
> > Hi there,
> >
> > The Embedded Artists has a board based on ARM LPC3250 called EA3250 and
> > they provide a BSP with patch to Linux Kernel version 2.6.29.2. I am
> trying
> > to "up merge" this patch to Kernel v3.4 (now 3.5) and after that get it
> in
> > the mainstream. Although I have a working version (
> > https://github.com/jrbenito/Kernel-LPC3250) I still have doubts on how
> to
> > correct submit it to mainline kernel.
> >
> > -The machine type is already registered in past (
> > http://www.arm.linux.org.uk/developer/machines/list.php?id=2512) but it
> is
> > not in mainline. Since I shall not patch this file, how can I ask to it
> be
> > updated with ea3250 board information?
>
> Sorry for the late reply, I was just going through old unread email.
>
> The lpc32xx platform is getting converted to device tree based probing,
> which means your board will have to use a device tree file rather than
> a board number anyway, which at least solves the problem of getting back
> the assigned board number entry.
>
> > -Could you please point me any documentation on how to add board support
> to
> > Linux Kernel?
> >
> > My doubts are mainly related with process and order of files to submit I
> > shall follow. Any direction will be strongly appreciated.
>
> Please have a look at the phy3250 support in arch/arm/boot/dts/phy3250.dts
> and at the files in Documentation/devicetree.
>
> There are still a few bits missing device tree bindings, in particular the
> display and the DMA engine, but you can start with a device tree file
> that describes everything else.
>
>         Arnd
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120920/4f430a83/attachment-0001.html>
