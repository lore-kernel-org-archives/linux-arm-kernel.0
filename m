From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jun 2015 11:36:15 +0100
Subject: [PATCH 00/13] Discover and probe dependencies
In-Reply-To: <55829269.2090309@samsung.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <55829269.2090309@samsung.com>
Message-ID: <20150618103615.GC14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 11:42:01AM +0200, Andrzej Hajda wrote:

There's something really messed up with how your mailer is word wrapping
paragraphs, might want to check it out - it looks like it's making lines
that are longer than 80 columns and then randomly breaking them 80
columns in rather than reflowing things.

> 3. Dependencies are mandatory, ie without it driver will not be able to
> successfully finish
> the probe.
>     It should be not true. Sometimes device will require given resource
> only in specific
>     scenario, or it can still probe successfully and ask for the
> resource later.
>     I can also imagine that firmware can describe more information than
> given driver require,
>     some resources even if they are present in the dts, will be not
> requested by the driver, it
>     can be the case of drivers providing limited functionality, or just
> obsolete bindings.

Well, this isn't clear - the model here seems to be that the
dependencies are those that are explicitly listed for a given platform.
For those our current expectation is that we will try to control them
and will defer probe until the resources that are mapped in on the
platform are present so this doesn't seem like a change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150618/c2c55b2b/attachment-0001.sig>
