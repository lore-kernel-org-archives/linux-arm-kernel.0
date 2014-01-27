From: ijc@hellion.org.uk (Ian Campbell)
Date: Mon, 27 Jan 2014 15:52:23 +0000
Subject: [PATCH] sunxi: dts: add a note that memory size is adjusted by
 boot loader.
In-Reply-To: <20140127145714.GL3867@lukather>
References: <1390572852-15027-1-git-send-email-ijc@hellion.org.uk>
 <52E2874F.10703@redhat.com>
 <1390578114.13513.13.camel@kazak.uk.xensource.com>
 <52E399F4.1040300@redhat.com> <20140127145714.GL3867@lukather>
Message-ID: <1390837943.12230.45.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-01-27 at 15:57 +0100, Maxime Ripard wrote:
> Hi Ian, Hans,
> 
> On Sat, Jan 25, 2014 at 12:03:16PM +0100, Hans de Goede wrote:
> > Hmm, I've no idea what the default / preferred way of handling this is,
> > I assume Maxime knows, so lets wait for his input on this.
> 
> I got the habit of setting the memory node to the max size the RAM
> controller can handle from previous work on imx,

I suppose this has the advantage of being static for a given SoC, so
there is no question of what the smallest possible value is, even if it
has the disadvantage of not working as a default on many platforms
(perhaps I'm overestimating the utility of that?).

>  but I don't really
> have a preferrence here.
> 
> If that confuses people, we can just remove it from the DTSI
> altogether. It will be patched by u-boot anyway, and we won't have to
> create DTS variants this way.

I've occasionally seen issues with u-boot not expanding the fdt itself,
so the placeholder serves the purpose of letting it update without
expanding. That was in my more complex Xen boot script which use "fdt
set" a lot -- probably doesn't apply to properly integrated
functionality like updating the memory node? (Or if it does that's a
u-boot bug).

> Just don't do it for the A31 for the moment, since we don't have
> DT-enabled u-boot for now.

Ack!

Ian.
