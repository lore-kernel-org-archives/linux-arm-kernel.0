From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Jan 2017 14:04:57 +0800
Subject: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
 for imx6sll
In-Reply-To: <CACRpkdaxvf6eHujfvKuOsRb69aL8+4jTE-aR3a6ywhytTEu6Hw@mail.gmail.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-6-git-send-email-ping.bai@nxp.com>
 <CACRpkdYUME8K+JusA0ORRKqxyBuhDdyei8eg7UZbHidKw9=bQw@mail.gmail.com>
 <AM3PR04MB5304992095753B761E66A9A87640@AM3PR04MB530.eurprd04.prod.outlook.com>
 <CACRpkdYTpEHyzBY-mA4YUsj=xt46Pibka3-4VHwUXosfgbgp1Q@mail.gmail.com>
 <AM3PR04MB530A88C5C0E7C6AD2C59B9E87790@AM3PR04MB530.eurprd04.prod.outlook.com>
 <CACRpkda1a4+yOrzBnKs6J84PS0StwQ68gHxDub_u7i5ofU9s7w@mail.gmail.com>
 <AM3PR04MB530F532D867C08824DADDC9877C0@AM3PR04MB530.eurprd04.prod.outlook.com>
 <CACRpkdaxvf6eHujfvKuOsRb69aL8+4jTE-aR3a6ywhytTEu6Hw@mail.gmail.com>
Message-ID: <20170123060454.GD5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 01:24:30PM +0100, Linus Walleij wrote:
> On Tue, Jan 17, 2017 at 7:35 AM, Jacky Bai <ping.bai@nxp.com> wrote:
> >> Subject: Re: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
> >> On Thu, Jan 12, 2017 at 3:57 AM, Jacky Bai <ping.bai@nxp.com> wrote:
> >>
> >> > Another thing is that we can use a pins-tool program developed by NXP
> >> > to  generate the pinctrl configuration code that can be used directly
> >> > in dts. This tiny program can avoid pin function conflict. As on i.MX,
> >> > there are so may pins, each pin can be used for up 8  function.
> >> > Configuring the pins is a time-consuming work.  This tools is very useful for
> >> customer to generate the dts code.
> >>
> >> I understand, but every silicon vendor has such a tool, all are different,
> >> proprietary and unfriendly to programmers and open source developers, who
> >> need to understand how the hardware is working without magic tools and
> >> secret data sheets to fix bugs.
> >>
> >> For the people working with maintaining the code it is paramount that DTS files
> >> are self-descriptive.
> >
> > OK.  Thanks for your comments.  Adding generic-pinconf in imx pinctrl needs some time
> > to finish and the legacy method still need be here even if generic-pinconf is added.
> > Do you plan to pick this legacy binding patch for now?
> 
> As I said earlier:
> 
> > atleast I need an indication from one of the i.MX maintainers how they
> > want to proceed.

Sorry for being late for the discussion.

To be honest, I did not really expect so many i.MX6 variants coming to
us.  Just out of curiosity, are there any more in the pipeline to come,
or is this the last known one?

I understand that there are now more generic support available at
pinctrl core level for us to use than the time we initial designed i.MX
pinctrl driver.  But I intend to agree with Jacky that imx6sll can be
supported by the existing driver, since it doesn't require any
additional driver changes.

If any new generation of i.MX family require changes on the existing
pinctrl driver, we should probably push back for a redesign to use
generic support as much as possible.  @Jacky, how does i.MX8 pinctrl
look like?  How same or different as/from i.MX6 pinctrl?

Just my opinion.

Shawn
