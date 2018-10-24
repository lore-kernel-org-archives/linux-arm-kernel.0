From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Oct 2018 08:51:52 +0200
Subject: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
In-Reply-To: <74512aef-d551-30af-b4cf-25f48047a4ac@kernel.org>
References: <20181009112837.2517-1-peron.clem@gmail.com>
 <e761c76d-a806-402a-b25b-04aee9329dbc@kernel.org>
 <CAJiuCceZr8NsDgBJgA2y61VHdQ3JYQ6_3r4jKooKLbVfRD8eJQ@mail.gmail.com>
 <74512aef-d551-30af-b4cf-25f48047a4ac@kernel.org>
Message-ID: <20181024065152.yinlj4axprtwdzku@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 03:35:31PM -0500, Dinh Nguyen wrote:
> 
> 
> On 10/23/2018 09:44 AM, Cl?ment P?ron wrote:
> > HI Dinh,
> > 
> > On Tue, 23 Oct 2018 at 16:04, Dinh Nguyen <dinguyen@kernel.org> wrote:
> >>
> >> Hi Cl?ment,
> >>
> >> On 10/09/2018 06:28 AM, Cl?ment P?ron wrote:
> >>> Cyclone5 and Arria10 doesn't have the same memory map for UART1.
> >>>
> >>> Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 for Cylone5.
> >>>
> >>
> >> I'm not sure the need for this patch. Are there any cyclone5 based
> >> boards that has UART1 as the debug uart? I see that all of them are
> >> using UART0.
> > 
> > There is no upstream device with this UART used. But the board I have
> > use it, and there is no limitation to not have it available upstream
> > no ?
> > 
> 
> I see. Then I don't think the patch is applicable because none of the
> upstream devices need it. Now, if you were to upstream your board that
> uses UART1, then there will be a case for this patch. Do you agree?

I'd not say having to upstream the board is a sensible precondition for
such a patch. One of the arguments for moving ARM to dt was that this
allows to separate the machine specifics from the code. So I'd say if
Cl?ment has a need, this is a good enough reason to take this patch.

Just my 0.02 ?,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
