From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 13 Jun 2012 11:56:21 -0400 (EDT)
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <4FD8AC5E.1060804@redhat.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <4FD8AC5E.1060804@redhat.com>
Message-ID: <alpine.LFD.2.02.1206131128020.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jun 2012, Jon Masters wrote:

> On 06/11/2012 12:52 PM, Gregory CLEMENT wrote:
> 
> > You'll find in this patch set the new version of the initial support for a
> > new family of ARMv7-compatible Marvell SoCs initially submitted by my
> > colleague Thomas Petazzoni. Following the conclusion of the discussion when
> > we submitted our first version we have chosen to add this support for this
> > SoC family in the to support in the arch/arm/mach-mvebu/ directory.
> 
> Pardon my silly question. I know that there's an effort to reconcile the
> two different SoCs so you're picking a neutral name, but what does
> "mvebu" mean, and will you be persistently keeping this name? Our guys
> want to know what this new platform will entail for Fedora support in
> terms of the platform name being used in various non-kernel places.

Marvell like to create different names for similar things and also reuse 
the same name for totally different things.  While this might look good 
for marketing purposes, we kernel developers prefer to gather things 
together according to shared support code.

Within Marvell there are actually 2 distinct SOC families: the one 
acquired from Intel with the XScale/PXA origin, and Marvell's own design 
that produced Orion, Kirkwood, Dove, etc.

The former is found under mach-pxa and mach-mmp. The later is getting 
way too scattered, currently using mach-dove, mach-kirkwood, 
mach-mv78xx0, mach-orion5x, and two more were proposed for the new SOCs.

Since all SOCs in the later family came from the EBU division within 
Marvell, and because they share a significant amount of code despite 
their wildly different names, we settled on "mvebu" to gather them 
together in the future.

This is therefore a name for kernel engineering/maintenance purpose 
only. I'd strongly suggest not to use this name in non-kernel places.


Nicolas
