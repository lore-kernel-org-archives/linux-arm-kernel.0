From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Wed, 6 Oct 2010 14:18:37 +0530
Subject: PL310 and QoS logic
In-Reply-To: <4C56D9DC.9010008@st.com>
References: <4C56D9DC.9010008@st.com>
Message-ID: <AANLkTi=tbFt9TyRL2oTDvgJu9BAxsc=mrpApCCMuQdrd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell, Catalin,

On Mon, Aug 2, 2010 at 8:14 PM, Armando VISCONTI
<armando.visconti@st.com> wrote:
> Catalin, All,
>
> I work on the SPEAr1300 SoC, which is a device based on Cortex A9 MP (r1p1)
> and
> is using a PL310 L2 cache controller.
>
> We are using the Linux version 2.6.35 and we have also ported some patches
> coming
> from you.
>
> Even with this latest version of kernel we are not able to make the L2 cache
> working.
> It looks like that we are having a problem particularly when using it in
> combination
> with MP.
>
> Just to add a very important information, the situation looks to clearly
> stabilize
> when ?we set the bit9 of PL310 Auxiliary Control Register to '1'. THis bit
> is reserved,
> and ARM support told us to avoid setting it.
>
> In fact, this bit when set seems to disable a ?QoS logic whose purpose is to
> avoid issues
> for which one core is not able to release a semaphore because the other core
> is
> continuously trying to take it. So, this QoS logic has been introduce inside
> the
> PL310 to set a kind of priority (a QoS).
>
> Strangely enough this issue looks exactly what we are seeing.
> It explains all of our observations.
>
> So, it seems that for us writing this bit9 to '1' has the effect of
> enabling (and not disabling) the QoS logic.
>
> Have you ever heard an issue like that?

Any help on this.

regards
Shiraz
