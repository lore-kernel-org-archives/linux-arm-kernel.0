From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Mar 2014 15:36:45 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140321150118.GH13596@arm.com>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
 <20140320171930.GA28238@arm.com>
 <20140321111353.GA24945@sirena.org.uk>
 <20140321150118.GH13596@arm.com>
Message-ID: <20140321153645.GA552@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 03:01:18PM +0000, Catalin Marinas wrote:
> On Fri, Mar 21, 2014 at 11:13:53AM +0000, Mark Brown wrote:

> > One thing that occurs to me with this - if we've always got a DT even if
> > we are booting with ACPI that might confuse code that implements
> > handling for firmware idioms.

> The DT presented on an ACPI-capable system only contains the chosen
> node (I guess the DT will not even be unflattened) .So the topology
> code would check for DT, if not it would check for ACPI (or the other
> way around) and only after that fall back to hardware MPIDR. I'm not
> sure whether current ACPI gives us rich enough information about
> topology like DT, in which case it could simply use MPIDR.

Sorry, this isn't related to topology - it's to do with other code that
checks if a DT was present and makes decisions based on that.  So long
as of_have_populated_dt() doesn't report true things should be fine but
it's something to watch out for.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/80a9e857/attachment.sig>
