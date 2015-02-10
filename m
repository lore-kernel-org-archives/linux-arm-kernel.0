From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 10 Feb 2015 08:59:48 +0000
Subject: [PATCH] xen/arm: allow console=hvc0 to be omitted for guests
In-Reply-To: <CAKv+Gu8kQ5e9dKTp9+e_11pnvskOPjin7ODpxXTj+HmTj+fPag@mail.gmail.com>
References: <1422626319-30752-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.DEB.2.02.1502100648050.29696@kaball.uk.xensource.com>
 <1423553200.5851.15.camel@citrix.com>
 <CAKv+Gu8kQ5e9dKTp9+e_11pnvskOPjin7ODpxXTj+HmTj+fPag@mail.gmail.com>
Message-ID: <1423558788.5851.17.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-02-10 at 15:51 +0800, Ard Biesheuvel wrote:
> > FWIW on x86 this doesn't depend on console_set_on_cmdline, does it need
> > to here?
> >
> 
> I didn't check the code, but it seems inappropriate to add a preferred
> console implicitly if the user has set 'console=' on the command line.

I had been thinking that add_preferred_console would DTRT, but it seems
not. Seems strange that most calls to it do not check if the console is
already set, but it does seem like the right thing in this case.

> > On x86 it does depend on !xen_initial_domain. I suppose on the principal
> > that a VT is normally available there. I suppose that doesn't apply to
> > ARM so much, although it could.
> >
> 
> OK, I got confused by the xen_guest_init(). So do you mean if if
> (!xen_initial_domain) should be added?

(dom0 is "Just A Guest" too ;-))

Adding it would be consistent with x86, I'm not precisely sure if that
is important or desirable in this case. I'd be inclined to start with
the if there.

Ian.
