From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Nov 2018 11:41:40 -0700
Subject: [PATCH 0/2] STM32: Fixes for 4.19 cycle
In-Reply-To: <20180926034055.yj3re5o4oesda4x5@localhost>
References: <1537461257-2940-1-git-send-email-alexandre.torgue@st.com>
 <20180923123438.kyvxpeqq6q6xo6cs@localhost>
 <d952b14a-644e-a067-9615-f0d35f370893@st.com>
 <CAOesGMjEHaubwAdZCo9ZgJEDJwaCTB1MgFfeqzwnScwPn2aELg@mail.gmail.com>
 <0f424a8e-67e0-cdc2-0276-660e455e3df6@st.com>
 <20180926034055.yj3re5o4oesda4x5@localhost>
Message-ID: <CAOesGMiwe5B84jPzyybGEb20CGv6G2DMFtYFG0y7VqKjqPPvvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 8:42 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Mon, Sep 24, 2018 at 11:28:17AM +0200, Alexandre Torgue wrote:
> > Olof
> >
> > On 09/24/2018 11:19 AM, Olof Johansson wrote:
> > > Hi,
> > >
> > >
> > > On Mon, Sep 24, 2018 at 7:55 AM, Alexandre Torgue
> > > <alexandre.torgue@st.com> wrote:
> > > > Hi Olof
> > > >
> > > > On 09/23/2018 02:34 PM, Olof Johansson wrote:
> > > > >
> > > > > Hi Alexandre,
> > > > >
> > > > > On Thu, Sep 20, 2018 at 06:34:15PM +0200, Alexandre Torgue wrote:
> > > > > >
> > > > > > Hi Arnd, olof and Kevin
> > > > > >
> > > > > > Those 2 patches fixe the same issue on 4.19-rc: a bad usage of the mdma
> > > > > > binding inside stm32mp157c.dts file. Can you please add them as fixe for
> > > > > > 4.19 ?
> > > > >
> > > > >
> > > > > The patches only mention removing unused property contents, not what the
> > > > > bug is
> > > > > that it fixes (or if it's even causing any problems). Care you clarify?
> > > >
> > > >
> > > > Sure.
> > > > Concerning SPI patch: without this patch, DMA request will fail but there
> > > > will be no crash because SPI will switch in interrupt mode.
> > > > Concerning HASH one, it's just to align DT with dt-bindings documentation.
> > > > Regarding the minor issue that they fix I could understand that you postpone
> > > > the merge of those two patches for 4.20.
> > >
> > > The former sounds like an appropriate fix, but the latter is probably
> > > 4.20 material, indeed.
> > >
> > > Should I just cherry-pick the two patches, or do you want to re-stage
> > > new branches?
> >
> > I have nothing else to send for v4.20 so if you can directly take those two
> > patches for v4.20, I agree.
>
> Thanks! Applied to fixes and next/dt respectively.

Looks like "ARM: dts: stm32: update HASH1 dmas property on
stm32mp157c" got dropped due to being applied to the wrong
tree/branch, so included it in fixes now.


-Olof
