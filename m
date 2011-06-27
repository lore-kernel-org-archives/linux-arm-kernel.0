From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Jun 2011 15:26:12 +0200
Subject: [PATCH V2 0/3] Add drivers/pwm and drivers/pwm/st_pwm.c
In-Reply-To: <4E086590.8080100@st.com>
References: <cover.1306831238.git.viresh.kumar@st.com>
	<4E086590.8080100@st.com>
Message-ID: <201106271526.12848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 June 2011, viresh kumar wrote:
> On 05/31/2011 02:21 PM, Viresh KUMAR wrote:
> > This patchset adds drivers/pwm directory as suggested by Arnd Bergmann in
> > following discussion:
> > 
> > http://comments.gmane.org/gmane.linux.ports.arm.kernel/118651
> > 
> > and also adds support for ST Microelectronics Pulse Width Modulator. This is
> > currently used by ST's SPEAr platform and tested on the same.
> > 
> > Changes since V1:
> >  - Moved driver to drivers/pwm/ directory from drivers/misc
> >  - arch/arm/configs/spear3xx_defconfig updated accordingly.
> > 
> > Changes since earlier patchset:
> >  - Moved driver to drivers/misc/ directory.
> > 
> > It was earlier reviewed as part of following patchset:
> > "[PATCH V6 00/17] Adding devices support for all spear machines"
> > 
> > Viresh Kumar (3):
> >   drivers/pwm st_pwm: Add support for ST's Pulse Width Modulator
> >   SPEAr3xx: Add machine support for ST's PWM IP
> >   SPEAr3xx: Update defconfig for ST's PWM
>
> Will you push this patchset through your tree or somebody else will do?

Good question. If Sascha is able to come up with the patch to introduce
the generic layer, I think it would be good to have it go though him.

Otherwise I guess I can carry it, but I'd start a new tree for
drivers/{misc,char} then and put it in there, along with patches to
move the other pwm drivers.

	Arnd
