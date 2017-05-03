From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 4 May 2017 00:27:46 +0200
Subject: [PATCH 1/3] ARM: dts: imx6qdl-nitrogen6_max: fix rv4162 compatible
In-Reply-To: <CAOMZO5BhxHbSyHhj-6GhHNSbgQ6H6b1+HudB9MhmUOsFPdd5YA@mail.gmail.com>
References: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
 <20170503085010.GF18578@dragon>
 <CAOMZO5BhxHbSyHhj-6GhHNSbgQ6H6b1+HudB9MhmUOsFPdd5YA@mail.gmail.com>
Message-ID: <20170503222746.rsm5y5dwesqbdk2k@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2017 at 19:14:42 -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Wed, May 3, 2017 at 5:50 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> 
> >>       rtc: rtc at 68 {
> >> -             compatible = "st,rv4162";
> >> +             compatible = "microcrystal,rv4162";
> >
> > The compatible is not documented?
> 
> This compatible has been added in a897bf138c9b443 ("rtc: m41t80: Add
> proper compatible for rv4162") in linux-next, so it will be present in
> 4.12-rc1.

Yes, and to be clear, both patches are independent and can be applied
in any order because the i?C core will still continue to match the
i2c_device_ids if the compatible doesn't match.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
