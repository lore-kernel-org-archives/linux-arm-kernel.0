From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Jan 2015 15:42:14 +0000
Subject: [PATCH repost 03/16] arm64/uaccess: fix sparse errors
In-Reply-To: <20150123153316.GB9557@e104818-lin.cambridge.arm.com>
References: <1419499661-8566-1-git-send-email-mst@redhat.com>
 <1419499661-8566-4-git-send-email-mst@redhat.com>
 <20150123153316.GB9557@e104818-lin.cambridge.arm.com>
Message-ID: <20150123154213.GB31460@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 03:33:16PM +0000, Catalin Marinas wrote:
> On Thu, Dec 25, 2014 at 09:28:41AM +0000, Michael S. Tsirkin wrote:
> > virtio wants to read bitwise types from userspace using get_user.  At the
> > moment this triggers sparse errors, since the value is passed through an
> > integer.
> > 
> > Fix that up using __force.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> I'm not sure who's going to merge this series. In the meantime, I
> cherry-picked the arm64 patch. Thanks.

I think there was a pull request for the whole series that went to Arnd, so
I don't think we need to do anything on the arm64 side.

Will
