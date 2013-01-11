From: rtivy@ti.com (Tivy, Robert)
Date: Fri, 11 Jan 2013 00:48:11 +0000
Subject: [PATCH v4 0/9] ARM: davinci: remoteproc support
In-Reply-To: <50E6C6C6.3010907@ti.com>
References: <1355967254-16726-1-git-send-email-rtivy@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FCECD@DFLE08.ent.ti.com>
 <50E6C6C6.3010907@ti.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C14311FE27B@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar,

At this point we have some examples/tests that exercise the davinci remoteproc framework using a socket layer that exists only in personal repos.  Ohad created rpmsg-based socket support for the kernel using vrings, and along with SYS/BIOS-based content developed by my TI team and others, it allows a SysLink-like MessageQ implementation to be used between the DSP and Linux user apps.  These apps consist of a Linux app communicating with the DSP firmware file loaded by remoteproc.  They rely on the rpmsg-based socket support, so they're of no use without that.

What I can do, for now, is provide a simple DSP firmware file that prints a "Hello, world" to a SYS/BIOS trace buffer that is known to remoteproc, and the remoteproc driver can be used to display the trace buffer contents through debugfs.  However, this won't exercise the run-time component of davinci remoteproc (which is really just interrupt support between the DSP and ARM).  I will do this and upload the firmware file and a README to my GitHub repo.  I will provide just the firmware binary since the capability to build it from source relies on SYS/BIOS, TI IPC, and XDC packages/installations.

Regards,

- Rob


> -----Original Message-----
> From: Nori, Sekhar
> Sent: Friday, January 04, 2013 4:11 AM
> To: Tivy, Robert
> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> kernel at lists.infradead.org; ohad at wizery.com; rob at landley.net; linux-
> doc at vger.kernel.org; Ring, Chris; Grosen, Mark
> Subject: Re: [PATCH v4 0/9] ARM: davinci: remoteproc support
> 
> On 12/22/2012 3:39 AM, Tivy, Robert wrote:
> > I have uploaded the commits corresponding to this patch set to a
> public repo on GitHub, forked from Linus' v3.7-rc2 tag on his "linux"
> repo.  These commits are on a branch named "davinci-remoteproc", here
> is the URL: https://github.com/RTivy/linux/tree/davinci-remoteproc
> >
> > This should make for an easier review of the changes.
> 
> Thanks. Is there a sample application we could use to exercise the
> driver? Looks like we need some firmware to load on the DSP too.
> 
> Thanks,
> Sekhar
