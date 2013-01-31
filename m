From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Jan 2013 14:56:30 -0800
Subject: [PATCH 6/6] ARM: integrator: ensure ap_syscon_base is
 initialised when !CONFIG_MMU
In-Reply-To: <20130131223417.GB19961@mudshark.cambridge.arm.com>
References: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
 <1359556069-28289-7-git-send-email-will.deacon@arm.com>
 <CACRpkdbFL6cA9wPdc7h8bTmH0t7PeVwmO+4LBwQGbSKNFJOS+Q@mail.gmail.com>
 <20130131223417.GB19961@mudshark.cambridge.arm.com>
Message-ID: <20130131225630.GB26523@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 10:34:17PM +0000, Will Deacon wrote:
> Hi Linus,
> 
> On Thu, Jan 31, 2013 at 08:21:04PM +0000, Linus Walleij wrote:
> > On Wed, Jan 30, 2013 at 3:27 PM, Will Deacon <will.deacon@arm.com> wrote:
> > 
> > > When running on Integrator/AP using atags, ap_syscon_base is initialised
> > > in ->map_io, which isn't called for !MMU platforms.
> > 
> > Oh hm. Haha apparently there is one guy with more bizarre hobbies
> > than myself, you're making me feel un-geeky... ;-)
> 
> Ha! Unfortunately, I only have one core-tile otherwise you could have one to
> help you feel less left-out :)
> 
> > > Instead, initialise the pointer in ->machine_init, as we do when booting
> > > with device-tree.
> > 
> > I was trying to figure out if there is some case where we need it earlier
> > but apparently not so.
> > 
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Cheers!
> 
> > Maybe you should send this oneliner directly to the ARM SoC
> > people?
> 
> [adding Olof and Arnd] Is it worth sending a pull request containing a
> single patch, or can this patch just be picked directly?

Definitely ok to just send the patch like this. However -- where was
the breakage introduced, i.e.  what should we apply the fix to?


-Olof
