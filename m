From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Apr 2012 18:31:23 +0000
Subject: [PATCH 2/9] SPEAr13xx: Add source files
In-Reply-To: <CAOh2x=mFk4j3+5-gMG1gbpJ6tPMDz1ArYQyL2=cBGfH+B9eLWw@mail.gmail.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <201204201815.57556.arnd@arndb.de>
 <CAOh2x=mFk4j3+5-gMG1gbpJ6tPMDz1ArYQyL2=cBGfH+B9eLWw@mail.gmail.com>
Message-ID: <201204211831.24158.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 April 2012, viresh kumar wrote:
> On 4/20/12, Arnd Bergmann <arnd@arndb.de> wrote:

> > I'd like to see this done differently, with a ahci_spear driver derived from
> > ahci_platform that provides these functions in a modular driver that
> > registers
> > to a spear specific identifier string and is able to do the platform
> > specific
> > based on information it can find in the device tree. That would however
> > require
> > changes to the existing ahci_platform code and I'd first like to hear what
> > Jeff and others have to say about this.
> 
> To get platform data for ahci with DT, we need to do as mentioned by you.
> But for now maybe we can accept this approach. Once somebody fix ahci
> DT support as you suggested, we could create such drivers.

Ok, fair enough. Right now we have only four platforms using this (davinci,
exynos, imx and now spear), but the code is still fairly well isolated.

	Arnd
