From: aarcange@redhat.com (Andrea Arcangeli)
Date: Tue, 26 May 2015 16:58:46 +0200
Subject: [BUG] Read-Only THP causes stalls (commit 10359213d)
In-Reply-To: <20150526143547.GA22363@cbox>
References: <20150524193404.GD16910@cbox> <20150525141525.GB26958@redhat.com>
 <20150526080848.GA27075@cbox>
 <CAPvkgC3kTgP720CawpfvLbm90FCs9UGNP3WOAamOD=UEgKoQCw@mail.gmail.com>
 <20150526143547.GA22363@cbox>
Message-ID: <20150526145846.GK26958@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 04:35:47PM +0200, Christoffer Dall wrote:
> Any chance you could send me the memhog tool?

memhog is just the first that come to mind because I got it
preinstalled everywhere (I only miss it on cyanogenmod as there's no
numactl there... yet).

Anything else would do as well, as long as you allocate lots of
anonymous memory (malloc(); bzero() or just write 1 byte every
4k). The tmpfs trick was fine as well as you'd end up swapping the
anonymous memory allocated by the running apps.

This would be the python version which I actually used sometime if I
couldn't find something preinstalled and I didn't want to install
packages.

echo 1 >/proc/sys/vm/overcommit_memory
python
a = "a"
while True:
	a += a

This is the more polished way, I just happen to have it installed
everywhere (except the cellphone) so I tend to use it, I think it's
simpler to install the numactl package.

https://github.com/numactl/numactl/blob/master/memhog.c
