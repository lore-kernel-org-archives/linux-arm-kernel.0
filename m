From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 19 Aug 2014 15:21:24 +0800
Subject: [PATCH v2] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <53F1FB9A.4070305@samsung.com>
References: <1406269240-24622-1-git-send-email-shawn.guo@freescale.com>
 <53F1AE97.8090807@samsung.com> <20140818123823.GK2114@dragon>
 <53F1F866.1@samsung.com> <53F1FB9A.4070305@samsung.com>
Message-ID: <20140819072122.GL2114@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 03:11:54PM +0200, Andrzej Hajda wrote:
> On 08/18/2014 02:58 PM, Andrzej Hajda wrote:
> > .load hook is called after all components are attached to the master.
> > So if suspend happen after probe of the master and before attaching the last
> > component you will have NULL here, I guess.
> 
> Probably you can test it by disabling driver for one of drm components
> and putting board in sleep mode.
> 
> Moreover I guess drvdata should be cleaned in .unload callback,
> otherwise if for some reason one of components will be detached and suspend
> happens drvdata will contain invalid pointer.

You're right, Andrzej.  I will fix it in v3.  Thanks for the comment.

Shawn
