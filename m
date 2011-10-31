From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2011 14:33:51 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111031142602.GA30958@totoro>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031141322.GK19187@n2100.arm.linux.org.uk>
	<20111031142602.GA30958@totoro>
Message-ID: <20111031143351.GL19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 02:26:02PM +0000, Jamie Iles wrote:
> I think you need:
> 
> spatch -sp_file arch_reset-1.cocci -patch .  arch/arm/*/include/*/system.h > \
> arch_reset-1.diff
> 
> I've also used -in_place in the past then use git to generate the diff, 
> but I guess it is nicer to have the patch self-contained.

Ah, yes, that allows it to start generating more useful patches, thanks.

I tried -patch '', which the documentation said should be the current
directory:

  -patch                     <dir> path name with respect to which a patch should be created
    "" for a file in the current directory

except it instead spits out this error:

Fatal error: exception Invalid_argument("index out of bounds")
