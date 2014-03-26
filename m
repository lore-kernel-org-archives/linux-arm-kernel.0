From: elder@ieee.org (Alex Elder)
Date: Wed, 26 Mar 2014 16:39:21 -0500
Subject: [ARM ATTEND] common ARM SMP initialization
Message-ID: <53334909.7050406@ieee.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'd like to attend the ARM mini-summit on April 28th.

I've been working on adding SMP support for a Broadcom SoC
and have found a very large amount of duplication of code
involved in starting up secondary ARM cores.

I'm working on a patch series that creates a consolidated
set of routines for multiple platforms to use.  Several
of these are going to be very easy; but there may need to
be a few (fairly small) tweaks to support more platforms
generically.

My goal is to define a set of CPU "enable-method" property
values that will allow a machine to leverage generic code
by specifying a few values in the machine's device tree.
There are two of these defined for arm64, and I'm trying
to follow the "spin-table" method there to make them as
consistent as possible.

I'll be posting some patches on this soon, but I'd like
to discuss this general topic at the summit, to make
sure I can hear from others any special requirements
or restrictions I need to know about.  I'd also like
to make sure I can get these proposed changes well
tested; in most cases I don't have access to the
affected hardware.

					-Alex
