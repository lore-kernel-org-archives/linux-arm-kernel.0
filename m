From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 21 Mar 2012 19:26:56 +0800
Subject: [PATCH 1/1] net: phylib: remove the length limitation of mii
 bus id
In-Reply-To: <4F688F01.40604@openwrt.org>
References: <1332217386-3586-1-git-send-email-b29396@freescale.com>
 <CAAQ0ZWQEoPORMXsf3xV-KPP+hOHk2euj460fORyUALnfPn3Q8g@mail.gmail.com>
 <CAA+hA=Ttc9RDmK1fDPCtqLpf91DYDDFSf3E6zWQ6seyw7sNqTg@mail.gmail.com>
 <4F688F01.40604@openwrt.org>
Message-ID: <20120321112655.GB4905@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 10:06:57PM +0800, Florian Fainelli wrote:
> Hi,
> 
> Le 03/20/12 11:53, Dong Aisheng a ?crit :
> > On Tue, Mar 20, 2012 at 1:32 AM, Shawn Guo<shawn.guo@linaro.org>  wrote:
> >> On 20 March 2012 12:23, Dong Aisheng<b29396@freescale.com>  wrote:
> >>> From: Dong Aisheng<dong.aisheng@linaro.org>
> >>>
> >>> When convert to dt, the length of old mii bus id (17 bytes) is not
> >>> sufficent to use.
> >>> For example, the bus id could be 800f0000.ethernet-1:00 in DT.
> >>>
> >>> This patch removes the bus id length limitation by changing the
> >>> bus id to a const char pionter and user could dynamically set the
> >>> bus id via kasprintf function call.
> >>>
> >>> Since then no users use MII_BUS_ID_SIZE any more, just remove it.
> >>>
> >>> Signed-off-by: Dong Aisheng<dong.aisheng@linaro.org>
> >>> ---
> >>> The simplest way may just change MII_BUS_ID_SIZE to a more bigger size,
> >>> but i'm not sure that's gonna be accepted.
> >>
> >> The simplest fix has been applied on -next tree as below.
> >>
> > Oh, i missed it, seems my patch covers that change.
> > But that patch only fixed wrong phy_name buffer length issue.
> > My patch is totally remove the length limitation of bus id and phy_name
> > or the bus id name will be truncated if it's longer than MII_BUS_ID_SIZE
> > which is not a comfortable limitation.
> 
> Then just increase the bus id size locally for your driver. Drivers that 
> can live with a static allocation are better of using it.
> 
That's the common part, can not change it locally by driver.
Or we can change MII_BUS_ID_SIZE to a more big size in common code,
maybe 30 bytes, but when is the end?

> Your patch completely missed testing the return value of kasprintf(), 
> and its return value can be NULL, please fix this at least.
> 
Yes, thanks for the reminder.
I will fix it.

Regards
Dong Aisheng
