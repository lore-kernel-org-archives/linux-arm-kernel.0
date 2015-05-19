From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 19 May 2015 16:36:39 +0200
Subject: [PATCH] memory: tegra: Expose supported rates via debugfs
In-Reply-To: <CAAObsKCo7x4qMdPvBb-dNoN=j7Od-eMCxw9BNoSvDR5mUZXGtA@mail.gmail.com>
References: <1431963330-25708-1-git-send-email-thierry.reding@gmail.com>
 <CAAObsKCo7x4qMdPvBb-dNoN=j7Od-eMCxw9BNoSvDR5mUZXGtA@mail.gmail.com>
Message-ID: <20150519143637.GF26748@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 02:21:01PM +0200, Tomeu Vizoso wrote:
> On 18 May 2015 at 17:35, Thierry Reding <thierry.reding@gmail.com> wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > In order to ease testing, expose the list of supported EMC frequencies
> > via debugfs.
> 
> Looks good to me, but if this is for automated testing, why not just
> read the timings from the DT? We would be covering more code that way.
> 
> Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

The idea is that by putting this into debugfs we have a single source of
information to use in tests.

Now if in addition to merely testing the frequencies you want to make
sure the driver has a consistent representation of what's in device tree
we could always write another test that reads the device tree nodes and
compares them to the list of supported rates from debugfs.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150519/9abd9450/attachment.sig>
