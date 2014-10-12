From: balbi@ti.com (Felipe Balbi)
Date: Sat, 11 Oct 2014 19:50:07 -0500
Subject: [PATCH 07/12] rtc: omap: silence bogus power-up reset message at
 probe
In-Reply-To: <20141011102004.GD18988@localhost>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-8-git-send-email-johan@kernel.org>
 <20141010180054.GS31348@saruman> <20141010180256.GU31348@saruman>
 <20141011102004.GD18988@localhost>
Message-ID: <20141012005007.GC21128@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 11, 2014 at 12:20:04PM +0200, Johan Hovold wrote:
> On Fri, Oct 10, 2014 at 01:02:56PM -0500, Felipe Balbi wrote:
> > On Fri, Oct 10, 2014 at 01:00:54PM -0500, Felipe Balbi wrote:
> > > On Thu, Oct 09, 2014 at 09:06:29PM +0200, Johan Hovold wrote:
> > > > Some legacy RTC IP revisions has a power-up reset flag in the status
> > > > register that later revisions lack.
> > > > 
> > > > As this flag is always read back as set on later revisions (or is
> > > > overloaded with a different flag), make sure to only clear the flag and
> > > > print the info message on legacy platforms.
> > > > 
> > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > 
> > > Reviewed-by: Felipe Balbi <balbi@ti.com>
> > 
> > oh, btw. This should be done for DT probes too.
> 
> What do you mean? This is for DT probes (of "ti,da830-rtc" and
> "ti,am3352-rtc"). DT probing of legacy RTC IPs is currently not
> supported.
> 
> Are you suggesting I should add a new compatible string for that?

it seemed to me that you're only passing the new flag through
platform_device_id table, not DT table. Did I miss something ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141011/4f0bcc7f/attachment.sig>
