From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 13:23:10 +0000
Subject: [PATCH 1/3] ARM: DT: STi: Add support to B2020 revision E board.
In-Reply-To: <531EFE75.9010709@st.com>
References: <1394533324-20299-1-git-send-email-lee.jones@linaro.org>
 <531EEA39.50504@st.com> <20140311112342.GE21216@lee--X1>
 <531EFE75.9010709@st.com>
Message-ID: <20140311132310.GN21216@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> >>>
> >>>This patch adds support to rev E board of B2020 which has few minor
> >>>changes :
> >>>	PHY reset PIO (Change from PIO30 to PIO07)
> >>>	Power LED(Green) Control(Change from PIO47 to PIO13)
> >>
> >>I thought we decided last October to support only one revision of
> >>the b2020 board.
> >>
> >>The idea was to create an external git to provide DTS for all our
> >>boards, and only have a minimal subset in in the kernel.
> >
> >Ah, I was unaware of that conversation/decision. If that's the case we
> >can scrap this submission along with the following patch.
> 
> In fact we had the discussion together with Arnd (IIRC) on #armlinux :)

I remember discussing {cpu,machine}_is() implementations with regards
to handling quirks. I wasn't aware that this culminated in the
decision above. When it comes to things like PIO line or other key
hardware changes through revisions, I fully expect this to be
described inside a .dts file.

> The reason is we wanted to avoid flooding arch/arm/dts/ with all the
> possible combinations of board revisions.
> 
> The idea was to put in place a git repository at stlinux.com to
> provide the DTS for all the STi boards, and try to keep
> arch/arm/dts/sti* simple.

I can certainly sympathise with the reasoning, but for me fetching DTS
files from an external Git repo sounds unnecessarily tiresome. I had
thought about creating some per-vendor directories in there to
simplify the format a little, but then I guess we're back to square
one of the old arch/arm/mach-* situation.

> >JOOI, what happens if I want to boot Mainline on my revE board? It
> >won't be fully functional will it? That will be a shame. The LEDs, not
> >so much, but networking is a pretty big piece of functionality to
> >lose.
> 
> I agree this is not comfortable.
> 
> The problem is that your patch is not enough. We would need to
> create much more files, because for example, the i2c used are not
> the same between rev. C and rev. E.
> 
> It gives theses files only for b2020 support:
>   arch/arm/boot/dts/stih415-b2020.dts
>   arch/arm/boot/dts/stih416-b2020e.dts
>   arch/arm/boot/dts/stih41x-b2020e.dtsi
>   arch/arm/boot/dts/stih416-b2020.dts
>   arch/arm/boot/dts/stih41x-b2020.dtsi
>   arch/arm/boot/dts/stih41x-b2020x.dtsi

Right, but you're also talking about supporting two different SoCs
there too, so I guess that's not so bad?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
