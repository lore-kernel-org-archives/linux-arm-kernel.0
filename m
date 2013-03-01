From: balbi@ti.com (Felipe Balbi)
Date: Fri, 1 Mar 2013 08:29:18 +0200
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core
 probe's result
In-Reply-To: <20130301014457.GB19324@nchen-desktop>
References: <20130227022202.GA20402@nchen-desktop>
 <20130227121238.GE8016@arwen.pp.htv.fi>
 <20130228031118.GA19387@nchen-desktop>
 <20130228072617.GB6154@arwen.pp.htv.fi>
 <20130228083143.GB19516@nchen-desktop>
 <20130228084933.GG6544@arwen.pp.htv.fi>
 <871uc0yeau.fsf@ashishki-desk.ger.corp.intel.com>
 <20130228100654.GC19516@nchen-desktop>
 <20130228104559.GB22736@arwen.pp.htv.fi>
 <20130301014457.GB19324@nchen-desktop>
Message-ID: <20130301062918.GC3120@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 09:45:51AM +0800, Peter Chen wrote:
> On Thu, Feb 28, 2013 at 12:45:59PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Thu, Feb 28, 2013 at 06:06:55PM +0800, Peter Chen wrote:
> > 
> > > For runtime pm disabled, we may had to add some ugly things, like
> > > notify core probe fail, and platform layer needs to handle this failed
> > > notify.
> > 
> > Please stop talking about about "notify core probe fail" that will never
> > happen. Not today, not ever. Forget that idea.
> 
> Of course, it is ugly way, I just thought if it will affect power, eg dvfs,
> bus freq if the usb clock is on. Maybe the user will find USB core init fails
> case causes runtime power rise, and fix the core init fail bug.

right, we need to fix the bug, but hiding it under some obscure way of
passing return values back to glue layer isn't correct. We should fix
the real issue, always, instead of hacking around buggy code.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130301/5a467e76/attachment.sig>
