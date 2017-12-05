From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 5 Dec 2017 11:28:40 +0100
Subject: [RFC PATCH 1/6] drm: Add Content Protection property
In-Reply-To: <20171130030907.26848-2-seanpaul@chromium.org>
References: <20171130030907.26848-1-seanpaul@chromium.org>
 <20171130030907.26848-2-seanpaul@chromium.org>
Message-ID: <20171205102840.GB12982@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-11-29 22:08:56, Sean Paul wrote:
> This patch adds a new optional connector property to allow userspace to enable
> protection over the content it is displaying. This will typically be implemented
> by the driver using HDCP.
> 
> The property is a tri-state with the following values:
> - OFF: Self explanatory, no content protection
> - DESIRED: Userspace requests that the driver enable protection
> - ENABLED: Once the driver has authenticated the link, it sets this value
> 
> The driver is responsible for downgrading ENABLED to DESIRED if the link becomes
> unprotected. The driver should also maintain the desiredness of protection
> across hotplug/dpms/suspend.

Why would user of the machine want this to be something else than
'OFF'?

If kernel implements this, will it mean hardware vendors will have to
prevent user from updating kernel on machines they own?

If this is merged, does it open kernel developers to DMCA threats if
they try to change it?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/db10c986/attachment.sig>
