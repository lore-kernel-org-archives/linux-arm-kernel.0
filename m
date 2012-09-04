From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Sep 2012 10:08:54 +0100
Subject: [PATCH] ARM: ux500: Provide SMSC911x fixed-regulator when not
 booting DT
In-Reply-To: <CACRpkdb_aW-uxf_4GQpRWJhLqD_QujH1BOFeG4MgVHfRasGY+A@mail.gmail.com>
References: <1345809612-30992-1-git-send-email-lee.jones@linaro.org>
 <20120903133333.GE31163@gmail.com>
 <CACRpkdb_aW-uxf_4GQpRWJhLqD_QujH1BOFeG4MgVHfRasGY+A@mail.gmail.com>
Message-ID: <20120904090846.GA6091@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 10:53:32AM +0200, Linus Walleij wrote:
> On Mon, Sep 3, 2012 at 3:33 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Author: Lee Jones <lee.jones@linaro.org>
> > Date:   Fri Aug 24 12:40:58 2012 +0100
> >
> >     ARM: ux500: Provide SMSC911x fixed-regulator when not booting DT
> >
> >     The SMSC911x Ethernet chip requires a fixed-regulator in order to
> >     function correctly. We have previously provided a means to obtain
> >     this during a Device Tree boot, however nothing has been put into
> >     place when booting with a non-DT kernel. This patch aims to change
> >     that.
> >
> >     Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> You forgot to add select REGULATOR_FIXED_VOLTAGE to
> the MOP500 Kconfig entry, but I added it when applying.

I didn't forget. I intentionally left it out because it's
unconditionally set in the defconfig.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
