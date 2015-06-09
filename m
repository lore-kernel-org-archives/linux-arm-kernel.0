From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 09 Jun 2015 10:15:20 +0200
Subject: [PATCH v4 2/2] dma: Add Xilinx AXI Central Direct Memory Access
 Engine driver support
In-Reply-To: <55769132.6070601@monstr.eu>
References: <1432228035-6569-1-git-send-email-appanad@xilinx.com>
 <1432290653.27695.97.camel@x220> <557681A7.7080202@monstr.eu>
 <alpine.DEB.2.02.1506090808500.2069@localhost6.localdomain6>
 <55769132.6070601@monstr.eu>
Message-ID: <1433837720.16887.42.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-06-09 at 09:09 +0200, Michal Simek wrote:
> On 06/09/2015 08:10 AM, Julia Lawall wrote:
> > On Tue, 9 Jun 2015, Michal Simek wrote:
> >> Also sort of checking for this will be great. Julia?
> > 
> > If this requires checking the contents of comment, Coccinelle currently 
> > can't help with that.  Perhaps an idea would be to just do a grep on the 
> > file.  So if I find MODULE_LICENSE("GPL v2") and then grepping for "either 
> > vresion 2" gives success, then there is a problem?  It's obviously not 
> > foolproof, but perhaps it could be helpful.
> 
> Having some sort of checking somewhere will be great. checkpatch?
> zero-day testing system?

Mistakes I've seen made since I started checking this stuff (a few
months ago):
- typos in the license ident, say "GPLv2", "GPL V2", or "BSD": generates
a warning when module is loaded and taints kernel. People still get this
wrong. A test in checkpatch for these typos was submitted a while ago,
but it never got added;
- not adding MODULE_LICENSE() to a module: also generates a warning when
module is loaded and taints kernel. People still get this wrong;
- adding MODULE_LICENSE() to built-in only code: pointless at best, and
annoying for reviewers ("Hey, did the submitter intend to write built-in
only code or modular code?");
- using "Dual BSD/GPL" but not a trace of the BSD license blurb in
sight, while adding that blurb is one of the very few requirements this
license actually has;
- license mismatch, say comment blurb states "GPL v2 (or later)" but
MODULE_LICENSE() ident states "GPL v2" only (or vice versa): very easy
mistake to make, happens once or twice a week.  

Did I miss anything in that list?

I'm afraid that most of the above can only be caught reliably by
attention to detail by submitters and reviewers. That's a pity, because
checking for that stuff is about as boring as it gets. (What does that
say about me?)

Thanks,


Paul Bolle
