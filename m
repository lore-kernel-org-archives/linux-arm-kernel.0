From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 20 Nov 2018 09:38:30 +0100
Subject: [PATCH 2/3] pinctrl: stm32: protect configuration registers with
 a hwspinlock
In-Reply-To: <CACRpkdZD5EurbTRyUg7AWRZqVQ-6rmUQDUmVVCFU3r0Y1bwnVg@mail.gmail.com>
References: <20181113095142.32015-1-benjamin.gaignard@st.com>
 <20181113095142.32015-3-benjamin.gaignard@st.com>
 <CACRpkdZD5EurbTRyUg7AWRZqVQ-6rmUQDUmVVCFU3r0Y1bwnVg@mail.gmail.com>
Message-ID: <CA+M3ks6nnj69KJay=nGS=RP2jEkPa0wibfVkwYN9-CSq=fHowg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lun. 19 nov. 2018 ? 13:20, Linus Walleij <linus.walleij@linaro.org> a ?crit :
>
> On Tue, Nov 13, 2018 at 10:51 AM Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>
> > If a hwspinlock if defined in device tree use it to protect
> > configuration registers.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> Patch applied with Alex' ACK.

Thanks

>
> Out of curiosity: what is it protecting against?
> I would guess simultaneous access from another CPU
> but the commit doesn't say.
>
> Simultaneous access from two CPUs makes it extra important
> that all register access is read-modify-write, so I'd have a second
> check over the code to make sure this is the case.

Yes it is to protect configuration registers from being used at the same by
cortexA and cortexM.

>
> Yours,
> Linus Walleij
