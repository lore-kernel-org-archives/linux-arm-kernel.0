From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 02 May 2018 09:20:30 +0200
Subject: [PATCH v2 6/9] drm/panel: Add Netron DY E231732
In-Reply-To: <20160909143510.GB8881@lukather>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-7-maxime.ripard@free-electrons.com>
 <CAGb2v64RQdHZod7z4ErycNgGremj41-o4R_V_i7ThrCPLNhZOw@mail.gmail.com>
 <20160909143510.GB8881@lukather>
Message-ID: <89cac24ddcb5f4ac710a697a4433c927e5c7e71e.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le vendredi 09 septembre 2016 ? 16:35 +0200, Maxime Ripard a ?crit :
> On Wed, Sep 07, 2016 at 12:01:56AM +0800, Chen-Yu Tsai wrote:
> > Hi,
> > 
> > On Tue, Sep 6, 2016 at 10:46 PM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > The E231732 is a 7" panel with a resolution of 800x480.
> > 
> > From what I could make out of an archived version of Netron's
> > website
> > (it's unreachable from my place), they are a manufacturer of printed
> > ribbon cables, not LCD panels. This is probably a no-go.
> 
> I don't know. I haven't been able to find any website for Netron DY,
> however, googling the part number I used find numerous matches on ebay
> and alibaba.

While starting a port for the A13-based TZX-Q8-713B7 tablet, it appears
that my LCD cable also has the Netron-DY E231732 marking, but is
definitely different from the one on the SinA33. So I think Chen-Yu's
comment was founded and "Netron DY E231732" does not reflect the panel
name.

Here are some details regarding the LCD cable on both devices:

The SinA33 has a 1024x600 panel with the following markings:
7300101463
E231732
NETRON-DY <> 1
94V-0\1310

The TZX-Q8-713B7 has a 800x480 panel with the following markings:
7300101448
E231732
NETRON-DY <> 2
94V-0\1249

So it seems that the distinctive part of the name is
7300101463/7300101448.

Also, it seems that various online shops list the panels with a name
like "E231732 7300101463". So maybe we could change the bindings to
have:

- netron-dy,e231732-7300101463
- netron-dy,e231732-7300101448

What do you think? Does that make sense?

We should probably also fallback netron-dy,e231732 to the sina33's panel
in order to avoid breaking the ABI.

Cheers,

-- 
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
