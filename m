From: monstr@monstr.eu (Michal Simek)
Date: Tue, 22 May 2012 10:18:22 +0200
Subject: [PATCH 1/7] remoteproc: resource table overhaul
In-Reply-To: <CAK=WgbYSrzTKW-QME4-r6XhVAQL0b6iWyus632KZOpfpTPgwWg@mail.gmail.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
 <1330589497-4139-2-git-send-email-ohad@wizery.com>
 <4F6354E4.8030704@monstr.eu>
 <CAK=Wgbbbi4GnuHedSh6cR1LhkZr8c9q6i=_TLSL252LpPB8Xsw@mail.gmail.com>
 <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
 <CAHTX3d+=QTZo994jct6+pPqsCniG0B2a_9q6fLdGjvcbZ7qj_A@mail.gmail.com>
 <CAK=WgbahzGHmvszw6HBgihN4NcPA8ceaQCNSOk_FC61bToxBXQ@mail.gmail.com>
 <CAHTX3dK8rDomYqWvBX1ay200AmM1dBCYD3nJ2UYbzC_SSFankw@mail.gmail.com>
 <CAK=WgbYSrzTKW-QME4-r6XhVAQL0b6iWyus632KZOpfpTPgwWg@mail.gmail.com>
Message-ID: <CAHTX3dKKr5bjUKQVsaHhy41yjz8V-yyAWAbit73WgGEWFv4e2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

2012/5/22 Ohad Ben-Cohen <ohad@wizery.com>

> Hi Michal,
>
> On Tue, May 22, 2012 at 8:51 AM, Michal Simek <monstr@monstr.eu> wrote:
> > Simple enabling RSC_VDEV in rproc_handle_rsc doesn't work.
>
> Sure - you'll need to actually plug the vrings allocation code there,
> too (i.e. this requires some coding, it's not a 1-liner).
>
> > BTW: I am using kernel modules and there is no dependency for
> > virtio_rpmsg_bus in remoteproc module
> > in sense if you load remoteproc module you also need to load
> > virtio_rpmsg_bus to get firmware to work.
>
> This is expected: remoteproc only provides means for booting and
> controlling remote processors and it doesn't boot them upfront.
>
> To actually boot a remote processor, and do something useful with it,
> one needs to load a module which utilizes remoteproc's API (e.g.
> virtio_rpmsg_bus, but YMMV).
>
> > ~ # lsmod
> > ~ # modprobe zynq_remoteproc
> > zynq_remoteproc: Unknown symbol rproc_register (err 0)
> > zynq_remoteproc: Unknown symbol rproc_alloc (err 0)
> > zynq_remoteproc: Unknown symbol rproc_vq_interrupt (err 0)
> > zynq_remoteproc: Unknown symbol rproc_free (err 0)
> > zynq_remoteproc: Unknown symbol rproc_unregister (err 0)
>
> We don't have these errors - have you tried looking into them ?
>

It is probably any problem with modules. If I load them in sequence
there is no error.


>
> Btw do you plan on submitting the code for zynq_remoteproc ?
>

It is still under developing and there are some core changes in ARM low
level code
which need to be applied to mainline before this driver. I haven't sent
these patches
to mainline for review but I expect they won't be accepted but maybe I am
wrong.


>
> > Can you see the same behavior on omap?
>
> Except the "Unknown symbol" errors, everything else looks good.
>

Ok. Good.

Thanks,
Michal
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120522/e343ba88/attachment-0001.html>
