From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Mon, 10 May 2010 16:08:09 +0300
Subject: [PATCHv4 1/4] procfs: Introduce socinfo under /proc
In-Reply-To: <20100510125440.GA31721@nokia.com>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-3-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-2-git-send-email-eduardo.valentin@nokia.com>
	<20100510111259.GA14680@linux-sh.org>
	<20100510125440.GA31721@nokia.com>
Message-ID: <20100510130809.GC11804@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 02:54:40PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
> On Mon, May 10, 2010 at 01:13:00PM +0200, ext Paul Mundt wrote:
> >You'll still need the show function, but all of the rest of this is just
> >duplicating what single_open() already does. If the socinfo string is
> >static you may also want to rework this a bit so you can just stash the
> >string in the proc_dir_entry private data. Combine this with something
> >like kstrdup() and you'll save yourself a bit of stack while you're at
> >it.
> 
> doesn't ksrtdup() cause memleak ?? Or is it only when used with 
> module parameters ??

I'm not aware of the module parameter stuff.. but the leak might be other thing
than kstrdup?
> 
> -- 
> balbi
> 
> DefectiveByDesign.org
