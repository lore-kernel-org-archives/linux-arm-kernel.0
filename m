From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Nov 2013 19:15:57 +0100
Subject: ACPI
In-Reply-To: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
Message-ID: <201311191915.57516.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 November 2013, Jon Masters wrote:
> Hi Folks,
> 
> Starting a new thread with a question. Suppose for a moment that ACPI is
> the way of the future and that there is, in fact, already a three year
> story behind this[0] that will come out in due course. What could be
> done to make things smoother /going forward/? Could we articulate a
> series of useful asks that would help with moving forward with ACPI? 

I think the most important thing to do here is to actually describe
and agree on the scope of ACPI support here.  I think in the discussion,
everyone had different scenarios in mind, and hopefully only some
of them apply here. You keep saying "servers", but that isn't actually
a feature of how the system is designed, rather than what is running
on them. Given these examples (or any others, you could come up with),
which ones do you actually see as relevant here:

1. An exterprise server (SPARC enterprise M9000, Power 795, Integrity
   Superdome) with the CPU core changed to run ARM instructions
2. An ATX whitebox server mainboard with one to four sockets and PC
   peripherals and plug-compatible ARM CPU chips.
3. A purpose-built server SoC based on standard components
4. A new server SoC based on an older proprietary embedded or mobile
   SoC design (think Exynos, OMAP, Snapdragon, ... based)
5. A server built from using a cheap devboard (BeagleBone, Cubieboard, ...
   style) with an unmodified SoC.
6. A virtual machine running on KVM or Xen.

Related to that question, what would be the expected way to do runtime
device power management? 

a) not at all
b) using ACPI D states and AML
c) using HW-specific clock/regulator/pmdomain/pinctrl/phy/...
   kernel drivers

Some combinations of the above are particularly scary, and until we
have ruled out a good number of them, we will keep arguing about the
wrong problems.

The other really helpful would be a list of things that actually
speak in favor of doing ACPI, from a system design perspective.
What is it that people want out of it?

> For example, it is clear that there needs to be more involvement in the
> standardization of ACPI (this is why we initiated the governance model
> change of ACPI several years ago that has taken this long to resolve
> with everyone involved in that) and we want to get more ARM kernel folks
> involved. But what else? Blank slate.
> What do we need to make ACPI a success here?

I think you are asking the wrong question here. I assume we all try to
make ARM Linux work best on servers and that people are willing to
work together on that. However, to a lot of us that would mean making
sure that ACPI does not get anywhere near us (for the right or for the
wrong reasons). A blank slate to me would imply that you consider the
possibility that ACPI is not the right answer at this point at all rather
than asking everybody is working on platform code to take your word
that it is.

Since you mention this has been going for three years, I can understand
what arguments originally led to such a decision, but my feeling is that
we have move on since then and that the original discussion will need to
be revisited (ideally in a more open way) based on what we learned in
the meantime by moving most ARM platforms over from board files to DT.

	Arnd
