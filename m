From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 05 Nov 2013 19:59:14 +0100
Subject: [PATCH v3] iommu: shmobile: Enable the driver on all ARM platforms
In-Reply-To: <20131030162854.GB2493@sirena.org.uk>
References: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1652955.Gs3XDiEUHO@avalon> <20131030162854.GB2493@sirena.org.uk>
Message-ID: <1675842.yXNSE5Ofkv@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 October 2013 09:28:54 Mark Brown wrote:
> On Wed, Oct 30, 2013 at 12:40:12PM +0100, Laurent Pinchart wrote:
> > > For similar reasons as x86, can we please think about using:
> > > 	depends on ARM
> > > 	depends on ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI || COMPILE_TEST
> > 
> > I'm fine with your proposed option. As I don't want to respin the series
> > dozens of time let's first agree on the course of action, I will then
> > repost the patches. Mark, you've pushed towards as few platform
> > dependencies as possible, what's your opinion on this ?
> 
> In general I think we should have whatever the real depedencies are or
> COMPILE_TEST (to the extent that they will actually build cleanly on
> other targets).  That way only people who explicitly go looking to
> compile test things for build coverage (eg, when doing global cleanups
> or API updates) need to be bothered by the extra compile test options.
> 
> I'd read the above as saying the code needs ARM to build at all and that
> the hardware will only ever appear on SHMOBILE.

That's my reading as well, and it makes sense to express it that way to me. 
I'll resubmit the whole series (minus the patches that have been applied 
already, I'll fix those in follow-up patches) with the dependencies expressed 
that way.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131105/a21f7815/attachment.sig>
