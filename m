From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 13:17:46 +0100
Subject: [PATCH v4 20/22] driver core: Allow deferring probes until late
 init
In-Reply-To: <1441628627-5143-21-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-21-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150911121746.GR12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 02:23:45PM +0200, Tomeu Vizoso wrote:
> Add a field to struct device that instructs the device-driver core to
> defer the probe of this device until the late_initcall level.
> 
> By letting all built-in drivers to register before starting to probe, we
> can avoid any deferred probes by probing dependencies on demand.

Is this not going to resut in massive churn as we go through and set
this flag for a massive proportion of drivers?  Could we mitigate this
by having a first pass at setting this per subsystem or something so
that we get a good proportion of drivers with changes in core code?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/54c40dc5/attachment.sig>
