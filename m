From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 15 Feb 2013 11:39:57 +0000
Subject: [RFC v3] Better BE support for ARM
In-Reply-To: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <511E1E8D.9090503@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/13 10:55, Ben Dooks wrote:
> This is a smaller version of the previous series that adds some fixes
> for ARM big endian (BE8) mode on some of the latest ARMv7 systems as
> well as fix a few issues that where found whilst doing this.
>
> The new series should be less intrusive, as we alter less and use an
> assembly macro to remove anything we do not need if we are not in BE8
> mode. If it was not for secondary CPU initialisations and resume paths
> we could do this with a pre-boot shim for loading from LE boot loaders.x
>
> Since the issue of the ATAGS endian-ness is still in discussion, this
> has been removed from the series. If the system was booted from an LE
> enviromnent which uses FDT, then this patch set should work. The ATAGS
> code will be posted as a separate series.
>
> The fixes for ASID allocation when big endian has already been sent to
> the patch system.

Russell, any objections to get this pulled for 3.9-rc series?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
