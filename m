From: ian.campbell@citrix.com (Ian Campbell)
Date: Wed, 18 Feb 2015 16:03:00 +0000
Subject: [PATCH v2 3/3] xen/arm: allow console=hvc0 to be omitted for
 guests
In-Reply-To: <CAL_Jsq+QniOFiVXEhuS+GEEnCkUpkrmtdE5E4ZytwTzoQSDpOg@mail.gmail.com>
References: <1424267513-15836-1-git-send-email-julien.grall@linaro.org>
 <1424267513-15836-4-git-send-email-julien.grall@linaro.org>
 <CAL_Jsq+QniOFiVXEhuS+GEEnCkUpkrmtdE5E4ZytwTzoQSDpOg@mail.gmail.com>
Message-ID: <1424275380.20761.31.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-02-18 at 09:50 -0600, Rob Herring wrote:
> On Wed, Feb 18, 2015 at 7:51 AM, Julien Grall <julien.grall@linaro.org> wrote:
> > From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > This patch registers hvc0 as the preferred console if no console
> > has been specified explicitly on the kernel command line.
> >
> > The purpose is to allow platform agnostic kernels and boot images
> > (such as distro installers) to boot in a Xen/ARM domU without the
> > need to modify the command line by hand.
> 
> How does this interact with DT chosen stdout-path?

I think it shouldn't any more than the existing calls from e.g. the 8250
driver to preferred_console do.

> Is there a node for hvc0?

Not a direct one, it is inferred from the presence of the general Xen
node. I did vaguely consider handling a stdout-path pointing to that --
but it seemed a bit of an abuse.

Ian.
