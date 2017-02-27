From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 27 Feb 2017 15:39:20 -0500
Subject: [RFC PATCH V1 v4.10-rc3 1/1] acpi: apei: handle GSIV
 notification type
In-Reply-To: <20170227185818.GA8577@windriver.com>
References: <86258A5CC0A3704780874CF6004BA8A62DCAB57E@lhreml502-mbs>
 <20170227185818.GA8577@windriver.com>
Message-ID: <20170227153920.5f4f6942@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Feb 2017 13:58:19 -0500
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:


> > --- a/drivers/acpi/apei/Kconfig
> > +++ b/drivers/acpi/apei/Kconfig
> > @@ -1,6 +1,15 @@
> >  config HAVE_ACPI_APEI
> >  	bool
> >  
> > +config HAVE_ACPI_APEI_GSIV
> > +        bool "APEI GSIV(Global System Interrupt) logging/recovering support"
> > +        depends on ACPI_APEI && ACPI_APEI_GHES
> > +        help
> > +          This option should be enabled if the system supports
> > +          firmware first handling of GSIV (Global System Interrupt)
> > +	  for the hardware errors and allows OS to do error
> > +          recovery/logging.
> > +
> >  config HAVE_ACPI_APEI_NMI
> >  	bool  
> 
> A "config HAVE_<foo>" option normally doesn't have a "help" section
> since it isn't meant to be user selected.  You can see that in the other
> two options that exist right here in the context of your patch.

I will argue that having "help" messages for even configs that do not
get selected are useful. It helps reviewers of the code to know why one
of these events should be enabled or not.


> 
> Also your Cc list here seems rather large; not sure how you came up with
> such a large list...

+1

-- Steve
