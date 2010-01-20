From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 19 Jan 2010 17:24:09 -0700 (MST)
Subject: [PATCH 04/10] OMAP clockdomain/powerdomain: remove runtime
	register/unregister
In-Reply-To: <87ljftd582.fsf@deeprootsystems.com>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
	<20100112010536.6275.36524.stgit@localhost.localdomain>
	<87ljftd582.fsf@deeprootsystems.com>
Message-ID: <alpine.DEB.2.00.1001191723250.3977@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, 19 Jan 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > OMAP clockdomains and powerdomains are currently defined statically,
> > only registered at boot, and never unregistered, so we can remove the
> > unregister function and the locking.   A variant of this was originally
> > suggested a while ago by Dmitry Baryshkov <dbaryshkov@gmail.com>.
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
> 
> Hi Paul,
> 
> This patch removes the _nolock() iterator but forgot to fixup the
> users.  I found this when building an updated PM branch on top of your
> fixes branch.

That patch is in the for_2.6.34 branch, so I'll fold your fix in there. 


thanks,

- Paul
