From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 9 May 2015 10:39:14 +0300
Subject: [PATCH v3 1/4] remoteproc: introduce rproc_get_by_phandle API
In-Reply-To: <1427917039-43206-2-git-send-email-d-gerlach@ti.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
 <1427917039-43206-2-git-send-email-d-gerlach@ti.com>
Message-ID: <CAK=WgbZCqnMPEnU2992gkOp07BaCP5NJNRO-hLCAdOtUXZGRnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Wed, Apr 1, 2015 at 10:37 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Allow users of remoteproc the ability to get a handle to an rproc by
> passing a phandle supplied in the user's device tree node. This is
> useful in situations that require manual booting of the rproc.
>
> This patch uses the code removed by commit 40e575b1d0b3 ("remoteproc:
> remove the get_by_name/put API") for the ref counting a rproc klist
> code but has rproc_get_by_name replaced with an rproc_get_by_phandle API.

The general idea makes sense to me, but I'm not sure we really do need
a klist here, since the usage profile of this list is expected to be
super simple: very small number of accessors, looking for small number
of list members a small number of times, and probably never do need to
modify the list while accessing it.

I suspect that the code would be simpler to maintain, debug and
understand if we just use a simple list with a simple locking
methodology here.

Thanks,
Ohad.
