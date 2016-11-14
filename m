From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Nov 2016 15:28:58 +0100
Subject: [PATCH 04/16] ARM: realview: use generic API for enabling SCU
In-Reply-To: <95b10b29-2d51-9e96-c628-232f081e09f4@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <3587281.4kOCcW9Ryd@wuerfel>
 <95b10b29-2d51-9e96-c628-232f081e09f4@samsung.com>
Message-ID: <7078795.avIAjbub0e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 14, 2016 5:36:43 PM CET pankaj.dubey wrote:
> On Monday 14 November 2016 05:26 PM, Arnd Bergmann wrote:
> > On Monday, November 14, 2016 10:31:59 AM CET Pankaj Dubey wrote:
> > 
> > The only difference here seems to be that realview also needs to handle
> > "arm,arm11mp-scu". Why not move that into the generic implementation?
> > 
> 
> Do you mean "arm,arm11mp-scu" this is generic SCU specific to ARM?

Yes.

> If it's generic then it can be moved on the same line I moved a5-scu and
> a9-scu.
> 
> I left it here in same file, as I understood it might be related with
> very specific to realview platform.

The reason why only realview has it is that this is currently the
only platform we support that uses SMP on an ARM11MPcore.

cns3xxx in is also SMP hardware, but we only support the first core.

	ARnd
