From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 16 Jul 2013 16:16:30 -0700
Subject: [PATCH v2 01/22] [HACK] of: dev_node has struct device pointer
In-Reply-To: <51E5CFBF.5080407@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-2-git-send-email-hdoyu@nvidia.com>
 <51E5CFBF.5080407@wwwdotorg.org>
Message-ID: <20130716231629.GA12189@dhcp-172-17-186-34.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 04:57:03PM -0600, Stephen Warren wrote:
> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > To prevent of_platform_populate() from trying to populate duplicate
> > devices if a device has been already populated.
> 
> You need to send drivers/of patches to the DT maintainer and
> devicetree-discuss mailing list.
> 
> > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > ---
> > Need to take care of early_platform_devices, or alternative solution.
> 
> I assume that's a TODO item... Are you planning on fleshing out this
> patch to address that issue?

There was some more discussion about it, which can be found in the
following thread:

	https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/036934.html

That's one of the last messages and it should have most of the
background. If not you may have to walk up the thread for more context.
In a nutshell I raised the question as to why we can't simply call
of_platform_populate() earlier and side-step all the workarounds that
have found their way into the kernel to side-step the issue of their not
being a struct device associated with the struct device_node.

If of_platform_populate() can be made to run early, then we can restore
a whole lot of consistency in how "early" drivers on an OF kernel work.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/db0a8b7f/attachment.sig>
