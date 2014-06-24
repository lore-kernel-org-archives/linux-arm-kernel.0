From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 16:56:23 +0200
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <alpine.LFD.2.11.1406241016340.16842@knanqh.ubzr>
References: <7416978.W29blLsymn@wuerfel> <20140624141056.GD4489@arm.com>
 <alpine.LFD.2.11.1406241016340.16842@knanqh.ubzr>
Message-ID: <6810513.25mgpAfEFf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 10:49:23 Nicolas Pitre wrote:
> > You don't even need to branch to out of line assembly, just branch over
> > the imprecise VFP abort handling in arch/arm/vfp/vfphw.S.
> 
> Even better.  I looked too quickly at the patch seeing a #ifdef while it 
> is in fact #ifndef.
> 
> What about something like this?
> 

I should have posted the entire original patch. There are in fact three
#ifndef that were introduced there, two in vfphw.S and one in vfpmodule.c,
so it needs to be slightly more verbose, but the principle seems right.

	Arnd
