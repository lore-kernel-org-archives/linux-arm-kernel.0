From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 14 Mar 2012 21:53:39 -0400
Subject: linux-next: build failure after merge of the final tree (arm-soc
 tree related)
In-Reply-To: <20120315105901.7b10c9f4de9374a613436988@canb.auug.org.au>
References: <20120315105901.7b10c9f4de9374a613436988@canb.auug.org.au>
Message-ID: <CAP=VYLosYNbhGeUYyLr=0xa1UgK=fL-GOafySixFyQjy4GrdgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 7:59 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the final tree, today's linux-next build (powerpc
> allmodconfig) failed like this:
>
> drivers/ata/sata_mv.c:4185:1: error: '__mod_of_device_table' aliased to undefined symbol 'mvsdio_dt_ids'
>
> Caused by commit f1e1e148c5cb ("ARM: kirkwood: sata_mv: add device tree
> binding").

Looks like the same thing I reported in yesterday's triage that was
screwing sparc:

http://www.spinics.net/lists/sparclinux/msg09199.html

Odd that it only started screwing powerpc today though.

Paul.
--

> --
> Cheers,
> Stephen Rothwell ? ? ? ? ? ? ? ? ? ?sfr at canb.auug.org.au
