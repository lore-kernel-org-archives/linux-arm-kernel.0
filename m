From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 1 Jul 2018 16:21:21 +0800
Subject: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
In-Reply-To: <CAOMZO5B5PS7a6SFfzX915AkRoDpeFVV7P0hrG9A51yWRFy5X_w@mail.gmail.com>
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
 <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru>
 <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
 <CAOMZO5B5PS7a6SFfzX915AkRoDpeFVV7P0hrG9A51yWRFy5X_w@mail.gmail.com>
Message-ID: <20180701082119.GH4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 02:00:11PM -0300, Fabio Estevam wrote:
> On Wed, Jun 27, 2018 at 1:46 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
> 
> > We are now starting to give Andrey Gusakov conflicting
> > recommendations. For the sake of moving forward, can we agree that
> > this and similar comments are relatively minor and defer to the
> > maintainers to make a call which way to go?
> > This way Andrey has a clear way on how to move forward with this set.
> 
> The approach in this patched looked fine to me as well.
> 
> Maybe we can have some feedback from Shawn?

I'm overall fine with the approach as well.  But I agree with Nikita's
comment that having pinctrl definition and usage spread in different
files makes reader's life harder.  So I would suggest that we have the
following properties in imx51-zii-rdu1.dts as well.

	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_swi2c>;

Shawn
