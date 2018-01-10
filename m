From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Jan 2018 16:52:43 +0100
Subject: [PATCH 0/7] ARM: dts: STi: Fix DT dtc warnings
In-Reply-To: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
References: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
Message-ID: <CAK8P3a2qgyJ8Hgr6fLnn6jVRhHVtcc1kxzyD2N7Bb7gzPe1xfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 9:21 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> This series fixes all dtc warnings related to STi platforms dt files.
> It has been triggered by Rob Herring [1]
>
> [1] https://www.spinics.net/lists/devicetree/msg206209.html
>
> For most of implicated node, a simple move outside the soc node
> solves the warnings.
>
> Patrice Chotard (7):
>   ARM: dts: STi: fix bindings notation
>   ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property
>   ARM: dts: STi: Move clocks without reg outside soc
>   ARM: dts: STi: Move leds node outside soc node
>   ARM: dts: STi: Move usb2_picophyX nodes without reg out of soc
>   ARM: dts: STi: Move sound related nodes without reg out of soc
>   ARM: dts: STi: Add fake reg property for sti-display-subsystem

Thanks a lot for addressing these!

As far as I can tell, there is one patch in particular that addresses a warning
we get at the default warning level: "ARM: dts: STi: Add gpio polarity for
"hdmi,hpd-gpio" property". Should we merge that one for 4.15 to get closer
to a clean build again? I'm not sure whether we can address the other
dtc warnings, but we're getting fairly close now.

       Arnd
