From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Jun 2013 01:53:49 +0200
Subject: [PATCH 1/2] pinctrl: add function to parse generic pinconfig
 properties from a dt node
In-Reply-To: <CACRpkdZavNX3jk4K5unEJCED4vTuZEUF=NC1naGOMyr54hXQKw@mail.gmail.com>
References: <201306102139.32444.heiko@sntech.de>
 <201306131723.04721.heiko@sntech.de>
 <CACRpkdZavNX3jk4K5unEJCED4vTuZEUF=NC1naGOMyr54hXQKw@mail.gmail.com>
Message-ID: <1862891.4yIecp615h@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thursday 13 June 2013 17:36:00 Linus Walleij wrote:
> On Thu, Jun 13, 2013 at 5:23 PM, Heiko St?bner <heiko@sntech.de> wrote:
> >> Ok, I'll see that I get this fixed :-)
> > 
> > Hmm ... what is the meaning of the argument of bias-disable and bias-high-
> > impedance, as the kernel-doc in pinconf-generic.h does not tell?
> 
> I think those arguments are N/A, ignored, doesn't matter.
> If these options were typed, they would be bool.
> 
> Please improve documentation if you can... sorry for all the
> rough edges.
> 
> > bias-bus-hold ignores its argument and we already clarified that the
> > pull-* do have != 0 or 0 argument.
> 
> I think in the DT binding, both these forms:
> 
> bias-pull-up;
> bias-pull-up = <150000>;
> 
> Should be allowed.
> 
> So when parsing, you first check if it exists, then if there
> is an argument, if there is no value supplied, just set it
> to 1, as that is clearly != 0...

What's the expected way to disable pull-ups in DT ? Should it be 'bias-pull-up 
= <0>;' or 'bias-disable;' ?

-- 
Regards,

Laurent Pinchart
