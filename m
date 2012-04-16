From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 16 Apr 2012 07:50:12 +0200
Subject: [PATCH v6 17/17] pwm: Take over maintainership of the PWM
 subsystem
In-Reply-To: <20120412122740.GB5353@avionic-0098.adnet.avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <201204101951.44198.arnd@arndb.de>
 <20120412072206.GB18252@avionic-0098.mockup.avionic-design.de>
 <201204121134.24892.arnd@arndb.de>
 <20120412122740.GB5353@avionic-0098.adnet.avionic-design.de>
Message-ID: <20120416055012.GA3037@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thierry Reding wrote:
> * Arnd Bergmann wrote:
> > On Thursday 12 April 2012, Thierry Reding wrote:
> > >   * Arnd Bergmann wrote:
> > > > On Tuesday 10 April 2012, Thierry Reding wrote:
> > > > > I'm taking over the maintainership of the PWM subsystem. This commit
> > > > > also adds the URLs to the gitorious project and repository as well as
> > > > > any missing files related to the PWM subsystem.
> > > > > 
> > > > > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > > > > ---
> > > > > Note: I guess this patch in particular could use some Acked-by, maybe from
> > > > > Arnd and Sascha so that people will know this happens with their blessing.
> > > > 
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > As far as I can tell the series is in pretty good shape. I've integrated
> > > Shawn's latest comments and I think we could get this into 3.5. Does it make
> > > sense to take the PWM tree through Linux next before having it pulled into
> > > mainline during the next merge window?
> > 
> > Yes, that's the way to go. Just ask Stephen Rothwell to include it right
> > away if you are sufficiently happy with the contents and believe that they
> > don't break stuff.
> 
> I just saw that there's been some discussion to remove IS_ENABLED() and
> replace it by something else. So maybe I should wait another day or two
> until those changes settle in next.

Seems like this issue is resolved, but something else came up. In the !OF
builds, of_pwm_request() no longer builds because of_property_match_string()
and of_parse_phandle_with_args() have no dummies for !OF. I've posted patches
for these on Friday and they need to go in before the PWM subsystem. I could
also revert the IS_ENABLED() parts and go back to a #ifdef CONFIG_OF but I'd
rather not.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120416/36702ea1/attachment-0001.sig>
